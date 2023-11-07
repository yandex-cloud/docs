# Настройки логирования для Ingress-контроллеров {{ alb-name }}

Вы можете задать настройки логирования для [L7-балансировщиков](../../application-load-balancer/concepts/application-load-balancer.md), созданных с помощью [Ingress-контроллеров](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) {{ alb-name }} в кластере {{ managed-k8s-name }}.

Из этой статьи вы узнаете, как создать три L7-балансировщика с различными настройками логирования:

* Запись в [лог-группу по умолчанию](../../logging/concepts/log-group.md).
* Запись в пользовательскую лог-группу.
* Без записи логов.

Чтобы задать настройки для L7-балансировщиков:

1. [{#T}](#install-app).
1. [{#T}](#create-ingress).
1. [{#T}](#configure-group).
1. [{#T}](#check-result).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

### Подготовьте инфраструктуру {#deploy-infrastructure}

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

{% list tabs %}

- Вручную

    1. [Создайте сервисные аккаунты](../../iam/operations/sa/create.md) для кластера {{ managed-k8s-name }}:

        * Сервисный аккаунт для ресурсов с ролью [{{ roles-editor }}](../../iam/concepts/access-control/roles.md#editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создается [кластер {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster).
        * Сервисный аккаунт для узлов с ролью [{{ roles-cr-puller }}](../../iam/concepts/access-control/roles.md#cr-images-puller) на каталог с [реестром](../../container-registry/concepts/registry.md) Docker-образов. От его имени узлы будут скачивать из реестра необходимые Docker-образы.
        * Сервисный аккаунт для работы Ingress-контроллера {{ alb-name }} с ролями:

            * [{{ roles-alb-editor }}](../../iam/concepts/access-control/roles.md#alb-editor) — для создания необходимых ресурсов.
            * [{{ roles-vpc-public-admin }}](../../iam/concepts/access-control/roles.md#vpc-public-admin) — для управления [внешней связностью](../../vpc/security/index.md#roles-list).
            * [certificate-manager.certificates.downloader](../../iam/concepts/access-control/roles.md#certificate-manager-certificates-downloader) — для работы с сертификатами, зарегистрированными в сервисе [{{ certificate-manager-full-name }}](../../certificate-manager/).
            * [compute.viewer](../../iam/concepts/access-control/roles.md#compute-viewer) — для использования узлов кластера {{ managed-k8s-name }} в [целевых группах](../../application-load-balancer/concepts/target-group.md) балансировщика.

        Вы можете использовать один и тот же сервисный аккаунт для всех операций.

    1. [Создайте авторизованный ключ](../../iam/operations/authorized-key/create.md) для сервисного аккаунта Ingress-контроллера в формате JSON и сохраните его в файл `key.json`:

        ```bash
        yc iam key create \
           --service-account-name <имя_сервисного_аккаунта_для_Ingress-контроллера> \
           --output key.json
        ```

        Данные ключа необходимы для [установки](#install-alb-ingress-controller) приложения ALB Ingress Controller.

    1. [Создайте кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-create.md#kubernetes-cluster-create) и [группу узлов](../operations/node-group/node-group-create.md). При создании кластера укажите ранее созданные сервисные аккаунты для ресурсов и узлов и выберите для настройки **{{ ui-key.yacloud.k8s.clusters.create.field_address-type }}** значение `{{ ui-key.yacloud.k8s.clusters.create.switch_auto }}`.

    1. Настройте группы безопасности:

        * [Для кластера и группы узлов {{ managed-k8s-name }}](../operations/connect/security-groups.md).
        * [Для балансировщиков нагрузки {{ alb-name }}](../../application-load-balancer/concepts/application-load-balancer.md#security-groups).

    1. [Создайте пользовательскую лог-группу {{ cloud-logging-name }}](../../logging/operations/create-group.md).

- С помощью {{ TF }}

    1. {% include [terraform-install](../../_includes/terraform-install.md) %}
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и [укажите значения параметров](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
    1. Скачайте в ту же рабочую директорию файл конфигурации [k8s-and-registry-for-alb.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/managed-kubernetes/k8s-and-registry-for-alb.tf).

        В этом файле описаны:

        * [Сеть](../../vpc/concepts/network.md#network).
        * [Подсеть](../../vpc/concepts/network.md#subnet).
        * [Группы безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для работы [кластера {{ managed-k8s-name }}](../concepts/index.md#kubernetes-cluster) и [балансировщиков нагрузки {{ alb-name }}](../../application-load-balancer/concepts/application-load-balancer.md).
        * Кластер {{ managed-k8s-name }}.
        * [Сервисный аккаунт](../../iam/concepts/users/service-accounts.md) для ресурсов и узлов {{ managed-k8s-name }}.
        * Сервисный аккаунт для работы Ingress-контроллера {{ alb-name }}.
        * [Пользовательская лог-группа](../../logging/concepts/log-group.md) {{ cloud-logging-name }}.
        * [Авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта Ingress-контроллера.
        * Создание локального файла `key.json` с данными авторизованного ключа. Данные ключа необходимы для [установки](#install-alb-ingress-controller) приложения ALB Ingress Controller.

    1. Укажите в файле `k8s-and-registry-for-alb.tf`:

        * [Идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
        * [Версию {{ k8s }}](../../managed-kubernetes/concepts/release-channels-and-updates.md) для кластера и групп узлов {{ managed-k8s-name }}.
        * Имя сервисного аккаунта для ресурсов и узлов {{ k8s }}.
        * Имя сервисного аккаунта для работы Ingress-контроллера {{ alb-name }}.
        * Имя пользовательской лог-группы {{ cloud-logging-name }}.

    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Подготовьтесь к работе с кластером {{ managed-k8s-name }} {#prepare-k8s-cluster}

1. {% include [install-kubectl](../../_includes/managed-kubernetes/kubectl-install.md) %}

1. [Установите менеджер пакетов {{ k8s }} Helm](https://helm.sh/ru/docs/intro/install).

### Зарегистрируйте доменную зону {#register-domain}

[Зарегистрируйте публичную доменную зону и делегируйте домен](../../dns/operations/zone-create-public.md).

### Установите Ingress-контроллер {{ alb-name }} {#install-alb-ingress-controller}

Установите приложение [ALB Ingress Controller](/marketplace/products/yc/alb-ingress-controller) согласно [инструкции](../operations/applications/alb-ingress-controller.md). При установке используйте данные ключа `key.json` из раздела [{#T}](#deploy-infrastructure).

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

## Настройте Ingress-контроллеры {#create-ingress}

Создайте три ресурса [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/), из которых Ingress-контроллер {{ alb-name }} создаст три балансировщика с нужными обработчиками и HTTP-роутерами.

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

    * `ingress.alb.yc.io/group-name` — объединение ресурсов {{ k8s }} Ingress в группы, каждая их которых обслуживается отдельным экземпляром {{ alb-name }}.
    * `ingress.alb.yc.io/subnets` — одна или несколько [подсетей](../../vpc/concepts/network.md#subnet), с которыми будет работать {{ alb-name }}.
    * `ingress.alb.yc.io/security-groups` — одна или несколько [групп безопасности](../../application-load-balancer/concepts/application-load-balancer.md#security-groups) для {{ alb-name }}. Если параметр не задан, используется группа безопасности по умолчанию.
    * `ingress.alb.yc.io/external-ipv4-address` — предоставление публичного доступа к {{ alb-name }} из интернета. При значении `auto` будет использоваться новый IP-адрес. При удалении Ingress-контроллера IP-адрес также будет удален из облака.
    * `ingress.alb.yc.io/group-settings-name` — имя для настроек группы, которые должны быть описаны в дополнительном ресурсе `IngressGroupSettings`.

    (Опционально) Укажите дополнительные настройки контроллеров:

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

    Подробное описание настроек ресурса Ingress см. в статье [{#T}](../../application-load-balancer/k8s-ref/ingress.md).

1. Создайте Ingress-контроллеры:

    ```bash
    kubectl apply -f ingress.yaml
    ```

    Результат:

    ```text
    ingress.networking.k8s.io/logs-demo-nondefault created
    ingress.networking.k8s.io/logs-demo-disabled created
    ingress.networking.k8s.io/logs-demo-default created
    ```

    По конфигурациям Ingress-контроллеров будут автоматически развернуты три [L7-балансировщика](../../application-load-balancer/concepts/application-load-balancer.md).

## Настройте группы Ingress-контроллеров {#configure-group}

Создайте ресурс `IngressGroupSettings` с настройками логирования для групп Ingress-контроллеров:

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

1. Примените настройки для групп Ingress-контроллеров:

    ```bash
    kubectl apply -f settings.yaml
    ```

    Результат:

    ```text
    ingressgroupsettings.alb.yc.io/non-default-settings created
    ingressgroupsettings.alb.yc.io/logs-disabled-settings created
    ```

## Проверьте результат {#check-result}

[Получите идентификаторы лог-групп](../../application-load-balancer/operations/application-load-balancer-get-log-group-id.md) для созданных L7-балансировщиков и убедитесь, что они соответствуют настройкам в файле `settings.yaml`:

* Для одного балансировщика должна быть выбрана созданная пользовательская лог-группа с определенными правилами.
* Для другого — лог-группа по умолчанию.
* Для третьего запись логов должна быть отключена.

## Удалите созданные ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs %}

- Вручную

    1. [Удалите кластер {{ managed-k8s-name }}](../operations/kubernetes-cluster/kubernetes-cluster-delete.md).
    1. Если вы зарезервировали для кластера публичный статический IP-адрес, [удалите его](../../vpc/operations/address-delete.md).
    1. [Удалите сервисные аккаунты](../../iam/operations/sa/delete.md).
    1. [Удалите лог-группу](../../logging/operations/delete-group.md).

- С помощью {{ TF }}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    1. Удалите конфигурационный файл `k8s-and-registry-for-alb.tf`.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Все ресурсы, которые были описаны в конфигурационном файле `k8s-and-registry-for-alb.tf`, будут удалены.

{% endlist %}
