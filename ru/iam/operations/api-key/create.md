# Создание API-ключа

Это инструкция по созданию [API-ключа](../../concepts/authorization/api-key.md) для [сервисного аккаунта](../../concepts/users/service-accounts.md). _API-ключ_ — секретный ключ, используемый для упрощенной авторизации в API {{ yandex-cloud }}.

Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

## Создать API-ключ {#create-api-key}

Чтобы создать API-ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [create-console](../../../_includes/iam/create-api-key-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания API-ключа:

      ```bash
      yc iam api-key create --help
      ```

  1. Получите список сервисных аккаунтов в каталоге по умолчанию:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```text
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | my-robot         |                               |
      | aje9sda1ufvq******** | account_name     | account_description           |
      +----------------------+------------------+-------------------------------+
      ```

  1. Создайте API-ключ для нужного сервисного аккаунта и запишите ответ в файл `api_key.yaml`:

      ```bash
      yc iam api-key create \
        --service-account-name <имя_сервисного_аккаунта> \
        --scope <область_действия> \
        --expires-at <дата_и_время> \
        > api_key.yaml
      ```

      Где:
      
      * `--service-account-name` — имя сервисного аккаунта. Обязательный параметр.
      * `--scope` — [область действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Необязательный параметр.
      * `--expires-at` — дата и время истечения срока действия ключа. Необязательный параметр.
      * `api_key.yaml` — файл, в который сохраняется ответ.
      
      В результате вы получите файл `api_key.yaml`, который содержит значение API-ключа в поле `secret`:

      ```yaml
      api_key:
        id: ajeke74kbp5b********
        service_account_id: ajepg0mjt06s********
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHs********
      ```

  О том, как передать ключ в запросе, читайте в документации [сервисов](../../concepts/authorization/api-key.md#supported-services), которые поддерживают такой способ авторизации.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        description        = "<описание_ключа>"
        scope              = "<область_действия>"
        expires_at         = "<дата_и_время>"
        pgp_key            = "<pgp-ключ>"
      }
      ```

      Где:

      * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
      * `description` — описание ключа. Необязательный параметр.
      * `scope` — [область действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Необязательный параметр.
      * `expires_at` — дата и время истечения срока действия ключа в формате `YYYY-MM-DDThh:mm:ssZ`. Необязательный параметр.
      * `pgp_key` — дополнительный PGP-ключ для шифрования закрытого ключа. Указывается публичная часть ключа в кодировке base64, либо в виде `keybase:keybaseusername`. Необязательный параметр.

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_api_key).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

      ```bash
      yc iam key list --service-account-id <идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Создайте API-ключ с помощью метода REST API [create](../../api-ref/ApiKey/create.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md):

  ```bash
  export SERVICEACCOUNT_ID=<идентификатор_сервисного_аккаунта>
  export IAM_TOKEN=<токен>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --data "{
        \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
        \"scope\": \"<область_действия>\",
        \"expiresAt\": \"<дата_и_время>\"
    }" \
    https://iam.{{ api-host }}/iam/v1/apiKeys
  ```

  Где:

  * `SERVICEACCOUNT_ID` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
  * `IAM_TOKEN` — [IAM-токен](../../concepts/authorization/iam-token.md). Обязательный параметр.
  * `scope` — [область действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Необязательный параметр.
  * `expiresAt` — дата и время истечения срока действия ключа с ограниченным доступом. Необязательный параметр.

  Также API-ключ можно создать с помощью вызова gRPC API [ApiKeyService/Create](../../api-ref/grpc/ApiKey/create.md).

{% endlist %}

### Посмотреть доступные области действия {#available-scopes}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы посмотреть доступные области действия API-ключа, выполните команду:

  ```bash
  yc iam api-key list-scopes
  ```

  Результат:

  ```text
  {% if region == "ru" or region == "int" %}- yc.postbox.send{% endif %}
  - yc.ydb.tables.manage
  - yc.ydb.topics.manage
  ```

- API {#api}

  Посмотрите доступные области действия API-ключа с помощью метода REST API [ListScopes](../../api-ref/ApiKey/listScopes.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md).

  Доступные области действия API-ключа также можно посмотреть с помощью вызова gRPC API [ApiKeyService/ListScopes](../../api-ref/grpc/ApiKey/listScopes.md).

{% endlist %}

## Примеры {#examples}

### Добавить описание при создании API-ключа {#add-description}

Чтобы добавить описание API-ключа при его создании:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc iam api-key create --service-account-name my-robot \
    --description "this API-key is for my-robot"
  ```

  Где:

  * `--service-account-name` — имя сервисного аккаунта. Обязательный параметр.
  * `--description` — описание API-ключа. Необязательный параметр.

- {{ TF }} {#tf}

  ```hcl
  resource "yandex_iam_service_account_api_key" "sa-api-key" {
    service_account_id = "<идентификатор_сервисного_аккаунта>"
    description        = "this API-key is for my-robot"
  }
  ```

  Где:

  * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
  * `description` — описание ключа. Необязательный параметр.

- API {#api}

  ```bash
  export SERVICEACCOUNT_ID=<идентификатор_сервисного_аккаунта>
  export IAM_TOKEN=<IAM-токен>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --data "{
        \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
        \"description\": \"this API-key is for my-robot\"
    }" \
    https://iam.{{ api-host }}/iam/v1/apiKeys
  ```

  Где:

  * `SERVICEACCOUNT_ID` - [идентификатор сервисного аккаунта](../sa/get-id). Обязательный параметр.
  * `IAM_TOKEN` - [IAM-токен](../../concepts/authorization/iam-token.md). Обязательный параметр.

{% endlist %}

#### Что дальше {#what-is-next}

* [Узнайте, какие сервисы поддерживают API-ключи](../../concepts/authorization/api-key.md#supported-services).
