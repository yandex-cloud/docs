# Настройка {{ alb-name }} Ingress-контроллера

Сервис [{{ alb-full-name }}](../../application-load-balancer/) используется для балансировки нагрузки и распределения трафика между приложениями. Чтобы с его помощью управлять трафиком к приложениям, запущенным в кластере {{ managed-k8s-name }}, необходим [Ingress-контроллер](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/).

Чтобы настроить доступ к запущенным в кластере приложениям через {{ alb-name }}:
1. [{#T}](#create-namespace).
1. [{#T}](#install-alb).
1. [{#T}](#create-ingress-and-apps).
1. [{#T}](#verify-setup).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Создайте](../../iam/operations/sa/create.md) [сервисный аккаунт](../../iam/concepts/index.md#sa), необходимый для работы Ingress-контроллера.
   1. [Назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md):
      * `alb.editor` — для создания необходимых ресурсов.
      * `vpc.publicAdmin` — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
      * `certificate-manager.certificates.downloader` — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../certificate-manager/).
      * `compute.viewer` — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../application-load-balancer/concepts/target-group.md) балансировщика.
   1. Создайте для него [авторизованный ключ](../../iam/operations/sa/create-access-key.md) и сохраните в файл `sa-key.json`:

      ```bash
      yc iam key create \
        --service-account-name <имя сервисного аккаунта для Ingress-контроллера> \
        --output sa-key.json
      ```

1. [Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).
1. Если у вас уже есть сертификат для доменной зоны, [добавьте сведения о нем](../../certificate-manager/operations/import/cert-create.md) в сервис {{ certificate-manager-name }}. Или [создайте новый сертификат от Let's Encrypt®](../../certificate-manager/operations/managed/cert-create.md).

1. {% include [k8s-ingress-controller-create-cluster](../../_includes/application-load-balancer/k8s-ingress-controller-create-cluster.md) %}

1. {% include [k8s-ingress-controller-create-node-group](../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

1. [Настройте группы безопасности кластера и группы узлов](../operations/connect/security-groups.md). Группа безопасности группы узлов должна разрешать входящие TCP-соединения к портам 10501 и 10502 из подсетей балансировщика или из его группы безопасности (позже подсети и группу нужно будет указать для [создания Ingress-контроллера](#create-ingress-and-apps)).

1. {% include [k8s-ingress-controller-install-helm](../../_includes/application-load-balancer/k8s-ingress-controller-install-helm.md) %}

1. {% include [kubectl-install](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. Убедитесь, что вы можете подключиться к кластеру с помощью `kubectl`:

   ```bash
   kubectl cluster-info
   ```

## Создайте пространство имен для {{ alb-name }} Ingress-контроллера {#create-namespace}

Чтобы создать [пространство имен](../concepts/index.md#namespace), выполните следующую команду:

```bash
kubectl create namespace yc-alb-ingress
```

## Установите {{ alb-name }} Ingress-контроллер {#install-alb}

Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с [Ingress-контроллером](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) выполните команды:

```bash
export HELM_EXPERIMENTAL_OCI=1 && \
cat sa-key.json | helm registry login {{ registry }} --username 'json_key' --password-stdin && \
helm pull oci://{{ registry }}/yc/yc-alb-ingress-controller-chart \
  --version=v{{ alb-ingress-version }} \
  --untar && \
helm install \
  --namespace yc-alb-ingress \
  --set folderId=<идентификатор каталога> \
  --set clusterId=<идентификатор кластера> \
  --set-file saKeySecretKey=sa-key.json \
yc-alb-ingress-controller ./yc-alb-ingress-controller-chart/
```

Идентификатор кластера можно [получить со списком кластеров в каталоге](../operations/kubernetes-cluster/kubernetes-cluster-list.md).

## Создайте Ingress-контроллер и тестовые приложения {#create-ingress-and-apps}

В качестве рабочей нагрузки Ingress-контроллера могут выступать [сервисы {{ k8s }}](../concepts/index.md#service), [целевые группы](../../application-load-balancer/concepts/target-group.md) {{ alb-name }} или [бакеты](../../storage/concepts/bucket.md) {{ objstorage-full-name }}.

Перед началом работы получите идентификатор [добавленного ранее](#before-you-begin) TLS-сертификата:

```bash
yc certificate-manager certificate list
```

Результат:

```text
+-----------------+-------+----------------+---------------------+----------+--------+
|       ID        | NAME  |    DOMAINS     |      NOT AFTER      |   TYPE   | STATUS |
+-----------------+-------+----------------+---------------------+----------+--------+
| <идентификатор> | <имя> | <доменное имя> | 2022-01-06 17:19:37 | IMPORTED | ISSUED |
+-----------------+-------+----------------+---------------------+----------+--------+
```

{% list tabs %}

- Ingress-контроллер для сервисов {{ k8s }}

  1. В отдельном каталоге создайте файл `ingress.yaml` и укажите в нем [делегированное ранее доменное имя](#before-you-begin), идентификатор сертификата и настройки для {{ alb-name }}:

     ```yaml
     apiVersion: networking.k8s.io/v1
     kind: Ingress
     metadata:
       name: alb-demo-tls
       annotations:
         ingress.alb.yc.io/subnets: <список идентификаторов подсетей>
         ingress.alb.yc.io/security-groups: <список идентификаторов групп безопасности>
         ingress.alb.yc.io/external-ipv4-address: <auto или статический IP-адрес>
         ingress.alb.yc.io/group-name: <имя Ingress-группы>
     spec:
       tls:
         - hosts:
             - <доменное имя>
           secretName: yc-certmgr-cert-id-<идентификатор TLS-сертификата>
       rules:
         - host: <доменное имя>
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

     * `ingress.alb.yc.io/subnets` — одна или несколько [подсетей](../../vpc/concepts/network.md#subnet), с которыми будет работать {{ alb-name }}.
     * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для {{ alb-name }}. Если параметр не задан, используется группа безопасности по умолчанию. Хотя бы одна из групп безопасности должна разрешать исходящие TCP-соединения к портам 10501 и 10502 в подсети группы узлов или в ее группу безопасности.
     * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к {{ alb-name }} из интернета. Укажите [заранее полученный IP-адрес](../../vpc/operations/get-static-ip.md), либо установите значение `auto`, чтобы получить новый.
     * `ingress.alb.yc.io/group-name` — объединение ресурсов {{ k8s }} Ingress в группы, каждая их которых обслуживается отдельным экземпляром {{ alb-name }}. Укажите имя группы.

     (Опционально) Укажите дополнительные настройки контроллера:
     * `ingress.alb.yc.io/internal-ipv4-address` — предоставление внутреннего доступа к {{ alb-name }}. Укажите внутренний IP-адрес, либо установите значение `auto`, чтобы получить IP-адрес автоматически.

       {% note info %}

       Вы можете одновременно использовать только один тип доступа к {{ alb-name }}: `ingress.alb.yc.io/external-ipv4-address` или `ingress.alb.yc.io/internal-ipv4-address`.

       {% endnote %}

     * `ingress.alb.yc.io/internal-alb-subnet` — подсеть для размещения внутреннего IP-адреса {{ alb-name }}. Обязательный параметр, если выбран параметр `ingress.alb.yc.io/internal-ipv4-address`.
     * `ingress.alb.yc.io/protocol` — протокол соединений между балансировщиком и бэкендами:
       * `http` — HTTP/1.1. Значение по умолчанию.
       * `http2` — HTTP/2.
       * `grpc` — gRPC.
     * `ingress.alb.yc.io/transport-security` — протокол шифрования соединений между балансировщиком и бэкендами:
       * `tls` — TLS без проверки сертификата.

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

       {% note info %}

       Настройки действуют только на хосты этого контроллера, но не на всю группу Ingress.

       {% endnote %}

  1. В том же каталоге создайте файлы приложений `demo-app-1.yaml` и `demo-app-2.yaml`:

     {% cut "demo-app1.yaml" %}

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

     {% cut "demo-app2.yaml" %}

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

  1. Создайте Ingress-контроллер и приложения:

     ```bash
     kubectl apply -f .
     ```

  1. Дождитесь создания Ingress-контроллера и получения им публичного IP-адреса, это может занять несколько минут:

     ```bash
     kubectl get ingress alb-demo-tls
     ```

     Результат — непустое значение в поле `ADDRESS` для созданного Ingress-контроллера:

     ```bash
     NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
     alb-demo-tls  <none>  <доменное имя>  <IP-адрес>  80, 443  15h
     ```

     По конфигурации Ingress-контроллера будет автоматически развернут [L7-балансировщик](../../application-load-balancer/concepts/application-load-balancer.md).

- Ingress-контроллер для группы бэкендов

  Для настройки [группы бэкендов](../../application-load-balancer/concepts/backend-group.md) используйте [CustomResourceDefinition](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) `HttpBackendGroup`. В качестве бэкенда может выступать [целевая группа](../../application-load-balancer/concepts/target-group.md) {{ alb-name }} или [бакет](../../storage/concepts/bucket.md) {{ objstorage-name }}.

  Чтобы настроить {{ alb-name }} на работу с группой бэкендов:
  1. Создайте [группу бэкендов с бакетом](../../application-load-balancer/operations/backend-group-create.md#with-s3-bucket):
     1. Создайте [публичный бакет в {{ objstorage-name }}](../../tutorials/web/static.md#create-public-bucket).
     1. [Настройте главную страницу сайта и страницу ошибки](../../tutorials/web/static.md#index-and-error).
  1. Создайте конфигурационный файл приложения `demo-app-1.yaml`:

     {% cut "demo-app1.yaml" %}

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

  1. В отдельном каталоге создайте файл `http-group.yaml`, содержащий настройки объекта `HttpBackendGroup`:

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
             name: <имя бакета>
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
         ingress.alb.yc.io/subnets: <список идентификаторов подсетей> # Одна или несколько подсетей, с которыми будет работать {{ alb-name }}.
         ingress.alb.yc.io/security-groups: <список идентификаторов групп безопасности> # Одна или несколько групп безопасности для {{ alb-name }}. Если параметр не задан, используется группа безопасности по умолчанию.
         ingress.alb.yc.io/external-ipv4-address: <auto или статический IP-адрес> # Предоставление публичного доступа к {{ alb-name }} из интернета. Укажите заранее полученный IP-адрес, либо установите значение `auto`, чтобы получить новый.
         ingress.alb.yc.io/group-name: <имя Ingress-группы> # Объединение ресурсов {{ k8s }} Ingress в группы, каждая их которых обслуживается отдельным экземпляром {{ alb-name }}.
     spec:
       tls:
         - hosts:
           - <доменное имя>
           secretName: yc-certmgr-cert-id-<идентификатор TLS-сертификата>
       rules:
         - host: <доменное имя>
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

     (Опционально) Укажите дополнительные настройки контроллера:
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

     {% note info %}

     Настройки действуют только на хосты этого контроллера, но не на всю группу Ingress.

     {% endnote %}

  1. Создайте Ingress-контроллер, объект `HttpBackendGroup` и приложение {{ k8s }}:

     ```bash
     kubectl apply -f .
     ```

  1. Дождитесь создания Ingress-контроллера и получения им публичного IP-адреса, это может занять несколько минут:

     ```bash
     kubectl get ingress alb-demo-tls
     ```

     Результат — непустое значение в поле `ADDRESS` для созданного Ingress-контроллера:

     ```bash
     NAME          CLASS   HOSTS           ADDRESS     PORTS    AGE
     alb-demo-tls  <none>  <доменное имя>  <IP-адрес>  80, 443  15h
     ```

     По конфигурации Ingress-контроллера будет автоматически развернут L7-балансировщик.

{% endlist %}

## Убедитесь в доступности приложений кластера {{ k8s }} через {{ alb-name }} {#verify-setup}

1. [Добавьте A-запись в зону](../../dns/operations/resource-record-create.md) вашего домена. В поле **Значение** укажите публичный IP-адрес Ingress-контроллера.
1. [Настройте группы безопасности балансировщика](../../application-load-balancer/concepts/application-load-balancer.md#security-groups).
1. Проверьте работу {{ alb-name }}:

   {% list tabs %}

   - Сервисы {{ k8s }}

     Откройте в браузере URI приложений:

     ```http
     https://<ваш домен>/app1
     https://<ваш домен>/app2
     ```

     Убедитесь, что приложения доступны через {{ alb-name }} и возвращают страницы с текстом `This is APP#1` и `This is APP#2` соответственно.

   - Группа бэкендов

     Откройте в браузере URI приложения:

     ```http
     https://<ваш домен>/app1
     ```

     Убедитесь, что целевые ресурсы доступны через {{ alb-name }}.

   {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:
1. [Удалите кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) {{ managed-k8s-name }}.
1. [Удалите целевые группы](../../application-load-balancer/operations/target-group-delete.md) {{ alb-name }}.
1. [Удалите бакет](../../storage/operations/buckets/delete.md) {{ objstorage-name }}.