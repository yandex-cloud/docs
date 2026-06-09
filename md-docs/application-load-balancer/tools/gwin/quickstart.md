# Установка контроллера Gwin

Gwin — инструмент для управления балансировщиками нагрузки Yandex Application Load Balancer в кластерах Yandex Managed Service for Kubernetes.

Следуя этому руководству, вы установите в кластер Managed Service for Kubernetes контроллер Gwin. По конфигурации ресурсов Ingress или Gateway API контроллер автоматически развернет балансировщик Application Load Balancer, который:

* автоматически получает динамический публичный IP-адрес;
* принимает HTTP-трафик на порт `80`;
* принимает HTTPS-трафик на порт `443`, используя сертификат Certificate Manager;
* отправляет GET-запросы к тестовому сервису `example-service`.

{% note warning %}

Не изменяйте и не удаляйте балансировщик нагрузки и его дочерние ресурсы, созданные с помощью Managed Service for Kubernetes, через интерфейсы Yandex Cloud (консоль управления, Terraform, CLI и API). Это может привести к некорректной работе кластера.

{% endnote %}

## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:

* Плата за мастер Managed Service for Kubernetes (см. [тарифы Managed Service for Kubernetes](../../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера Managed Service for Kubernetes: использование вычислительных ресурсов и хранилища (см. [тарифы Compute Cloud](../../../compute/pricing.md)).
* Плата за публичные IP-адреса для хостов кластера Managed Service for Kubernetes и узлов кластера Managed Service for Kubernetes, если для них включен публичный доступ (см. [тарифы Virtual Private Cloud](../../../vpc/pricing.md#prices-public-ip)).
* Плата за использование вычислительных ресурсов балансировщика (см. [тарифы Application Load Balancer](../../pricing.md)).

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

1. [Создайте группы безопасности](../../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

    Также [настройте](../k8s-ingress-controller/security-groups.md) группы безопасности, необходимые для работы Application Load Balancer.

    {% note warning %}
    
    От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
    
    {% endnote %}

1. [Создайте кластер](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) Managed Service for Kubernetes. При создании укажите группы безопасности, подготовленные ранее.

1. [Создайте группу узлов](../../../managed-kubernetes/operations/node-group/node-group-create.md). Выделите ей публичный адрес, чтобы предоставить доступ в интернет и возможность скачивать Docker-образы и компоненты. Укажите группы безопасности, подготовленные ранее.

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

1. [Создайте сервисный аккаунт IAM](../../../iam/operations/sa/create.md), от имени которого контроллер будет создавать ресурсы Application Load Balancer, и [назначьте ему роли](../../../iam/operations/sa/assign-role-for-sa.md) на каталог:

    * [alb.editor](../../security/index.md#alb-editor) — для создания необходимых ресурсов Application Load Balancer.
    * [vpc.publicAdmin](../../../vpc/security/index.md#vpc-public-admin) — для управления внешней сетевой связностью.
    * [certificate-manager.certificates.downloader](../../../certificate-manager/security/index.md#certificate-manager-certificates-downloader) — при использовании облачных сертификатов, зарегистрированных в сервисе [Yandex Certificate Manager](../../../certificate-manager/index.md).
    * [certificate-manager.editor](../../../certificate-manager/security/index.md#certificate-manager-editor) — при использовании сертификатов кластеров Managed Service for Kubernetes. В этом случае контроллер создает соответствующие им облачные сертификаты.
    * [compute.viewer](../../../compute/security/index.md#compute-viewer) — для использования узлов кластера Managed Service for Kubernetes в [целевых группах](../../concepts/target-group.md) L7-балансировщика.
    * [k8s.viewer](../../../managed-kubernetes/security/index.md#k8s-viewer) — для определения, в какой сети контроллеру нужно развернуть L7-балансировщик.
    * (опционально) [smart-web-security.editor](../../../smartwebsecurity/security/index.md#smart-web-security-editor) — для подключения [профиля безопасности](../../../smartwebsecurity/concepts/profiles.md) Yandex Smart Web Security к виртуальному хосту L7-балансировщика.
    * (опционально) [logging.writer](../../../logging/security/index.md#logging-writer) — при указании в ресурсе [Gateway](../../../managed-kubernetes/alb-ref/gateway.md) [лог-группы](../../../logging/concepts/log-group.md) для записи логов L7-балансировщика в Yandex Cloud Logging.

1. Выберите способ аутентификации Gwin в API Yandex Cloud для создания и управления балансировщиками нагрузки Yandex Application Load Balancer.

    Аутентификация осуществляется с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) с ограниченным сроком жизни. Получить IAM-токен изнутри кластера можно следующими инструментами:
    * [Федерация сервисных аккаунтов](../../../iam/concepts/workload-identity.md) (Workload Identity Federation) — связь между внешними системами и Yandex Cloud по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC) без использования долгоживущих ключей. Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.
    * [Авторизованный ключ](../../../iam/concepts/authorization/key.md) — ключ с алгоритмом шифрования RSA-2048 или RSA-4096 с неограниченным сроком жизни.

    {% list tabs group=authentication %}

    - Федерация сервисных аккаунтов {#wlif}

      1. [Настройте](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-wlif-integration.md) поддержку федерации сервисных аккаунтов в кластере и группе узлов.
      1. [Создайте](../../../iam/operations/wlif/setup-wlif.md#create-wlif) федерацию сервисных аккаунтов:
          * В качестве **Значение Issuer (iss)** и **Допустимые значения Audience (aud)** используйте значение **URL эмитента**, полученное при настройке кластера.
          * В качестве **Адрес JWKS** используйте значение **URL набора ключей JWKS**, полученное при настройке кластера.
      1. [Привяжите](../../../iam/operations/wlif/setup-wlif.md#create-federated-credential) сервисный аккаунт IAM к федерации.

          В качестве идентификатора внешнего субъекта используйте следующее значение:
          
          ```text
          system:serviceaccount:<пространство_имен>:<имя_сервисного_аккаунта_Kubernetes>
          ```

          Где:
          * `<пространство_имен>` — пространство имен кластера, в которое вы хотите установить Gwin.
          * `<имя_сервисного_аккаунта_Kubernetes>` — имя сервисного аккаунта Kubernetes для Gwin. По умолчанию — `gwin`.

            {% note tip %}

            Чтобы переопределить имя сервисного аккаунта Kubernetes для Gwin, при [установке с помощью Helm-чарта](#helm-install) используйте параметр `--set controller.names.serviceAccount=<имя_сервисного_аккаунта_Kubernetes>`.

            {% endnote %}

      Подробнее см. на странице [Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management](../../../managed-kubernetes/tutorials/wlif-managed-k8s-integration.md).

    - Авторизованный ключ {#authorized-key}

      [Создайте](../../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) авторизованный ключ для сервисного аккаунта IAM в формате JSON и сохраните его в файл `sa-key.json`:

      ```bash
      yc iam key create \
        --service-account-name <имя_сервисного_аккаунта_IAM> \
        --output sa-key.json
      ```

    {% endlist %}

## Установите Gwin {#install}

### Установка с помощью Yandex Cloud Marketplace {#marketplace-install}

1. Перейдите на [страницу каталога](https://console.yandex.cloud) и выберите сервис **Managed Service for&nbsp;Kubernetes**.
1. Нажмите на имя нужного [кластера Managed Service for Kubernetes](../../../managed-kubernetes/concepts/index.md#kubernetes-cluster) и выберите вкладку ![image](../../../_assets/console-icons/shopping-cart.svg) **Marketplace**.
1. В разделе **Доступные для установки приложения** выберите [Gwin](https://yandex.cloud/ru/marketplace/products/yc/gwin) и нажмите кнопку **Перейти к установке**.
1. Задайте настройки приложения:
    * **Пространство имен** — создайте новое [пространство имен](../../../managed-kubernetes/concepts/index.md#namespace) (например, `gwin-space`). Если вы оставите пространство имен по умолчанию, Gwin может работать некорректно.
    * **Название приложения** — укажите название приложения.
    * **Идентификатор каталога** — укажите [идентификатор каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать Gwin.
1. В зависимости от того, какой способ аутентификации вы выбрали, укажите один из параметров:
    * **Ключ сервисного аккаунта** — скопируйте содержимое файла `sa-key.json`.
    * **Сервисный аккаунт, привязанный к WLIF** — выберите сервисный аккаунт IAM, настроенный ранее.
1. Нажмите кнопку **Установить**.
1. Дождитесь перехода приложения в статус `Deployed`.

### Установка с помощью Helm-чарта {#helm-install}

1. [Установите менеджер пакетов Helm](https://helm.sh/ru/docs/intro/install/) версии не ниже 3.8.0.

1. Для установки [Helm-чарта](https://helm.sh/docs/topics/charts/) с контроллером Gwin в зависимости от выбранного способа аутентификации выполните команду:

    {% list tabs group=authentication %}

    - Федерация сервисных аккаунтов {#wlif}

      ```bash
      helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/gwin/gwin-chart \
        --version v1.4.0 \
        --untar \
      helm install \
        --namespace <пространство_имен> \
        --create-namespace \
        --set controller.folderId=<идентификатор_каталога> \
        --set controller.ycServiceAccount.workloadIdentityFederation.serviceAccountID=<идентификатор_сервисного_аккаунта_IAM> \
        gwin ./gwin-chart
      ```

    - Авторизованный ключ {#authorized-key}

      ```bash
      helm pull oci://cr.yandex/yc-marketplace/yandex-cloud/gwin/gwin-chart \
        --version v1.4.0 \
        --untar \
      helm install \
        --namespace <пространство_имен> \
        --create-namespace \
        --set controller.folderId=<идентификатор_каталога> \
        --set-file controller.ycServiceAccount.secret.value=./sa-key.json \
        gwin ./gwin-chart
      ```

    {% endlist %}

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

1. Добавьте сертификат в Certificate Manager:

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

      Используйте идентификатор сертификата, сохраненный ранее.

      Чтобы узнать идентификаторы групп безопасности, [получите информацию об L7-балансировщике](../../operations/application-load-balancer-get.md).

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

      Используйте идентификатор сертификата, сохраненный ранее.

      Чтобы узнать идентификаторы групп безопасности, [получите информацию об L7-балансировщике](../../operations/application-load-balancer-get.md).

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

1. Убедитесь, что балансировщик Application Load Balancer создан:

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

1. [Удалите](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) кластер Managed Service for Kubernetes.

1. [Удалите](../../operations/application-load-balancer-delete.md) балансировщик Application Load Balancer.