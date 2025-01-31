# Настройка L7-балансировщика {{ alb-full-name }} с помощью Ingress-контроллера

Сервис [{{ alb-full-name }}](../../application-load-balancer/) используется для балансировки нагрузки и распределения трафика между приложениями. Чтобы с его помощью управлять трафиком к приложениям, запущенным в [кластере {{ managed-k8s-name }}](../../managed-kubernetes/concepts/index.md#kubernetes-cluster), необходим [Ingress-контроллер](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).

Чтобы настроить доступ к запущенным в кластере {{ managed-k8s-name }} приложениям через L7-балансировщик {{ alb-name }}:

1. [Настройте тестовые приложения и ресурс Ingress](#create-ingress-and-apps).
1. [(Опционально) Настройте группу ресурсов Ingress](#configure-group).
1. [Убедитесь в доступности приложений кластера {{ managed-k8s-name }} через {{ alb-name }}](#verify-setup).

Полную конфигурацию ресурсов для Ingress-контроллера {{ alb-name }} см. в следующих разделах:

* [Ingress](../../managed-kubernetes/alb-ref/ingress.md) — правила распределения трафика между бэкендами и настройки балансировщика.
* [HttpBackendGroup](../../managed-kubernetes/alb-ref/http-backend-group.md), [GrpcBackendGroup](../../managed-kubernetes/alb-ref/grpc-backend-group.md) — объединение бэкендов в группы.
* [IngressClass](../../managed-kubernetes/alb-ref/ingress-class.md) — управление несколькими Ingress-контроллерами в кластере {{ k8s }}.
* [Service](../../managed-kubernetes/alb-ref/service-for-ingress.md) — описание сервисов {{ k8s }}, используемых в качестве бэкендов.

## Перед началом работы {#before-you-begin}

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).

1. Если у вас уже есть сертификат для доменной зоны, [добавьте сведения о нем](../../certificate-manager/operations/import/cert-create.md) в сервис [{{ certificate-manager-full-name }}](../../certificate-manager/). Или [добавьте новый сертификат от {{ lets-encrypt }}](../../certificate-manager/operations/managed/cert-create.md).

1. Получите идентификатор добавленного сертификата:

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

1. {% include [configure-sg-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-manual-lvl3.md) %}

    {% include [configure-sg-alb-manual](../../_includes/managed-kubernetes/security-groups/configure-sg-alb-manual.md) %}

    {% include [sg-common-warning](../../_includes/managed-kubernetes/security-groups/sg-common-warning.md) %}

1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}
1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

1. [Установите Ingress-контроллер {{ alb-name }}](../../managed-kubernetes/operations/applications/alb-ingress-controller.md).


1. {% include [install externaldns](../../_includes/managed-kubernetes/install-externaldns.md) %}


1. {% include [Install and configure kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

   {% include [Run kubectl cluster-info](../../_includes/managed-kubernetes/kubectl-info.md) %}

## Настройте ресурс Ingress и тестовые приложения {#create-ingress-and-apps}

В [ресурсе Ingress](../../application-load-balancer/k8s-ref/ingress.md) определяются:

* Параметры L7-балансировщика, которые задаются с помощью аннотаций.
* Правила распределения входящего трафика между [сервисами {{ k8s }}](../../application-load-balancer/k8s-ref/service-for-ingress.md).

    Сервисы, выступающие в роли бэкендов {{ alb-name }}, могут быть указаны в ресурсе Ingress напрямую или в составе групп бэкендов [HttpBackendGroup](../../application-load-balancer/k8s-ref/http-backend-group.md)/[GrpcBackendGroup](../../application-load-balancer/k8s-ref/grpc-backend-group.md).

Создайте тестовые приложения и ресурс Ingress:

{% list tabs %}

- Ресурс Ingress для сервисов {{ k8s }}

  1. В отдельной директории создайте конфигурационные файлы приложений `demo-app-1.yaml` и `demo-app-2.yaml`:

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

  1. В той же директории создайте файл `ingress.yaml` и укажите в нем [делегированное ранее доменное имя](#before-you-begin), [идентификатор полученного ранее сертификата](#before-you-begin) и настройки L7-балансировщика {{ alb-name }}:

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

     * `ingress.alb.yc.io/subnets` — одна или несколько подсетей, в которых будет расположен L7-балансировщик {{ alb-name }}.
     * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для балансировщика. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящее TCP-соединение к порту `10501` в подсети группы узлов {{ managed-k8s-name }} или в ее группу безопасности.
     * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к балансировщику из интернета. Укажите [заранее полученный IP-адрес](../../vpc/operations/get-static-ip.md) либо установите значение `auto`, чтобы получить новый.

       Если вы указали значение `auto`, то при удалении балансировщика из [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) также будет удален его [IP-адрес](../../vpc/concepts/address.md). Чтобы избежать этого, используйте имеющийся зарезервированный адрес.

     * `ingress.alb.yc.io/group-name` — имя группы. Ресурсы Ingress объединяются в группы, каждая из которых обслуживается отдельным балансировщиком.

       Вместо `my-ingress-group` вы можете указать произвольное имя группы. Убедитесь, что оно соответствует [требованиям]({{ k8s-docs }}/concepts/overview/working-with-objects/names/).

     В версиях [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) до 0.2.0 каждая группа бэкендов соответствует связке параметров `host`, `http.paths.path` и `http.paths.pathType`. В версиях 0.2.0 и позднее группа бэкендов соответствует параметру `backend.service`. Из-за этого при обновлении ALB Ingress Controller могут возникнуть коллизии. Чтобы избежать их, [узнайте, применимы ли ограничения при обновлении](../../managed-kubernetes/operations/applications/upgrade-alb-ingress-controller.md) к вашей инфраструктуре.

     (Опционально) Укажите дополнительные настройки балансировщика:

     {% cut "Дополнительные настройки" %}

     {% include [alb-ingress-balancer-additional-settings](../_tutorials_includes/alb-ingress-balancer-additional-settings.md) %}

     Доступные настройки:

     * `ingress.alb.yc.io/group-settings-name` — имя для настроек группы ресурсов Ingress, которые должны быть описаны в дополнительном ресурсе `IngressGroupSettings`. Подробнее см. в разделе [Настройте группу ресурсов Ingress](#configure-group).
     * `ingress.alb.yc.io/internal-ipv4-address` — предоставление внутреннего доступа к балансировщику. Укажите внутренний IP-адрес, либо установите значение `auto`, чтобы получить IP-адрес автоматически.

       {% note info %}

       Вы можете одновременно использовать только один тип доступа к балансировщику: `ingress.alb.yc.io/external-ipv4-address` или `ingress.alb.yc.io/internal-ipv4-address`.

       {% endnote %}

     * `ingress.alb.yc.io/internal-alb-subnet` — подсеть, в которой нужно разместить балансировщик. Обязательный параметр, если выбран параметр `ingress.alb.yc.io/internal-ipv4-address`.
     * `ingress.alb.yc.io/protocol` — протокол соединений между балансировщиком и бэкендами:
       * `http` — HTTP/1.1. Значение по умолчанию.
       * `http2` — HTTP/2.
       * `grpc` — gRPC.
     * `ingress.alb.yc.io/transport-security` — протокол шифрования соединений между балансировщиком и бэкендами.

        {% note warning %}

        В [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) версии 0.2.0 и позднее аннотация используется только в объекте [Service](../../application-load-balancer/k8s-ref/service-for-ingress.md#metadata).

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

     * `ingress.alb.yc.io/security-profile-id` — поддержка сервиса [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md), который позволяет защититься от [DDoS-атак](../../glossary/ddos.md) и ботов, а также задействовать [WAF](../../smartwebsecurity/concepts/waf.md) и [ограничить нагрузку](../../smartwebsecurity/concepts/arl.md) на защищаемый ресурс.

       Чтобы включить поддержку сервиса, в аннотации Ingress укажите заранее созданный [профиль безопасности](../../smartwebsecurity/concepts/profiles.md) {{ sws-name }}:

       ```yaml
       ingress.alb.yc.io/security-profile-id: <идентификатор_профиля_безопасности>
       ```

       {% include [sws-editor-role](../../_includes/managed-kubernetes/alb-ref/sws-editor-role.md) %}

     * `ingress.alb.yc.io/use-regex` — поддержка регулярных выражений стандарта [RE2](https://github.com/google/re2/wiki/Syntax) при сопоставлении пути запроса. Если передана строка `true`, поддержка включена. Применимо, только если для параметра `pathType` указано значение `Exact`.

     * `ingress.alb.yc.io/balancing-panic-threshold` — пороговое значения для активации [режима паники](../../application-load-balancer/concepts/backend-group.md#panic-mode). Режим включится, если процент работоспособных эндпоинтов опустится ниже указанного значения. Значение по умолчанию — `0`, при котором режим паники не активируется никогда.

     * `ingress.alb.yc.io/balancing-locality-aware-routing` — процент входящего трафика, который балансировщик передает бэкендам из своей зоны доступности. Остальной трафик поровну делится между другими зонами. Значение по умолчанию — `0`. [Подробнее о локализации трафика](../../application-load-balancer/concepts/backend-group.md#locality).

     * `ingress.alb.yc.io/autoscale-max-size` — максимальное суммарное количество ресурсных единиц. По умолчанию количество не ограничено. Значение должно быть не меньше, чем количество зон доступности балансировщика, умноженное на минимальное количество ресурсных единиц в каждой зоне. [Подробнее о настройках автомасштабирования](../../application-load-balancer/concepts/application-load-balancer.md#lcu-scaling-settings).

     * `ingress.alb.yc.io/modify-header-request-append` — добавляет строку к значению заголовка запроса. Заголовок и строка указываются в формате:

       ```yaml
       ingress.alb.yc.io/modify-header-request-append: <имя_изменяемого_заголовка>=<строка>
       ```

     * `ingress.alb.yc.io/modify-header-request-replace` — заменяет значение заголовка запроса. Заголовок и его новое значение указываются в формате:

       ```yaml
       ingress.alb.yc.io/modify-header-request-replace: <имя_изменяемого_заголовка>=<новое_значение_заголовка>
       ```

     * `ingress.alb.yc.io/modify-header-request-rename` — переименовывает заголовок запроса. Заголовок и его новое имя указываются в формате:

       ```yaml
       ingress.alb.yc.io/modify-header-request-rename: <имя_изменяемого_заголовка>=<новое_имя_заголовка>
       ```

     * `ingress.alb.yc.io/modify-header-request-remove` — удаляет заголовок запроса. Заголовок для удаления указывается в формате:

       ```yaml
       ingress.alb.yc.io/modify-header-request-remove: <имя_удаляемого_заголовка>=true
       ```

     {% endcut %}

     Если вы используете несколько Ingress-контроллеров, для каждого из них создайте ресурс [IngressClass](../../managed-kubernetes/alb-ref/ingress-class.md). В конфигурации `Ingress` укажите нужный `IngressClass` в поле `spec.ingressClassName`.

     Подробное описание настроек ресурса `Ingress` см. в статье [{#T}](../../managed-kubernetes/alb-ref/ingress.md).

  1. Создайте приложения {{ k8s }} и ресурс Ingress:

     ```bash
     kubectl apply -f .
     ```

     ALB Ingress Controller автоматически развернет [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) по конфигурации ресурса Ingress.

  1. Дождитесь создания L7-балансировщика {{ alb-name }} и получения им публичного IP-адреса, это может занять несколько минут.

     Чтобы отслеживать создание балансировщика и убедиться в отсутствии ошибок, откройте логи пода, в котором запущен процесс создания:

     1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Нажмите на имя нужного кластера и на панели слева выберите **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
     1. Выберите один из подов `alb-demo-***`, в котором запущен процесс создания балансировщика.
     1. На странице пода перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-logs }}**.

        В режиме реального времени записываются и отображаются логи о создании балансировщика. Если возникла ошибка во время создания, она появится в логах.

  1. Убедитесь, что балансировщик создан. Для этого выполните команду и проверьте, что в поле `ADDRESS` в выводе команды появилось значение:

     ```bash
     kubectl get ingress alb-demo-tls
     ```

     Результат:

     ```bash
     NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
     alb-demo-tls  <none>  <доменное_имя>  <IP-адрес>  80, 443  15h
     ```

- Ресурс Ingress для группы бэкендов

  1. Создайте [группу бэкендов с бакетом](../../application-load-balancer/operations/backend-group-create.md#with-s3-bucket):
     1. Создайте [публичный бакет в {{ objstorage-name }}](../../tutorials/web/static/console.md#create-public-bucket).
     1. [Настройте главную страницу сайта и страницу ошибки](../../tutorials/web/static/console.md).
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

  1. В отдельной директории создайте файл `http-group.yaml`, содержащий настройки ресурса `HttpBackendGroup`:

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

     (Опционально) Укажите дополнительные настройки для группы бэкендов:
     * `spec.backends.useHttp2` — режим использования протокола `HTTP/2`.
     * `spec.backends.tls` — сертификат удостоверяющего центра, которому балансировщик будет доверять при установке безопасного соединения с эндпоинтами бэкендов. Укажите содержимое сертификата в поле `trustedCa` в открытом виде.

     Подробнее см. в разделе [{#T}](../../application-load-balancer/concepts/backend-group.md).

  1. В той же директории создайте файл `ingress-http.yaml` и укажите в нем [делегированное ранее доменное имя](#before-you-begin), [идентификатор полученного ранее сертификата](#before-you-begin) и настройки L7-балансировщика {{ alb-name }}:

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
     * `ingress.alb.yc.io/subnets` — одна или несколько подсетей, в которых будет расположен L7-балансировщик {{ alb-name }}.
     * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для балансировщика. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящее TCP-соединение к порту `10501` в подсети группы узлов {{ managed-k8s-name }} или в ее группу безопасности.
     * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к балансировщику из интернета. Укажите [заранее полученный IP-адрес](../../vpc/operations/get-static-ip.md) либо установите значение `auto`, чтобы получить новый.

       Если вы указали значение `auto`, то при удалении балансировщика из [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) также будет удален его [IP-адрес](../../vpc/concepts/address.md). Чтобы избежать этого, используйте имеющийся зарезервированный адрес.

     * `ingress.alb.yc.io/group-name` — имя группы. Ресурсы Ingress объединяются в группы, каждая из которых обслуживается отдельным балансировщиком.

       Вместо `my-ingress-group` вы можете указать произвольное имя группы. Убедитесь, что оно соответствует [требованиям]({{ k8s-docs }}/concepts/overview/working-with-objects/names/).

     (Опционально) Укажите дополнительные настройки балансировщика.

     {% include [alb-ingress-balancer-additional-settings](../_tutorials_includes/alb-ingress-balancer-additional-settings.md) %}

     Доступные настройки:

     * `ingress.alb.yc.io/group-settings-name` — имя для настроек группы ресурсов Ingress, которые должны быть описаны в дополнительном ресурсе `IngressGroupSettings`. Подробнее см. в разделе [Настройте группу ресурсов Ingress](#configure-group).
     * `ingress.alb.yc.io/internal-ipv4-address` — предоставление внутреннего доступа к балансировщику. Укажите внутренний IP-адрес, либо установите значение `auto`, чтобы получить IP-адрес автоматически.

       {% note info %}

       Вы можете одновременно использовать только один тип доступа к балансировщику: `ingress.alb.yc.io/external-ipv4-address` или `ingress.alb.yc.io/internal-ipv4-address`.

       {% endnote %}

     * `ingress.alb.yc.io/internal-alb-subnet` — подсеть, в которой нужно разместить балансировщик. Обязательный параметр, если выбран параметр `ingress.alb.yc.io/internal-ipv4-address`.
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

     * `ingress.alb.yc.io/security-profile-id` — поддержка сервиса [{{ sws-full-name }}](../../smartwebsecurity/concepts/index.md), который позволяет защититься от [DDoS-атак](../../glossary/ddos.md) и ботов, а также задействовать [WAF](../../smartwebsecurity/concepts/waf.md) и [ограничить нагрузку](../../smartwebsecurity/concepts/arl.md) на защищаемый ресурс.

       Чтобы включить поддержку сервиса, в аннотации Ingress укажите заранее созданный [профиль безопасности](../../smartwebsecurity/concepts/profiles.md) {{ sws-name }}:

       ```yaml
       ingress.alb.yc.io/security-profile-id: <идентификатор_профиля_безопасности>
       ```

       {% include [sws-editor-role](../../_includes/managed-kubernetes/alb-ref/sws-editor-role.md) %}

     * `ingress.alb.yc.io/use-regex` — поддержка регулярных выражений стандарта [RE2](https://github.com/google/re2/wiki/Syntax) при сопоставлении пути запроса. Если передана строка `true`, поддержка включена. Применимо, только если для параметра `pathType` указано значение `Exact`.

     Подробное описание настроек ресурса Ingress см. в статье [{#T}](../../managed-kubernetes/alb-ref/ingress.md).
  1. Создайте приложение {{ k8s }}, ресурс HttpBackendGroup и ресурс Ingress:

     ```bash
     kubectl apply -f .
     ```

    ALB Ingress Controller автоматически развернет [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md) по конфигурации ресурса Ingress.

  1. Дождитесь создания L7-балансировщика {{ alb-name }} и получения им публичного IP-адреса, это может занять несколько минут.

     Чтобы отслеживать создание балансировщика и убедиться в отсутствии ошибок, откройте логи пода, в котором запущен процесс создания:

     1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
     1. Нажмите на имя нужного кластера и на панели слева выберите **{{ ui-key.yacloud.k8s.cluster.switch_workloads }}**.
     1. Выберите один из подов `alb-demo-***`, в котором запущен процесс создания балансировщика.
     1. На странице пода перейдите на вкладку **{{ ui-key.yacloud.k8s.workloads.label_tab-logs }}**.

        В режиме реального времени записываются и отображаются логи о создании балансировщика. Если возникла ошибка во время создания, она появится в логах.

  1. Убедитесь, что балансировщик создан. Для этого выполните команду и проверьте, что в поле `ADDRESS` в выводе команды появилось значение:

     ```bash
     kubectl get ingress alb-demo-tls
     ```

     Результат:

     ```bash
     NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
     alb-demo-tls  <none>  <доменное_имя>  <IP-адрес>  80, 443  15h
     ```

{% endlist %}

По умолчанию Ingress-контроллер {{ alb-name }} принимает от L7-балансировщика запросы для [проверок состояния](../../application-load-balancer/concepts/backend-group.md#health-checks) приложения на TCP-порт `10501` и проверяет работоспособность подов [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) на каждом узле кластера. Суть проверки состояния заключается в том, что когда `kube-proxy` работоспособен, то даже если приложение в конкретном поде не отвечает, {{ k8s }} перенаправит трафик в другой под с этим приложением или на другой узел.

В параметрах ресурса [HttpBackendGroup](../../application-load-balancer/k8s-ref/http-backend-group.md)/[GrpcBackendGroup](../../application-load-balancer/k8s-ref/grpc-backend-group.md) вы можете настроить собственные проверки состояния. Подробнее см. в разделе [{#T}](../../managed-kubernetes/tutorials/custom-health-checks.md).

## (Опционально) Настройте группу ресурсов Ingress {#configure-group}

Если при настройке ресурса Ingress вы указали имя для настроек группы ресурсов Ingress в аннотации `ingress.alb.yc.io/group-settings-name`, то вы можете задать настройки логирования для L7-балансировщика. Для этого [создайте пользовательскую лог-группу](../../logging/operations/create-group.md) и укажите настройки группы ресурсов Ingress в дополнительном ресурсе `IngressGroupSettings`:

1. Создайте файл `settings.yaml` и укажите в нем настройки логирования и идентификатор пользовательской лог-группы, например:

    ```yaml
    apiVersion: alb.yc.io/v1alpha1
    kind: IngressGroupSettings
    metadata:
      name: <имя_для_настроек_группы_ресурсов_Ingress>
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

    Где `name` — имя для настроек группы ресурсов Ingress в аннотации `ingress.alb.yc.io/group-settings-name`.

1. Примените настройки для группы ресурсов Ingress:

    ```bash
    kubectl apply -f settings.yaml
    ```

## Убедитесь в доступности приложений через L7-балансировщик {#verify-setup}

1. Если вы не устанавливали [ExternalDNS c плагином для {{ dns-name }}](/marketplace/products/yc/externaldns), [добавьте A-запись в зону](../../dns/operations/resource-record-create.md) вашего домена. В поле **Значение** укажите публичный IP-адрес L7-балансировщика {{ alb-name }}. При использовании ExternalDNS c плагином для {{ dns-full-name }} запись создастся автоматически.

1. Проверьте работу балансировщика:

   {% list tabs %}

   - Ресурс Ingress для сервисов {{ k8s }}

     Откройте в браузере URI приложений:

     ```http
     https://<ваш_домен>/app1
     https://<ваш_домен>/app2
     ```

     Убедитесь, что приложения доступны через L7-балансировщик {{ alb-name }} и возвращают страницы с текстом `This is APP#1` и `This is APP#2` соответственно.

     {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

   - Ресурс Ingress для группы бэкендов

     Откройте в браузере URI приложения:

     ```http
     https://<ваш_домен>/app1
     ```

     Убедитесь, что целевые ресурсы доступны через L7-балансировщик {{ alb-name }}.

     {% include [Настройка групп безопасности при недоступности ресурса](../../_includes/managed-kubernetes/security-groups/check-sg-if-url-unavailable-lvl3.md) %}

   {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
1. [Удалите целевые группы](../../application-load-balancer/operations/target-group-delete.md) {{ alb-name }}.
1. [Удалите бакет](../../storage/operations/buckets/delete.md) {{ objstorage-name }}.
