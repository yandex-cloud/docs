# Доступ к API {{ yandex-cloud }} из кластера {{ managed-k8s-name }} с помощью федерации сервисных аккаунтов {{ iam-name }}

{% include [wlif-mk8s-description](../../_includes/managed-kubernetes/wlif-mk8s-description.md) %}

![image](../../_assets/managed-kubernetes/mk8s-wlif.svg)

{% note warning %}

Полная интеграция с федерацией сервисных аккаунтов с использованием контроллера DaemonSet `yc-metadata-server` на узлах для автоматического обмена токенов сервисного аккаунта {{ k8s }} на IAM-токен доступна для кластеров с [актуальной версией {{ k8s }}](../../managed-kubernetes/concepts/k8s-supported-versions.md) в [релизном канале](../../managed-kubernetes/concepts/release-channels-and-updates.md) `RAPID`.

Частичная интеграция с [ручным обменом токенов](#manual-token-exchange) сервисного аккаунта {{ k8s }} на IAM-токен доступна для кластеров со всеми актуальными версиями {{ k8s }} во всех релизных каналах.

{% endnote %}

В этом руководстве для примера показано, как получить значение [секрета](../../lockbox/concepts/secret.md) {{ lockbox-full-name }} со стороны кластера {{ managed-k8s-name }} от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md) {{ iam-name }}. 

Аналогичным образом можно выполнить любое действие через [{{ yandex-cloud }} CLI](../../cli/quickstart.md), [{{ TF }}](../../terraform/quickstart.md), [SDK](../../overview/sdk/overview.md) или [API](../../api-design-guide/).

{% note info %}

В руководстве представлен пример интеграции кластера {{ managed-k8s-name }} с федерацией сервисных аккаунтов. Руководство по интеграции пользовательской инсталляции {{ k8s }} см. на странице [Получение значения секрета {{ lockbox-full-name }} на стороне пользовательской инсталляции {{ k8s }}](../../tutorials/security/wlif-k8s-integration.md).

{% endnote %}

Чтобы с помощью федерации сервисных аккаунтов настроить доступ к секрету {{ lockbox-name }} из кластера {{ managed-k8s-name }} через API {{ yandex-cloud }}:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Настройте кластер {{ managed-k8s-name }}](#prepare-cluster).
1. [Создайте федерацию сервисных аккаунтов](#create-wlif).
1. [Подготовьте сервисный аккаунт {{ iam-short-name }}](#prepare-sa).
1. [Подготовьте сервисный аккаунт {{ k8s }}](#prepare-sa-k8s).
1. [Привяжите сервисный аккаунт {{ iam-short-name }} к федерации](#connect-sa).
1. [Создайте секрет {{ lockbox-name }}](#create-secret).
1. [Проверьте работу интеграции](#check-integration).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:
* Плата за вычислительные ресурсы и диски [узлов](../../managed-kubernetes/concepts/index.md#node-group) кластера {{ managed-k8s-name }} (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).
* Плата за использование [мастера](../../managed-kubernetes/concepts/index.md#master) {{ managed-k8s-name }} и исходящий трафик (см. [тарифы {{ managed-k8s-name }}](../../managed-kubernetes/pricing.md)).
* Плата за [публичные IP-адреса](../../vpc/concepts/address.md#public-addresses) кластера {{ managed-k8s-name }} (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).
* Плата за хранение [секрета](../../lockbox/concepts/secret.md) и запросы к нему (см. [тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).

## Настройте кластер {{ managed-k8s-name }} {#prepare-cluster}

{% include [wlif-mk8s-cluster-setup](../../_includes/managed-kubernetes/wlif-mk8s-cluster-setup.md) %}

## Создайте федерацию сервисных аккаунтов {#create-wlif}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, к которому вы хотите получить доступ через API {{ yandex-cloud }}.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![cpus](../../_assets/console-icons/cpus.svg) **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.label_create-wli-federation }}**.
  1. В поле **{{ ui-key.yacloud.iam.federations.field_issuer }}** введите значение **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}**, полученное ранее, например `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
  1. В поле **{{ ui-key.yacloud.iam.federations.field_audiences }}** также введите значение **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-issuer_iKJcv }}**.
  1. В поле **{{ ui-key.yacloud.iam.federations.field_jwks }}** введите значение **{{ ui-key.yacloud.k8s.IAMService.ClusterIAMSection.iam-jwks-uri_x2AJJ }}**, полученное ранее, например `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.
  1. В поле **{{ ui-key.yacloud.iam.federations.field_name }}** введите имя федерации, например `test-iam-federation`.
  1. Нажмите **{{ ui-key.yacloud_billing.iam.cloud.create.popup-create-cloud_button_add }}**.

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
  * `--issuer` и `--audiences` — значение URL эмитента, полученное ранее, например `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
  * `--jwks-url` — значение URL набора ключей JWKS, полученное ранее, например `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.

  Результат:

  ```text
  id: aje2c4qv19lf********
  name: test-iam-federation
  folder_id: b1gfq9pe6rd2********
  enabled: true
  audiences:
    - https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********
  issuer: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********
  jwks_url: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json
  created_at: "2024-12-28T16:04:31.530652473Z"
  ```

  Сохраните идентификатор федерации, он понадобится в дальнейшем.

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле {{ TF }} параметры федерации, которую необходимо создать:

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
      * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором создается федерация сервисных аккаунтов.
      * `issuer` и `audiences` — значение URL эмитента, полученное ранее, например `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********`.
      * `jwks_url` — значение URL набора ключей JWKS, полученное ранее, например `https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********/jwks.json`.

  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите создание ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      Сохраните идентификатор федерации, он понадобится в дальнейшем.

- API {#api}

  Чтобы создать федерацию сервисных аккаунтов, воспользуйтесь методом REST API [create](../../iam/workload/oidc/workload-identity/api-ref/Federation/create.md) для ресурса [Federation](../../iam/workload/oidc/workload-identity/api-ref/Federation/index.md) или вызовом gRPC API [FederationService/Create](../../iam/workload/oidc/workload-identity/api-ref/grpc/Federation/create.md).

{% endlist %}

{% endlist %}

## Подготовьте сервисный аккаунт {{ iam-short-name }} {#prepare-sa}

1. Создайте сервисный аккаунт {{ iam-short-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором размещен секрет {{ lockbox-name }}.
      1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
      1. Введите имя сервисного аккаунта, например `sa-lockbox`.
      1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
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

      Сохраните идентификатор сервисного аккаунта {{ iam-short-name }}, он понадобится в дальнейшем.

    - {{ TF }} {#tf}

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:
    
          ```hcl
          resource "yandex_iam_service_account" "sa" {
            name        = "<имя_сервисного_аккаунта>"
            folder_id   = "<идентификатор_каталога>"
          }
          ```

          Где:
          * `name` — имя сервисного аккаунта, например `sa-lockbox`.
          * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
    
      1. Проверьте корректность конфигурационных файлов.

          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите создание ресурсов.

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

          Сохраните идентификатор сервисного аккаунта {{ iam-short-name }}, он понадобится в дальнейшем.

    - API {#api}

      Воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC API [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

    {% endlist %}

1. Назначьте сервисному аккаунту [роль](../../iam/concepts/access-control/roles.md) `{{ roles-lockbox-payloadviewer }}` на каталог: 

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создан сервисный аккаунт.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
      1. Нажмите **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. В открывшемся окне выберите раздел **{{ ui-key.yacloud_components.acl.label.service-accounts}}**.
      1. Выберите сервисный аккаунт, созданный ранее.
      1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите [роль](../../lockbox/security/index.md#lockbox-payloadViewer) `{{ roles-lockbox-payloadviewer }}`.
      1. Нажмите **{{ ui-key.yacloud_components.acl.action.apply }}**.

    - CLI {#cli}

      Выполните команду, указав идентификаторы каталога и сервисного аккаунта:

      ```bash
      yc resource-manager folder add-access-binding <идентификатор_каталога> \
        --role {{ roles-lockbox-payloadviewer }} \
        --subject serviceAccount:<идентификатор_сервисного_аккаунта>
      ```

    - {{ TF }} {#tf}

      1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

          ```hcl
          resource "yandex_resourcemanager_folder_iam_member" "lockbox" {
            folder_id   = "<идентификатор_каталога>"
            role        = "{{ roles-lockbox-payloadviewer }}"
            member      = "serviceAccount:<идентификатор_сервисного_аккаунта>"
          }
          ```

          Где:
          * `folder_id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).
          * `role` — назначаемая роль, например `{{ roles-lockbox-payloadviewer }}`.
          * `member` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), которому назначается роль. Указывается в виде `serviceAccount:<идентификатор_сервисного_аккаунта>`.

      1. Проверьте корректность конфигурационных файлов.

          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите создание ресурсов.

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    - API {#api}

      Воспользуйтесь методом REST API [UpdateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) для ресурса [Folder](../../resource-manager/api-ref/Folder/index.md) или вызовом gRPC API [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md).

    {% endlist %}

## Подготовьте сервисный аккаунт {{ k8s }} {#prepare-sa-k8s}

1. [Подключитесь](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) к кластеру {{ managed-k8s-name }} с помощью `kubectl`.
1. Создайте манифест сервисного аккаунта {{ k8s }} `service-account.yaml` со следующим содержимым:

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

## Привяжите сервисный аккаунт {{ iam-short-name }} к федерации {#connect-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором был создан сервисный аккаунт.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. В списке выберите сервисный аккаунт `sa-lockbox`.
  1. Перейдите на вкладку **{{ ui-key.yacloud.iam.label_federations }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.connected-federation.action_connect-federation }}**.
  1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_federation }}** выберите ранее созданную федерацию.
  1. В поле **{{ ui-key.yacloud.iam.connected-federation.field_subject }}** укажите идентификатор сервисного аккаунта {{ k8s }}, созданного ранее, в формате `system:serviceaccount:<пространство_имен>:<имя_сервисного_аккаунта_{{ k8s }}>`, где:
      * `пространство_имен` — значение поля `Namespace` сервисного аккаунта {{ k8s }}, например `default`.
      * `имя_аккаунта` — значение поля `Name` сервисного аккаунта {{ k8s }}, например `wlif`.

  1. Нажмите **{{ ui-key.yacloud.iam.connected-federation.action_connect }}**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc iam workload-identity federated-credential create \
    --service-account-id <идентификатор_сервисного_аккаунта_{{ iam-short-name }}> \
    --federation-id <идентификатор_федерации> \
    --external-subject-id "system:serviceaccount:<пространство_имен>:<имя_сервисного_аккаунта_{{ k8s }}>"
  ```

  Где:
  * `--service-account-id` — идентификатор сервисного аккаунта {{ iam-short-name }}, полученный ранее.
  * `--federation-id` — идентификатор федерации сервисных аккаунтов, полученный ранее.
  * `--external-subject-id` — идентификатор внешнего субъекта, где:
    * `пространство_имен` — значение поля `Namespace` сервисного аккаунта {{ k8s }}, например `default`.
    * `имя_сервисного_аккаунта_{{ k8s }}` — значение поля `Name` сервисного аккаунта {{ k8s }}, например `wlif`.

  Результат:

  ```text
  id: aje401v1sup8********
  service_account_id: ajek7v5j65cg********
  federation_id: aje2c4qv19lf********
  external_subject_id: system:serviceaccount:default:wlif
  created_at: "2024-12-28T16:33:47.057632267Z"
  ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле {{ TF }} параметры привязки, которую необходимо создать:

      ```hcl
      resource "yandex_iam_workload_identity_federated_credential" "fc" {
        service_account_id  = "<идентификатор_сервисного_аккаунта>"
        federation_id       = "<идентификатор_федерации>"
        external_subject_id = "system:serviceaccount:<пространство_имен>:<имя_сервисного_аккаунта_{{ k8s }}>"
      }
      ```

      Где:
      * `service_account_id` — идентификатор сервисного аккаунта {{ iam-short-name }}, полученный ранее.
      * `federation_id` — идентификатор федерации сервисных аккаунтов, полученный ранее.
      * `external-subject-id` — идентификатор внешнего субъекта, где:
        * `пространство_имен` — значение поля `Namespace` сервисного аккаунта {{ k8s }}, например `default`.
        * `external_subject_id` — значение поля `Name` сервисного аккаунта {{ k8s }}, например `wlif`.

  1. Проверьте корректность конфигурационных файлов.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите создание ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы создать привязку, воспользуйтесь методом REST API [create](../../iam/workload/workload-identity/api-ref/FederatedCredential/create.md) для ресурса [FederatedCredential](../../iam/workload/workload-identity/api-ref/FederatedCredential/index.md) или вызовом gRPC API [FederatedCredentialService/Create](../../iam/workload/workload-identity/api-ref/grpc/FederatedCredential/create.md).

{% endlist %}

## Создайте секрет {{ lockbox-name }} {#create-secret}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан секрет.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}**.
  1. Нажмите **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите имя секрета `MY_SECRET`.
  1. Выберите **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.label_key }}** введите неконфиденциальный идентификатор, например `test-secret`.
  1. В поле **{{ ui-key.yacloud.lockbox.forms.label_value }}** введите конфиденциальные данные для хранения, например `hello-world`.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.
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

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры секрета:

     ```hcl
     resource "yandex_lockbox_secret" "my_secret" {
       name = "<имя_секрета>"
     }
     ```

     Где `name` — имя секрета, например `MY_SECRET`.


  1. Проверьте корректность конфигурации секрета.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите создание секрета.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

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

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите создание содержимого секрета.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API {#api}

  Чтобы создать секрет, воспользуйтесь методом REST API [create](../../lockbox/api-ref/Secret/create.md) для ресурса [Secret](../../lockbox/api-ref/Secret/index.md) или вызовом gRPC API [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md).

{% endlist %}

## Проверьте работу интеграции {#check-integration}

{% note tip %}

Ниже представлен сценарий c использованием контроллера DaemonSet `yc-metadata-server` на узлах для автоматического обмена токенов сервисного аккаунта {{ k8s }} на IAM-токен, доступный для кластеров в [релизном канале](../../managed-kubernetes/concepts/release-channels-and-updates.md) `RAPID`. Для кластеров в других релизных каналах см. подраздел [{#T}](#manual-token-exchange).

{% endnote %}

1. [Подключитесь](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) к кластеру {{ managed-k8s-name }} с помощью `kubectl`.
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

    Где `spec:serviceAccountName` — имя сервисного аккаунта {{ k8s }}, созданного ранее.

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

1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md):

    ```bash
    IAMTOKEN=$(curl -s -H 'Metadata-Flavor: Google' \
      http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token \
      | jq -r '.access_token')
    ```

1. Получите секрет {{ lockbox-name }}:

    ```bash
    curl -sH "Authorization: Bearer ${IAMTOKEN}" \
      "https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/<идентификатор_секрета>/payload"
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

### Ручной обмен токена сервисного аккаунта {{ k8s }} на IAM-токен {#manual-token-exchange}

1. [Подключитесь](../../managed-kubernetes/operations/connect/index.md#kubectl-connect) к кластеру {{ managed-k8s-name }} с помощью `kubectl`.
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
                audience: https://{{ s3-storage-host }}/mk8s-oidc/v1/clusters/c49i54tk66ob********
    ```

    Где:
    * `spec:serviceAccountName` — имя сервисного аккаунта {{ k8s }}, созданного ранее.
    * `spec:volumes:projected:sources:serviceAccountToken:audience` — значение **{{ ui-key.yacloud.iam.federations.field_audiences }}**, заданное при создании федерации.

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
    SA_ID="<идентификатор_сервисного_аккаунта_{{ iam-short-name }}>" && \
    SECRET_ID="<идентификатор_секрета_{{ lockbox-short-name }}>" && \
    SA_TOKEN="$(cat /var/run/secrets/tokens/sa-token)"
    ```

    Где:
    * `SA_ID` — идентификатор сервисного аккаунта {{ iam-short-name }}, полученный ранее.
    * `SECRET_ID` — идентификатор секрета {{ lockbox-name }}, полученный ранее.
    * `SA_TOKEN` — токен сервисного аккаунта {{ k8s }}.

1. Установите вспомогательную утилиту `jq`:

    ```bash
    apt-get update >/dev/null 2>&1 && apt-get install -y jq >/dev/null 2>&1
    ```

1. Получите [IAM-токен](../../iam/concepts/authorization/iam-token.md):

    ```bash
    IAMTOKEN=$(curl -sH "Content-Type: application/x-www-form-urlencoded" \
      -d "grant_type=urn:ietf:params:oauth:grant-type:token-exchange&requested_token_type=urn:ietf:params:oauth:token-type:access_token&audience=${SA_ID}&subject_token=${SA_TOKEN}&subject_token_type=urn:ietf:params:oauth:token-type:id_token" \
      -X POST https://{{ auth-main-host }}/oauth/token | jq -r '.access_token')
    ```

1. Получите секрет {{ lockbox-name }}:

    ```bash
    curl -sH "Authorization: Bearer ${IAMTOKEN}" \
      "https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/${SECRET_ID}/payload"
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
* [Удалите](../../lockbox/operations/secret-delete.md) секрет {{ lockbox-name }}.
* [Удалите](../../managed-kubernetes/operations/node-group/node-group-delete.md) группу узлов {{ managed-k8s-name }}.
* [Удалите](../../managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-delete.md) кластер {{ managed-k8s-name }}.

### См. также {#see-also}

* [{#T}](../../iam/concepts/workload-identity.md)
* [Получение значения секрета {{ lockbox-full-name }} на стороне пользовательской инсталляции {{ k8s }}](../../tutorials/security/wlif-k8s-integration.md)