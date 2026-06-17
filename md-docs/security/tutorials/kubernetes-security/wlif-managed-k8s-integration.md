# Доступ к API Yandex Cloud из кластера Managed Service for Kubernetes с помощью федерации сервисных аккаунтов Identity and Access Management

В Managed Service for Kubernetes реализована интеграция с _федерациями сервисных аккаунтов_ Identity and Access Management.

[Федерации сервисных аккаунтов](../../../iam/concepts/workload-identity.md) (Workload Identity Federation) позволяют настроить связь между внешними системами и Yandex Cloud по протоколу [OpenID Connect](https://openid.net/developers/how-connect-works/) (OIDC). За счет этого внешние системы могут выполнять действия с ресурсами Yandex Cloud от имени [сервисных аккаунтов](../../../iam/concepts/users/service-accounts.md) IAM без использования [авторизованных ключей](../../../iam/concepts/authorization/key.md). Это более безопасный способ, минимизирующий риск утечки учетных данных и возможность несанкционированного доступа.

При включении опции Managed Service for Kubernetes автоматически создает для конкретного кластера OIDC-провайдер и предоставляет следующие параметры для интеграции с федерациями сервисных аккаунтов:
* `URL эмитента`.
* `URL набора ключей JWKS`.

![image](../../../_assets/managed-kubernetes/mk8s-wlif.svg)

В этом руководстве для примера показано, как получить значение [секрета](../../../lockbox/concepts/secret.md) Yandex Lockbox со стороны кластера Managed Service for Kubernetes от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) Identity and Access Management. 

Аналогичным образом можно выполнить любое действие через [Yandex Cloud CLI](../../../cli/quickstart.md), [Terraform](../../../terraform/quickstart.md), [SDK](../../../overview/sdk/overview.md) или [API](../../../api-design-guide/index.md).

{% note info %}

В руководстве представлен пример интеграции кластера Managed Service for Kubernetes с федерацией сервисных аккаунтов. Руководство по интеграции пользовательской инсталляции Kubernetes см. на странице [Получение значения секрета Yandex Lockbox на стороне пользовательской инсталляции Kubernetes](../../../tutorials/security/wlif-k8s-integration.md).

{% endnote %}

Чтобы с помощью федерации сервисных аккаунтов настроить доступ к секрету Yandex Lockbox из кластера Managed Service for Kubernetes через API Yandex Cloud:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте кластер Managed Service for Kubernetes](#prepare-cluster).
1. [Создайте федерацию сервисных аккаунтов](#create-wlif).
1. [Подготовьте сервисный аккаунт IAM](#prepare-sa).
1. [Подготовьте сервисный аккаунт Kubernetes](#prepare-sa-k8s).
1. [Привяжите сервисный аккаунт IAM к федерации](#connect-sa).
1. [Создайте секрет Yandex Lockbox](#create-secret).
1. [Проверьте работу интеграции](#check-integration).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* Плата за вычислительные ресурсы и диски [узлов](../../../managed-kubernetes/concepts/index.md#node-group) кластера Managed Service for Kubernetes ([тарифы Yandex Compute Cloud](../../../compute/pricing.md)).
* Плата за использование [мастера](../../../managed-kubernetes/concepts/index.md#master) Managed Service for Kubernetes и исходящий трафик ([тарифы Managed Service for Kubernetes](../../../managed-kubernetes/pricing.md)).
* Плата за [публичные IP-адреса](../../../vpc/concepts/address.md#public-addresses) кластера Managed Service for Kubernetes ([тарифы Yandex Virtual Private Cloud](../../../vpc/pricing.md)).
* Плата за хранение [секрета](../../../lockbox/concepts/secret.md) и запросы к нему ([тарифы Yandex Lockbox](../../../lockbox/pricing.md)).

## Настройте кластер Managed Service for Kubernetes {#prepare-cluster}

1. Если у вас еще нет кластера Managed Service for Kubernetes:
    1. [Создайте](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create.md) кластер.

    1. [Создайте](../../../managed-kubernetes/operations/node-group/node-group-create.md) группу узлов.
    1. [Настройте](../../../managed-kubernetes/operations/connect/security-groups.md) группы безопасности для кластера и группы узлов.
1. Для доступа к API Yandex Cloud у узлов кластера должен быть доступ в интернет. Убедитесь, что узлам кластера назначены публичные IP-адреса, или в подсети, где размещаются узлы, настроен [NAT-шлюз](../../../vpc/concepts/gateways.md#nat-gateway) или [NAT-инстанс](../../../tutorials/routing/nat-instance/index.md). Также убедитесь, что правилами группы безопасности разрешен весь исходящий трафик для узлов кластера.
1. Настройте интеграцию с федерацией сервисных аккаунтов для кластера и группы узлов:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором размещен кластер.
      1. Перейдите в сервис **Managed Service for&nbsp;Kubernetes**.
      1. Напротив кластера нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
      1. В поле **Управление идентификацией и доступом** включите федерацию сервисных аккаунтов.
      1. Нажмите **Сохранить**.
      1. На обзорной странице кластера в блоке **Управление идентификацией и доступом** скопируйте значения параметров **URL эмитента** и **URL набора ключей JWKS**. Они понадобятся для дальнейшей интеграции.
      1. Перейдите на вкладку **Группы узлов**.
      1. Напротив группы узлов нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
      1. В поле **Управление идентификацией и доступом** включите федерацию сервисных аккаунтов.
      1. Нажмите **Сохранить**.

    - CLI {#cli}

      Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

      1. Включите поддержку интеграции с федерацией сервисных аккаунтов в кластере:

          ```bash
          yc managed-kubernetes cluster update \
            --id <идентификатор_кластера> \
            --enable-workload-identity-federation
          ```

          Результат:

          ```text
          done (3s)
          ...
          workload_identity_federation:
            enabled: true
            issuer: https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/catc7433801j********
            jwks_uri: https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/catc7433801j********/jwks.json
          ```

          Скопируйте значения параметров `workload_identity_federation.issuer` и `workload_identity_federation.jwks_uri`. Они понадобятся для дальнейшей интеграции.

      1. Включите поддержку интеграции с федерацией сервисных аккаунтов в группе узлов:

          ```bash
          yc managed-kubernetes node-group update \
            --id <идентификатор_группы_узлов> \
            --enable-workload-identity-federation
          ```

          Результат:

          ```text
          done (12s)
          ...
          workload_identity_federation:
            enabled: true
          ```

    - Terraform {#tf}

      [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
      
      Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
      
      Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

      Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
      
      
      Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

      1. В конфигурационном файле Terraform добавьте в манифест кластера блок `workload_identity_federation`:

          ```hcl
          resource "yandex_kubernetes_cluster" "my_cluster" {
          ...
            workload_identity_federation {
              enabled = true
            }
          }
          ```

      1. В конфигурационном файле Terraform добавьте в манифест группы узлов блок `workload_identity_federation`:

          ```hcl
          resource "yandex_kubernetes_node_group" "my_node_group" {
          ...
            workload_identity_federation {
              enabled = true
            }
          }
          ```

      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
          1. Выполните команду:
          
             ```bash
             terraform validate
             ```
          
             Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Подтвердите изменение ресурсов.

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

      1. Получите URL эмитента (`issuer`) и URL набора ключей JWKS (`jwks_uri`) для настройки федерации сервисных аккаунтов с помощью источника данных Terraform [yandex_kubernetes_cluster](../../../terraform/data-sources/kubernetes_cluster.md).

          Также вы можете [узнать](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-list.md#get) эти параметры в [консоли управления](https://console.yandex.cloud), с помощью CLI или API.

    - API {#api}

      1. Воспользуйтесь методом REST API [update](../../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/update.md) для ресурса [Cluster](../../../managed-kubernetes/managed-kubernetes/api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../../../managed-kubernetes/managed-kubernetes/api-ref/grpc/Cluster/update.md).

          {% note info %}
          
          Ниже перечислены параметры для тела запроса к REST API. Чтобы указать параметр в вызове gRPC API, преобразуйте его имя из [lowerCamelCase](https://ru.wikipedia.org/wiki/CamelCase) в [snake_case](https://ru.wikipedia.org/wiki/Snake_case). Например, параметр `minResourcePresetId` преобразуется в `min_resource_preset_id`.
          
          {% endnote %}

          Передайте в запросе:
          * Идентификатор кластера в параметре `clusterId`.
          * Параметр `updateMask` со значением `workloadIdentityFederation.enabled`.

            {% note warning %}
            
            Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
            
            {% endnote %}

          * Параметр `workloadIdentityFederation` со значением `"enabled": "true"`.

          Скопируйте из ответа значения параметров `workloadIdentityFederation.issuer` и `workloadIdentityFederation.jwksUri`. Они понадобятся в дальнейшем.

      1. Воспользуйтесь методом REST API [update](../../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/update.md) для ресурса [NodeGroup](../../../managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/index.md) или вызовом gRPC API [NodeGroupService/Update](../../../managed-kubernetes/managed-kubernetes/api-ref/grpc/NodeGroup/update.md).

          Передайте в запросе:
          * Идентификатор группы узлов в параметре `nodeGroupId`.
          * Параметр `updateMask` со значением `workloadIdentityFederation.enabled`.
          * Параметр `workloadIdentityFederation` со значением `"enabled": "true"`.

    {% endlist %}

## Создайте федерацию сервисных аккаунтов {#create-wlif}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, к которому вы хотите получить доступ через API Yandex Cloud.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![cpus](../../../_assets/console-icons/cpus.svg) **Федерации сервисных аккаунтов**.
  1. Нажмите **Создать федерацию**.
  1. В поле **Значение Issuer (iss)** введите значение **URL эмитента**, полученное ранее, например `https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
  1. В поле **Допустимые значения Audience (aud)** также введите значение **URL эмитента**.
  1. В поле **Адрес JWKS** введите значение **URL набора ключей JWKS**, полученное ранее, например `https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.
  1. В поле **Имя** введите имя федерации, например `test-iam-federation`.
  1. Нажмите **Создать**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam workload-identity oidc federation create \
    --name <имя_федерации> \
    --issuer "<URL_эмитента>" \
    --audiences "<URL_эмитента>" \
    --jwks-url "<URL_набора_ключей_JWKS>"
  ```

  Где:
  * `--name` — имя создаваемой федерации, например `test-iam-federation`.
  * `--issuer` и `--audiences` — значение URL эмитента, полученное ранее, например `https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
  * `--jwks-url` — значение URL набора ключей JWKS, полученное ранее, например `https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.

  Результат:

  ```text
  id: aje2c4qv19lf********
  name: test-iam-federation
  folder_id: b1gfq9pe6rd2********
  enabled: true
  audiences:
    - https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********
  issuer: https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********
  jwks_url: https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json
  created_at: "2024-12-28T16:04:31.530652473Z"
  ```

  Сохраните идентификатор федерации, он понадобится в дальнейшем.

- Terraform {#tf}

  1. Опишите в конфигурационном файле Terraform параметры федерации, которую необходимо создать:

      ```hcl
      resource "yandex_iam_workload_identity_oidc_federation" "wlif" {
        name        = "<имя_федерации>"
        folder_id   = "<идентификатор_каталога>"
        issuer      = "<URL_эмитента>"
        audiences   = ["<URL_эмитента>"]
        jwks_url    = "<URL_набора_ключей_JWKS>"
      }
      ```

      Где:
      * `name` — имя создаваемой федерации, например `test-iam-federation`.
      * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), в котором создается федерация сервисных аккаунтов.
      * `issuer` и `audiences` — значение URL эмитента, полученное ранее, например `https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
      * `jwks_url` — значение URL набора ключей JWKS, полученное ранее, например `https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите создание ресурсов.

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

      Сохраните идентификатор федерации, он понадобится в дальнейшем.

- API {#api}

  Чтобы создать федерацию сервисных аккаунтов, воспользуйтесь методом REST API [create](../../../iam/workload/oidc/workload-identity/api-ref/Federation/create.md) для ресурса [Federation](../../../iam/workload/oidc/workload-identity/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Create](../../../iam/workload/oidc/workload-identity/api-ref/grpc/Federation/create.md).

{% endlist %}

{% endlist %}

## Подготовьте сервисный аккаунт IAM {#prepare-sa}

1. Создайте сервисный аккаунт IAM:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором размещен секрет Yandex Lockbox.
      1. Перейдите в сервис **Identity and Access Management**.
      1. Нажмите **Создать сервисный аккаунт**.
      1. Введите имя сервисного аккаунта, например `sa-lockbox`.
      1. Нажмите **Создать**.
      1. Выберите созданный сервисный аккаунт и сохраните его идентификатор, он понадобится в дальнейшем.

    - CLI {#cli}

      Выполните команду:

      ```bash
      yc iam service-account create --name sa-lockbox
      ```

      Результат:

      ```text
      done (2s)
      id: aje7s96nvmdp********
      folder_id: b1gsm0k26v1l********
      created_at: "2026-03-12T12:16:01Z"
      name: sa-lockbox
      ```

      Сохраните идентификатор сервисного аккаунта IAM, он понадобится в дальнейшем.

    - Terraform {#tf}

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
    
          ```hcl
          resource "yandex_iam_service_account" "sa" {
            name        = "<имя_сервисного_аккаунта>"
            folder_id   = "<идентификатор_каталога>"
          }
          ```

          Где:
          * `name` — имя сервисного аккаунта, например `sa-lockbox`.
          * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
    
      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
          1. Выполните команду:
          
             ```bash
             terraform validate
             ```
          
             Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Подтвердите создание ресурсов.

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

          Сохраните идентификатор сервисного аккаунта IAM, он понадобится в дальнейшем.

    - API {#api}

      Воспользуйтесь методом REST API [create](../../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../../iam/api-ref/grpc/ServiceAccount/create.md).

    {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../../iam/concepts/access-control/roles.md) `lockbox.payloadViewer` на каталог: 

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создан сервисный аккаунт.
      1. Перейдите на вкладку **Права доступа**.
      1. Нажмите **Настроить доступ**.
      1. В открывшемся окне выберите раздел **Сервисные аккаунты**.
      1. Выберите сервисный аккаунт, созданный ранее.
      1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите [роль](../../../lockbox/security/index.md#lockbox-payloadViewer) `lockbox.payloadViewer`.
      1. Нажмите **Сохранить**.

    - CLI {#cli}

      Выполните команду, указав идентификаторы каталога и сервисного аккаунта:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role lockbox.payloadViewer \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

    - Terraform {#tf}

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

          ```hcl
          resource "yandex_resourcemanager_folder_iam_member" "lockbox" {
            folder_id   = "<идентификатор_каталога>"
            role        = "lockbox.payloadViewer"
            member      = "serviceAccount:<идентификатор_сервисного_аккаунта>"
          }
          ```

          Где:
          * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
          * `role` — назначаемая роль, например `lockbox.payloadViewer`.
          * `member` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md), которому назначается роль. Указывается в виде `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      1. Проверьте корректность конфигурационных файлов.

          1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
          1. Выполните команду:
          
             ```bash
             terraform validate
             ```
          
             Если в файлах конфигурации есть ошибки, Terraform на них укажет.

      1. Подтвердите создание ресурсов.

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

    - API {#api}

      Воспользуйтесь методом REST API [UpdateAccessBindings](../../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

    {% endlist %}

## Подготовьте сервисный аккаунт Kubernetes {#prepare-sa-k8s}

1. [Подключитесь](../../../managed-kubernetes/operations/connect/index.md#kubectl-connect) к кластеру Managed Service for Kubernetes с помощью `kubectl`.
1. Создайте манифест сервисного аккаунта Kubernetes `service-account.yaml` со следующим содержимым:

    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: wlif
      annotations:
        yandex.cloud/federated-yc-service-account-id: <идентификатор_сервисного_аккаунта_IAM>
    ```

1. Примените манифест:

    ```bash
    kubectl apply -f service-account.yaml
    ```

1. Чтобы проверить созданный ресурс `ServiceAccount`, выполните команду:

    ```bash
    kubectl describe serviceaccount wlif
    ```

    Результат:

    ```text
    Name:                wlif
    Namespace:           default
    ...
    ```

1. Сохраните значения полей `Name` и `Namespace`, они понадобятся в дальнейшем.

## Привяжите сервисный аккаунт IAM к федерации {#connect-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором был создан сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. В списке выберите сервисный аккаунт `sa-lockbox`.
  1. На верхней панели нажмите ![image](../../../_assets/console-icons/cpus.svg) **Привязать к федерации**.
  1. В поле **Федерация сервисных аккаунтов** выберите ранее созданную федерацию.
  1. В поле **Значение Subject (sub)** укажите идентификатор сервисного аккаунта Kubernetes, созданного ранее, в формате `system:serviceaccount:<пространство_имен>:<имя_сервисного_аккаунта_Kubernetes>`, где:
      * `пространство_имен` — значение поля `Namespace` сервисного аккаунта Kubernetes, например `default`.
      * `имя_аккаунта` — значение поля `Name` сервисного аккаунта Kubernetes, например `wlif`.

  1. Нажмите **Привязать**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam workload-identity federated-credential create \
    --service-account-id <идентификатор_сервисного_аккаунта_IAM> \
    --federation-id <идентификатор_федерации> \
    --external-subject-id "system:serviceaccount:<пространство_имен>:<имя_сервисного_аккаунта_Kubernetes>"
  ```

  Где:
  * `--service-account-id` — идентификатор сервисного аккаунта IAM, полученный ранее.
  * `--federation-id` — идентификатор федерации сервисных аккаунтов, полученный ранее.
  * `--external-subject-id` — идентификатор внешнего субъекта, где:
    * `пространство_имен` — значение поля `Namespace` сервисного аккаунта Kubernetes, например `default`.
    * `имя_сервисного_аккаунта_Kubernetes` — значение поля `Name` сервисного аккаунта Kubernetes, например `wlif`.

  Результат:

  ```text
  id: aje401v1sup8********
  service_account_id: ajek7v5j65cg********
  federation_id: aje2c4qv19lf********
  external_subject_id: system:serviceaccount:default:wlif
  created_at: "2024-12-28T16:33:47.057632267Z"
  ```

- Terraform {#tf}

  1. Опишите в конфигурационном файле Terraform параметры привязки, которую необходимо создать:

      ```hcl
      resource "yandex_iam_workload_identity_federated_credential" "fc" {
        service_account_id  = "<идентификатор_сервисного_аккаунта>"
        federation_id       = "<идентификатор_федерации>"
        external_subject_id = "system:serviceaccount:<пространство_имен>:<имя_сервисного_аккаунта_Kubernetes>"
      }
      ```

      Где:
      * `service_account_id` — идентификатор сервисного аккаунта IAM, полученный ранее.
      * `federation_id` — идентификатор федерации сервисных аккаунтов, полученный ранее.
      * `external-subject-id` — идентификатор внешнего субъекта, где:
        * `пространство_имен` — значение поля `Namespace` сервисного аккаунта Kubernetes, например `default`.
        * `external_subject_id` — значение поля `Name` сервисного аккаунта Kubernetes, например `wlif`.

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите создание ресурсов.

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

- API {#api}

  Чтобы создать привязку, воспользуйтесь методом REST API [create](../../../iam/workload/workload-identity/api-ref/FederatedCredential/create.md) для ресурса [FederatedCredential](../../../iam/workload/workload-identity/api-ref/FederatedCredential/index.md) или вызовом gRPC API [FederatedCredentialService/Create](../../../iam/workload/workload-identity/api-ref/grpc/FederatedCredential/create.md).

{% endlist %}

## Создайте секрет Yandex Lockbox {#create-secret}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создан секрет.
  1. Перейдите в сервис **Lockbox**.
  1. Нажмите **Создать секрет**.
  1. В поле **Имя** введите имя секрета `MY_SECRET`.
  1. Выберите **Тип секрета** `Пользовательский`.
  1. В поле **Ключ** введите неконфиденциальный идентификатор, например `test-secret`.
  1. В поле **Значение** введите конфиденциальные данные для хранения, например `hello-world`.
  1. Нажмите **Создать**.
  1. Сохраните идентификатор секрета, он понадобится в дальнейшем.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc lockbox secret create \
    --name <имя_секрета> \
    --payload "<массив_с_содержимым_секрета>" \
  ```

  Где:
  * `--name` — имя секрета, например `MY_SECRET`.
  * `--payload` — содержимое секрета в виде массива формата YAML или JSON, например `"[{'key': 'test-secret', 'text_value': 'hello-world'}]"`.

  Результат:
  
  ```text
  done (1s)
  id: e6qduvprvcon********
  folder_id: b1gsm0k26v1l********
  created_at: "2026-03-12T13:02:15.543Z"
  name: MY_SECRET
  status: ACTIVE
  current_version:
    id: e6qr13mvsl8t********
    secret_id: e6qduvprvcon********
    created_at: "2026-03-12T13:02:15.543Z"
    status: ACTIVE
    payload_entry_keys:
      - test-secret
  ```

- Terraform {#tf}

  1. Опишите в конфигурационном файле параметры секрета:

     ```hcl
     resource "yandex_lockbox_secret" "my_secret" {
       name = "<имя_секрета>"
     }
     ```

     Где `name` — имя секрета, например `MY_SECRET`.


  1. Проверьте корректность конфигурации секрета.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите создание секрета.

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

      Сохраните идентификатор секрета, он понадобится в дальнейшем.

  1. Опишите в конфигурационном файле параметры содержимого секрета:

      ```hcl
      resource "yandex_lockbox_secret_version_hashed" "my_version" {
        secret_id    = "<идентификатор_секрета>"
        key_1        = "<ключ_секрета_1>"
        text_value_1 = "<значение_секрета_1>"

      }
      ```

      Где:

      * `secret_id` — идентификатор секрета, для которого создается версия.
      * `key_1` — ключ секрета. Несекретное название для значения, по которому вы будете его идентифицировать, например `test-secret`.
      * `text_value_1` — секретные данные в явном виде, например `hello-world`.

  1. Проверьте корректность конфигурации содержимого секрета.

      1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы Terraform с планом инфраструктуры.
      1. Выполните команду:
      
         ```bash
         terraform validate
         ```
      
         Если в файлах конфигурации есть ошибки, Terraform на них укажет.

  1. Подтвердите создание содержимого секрета.

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

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}

## Проверьте работу интеграции {#check-integration}

1. [Подключитесь](../../../managed-kubernetes/operations/connect/index.md#kubectl-connect) к кластеру Managed Service for Kubernetes с помощью `kubectl`.
1. Создайте манифест тестового пода `pod.yaml` со следующим содержимым:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: test-wlif
    spec:
      containers:
        - image: nginx
          name: nginx
      serviceAccountName: wlif
    ```

    Где `spec:serviceAccountName` — имя сервисного аккаунта Kubernetes, созданного ранее.

1. Примените манифест:

    ```bash
    kubectl apply -f pod.yaml
    ```

1. Убедитесь, что созданный под перешел в статус `Running`:

    ```bash
    kubectl get pod test-wlif
    ```

    Результат:

    ```
    NAME        READY   STATUS    RESTARTS   AGE
    test-wlif   1/1     Running   0          1m
    ```

1. Войдите в контейнер:

    ```bash
    kubectl exec test-wlif -it -- bash
    ```

1. Установите вспомогательную утилиту `jq`:

    ```bash
    apt-get update >/dev/null 2>&1 && apt-get install -y jq >/dev/null 2>&1
    ```

1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md):

    ```bash
    IAMTOKEN=$(curl -s -H 'Metadata-Flavor: Google' \
      http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token \
      | jq -r '.access_token')
    ```

1. Получите секрет Yandex Lockbox:

    ```bash
    curl -sH "Authorization: Bearer ${IAMTOKEN}" \
      "https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/<идентификатор_секрета>/payload"
    ```

    Результат:

    ```json
    {
     "entries": [
      {
       "key": "test-secret",
       "textValue": "hello-world"
      }
     ],
     "versionId": "e6qsqiadrsnh********"
    }
    ```

### Ручной обмен токена сервисного аккаунта Kubernetes на IAM-токен {#manual-token-exchange}

1. [Подключитесь](../../../managed-kubernetes/operations/connect/index.md#kubectl-connect) к кластеру Managed Service for Kubernetes с помощью `kubectl`.
1. Создайте манифест тестового пода `pod.yaml` со следующим содержимым:

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: test-wlif
    spec:
      containers:
        - image: nginx
          name: nginx
          volumeMounts:
            - mountPath: /var/run/secrets/tokens
              name: sa-token
      serviceAccountName: wlif
      volumes:
        - name: sa-token
          projected:
            sources:
              - serviceAccountToken:
                  path: sa-token
                  expirationSeconds: 7200
                  audience: https://storage.yandexcloud.net/mk8s-oidc/v1/clusters/c49i54tk66ob********
    ```

    Где:
    * `spec:serviceAccountName` — имя сервисного аккаунта Kubernetes, созданного ранее.
    * `spec:volumes:projected:sources:serviceAccountToken:audience` — значение **Допустимые значения Audience (aud)**, заданное при создании федерации.

1. Примените манифест:

    ```bash
    kubectl apply -f pod.yaml
    ```

1. Убедитесь, что созданный под перешел в статус `Running`:

    ```bash
    kubectl get pod test-wlif
    ```

    Результат:

    ```
    NAME        READY   STATUS    RESTARTS   AGE
    test-wlif   1/1     Running   0          1m
    ```

1. Войдите в контейнер:

    ```bash
    kubectl exec test-wlif -it -- bash
    ```

1. Задайте необходимые переменные:

    ```bash
    SA_ID="<идентификатор_сервисного_аккаунта_IAM>" && \
    SECRET_ID="<идентификатор_секрета_Lockbox>" && \
    SA_TOKEN="$(cat /var/run/secrets/tokens/sa-token)"
    ```

    Где:
    * `SA_ID` — идентификатор сервисного аккаунта IAM, полученный ранее.
    * `SECRET_ID` — идентификатор секрета Yandex Lockbox, полученный ранее.
    * `SA_TOKEN` — токен сервисного аккаунта Kubernetes.

1. Установите вспомогательную утилиту `jq`:

    ```bash
    apt-get update >/dev/null 2>&1 && apt-get install -y jq >/dev/null 2>&1
    ```

1. Получите [IAM-токен](../../../iam/concepts/authorization/iam-token.md):

    ```bash
    IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" \
      -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=${SA_ID}&subject_token=${SA_TOKEN}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" \
      -X POST https://auth.yandex.cloud/oauth/token | jq -r '.access_token')
    ```

1. Получите секрет Yandex Lockbox:

    ```bash
    curl -sH "Authorization: Bearer ${IAMTOKEN}" \
      "https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/${SECRET_ID}/payload"
    ```

    Результат:

    ```json
    {
     "entries": [
      {
       "key": "test-secret",
       "textValue": "hello-world"
      }
     ],
     "versionId": "e6qsqiadrsnh********"
    }
    ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите](../../../lockbox/operations/secret-delete.md) секрет Yandex Lockbox.
* [Удалите](../../../managed-kubernetes/operations/node-group/node-group-delete.md) группу узлов Managed Service for Kubernetes.
* [Удалите](../../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) кластер Managed Service for Kubernetes.

### Полезные ссылки {#see-also}

* [Федерации сервисных аккаунтов](../../../iam/concepts/workload-identity.md)
* [Получение значения секрета Yandex Lockbox на стороне пользовательской инсталляции Kubernetes](../../../tutorials/security/wlif-k8s-integration.md)