# Настройка Ingress-контроллера {{ alb-name }}

Сервис [{{ alb-full-name }}](../../application-load-balancer/) используется для балансировки нагрузки и распределения трафика между приложениями. Чтобы с его помощью управлять трафиком к приложениям, запущенным в [кластере {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster), необходим [Ingress-контроллер](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).

Чтобы настроить доступ к запущенным в кластере {{ managed-k8s-name }} приложениям через {{ alb-name }}:
1. [{#T}](#create-ingress-and-apps).
1. [{#T}](#configure-group).
1. [{#T}](#verify-setup).

## Перед началом работы {#before-you-begin}

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).
1. Если у вас уже есть сертификат для доменной зоны, [добавьте сведения о нем](../../certificate-manager/operations/import/cert-create.md) в сервис [{{ certificate-manager-full-name }}](../../certificate-manager/). Или [добавьте новый сертификат от Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md).
1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}
1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}
1. Создайте правила [групп безопасности](../../vpc/concepts/security-groups.md), чтобы разрешить:

   * [Служебный входящий и исходящий трафик](../operations/connect/security-groups.md#rules-internal) для кластера {{ managed-k8s-name }} и группы узлов.
   * Входящий трафик для группы узлов:

      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `10501-10502`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_tcp }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
     * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — укажите диапазоны адресов подсетей, которые вы будете использовать при [создании Ingress-контроллера](#create-ingress-and-apps). Например, `10.96.0.0/16` или `10.112.0.0/16`.

1. [Установите Ingress-контроллер {{ alb-name }}](../operations/applications/alb-ingress-controller.md).
1. {% include [install externaldns](../../_includes/managed-kubernetes/install-externaldns.md) %}
1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [Run kubectl cluster-info](../../_includes/managed-kubernetes/kubectl-info.md) %}

## Настройте Ingress-контроллер и тестовые приложения {#create-ingress-and-apps}

В качестве рабочей нагрузки Ingress-контроллера могут выступать [сервисы {{ k8s }}](../concepts/index.md#service) или [группы бэкендов](../../application-load-balancer/concepts/backend-group.md#types): целевые группы {{ alb-name }} или бакеты {{ objstorage-full-name }}.

Перед началом работы получите идентификатор [добавленного ранее](#before-you-begin) TLS-сертификата:

```bash
yc certificate-manager certificate list
```

Результат выполнения команды:

```text
+----------------------+-----------+----------------+---------------------+----------+--------+
|          ID          |   NAME    |    DOMAINS     |      NOT AFTER      |   TYPE   | STATUS |
+----------------------+-----------+----------------+---------------------+----------+--------+
| fpq8diorouhp******** | sert-test |    test.ru     | 2022-01-06 17:19:37 | IMPORTED | ISSUED |
+----------------------+-----------+----------------+---------------------+----------+--------+
```

{% list tabs %}

- Ingress-контроллер для сервисов {{ k8s }}

  1. В отдельной директории создайте файлы приложений `demo-app-1.yaml` и `demo-app-2.yaml`:

     {% cut "demo-app-1.yaml" %}

     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: alb-demo-1
     data:
       nginx.conf: |
         worker_processes auto;
         events {
         }
         http {
           server {
             listen 80 ;
             location = /_healthz {
               add_header Content-Type text/plain;
               return 200 'ok';
             }
             location / {
               add_header Content-Type text/plain;
               return 200 'Index';
             }
             location = /app1 {
               add_header Content-Type text/plain;
               return 200 'This is APP#1';
             }
           }
         }
     ---
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: alb-demo-1
       labels:
         app: alb-demo-1
         version: v1
     spec:
       replicas: 2
       selector:
         matchLabels:
           app: alb-demo-1
       strategy:
         type: RollingUpdate
         rollingUpdate:
           maxSurge: 1
           maxUnavailable: 0
       template:
         metadata:
           labels:
             app: alb-demo-1
             version: v1
         spec:
           terminationGracePeriodSeconds: 5
           volumes:
             - name: alb-demo-1
               configMap:
                 name: alb-demo-1
           containers:
             - name: alb-demo-1
               image: nginx:latest
               ports:
                 - name: http
                   containerPort: 80
               livenessProbe:
                 httpGet:
                   path: /_healthz
                   port: 80
                 initialDelaySeconds: 3
                 timeoutSeconds: 2
                 failureThreshold: 2
               volumeMounts:
                 - name: alb-demo-1
                   mountPath: /etc/nginx
                   readOnly: true
               resources:
                 limits:
                   cpu: 250m
                   memory: 128Mi
                 requests:
                   cpu: 100m
                   memory: 64Mi
     ---
     apiVersion: v1
     kind: Service
     metadata:
       name: alb-demo-1
     spec:
       selector:
         app: alb-demo-1
       type: NodePort
       ports:
         - name: http
           port: 80
           targetPort: 80
           protocol: TCP
           nodePort: 30081
     ```

     {% endcut %}

     {% cut "demo-app-2.yaml" %}

     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: alb-demo-2
     data:
       nginx.conf: |
         worker_processes auto;
         events {
         }
         http {
           server {
             listen 80 ;
             location = /_healthz {
               add_header Content-Type text/plain;
               return 200 'ok';
             }
             location / {
               add_header Content-Type text/plain;
               return 200 'Add app#';
             }
             location = /app2 {
               add_header Content-Type text/plain;
               return 200 'This is APP#2';
             }
           }
         }
     ---
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: alb-demo-2
       labels:
         app: alb-demo-2
         version: v1
     spec:
       replicas: 2
       selector:
         matchLabels:
           app: alb-demo-2
       strategy:
         type: RollingUpdate
         rollingUpdate:
           maxSurge: 1
           maxUnavailable: 0
       template:
         metadata:
           labels:
             app: alb-demo-2
             version: v1
         spec:
           terminationGracePeriodSeconds: 5
           volumes:
             - name: alb-demo-2
               configMap:
                 name: alb-demo-2
           containers:
             - name: alb-demo-2
               image: nginx:latest
               ports:
                 - name: http
                   containerPort: 80
               livenessProbe:
                 httpGet:
                   path: /_healthz
                   port: 80
                 initialDelaySeconds: 3
                 timeoutSeconds: 2
                 failureThreshold: 2
               volumeMounts:
                 - name: alb-demo-2
                   mountPath: /etc/nginx
                   readOnly: true
               resources:
                 limits:
                   cpu: 250m
                   memory: 128Mi
                 requests:
                   cpu: 100m
                   memory: 64Mi
     ---
     apiVersion: v1
     kind: Service
     metadata:
       name: alb-demo-2
     spec:
       selector:
         app: alb-demo-2
       type: NodePort
       ports:
         - name: http
           port: 80
           targetPort: 80
           protocol: TCP
           nodePort: 30082
     ```

     {% endcut %}

  1. В той же директории создайте файл `ingress.yaml` и укажите в нем [делегированное ранее доменное имя](#before-you-begin), идентификатор сертификата и настройки для {{ alb-name }}:

     ```yaml
     apiVersion: networking.k8s.io/v1
     kind: Ingress
     metadata:
       name: alb-demo-tls
       annotations:
         ingress.alb.yc.io/subnets: <список_идентификаторов_подсетей>
         ingress.alb.yc.io/security-groups: <список_идентификаторов_групп_безопасности>
         ingress.alb.yc.io/external-ipv4-address: <способ_назначения_IP-адреса>
         ingress.alb.yc.io/group-name: my-ingress-group
     spec:
       tls:
         - hosts:
             - <доменное_имя>
           secretName: yc-certmgr-cert-id-<идентификатор_TLS-сертификата>
       rules:
         - host: <доменное_имя>
           http:
             paths:
               - path: /app1
                 pathType: Prefix
                 backend:
                   service:
                     name: alb-demo-1
                     port:
                       number: 80
               - path: /app2
                 pathType: Prefix
                 backend:
                   service:
                     name: alb-demo-2
                     port:
                       number: 80
               - pathType: Prefix
                 path: "/"
                 backend:
                   service:
                     name: alb-demo-2
                     port:
                       name: http
     ```

     Где:

     * `ingress.alb.yc.io/subnets` — одна или несколько подсетей, с которыми будет работать {{ alb-name }}.
     * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для {{ alb-name }}. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящие TCP-соединения к портам 10501 и 10502 в подсети группы узлов {{ managed-k8s-name }} или в ее группу безопасности.
     * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к {{ alb-name }} из интернета. Укажите [заранее полученный IP-адрес](../../vpc/operations/get-static-ip.md) либо установите значение `auto`, чтобы получить новый.

       Если вы указали значение `auto`, то при удалении Ingress-контроллера [IP-адрес](../../vpc/concepts/address.md) также будет удален из [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud). Чтобы избежать этого, используйте имеющийся зарезервированный адрес.

     * `ingress.alb.yc.io/group-name` — имя группы. Ресурсы {{ k8s }} Ingress объединяются в группы, каждая их которых обслуживается отдельным экземпляром {{ alb-name }}.

       Вместо `my-ingress-group` вы можете указать произвольное имя группы. Убедитесь, что оно соответствует [требованиям]({{ k8s-docs }}/concepts/overview/working-with-objects/names/).

     В версиях [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) до 0.2.0 каждая группа бэкендов соответствует связке параметров `host`, `http.paths.path` и `http.paths.pathType`. В версиях 0.2.0 и позднее группа бэкендов соответствует параметру `backend.service`. Из-за этого при обновлении ALB Ingress Controller могут возникнуть коллизии. Чтобы избежать их, [узнайте, применимы ли ограничения при обновлении](../operations/applications/upgrade-alb-ingress-controller.md) к вашей инфраструктуре.

     (Опционально) Укажите дополнительные настройки контроллера:

     {% cut "Дополнительные настройки" %}

     * `ingress.alb.yc.io/group-settings-name` — имя для настроек Ingress-группы, которые должны быть описаны в дополнительном ресурсе `IngressGroupSettings`. Подробнее см. в разделе [Настройте Ingress-группу](#configure-group).
     * `ingress.alb.yc.io/internal-ipv4-address` — предоставление внутреннего доступа к {{ alb-name }}. Укажите внутренний IP-адрес, либо установите значение `auto`, чтобы получить IP-адрес автоматически.

       {% note info %}

       Вы можете одновременно использовать только один тип доступа к {{ alb-name }}: `ingress.alb.yc.io/external-ipv4-address` или `ingress.alb.yc.io/internal-ipv4-address`.

       {% endnote %}

     * `ingress.alb.yc.io/internal-alb-subnet` — подсеть для размещения внутреннего IP-адреса {{ alb-name }}. Обязательный параметр, если выбран параметр `ingress.alb.yc.io/internal-ipv4-address`.
     * `ingress.alb.yc.io/protocol` — протокол соединений между балансировщиком и бэкендами:
       * `http` — HTTP/1.1. Значение по умолчанию.
       * `http2` — HTTP/2.
       * `grpc` — gRPC.
     * `ingress.alb.yc.io/transport-security` — протокол шифрования соединений между балансировщиком и бэкендами.

        {% note warning %}

        В [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) версии 0.2.0 и позднее аннотация используется только в объекте [Service](../../application-load-balancer/k8s-ref/service.md#metadata).

        Если указать аннотацию в ресурсах `Ingress`, где используется один сервис с одинаковыми настройками для групп бэкендов, аннотация применится корректно. Но такой механизм устарел, в дальнейшем он не будет поддерживаться.

        {% endnote %}

        Допустимое значение: `tls` — TLS без проверки сертификата.

        Если аннотация не указана, балансировщик соединяется с бэкендами без шифрования.
     * `ingress.alb.yc.io/prefix-rewrite` — замена пути на указанное значение.
     * `ingress.alb.yc.io/upgrade-types` — допустимые значения HTTP-заголовка `Upgrade`, например, `websocket`.
     * `ingress.alb.yc.io/request-timeout` — максимальный период, на который может быть установлено соединение.
     * `ingress.alb.yc.io/idle-timeout` — максимальный период, в течение которого соединение может простаивать без передачи данных.

       Значения для `request-timeout` и `idle-timeout` следует указывать с единицами измерения, например: `300ms`, `1.5h`. Допустимые единицы измерения:
       * `ns` — наносекунды.
       * `us` — микросекунды.
       * `ms` — миллисекунды.
       * `s` — секунды.
       * `m` — минуты.
       * `h` — часы.

     * `ingress.alb.yc.io/use-regex` — поддержка регулярных выражений стандарта [RE2](https://github.com/google/re2/wiki/Syntax) при сопоставлении пути запроса. Если передана строка `true`, поддержка включена. Применимо только если для параметра `pathType` указано значение `Exact`.

     {% endcut %}

     {% note info %}

     Настройки действуют только на хосты этого контроллера, но не на всю группу Ingress.

     {% endnote %}

     Подробное описание настроек ресурса Ingress см. в статье [{#T}](../alb-ref/ingress.md).

  1. Создайте Ingress-контроллер и приложения:

     ```bash
     kubectl apply -f .
     ```

  1. Дождитесь создания Ingress-контроллера и получения им публичного IP-адреса, это может занять несколько минут.

     Чтобы отслеживать создание контроллера и убедиться в отсутствии ошибок, откройте логи пода, в котором запущен процесс создания:

     1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Нажмите на имя нужного кластера и на панели слева выберите **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
     1. Выберите один из подов `alb-demo-***`, в котором запущен процесс создания Ingress-контроллера.
     1. На странице пода перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-logs }}**.

        В режиме реального времени записываются и отображаются логи о создании Ingress-контроллера. Если возникла ошибка во время создания, она появится в логах.

  1. Убедитесь, что Ingress-контроллер создан. Для этого выполните команду и проверьте, что в поле `ADDRESS` в выводе команды появилось значение:

     ```bash
     kubectl get ingress alb-demo-tls
     ```

     Результат:

     ```bash
     NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
     alb-demo-tls  <none>  <доменное_имя>  <IP-адрес>  80, 443  15h
     ```

     По конфигурации Ingress-контроллера будет автоматически развернут [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md).

- Ingress-контроллер для группы бэкендов

  Для настройки [группы бэкендов](../../application-load-balancer/concepts/backend-group.md) используйте [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) `HttpBackendGroup`. В качестве бэкенда может выступать целевая группа {{ alb-name }} или бакет {{ objstorage-name }}.

  Чтобы настроить {{ alb-name }} на работу с группой бэкендов:
  1. Создайте [группу бэкендов с бакетом](../../application-load-balancer/operations/backend-group-create.md#with-s3-bucket):
     1. Создайте [публичный бакет в {{ objstorage-name }}](../../tutorials/web/static.md#create-public-bucket).
     1. [Настройте главную страницу сайта и страницу ошибки](../../tutorials/web/static.md#index-and-error).
  1. Создайте конфигурационный файл приложения `demo-app-1.yaml`:

     {% cut "demo-app-1.yaml" %}

     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: alb-demo-1
     data:
       nginx.conf: |
         worker_processes auto;
         events {
         }
         http {
           server {
             listen 80 ;
             location = /_healthz {
               add_header Content-Type text/plain;
               return 200 'ok';
             }
             location / {
               add_header Content-Type text/plain;
               return 200 'Index';
             }
             location = /app1 {
               add_header Content-Type text/plain;
               return 200 'This is APP#1';
             }
           }
         }
     ---
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: alb-demo-1
       labels:
         app: alb-demo-1
         version: v1
     spec:
       replicas: 2
       selector:
         matchLabels:
           app: alb-demo-1
       strategy:
         type: RollingUpdate
         rollingUpdate:
           maxSurge: 1
           maxUnavailable: 0
       template:
         metadata:
           labels:
             app: alb-demo-1
             version: v1
         spec:
           terminationGracePeriodSeconds: 5
           volumes:
             - name: alb-demo-1
               configMap:
                 name: alb-demo-1
           containers:
             - name: alb-demo-1
               image: nginx:latest
               ports:
                 - name: http
                   containerPort: 80
               livenessProbe:
                 httpGet:
                   path: /_healthz
                   port: 80
                 initialDelaySeconds: 3
                 timeoutSeconds: 2
                 failureThreshold: 2
               volumeMounts:
                 - name: alb-demo-1
                   mountPath: /etc/nginx
                   readOnly: true
               resources:
                 limits:
                   cpu: 250m
                   memory: 128Mi
                 requests:
                   cpu: 100m
                   memory: 64Mi
     ---
     apiVersion: v1
     kind: Service
     metadata:
       name: alb-demo-1
     spec:
       selector:
         app: alb-demo-1
       type: NodePort
       ports:
         - name: http
           port: 80
           targetPort: 80
           protocol: TCP
           nodePort: 30081
     ```

     {% endcut %}

  1. В отдельной директории создайте файл `http-group.yaml`, содержащий настройки объекта `HttpBackendGroup`:

     ```yaml
     apiVersion: alb.yc.io/v1alpha1
     kind: HttpBackendGroup
     metadata:
       name: example-backend-group
     spec:
       backends: # Список бэкендов.
         - name: alb-demo-1
           weight: 70 # Относительный вес бэкенда при распределении трафика. Нагрузка будет распределяться пропорционально весам других бэкендов из группы. Укажите вес, даже если в группе один бэкенд.
           service:
              name: alb-demo-1
              port:
                number: 80
         - name: bucket-backend
           weight: 30
           storageBucket:
             name: <имя_бакета>
     ```

     (Опционально) Укажите дополнительные настройки контроллера:
     * `spec.backends.useHttp2` — режим использования протокола `HTTP/2`.
     * `spec.backends.tls` — сертификат удостоверяющего центра, которому балансировщик будет доверять при установке безопасного соединения с эндпоинтами бэкендов. Укажите содержимое сертификата в поле `trustedCa` в открытом виде.

     Подробнее см. в разделе [{#T}](../../application-load-balancer/concepts/backend-group.md).
  1. Создайте файл `ingress-http.yaml` и укажите в нем [делегированное ранее доменное имя](#before-you-begin), идентификатор сертификата и настройки для {{ alb-name }}:

     ```yaml
     apiVersion: networking.k8s.io/v1
     kind: Ingress
     metadata:
       name: alb-demo-tls
       annotations:
         ingress.alb.yc.io/subnets: <список_идентификаторов_подсетей>
         ingress.alb.yc.io/security-groups: <список_идентификаторов_групп_безопасности>
         ingress.alb.yc.io/external-ipv4-address: <способ_назначения_IP-адреса>
         ingress.alb.yc.io/group-name: my-ingress-group
     spec:
       tls:
         - hosts:
           - <доменное_имя>
           secretName: yc-certmgr-cert-id-<идентификатор_TLS-сертификата>
       rules:
         - host: <доменное_имя>
           http:
             paths:
               - path: /app1
                 pathType: Exact
                 backend:
                   resource:
                     apiGroup: alb.yc.io
                     kind: HttpBackendGroup
                     name: example-backend-group
     ```

     Где:
     * `ingress.alb.yc.io/subnets` — одна или несколько подсетей, с которыми будет работать {{ alb-name }}.
     * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для {{ alb-name }}. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящие TCP-соединения к портам 10501 и 10502 в подсети группы узлов {{ managed-k8s-name }} или в ее группу безопасности.
     * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к {{ alb-name }} из интернета. Укажите [заранее полученный IP-адрес](../../vpc/operations/get-static-ip.md) либо установите значение `auto`, чтобы получить новый.

       Если вы указали значение `auto`, то при удалении Ingress-контроллера [IP-адрес](../../vpc/concepts/address.md) также будет удален из [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud). Чтобы избежать этого, используйте имеющийся зарезервированный адрес.

     * `ingress.alb.yc.io/group-name` — имя группы. Ресурсы {{ k8s }} Ingress объединяются в группы, каждая их которых обслуживается отдельным экземпляром {{ alb-name }}.

       Вместо `my-ingress-group` вы можете указать произвольное имя группы. Убедитесь, что оно соответствует [требованиям]({{ k8s-docs }}/concepts/overview/working-with-objects/names/).

     (Опционально) Укажите дополнительные настройки контроллера:
     * `ingress.alb.yc.io/group-settings-name` — имя для настроек Ingress-группы, которые должны быть описаны в дополнительном ресурсе `IngressGroupSettings`. Подробнее см. в разделе [Настройте Ingress-группу](#configure-group).
     * `ingress.alb.yc.io/internal-ipv4-address` — предоставление внутреннего доступа к {{ alb-name }}. Укажите внутренний IP-адрес, либо установите значение `auto`, чтобы получить IP-адрес автоматически.

       {% note info %}

       Вы можете одновременно использовать только один тип доступа к {{ alb-name }}: `ingress.alb.yc.io/external-ipv4-address` или `ingress.alb.yc.io/internal-ipv4-address`.

       {% endnote %}

     * `ingress.alb.yc.io/internal-alb-subnet` — подсеть для размещения внутреннего IP-адреса {{ alb-name }}. Обязательный параметр, если выбран параметр `ingress.alb.yc.io/internal-ipv4-address`.
     * `ingress.alb.yc.io/protocol` — протокол соединений между балансировщиком и бэкендами:
       * `http` — HTTP/1.1. Значение по умолчанию.
       * `http2` — HTTP/2.
       * `grpc` — gRPC.
     * `ingress.alb.yc.io/prefix-rewrite` — замена пути на указанное значение.
     * `ingress.alb.yc.io/upgrade-types` — допустимые значения HTTP-заголовка `Upgrade`, например, `websocket`.
     * `ingress.alb.yc.io/request-timeout` — максимальный период, на который может быть установлено соединение.
     * `ingress.alb.yc.io/idle-timeout` — максимальный период, в течение которого соединение может простаивать без передачи данных.

       Значения для `request-timeout` и `idle-timeout` следует указывать с единицами измерения, например: `300ms`, `1.5h`. Допустимые единицы измерения:
       * `ns` — наносекунды.
       * `us` — микросекунды.
       * `ms` — миллисекунды.
       * `s` — секунды.
       * `m` — минуты.
       * `h` — часы.

     * `ingress.alb.yc.io/use-regex` — поддержка регулярных выражений стандарта [RE2](https://github.com/google/re2/wiki/Syntax) при сопоставлении пути запроса. Если передана строка `true`, поддержка включена. Применимо только если для параметра `pathType` указано значение `Exact`.

     {% note info %}

     Настройки действуют только на хосты этого контроллера, но не на всю группу Ingress.

     {% endnote %}

     Подробное описание настроек ресурса Ingress см. в статье [{#T}](../alb-ref/ingress.md).
  1. Создайте Ingress-контроллер, объект `HttpBackendGroup` и приложение {{ k8s }}:

     ```bash
     kubectl apply -f .
     ```

  1. Дождитесь создания Ingress-контроллера и получения им публичного IP-адреса, это может занять несколько минут:

     Чтобы отслеживать создание контроллера и убедиться в отсутствии ошибок, откройте логи пода, в котором запущен процесс создания:

     1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Нажмите на имя нужного кластера и на панели слева выберите **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
     1. Выберите один из подов `alb-demo-***`, в котором запущен процесс создания Ingress-контроллера.
     1. На странице пода перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-logs }}**.

        В режиме реального времени записываются и отображаются логи о создании Ingress-контроллера. Если возникла ошибка во время создания, она появится в логах.

  1. Убедитесь, что Ingress-контроллер создан. Для этого выполните команду и проверьте, что в поле `ADDRESS` в выводе команды появилось значение:

     ```bash
     kubectl get ingress alb-demo-tls
     ```

     Результат:

     ```bash
     NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
     alb-demo-tls  <none>  <доменное_имя>  <IP-адрес>  80, 443  15h
     ```

     По конфигурации Ingress-контроллера будет автоматически развернут L7-балансировщик.

{% endlist %}

## (Опционально) Настройте Ingress-группу {#configure-group}

Если при установке Ingress-контроллера вы указали имя для настроек Ingress-группы в аннотации `ingress.alb.yc.io/group-settings-name`, можете задать настройки логирования для L7-балансировщика. Для этого [создайте пользовательскую лог-группу](../../logging/operations/create-group.md) и укажите настройки Ingress-группы в дополнительном ресурсе `IngressGroupSettings`.
1. Создайте файл `settings.yaml` и укажите в нем настройки логирования и идентификатор пользовательской лог-группы, например:

    ```yaml
    apiVersion: alb.yc.io/v1alpha1
    kind: IngressGroupSettings
    metadata:
      name: <имя_для_настроек_Ingress-группы>
    logOptions:
      logGroupID: <идентификатор_пользовательской_лог-группы>
      discardRules:
        - discardPercent: 50
          grpcCodes:
            - OK
            - CANCELLED
            - UNKNOWN
        - discardPercent: 67
          httpCodeIntervals:
            - HTTP_1XX
        - discardPercent: 20
          httpCodes:
            - 200
            - 404
    ```

    Где `name` — имя для настроек Ingress-группы в аннотации `ingress.alb.yc.io/group-settings-name`.

1. Примените настройки для Ingress-группы:

    ```bash
    kubectl apply -f settings.yaml
    ```

## Убедитесь в доступности приложений кластера {{ managed-k8s-name }} через {{ alb-name }} {#verify-setup}

1. Если вы не устанавливали [ExternalDNS c плагином для {{ dns-name }}](/marketplace/products/yc/externaldns), [добавьте A-запись в зону](../../dns/operations/resource-record-create.md) вашего домена. В поле **Значение** укажите публичный IP-адрес Ingress-контроллера. При использовании ExternalDNS c плагином для {{ dns-full-name }} запись создастся автоматически.
1. [Настройте группы безопасности балансировщика](../../application-load-balancer/concepts/application-load-balancer.md#security-groups).
1. Проверьте работу {{ alb-name }}:

   {% list tabs %}

   - Сервисы {{ k8s }}

     Откройте в браузере URI приложений:

     ```http
     https://<ваш_домен>/app1
     https://<ваш_домен>/app2
     ```

     Убедитесь, что приложения доступны через {{ alb-name }} и возвращают страницы с текстом `This is APP#1` и `This is APP#2` соответственно.

   - Группа бэкендов

     Откройте в браузере URI приложения:

     ```http
     https://<ваш_домен>/app1
     ```

     Убедитесь, что целевые ресурсы доступны через {{ alb-name }}.

   {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:
1. [Удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
1. [Удалите целевые группы](../../application-load-balancer/operations/target-group-delete.md) {{ alb-name }}.
1. [Удалите бакет](../../storage/operations/buckets/delete.md) {{ objstorage-name }}.