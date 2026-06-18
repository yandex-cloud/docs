# Настройка логирования для L7-балансировщика Yandex Application Load Balancer с помощью Ingress-контроллера

Вы можете задать настройки логирования для [L7-балансировщиков](../../application-load-balancer/concepts/application-load-balancer.md), созданных с помощью [Ingress-контроллеров](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) Application Load Balancer в кластере Managed Service for Kubernetes.

{% note tip %}

Вместо ALB Ingress-контроллера и Gateway API рекомендуется использовать новый контроллер [Yandex Cloud Gwin](../../application-load-balancer/tools/gwin/index.md).

{% endnote %}

Из этой статьи вы узнаете, как создать три L7-балансировщика с различными настройками логирования:

* Запись в [лог-группу по умолчанию](../concepts/log-group.md).
* Запись в пользовательскую лог-группу.
* Без записи логов.

Чтобы задать настройки для L7-балансировщиков:

1. [Создайте тестовое приложение](#install-app).
1. [Создайте ресурсы Ingress](#create-ingress).
1. [Задайте настройки для групп ресурсов Ingress](#configure-group).
1. [Проверьте результат](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за DNS-зону и DNS-запросы ([тарифы Cloud DNS](../../dns/pricing.md)).
* Плата за кластер Managed Service for Kubernetes: использование мастера и исходящий трафик ([тарифы Managed Service for Kubernetes](../../managed-kubernetes/pricing.md)).
* Плата за узлы кластера (ВМ): использование вычислительных ресурсов, операционной системы и хранилища ([тарифы Compute Cloud](../../compute/pricing.md)).
* Плата за использование вычислительных ресурсов каждого L7-балансировщика ([тарифы Application Load Balancer](../../application-load-balancer/pricing.md)).
* Плата за публичные IP-адреса для узлов кластера и L7-балансировщиков ([тарифы Virtual Private Cloud](../../vpc/pricing.md#prices-public-ip)).
* Плата за сервис Cloud Logging: запись и хранение данных ([тарифы Cloud Logging](../pricing.md)).


## Перед началом работы {#before-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md) для кластера Managed Service for Kubernetes:

        * Сервисный аккаунт для ресурсов с [ролями](../../managed-kubernetes/security/index.md#yc-api) `k8s.clusters.agent` и `vpc.publicAdmin` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается [кластер Managed Service for Kubernetes](../../managed-kubernetes/concepts/index.md#kubernetes-cluster).
        * Сервисный аккаунт для узлов с ролью [container-registry.images.puller](../../container-registry/security/index.md#container-registry-images-puller) на каталог с [реестром](../../container-registry/concepts/registry.md) Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
        * Сервисный аккаунт для работы Ingress-контроллера Application Load Balancer с ролями:

            * [alb.editor](../../application-load-balancer/security/index.md#alb-editor) — для создания необходимых ресурсов.
            * [vpc.publicAdmin](../../vpc/security/index.md#vpc-public-admin) — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
            * [certificate-manager.certificates.downloader](../../certificate-manager/security/index.md#certificate-manager-certificates-downloader) — для работы с сертификатами, зарегистрированными в сервисе [Yandex Certificate Manager](../../certificate-manager/index.md).
            * [compute.viewer](../../compute/security/index.md#compute-viewer) — для использования узлов кластера Managed Service for Kubernetes в [целевых группах](../../application-load-balancer/concepts/target-group.md) балансировщика.

        Вы можете использовать один и тот же сервисный аккаунт для всех операций.

    1. [Создайте авторизованный ключ](../../iam/operations/authentication/manage-authorized-keys.md#create-authorized-key) для сервисного аккаунта Ingress-контроллера в формате JSON и сохраните его в файл `key.json`:

        ```bash
        yc iam key create \
           --service-account-name <имя_сервисного_аккаунта_для_Ingress-контроллера> \
           --output key.json
        ```

        Данные ключа необходимы для [установки](#install-alb-ingress-controller) приложения ALB Ingress Controller.

    1. [Создайте группы безопасности](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

        Также [настройте](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) группы безопасности, необходимые для работы Application Load Balancer.

        {% note warning %}
        
        От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
        
        {% endnote %}

    1. [Создайте кластер](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) Managed Service for Kubernetes. При создании задайте настройки:

        * Укажите ранее созданные сервисный аккаунт для ресурсов и группы безопасности.
        * Если вы планируете работать с кластером в пределах сети Yandex Cloud, выделять кластеру публичный IP-адрес не нужно. Для подключений извне предоставьте кластеру публичный адрес.

    1. [Создайте группу узлов](../../managed-kubernetes/operations/node-group/node-group-create.md). При создании задайте настройки:

        * Укажите ранее созданные сервисный аккаунт для узлов и группы безопасности.
        * Выделите публичный IP-адрес, чтобы предоставить группе узлов доступ в интернет и возможность скачивать Docker-образы и компоненты.

    1. [Создайте пользовательскую лог-группу Cloud Logging](../operations/create-group.md).

- Terraform {#tf}

    1. Если у вас еще нет Terraform, [установите его](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

    1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-and-registry-for-alb.tf](https://github.com/yandex-cloud-examples/yc-mk8s-ingress-controller-logging/blob/main/k8s-and-registry-for-alb.tf).

        В этом файле описаны:

        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * Кластер Managed Service for Kubernetes.
        * [Группы безопасности](../../vpc/concepts/security-groups.md), которые содержат [необходимые правила](../../managed-kubernetes/operations/connect/security-groups.md) для кластера Managed Service for Kubernetes и входящих в него групп узлов.

            [Часть правил](../../application-load-balancer/tools/k8s-ingress-controller/security-groups.md) необходима для работы Application Load Balancer.

            {% note warning %}
            
            От настройки групп безопасности зависит работоспособность и доступность кластера, а также запущенных в нем сервисов и приложений.
            
            {% endnote %}

        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов Managed Service for Kubernetes.
        * Сервисный аккаунт для работы Ingress-контроллера Application Load Balancer.
        * [Пользовательская лог-группа](../concepts/log-group.md) Cloud Logging.
        * [Авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта Ingress-контроллера.
        * Создание локального файла `key.json` с данными авторизованного ключа. Данные ключа необходимы для [установки](#install-alb-ingress-controller) приложения ALB Ingress Controller.

    1. Укажите в файле `k8s-and-registry-for-alb.tf`:

        * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * [Версию Kubernetes](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов Managed Service for Kubernetes.
        * Имя сервисного аккаунта для ресурсов и узлов Kubernetes.
        * Имя сервисного аккаунта для работы Ingress-контроллера Application Load Balancer.
        * Имя пользовательской лог-группы Cloud Logging.

    1. Проверьте корректность файлов конфигурации Terraform с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, Terraform на них укажет.

    1. Создайте необходимую инфраструктуру:

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud).

{% endlist %}

### Подготовьтесь к работе с кластером Managed Service for Kubernetes {#prepare-k8s-cluster}

1. [Установите kubectl](https://kubernetes.io/ru/docs/tasks/tools/install-kubectl) и [настройте его на работу с созданным кластером](../../managed-kubernetes/operations/connect/index.md#kubectl-connect).

   Если для кластера не предоставлен публичный адрес и `kubectl` настроен через внутренний адрес кластера, выполняйте команды `kubectl` на ВМ Yandex Cloud, находящейся в одной сети с кластером.

1. [Установите менеджер пакетов Kubernetes Helm](https://helm.sh/ru/docs/intro/install).

### Зарегистрируйте доменную зону {#register-domain}

[Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).

### Установите Ingress-контроллер Application Load Balancer {#install-alb-ingress-controller}

Установите приложение [ALB Ingress Controller](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller) согласно [инструкции](../../managed-kubernetes/operations/applications/alb-ingress-controller.md). При установке используйте данные ключа `key.json` из раздела [Подготовьте инфраструктуру](#deploy-infrastructure).

## Создайте тестовое приложение {#install-app}

Создайте объекты [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/), [Deployment](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/) с NGINX и [Service](https://kubernetes.io/docs/concepts/services-networking/service/) для приложения.

1. Создайте файл приложения `app.yaml`:

    {% cut "app.yaml" %}

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

1. Создайте приложение:

    ```bash
    kubectl apply -f app.yaml
    ```

    Результат:

    ```text
    configmap/alb-demo-1 created
    deployment.apps/alb-demo-1 created
    service/alb-demo-1 created
    ```

## Создайте ресурсы Ingress {#create-ingress}

Создайте три ресурса [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), из которых Ingress-контроллер Application Load Balancer создаст три балансировщика с нужными обработчиками и HTTP-роутерами.

1. Создайте файл `ingress.yaml` и укажите в нем настройки балансировщиков и доменное имя:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: logs-demo-nondefault
      annotations:
        ingress.alb.yc.io/group-name: non-default
        ingress.alb.yc.io/subnets: <список_идентификаторов_подсетей>
        ingress.alb.yc.io/security-groups: <список_идентификаторов_групп_безопасности>
        ingress.alb.yc.io/group-settings-name: non-default-settings
        ingress.alb.yc.io/external-ipv4-address: auto
    spec:
      rules:
        - host: <доменное_имя>
          http:
            paths:
              - pathType: Prefix
                path: "/"
                backend:
                  service:
                    name: alb-demo-1
                    port: 
                      name: http
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: logs-demo-disabled
      annotations:
        ingress.alb.yc.io/group-name: logs-disabled
        ingress.alb.yc.io/subnets: <список_идентификаторов_подсетей>
        ingress.alb.yc.io/security-groups: <список_идентификаторов_групп_безопасности>
        ingress.alb.yc.io/group-settings-name: logs-disabled-settings
        ingress.alb.yc.io/external-ipv4-address: auto
    spec:
      rules:
        - host: <доменное_имя>
          http:
            paths:
              - pathType: Prefix
                path: "/"
                backend:
                  service:
                    name: alb-demo-1
                    port:
                      name: http
    ---
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: logs-demo-default
      annotations:
        ingress.alb.yc.io/group-name: default
        ingress.alb.yc.io/subnets: <список_идентификаторов_подсетей>
        ingress.alb.yc.io/security-groups: <список_идентификаторов_групп_безопасности>
        ingress.alb.yc.io/external-ipv4-address: auto
    spec:
      rules:
        - host: <доменное_имя>
          http:
            paths:
              - pathType: Prefix
                path: "/"
                backend:
                  service:
                    name: alb-demo-1
                    port:
                      name: http
    ```

    Где:

    * `ingress.alb.yc.io/group-name` — имя группы. Ресурсы Ingress объединяются в группы, каждая из которых обслуживается отдельным L7-балансировщиком Application Load Balancer.
    * `ingress.alb.yc.io/subnets` — одна или несколько [подсетей](../../vpc/concepts/network.md#subnet), в которых будет расположен балансировщик.
    * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для балансировщика. Если параметр не задан, используется группа безопасности по умолчанию.
    * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к балансировщику из интернета. Укажите [заранее полученный IP-адрес](../../vpc/operations/get-static-ip.md) либо установите значение `auto`, чтобы получить новый.

       Если вы указали значение `auto`, то при удалении балансировщика из [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) также будет удален его [IP-адрес](../../vpc/concepts/address.md). Чтобы избежать этого, используйте имеющийся зарезервированный адрес.

    * `ingress.alb.yc.io/group-settings-name` — имя для настроек группы ресурсов Ingress, которые должны быть описаны в дополнительном ресурсе `IngressGroupSettings`.

    (Опционально) Укажите дополнительные настройки контроллеров.

    {% note info %}
    
    Перечисленные ниже настройки будут применены только к [виртуальным хостам](../../application-load-balancer/tools/k8s-ingress-controller/principles.md#mapping) для ресурса Ingress, в котором заданы аннотации, соответствующие этим настройкам.
    
    К виртуальным хостам остальных ресурсов Ingress в группе эти настройки применены не будут.
    
    {% endnote %}

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

        В [ALB Ingress Controller](https://yandex.cloud/ru/marketplace/products/yc/alb-ingress-controller) версии 0.2.0 и позднее аннотация используется только в объекте [Service](../../application-load-balancer/k8s-ref/service-for-ingress.md#metadata).

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

    Подробное описание настроек ресурса Ingress смотрите в статье [Поля и аннотации ресурса Ingress](../../managed-kubernetes/alb-ref/ingress.md).

1. Создайте ресурсы Ingress:

    ```bash
    kubectl apply -f ingress.yaml
    ```

    Результат:

    ```text
    ingress.networking.k8s.io/logs-demo-nondefault created
    ingress.networking.k8s.io/logs-demo-disabled created
    ingress.networking.k8s.io/logs-demo-default created
    ```

    По конфигурациям ресурсов Ingress будут автоматически развернуты три [L7-балансировщика](../../application-load-balancer/concepts/application-load-balancer.md).

## Задайте настройки для групп ресурсов Ingress {#configure-group}

Создайте ресурс `IngressGroupSettings` с настройками логирования для групп ресурсов Ingress:

* `non-default-settings` — запись в пользовательскую лог-группу, созданную [ранее](#deploy-infrastructure), с определенными правилами.
* `logs-disabled-settings` — запись логов отключена.

Для записи в лог-группу по умолчанию настройки не указываются.

1. Создайте файл `settings.yaml` и укажите в нем идентификатор лог-группы:

    ```yaml
    apiVersion: alb.yc.io/v1alpha1
    kind: IngressGroupSettings
    metadata:
      name: non-default-settings
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
    ---
    apiVersion: alb.yc.io/v1alpha1
    kind: IngressGroupSettings
    metadata:
      name: logs-disabled-settings
    logOptions:
      disable: true
    ```

1. Создайте ресурсы:

    ```bash
    kubectl apply -f settings.yaml
    ```

    Результат:

    ```text
    ingressgroupsettings.alb.yc.io/non-default-settings created
    ingressgroupsettings.alb.yc.io/logs-disabled-settings created
    ```

Настройки, указанные в этих ресурсах, применятся к группам ресурсов Ingress в соответствии с аннотациями `ingress.alb.yc.io/group-settings-name`, [указанными для ресурсов Ingress](#create-ingress).

## Проверьте результат {#check-result}

[Получите идентификаторы лог-групп](../../application-load-balancer/operations/application-load-balancer-get-log-group-id.md) для созданных L7-балансировщиков и убедитесь, что они соответствуют настройкам в файле `settings.yaml`:

* Для одного балансировщика должна быть выбрана созданная пользовательская лог-группа с определенными правилами.
* Для другого — лог-группа по умолчанию.
* Для третьего запись логов должна быть отключена.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите кластер Managed Service for Kubernetes](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md).
    1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
    1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
    1. [Удалите лог-группу](../operations/delete-group.md).

- Terraform {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет Terraform-манифестов с ресурсами, которые вы хотите сохранить. Terraform удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в Terraform-манифестах, будут удалены.

{% endlist %}