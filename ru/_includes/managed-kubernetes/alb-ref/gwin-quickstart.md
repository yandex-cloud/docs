# Установка контроллера Gwin

Gwin — инструмент для управления балансировщиками нагрузки {{ alb-full-name }} в кластерах {{ managed-k8s-full-name }}.

Следуя этому руководству, вы установите в кластер {{ managed-k8s-name }} контроллер Gwin. По конфигурации ресурсов Ingress или Gateway API контроллер автоматически развернет балансировщик {{ alb-name }}, который:

  * автоматически получает динамический публичный IP-адрес;
  * принимает HTTP-трафик на порт `80`;
  * принимает HTTPS-трафик на порт `443`, используя сертификат {{ certificate-manager-name }};
  * отправляет GET-запросы к тестовому сервису `example-service`.

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за мастер {{ managed-k8s-name }} (см. [тарифы {{ managed-k8s-name }}](../../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера {{ managed-k8s-name }}: использование вычислительных ресурсов и хранилища (см. [тарифы {{ compute-name }}](../../../compute/pricing.md)).
* Плата за публичные IP-адреса для хостов кластера {{ managed-k8s-name }} и узлов кластера {{ managed-k8s-name }}, если для них включен публичный доступ (см. [тарифы {{ vpc-name }}](../../../vpc/pricing.md#prices-public-ip)).
* Плата за использование вычислительных ресурсов балансировщика (см. [тарифы {{ alb-name }}](../../../application-load-balancer/pricing.md)).

## Перед началом работы {#before-you-begin}

1. {% include [cli-install](../../cli-install.md) %}

   {% include [default-catalogue](../../default-catalogue.md) %}

1. {% include [configure-sg-manual](../security-groups/configure-sg-manual-lvl3.md) %}

   {% include [configure-sg-alb-manual](../security-groups/configure-sg-alb-manual.md) %}

   {% include [sg-common-warning](../security-groups/sg-common-warning.md) %}

1. [Создайте кластер](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) {{ managed-k8s-name }}. При создании укажите группы безопасности, подготовленные ранее.

1. {% include [create-node-group](../../../_includes/application-load-balancer/k8s-ingress-controller-create-node-group.md) %}

1. {% include [kubectl-install](../kubectl-install.md) %}

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md), от имени которого контроллер будет создавать ресурсы {{ alb-name }}, и [назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md) на каталог:

   * [alb.editor](../../../application-load-balancer/security/index.md#alb-editor) — для создания необходимых ресурсов {{ alb-name }}.
   * [vpc.publicAdmin](../../../vpc/security/index.md#vpc-public-admin) — для управления внешней сетевой связностью.
   * [certificate-manager.certificates.downloader](../../../certificate-manager/security/index.md#certificate-manager-certificates-downloader) — если используются облачные сертификаты, зарегистрированные в сервисе [{{ certificate-manager-full-name }}](../../../certificate-manager/).
   * [certificate-manager.editor](../../../certificate-manager/security/index.md#certificate-manager.editor) — если используются сертификаты кластера {{ managed-k8s-name }}. В этом случае контроллер создает соответствующие им облачные сертификаты.
   * [compute.viewer](../../../compute/security/index.md#compute-viewer) — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../../application-load-balancer/concepts/target-group.md) L7-балансировщика.
   * [k8s.viewer](../../../managed-kubernetes/security/index.md#k8s-viewer) — чтобы контроллер мог определить, в какой сети нужно развернуть L7-балансировщик.
   * (опционально) [smart-web-security.editor](../../../smartwebsecurity/security/index.md#smart-web-security-editor) — для подключения [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) {{ sws-full-name }} к виртуальному хосту L7-балансировщика.
   * (опционально) [logging.writer](../../../logging/security/index.md#logging-writer) — если в ресурсе [Gateway](../../../managed-kubernetes/alb-ref/gateway.md) указана [лог-группа](../../../logging/concepts/log-group.md) для записи логов L7-балансировщика в {{ cloud-logging-full-name }}.

1. [Создайте авторизованный ключ доступа](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта в формате JSON и сохраните его в файл `sa-key.json`:

    ```bash
    yc iam key create \
      --service-account-name <имя_сервисного_аккаунта> \
      --output sa-key.json
    ```

## Установите Gwin {#install}

### Установка с помощью {{ marketplace-full-name }} {#marketplace-install}

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kubernetes }}**.
1. Нажмите на имя нужного [кластера {{ managed-k8s-name }}](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **{{ ui-key.yacloud.k8s.cluster.switch_marketplace }}**.
1. В разделе **{{ ui-key.yacloud.marketplace-v2.label_available-products }}** выберите [Gwin](/marketplace/products/yc/gwin) и нажмите кнопку **{{ ui-key.yacloud.marketplace-v2.button_k8s-product-use }}**.
1. Задайте настройки приложения:

   * **Пространство имен** — создайте новое [пространство имен](../../../managed-kubernetes/concepts/index.md#namespace) (например, `gwin-space`). Если вы оставите пространство имен по умолчанию, Gwin может работать некорректно.
   * **Название приложения** — укажите название приложения.
   * **Идентификатор каталога** — укажите [идентификатор каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать Gwin.
   * **Ключ сервисного аккаунта** — скопируйте содержимое файла `sa-key.json`.

1. Нажмите кнопку **{{ ui-key.yacloud.k8s.cluster.marketplace.button_install }}**.
1. Дождитесь перехода приложения в статус `Deployed`.

### Установка с помощью Helm-чарта {#helm-install}

1. {% include [helm-install](../helm-install.md) %}

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с контроллером Gwin выполните команду:

    ```bash
    helm pull oci://{{ mkt-k8s-key.yc_gwin.helmChart.name }} \
      --version {{ mkt-k8s-key.yc_gwin.helmChart.tag }} \
      --untar \
    helm install \
      --namespace <пространство_имен> \
      --create-namespace \
      --set controller.folderId=<идентификатор_каталога> \
      --set-file controller.ycServiceAccount.secret.value=./sa-key.json \
      gwin ./gwin-chart
    ```

      Если вы укажете в параметре `namespace` пространство имен по умолчанию, Gwin может работать некорректно. Рекомендуется указывать значение, отличное от всех существующих пространств имен (например, `gwin-space`).

      Идентификатор каталога можно запросить со [списком каталогов в облаке](../../../resource-manager/operations/folder/get-id.md).

## Подготовьте тестовое приложение {#create-test-app}

Чтобы проверить работу контроллера Gwin, создайте тестовое приложение `example-app`:

1. Создайте [пользовательский сертификат](../../../certificate-manager/concepts/imported-certificate.md) для домена, который будет использоваться приложением:

    ```bash
    openssl req -x509 -newkey rsa:4096 -keyout example-com.key -out example-com.crt -days 365 -nodes -subj \
    "/C=RU/ST=Moscow/L=Moscow/O=Example/OU=IT/CN=example.com"
    ```

    Команда выпустит самоподписанный сертификат и сгенерирует для него приватный ключ. Будут созданы два файла:
    
      * `example-com.crt` — для сертификата.
      * `example-com.key` — для приватного ключа.

1. Добавьте сертификат в {{ certificate-manager-name }}:

    ```bash
    yc certificate-manager certificate create \
      --folder-id <идентификатор_каталога> \
      --name example-certificate \
      --chain example-com.crt \
      --key example-com.key
    ```

    Проверьте результат и сохраните идентификатор сертификата, указанный в поле `id`:

    ```bash
    id: fpqmg47avvim********
    folder_id: b1g7gvsi89m3********
    created_at: "2020-09-15T06:54:44.916325Z"
    ...
    issued_at: "2020-09-15T06:54:44.916325Z"
    not_after: "2021-09-15T06:48:26Z"
    not_before: "2020-09-15T06:48:26Z"
    ```

1. Создайте для приложения пространство имен:

    ```bash
    kubectl create namespace example-ns
    ```

1. В отдельной директории создайте конфигурационный файл приложения `example-app.yaml`:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: example-deployment
      namespace: example-ns
      labels:
        app: example-app
    spec:
      replicas: 2
      selector:
        matchLabels:
          app: example-app
      template:
        metadata:
          labels:
            app: example-app
        spec:
          containers:
          - name: nginx
            image: nginx:alpine
            ports:
            - containerPort: 80
            volumeMounts:
            - name: config-volume
              mountPath: /etc/nginx/conf.d
          volumes:
          - name: config-volume
            configMap:
              name: example-html
    ---
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: example-html
      namespace: example-ns
    data:
      default.conf: |
        server {
            listen 80;
            server_name _;
            
            location / {
                return 200 'Hello World';
                add_header Content-Type text/plain;
            }
        }
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: example-service
      namespace: example-ns
      labels:
        app: example-app
    spec:
      type: NodePort
      ports:
      - port: 80
        targetPort: 80
        nodePort: 30080
        protocol: TCP
        name: http
      selector:
        app: example-app
    ```

1. В той же директории создайте конфигурационный файл `resources.yaml` для ресурсов Gateway API или Ingress:

    {% list tabs group=instructions %}

    - Gateway API {#gw}

      ```yaml
      apiVersion: gateway.networking.k8s.io/v1
      kind: Gateway
      metadata:
        name: example-gateway
        namespace: example-ns
        annotations:
          gwin.yandex.cloud/securityGroups: <идентификаторы_групп_безопасности_балансировщика>
      spec:
        gatewayClassName: gwin-default
        listeners:
          - name: http
            protocol: HTTP
            port: 80
            hostname: "example.com"
            allowedRoutes:
              namespaces:
                from: Same
          - name: https
            protocol: HTTPS
            port: 443
            hostname: "example.com"
            allowedRoutes:
              namespaces:
                from: Same
            tls:
              certificateRefs:
                - group: gwin.yandex.cloud
                  kind: YCCertificate
                  name: example-certificate
        addresses:
          - type: gwin.yandex.cloud/autoIPv4
            value: auto
      ---
      apiVersion: gateway.networking.k8s.io/v1
      kind: HTTPRoute
      metadata:
        name: example-redirect-httproute
        namespace: example-ns
      spec:
        hostnames:
          - "example.com"
        parentRefs:
          - name: example-gateway
            sectionName: http
        rules:
          - filters:
              - type: RequestRedirect
                requestRedirect:
                  scheme: https
                  statusCode: 301
      ---
      apiVersion: gateway.networking.k8s.io/v1
      kind: HTTPRoute
      metadata:
        name: example-httproute
        namespace: example-ns
      spec:
        hostnames:
          - "example.com"
        parentRefs:
          - name: example-gateway
            sectionName: https
        rules:
          - matches:
              - path:
                  value: /api
                  type: PathPrefix
                method: GET
            backendRefs:
              - kind: Service
                name: example-service
                port: 80
      ---
      apiVersion: gwin.yandex.cloud/v1
      kind: YCCertificate
      metadata:
        name: example-certificate
        namespace: example-ns
      spec:
        certificateRef:
          certificateID: "<идентификатор_сертификата>"
      ```

    - Ingress {#ingress}

      ```yaml
      apiVersion: networking.k8s.io/v1
      kind: Ingress
      metadata:
        name: example-ingress
        namespace: example-ns
        annotations:
          gwin.yandex.cloud/groupName: example
          gwin.yandex.cloud/externalIPv4Address: auto
          gwin.yandex.cloud/rules.allowedMethods: "GET"
          gwin.yandex.cloud/securityGroups: <идентификаторы_групп_безопасности_балансировщика>
      spec:
        ingressClassName: gwin-default
        rules:
          - host: example.com
            http:
              paths:
                - pathType: Prefix
                  path: "/api"
                  backend:
                    service:
                      name: example-service
                      port:
                        number: 80
        tls:
          - hosts:
              - example.com
            secretName: "yc-certmgr-cert-id-<идентификатор_сертификата>"
      ```

    {% endlist %}

    {% note info %}

    В примерах конфигураций балансировщику присваивается динамический публичный IP-адрес. При удалении балансировщика из облака также будет удален его IP-адрес. Чтобы избежать потери IP-адреса в производственной среде, [резервируйте](../../../vpc/operations/get-static-ip.md) и используйте статический IP-адрес.

    {% endnote %}

1. Примените файлы конфигурации:

    ```bash
    kubectl apply -f example-app.yaml && \
    kubectl apply -f resources.yaml
    ```

## Проверьте результат

1. Убедитесь, что балансировщик {{ alb-name }} создан:

    {% list tabs group=instructions %}

    - Gateway API {#gw}

      1. Выполните команду:

          ```bash
          kubectl get gateway -n example-ns example-gateway
          ```

      1. Проверьте, что в поле `ADDRESS` вывода команды отображается IP-адрес балансировщика:

          ```bash
          NAME              CLASS           ADDRESS      PROGRAMMED      AGE
          example-gateway   gwin-default    <IP-адрес>                   32h
          ```

    - Ingress {#ingress}

      1. Выполните команду:

          ```bash
          kubectl get ingress -n example-ns example-ingress
          ```

      1. Проверьте, что в поле `ADDRESS` вывода команды отображается IP-адрес балансировщика:

          ```bash
          NAME              CLASS         HOSTS         ADDRESS       PORTS       AGE
          example-ingress   gwin-default  example.com   <IP-адрес>    80, 443     31h
          ```

    {% endlist %}

1. Убедитесь, что при запросах к тестовому приложению выполняется перенаправление с HTTP на HTTPS:

    ```bash
    curl -I <IP-адрес_балансировщика> -H "Host:example.com"
    ```

    Ожидаемый результат:

    ```bash
    HTTP/1.1 301 Moved Permanently
    location: https://example.com:443/
    date: Sat, 06 Sep 2025 23:09:19 GMT
    server: ycalb
    transfer-encoding: chunked
    ```

1. Убедитесь, что выполняются HTTPS-запросы к тестовому приложению:

    ```bash
    curl --resolve example.com:443:<IP-адрес_балансировщика> \
      --cacert example-com.crt \
      https://example.com/api/hello
    ```

    Ожидаемый результат:

    ```bash
    Hello World
    ```

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Удалите ресурсы, которые вы больше не будете использовать, чтобы за них не списывалась плата:

1. [Удалите](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) кластер {{ managed-k8s-name }}.

1. [Удалите](../../../application-load-balancer/operations/application-load-balancer-delete.md) балансировщик {{ alb-name }}.

