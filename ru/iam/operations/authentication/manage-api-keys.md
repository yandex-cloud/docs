---
title: Как управлять API-ключами в {{ iam-full-name }}
description: Из статьи вы узнаете, как создавать и удалять API-ключи в {{ iam-full-name }} через консоль управления, CLI и API сервиса.
---

# Управление API-ключами

[API-ключ](../../concepts/authorization/api-key.md) — секретный ключ, используемый для упрощенной аутентификации [сервисного аккаунта](../../concepts/users/service-accounts.md) в [API {{ yandex-cloud }}](../../../api-design-guide/index.yaml).

Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

## Создать API-ключ {#create-api-key}

Чтобы создать API-ключ сервисного аккаунта:

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
        --scopes <область_действия_1>[,<область_действия_2>,...,<область_действия_n>] \
        --expires-at <дата_и_время> \
        > api_key.yaml
      ```

      Где:
      
      * `--service-account-name` — имя сервисного аккаунта. Обязательный параметр.
      * `--scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Можно указать одну или несколько областей действия. Необязательный параметр.

          Если параметр не задан, API-ключу будут по умолчанию назначены следующие области действия:

          {% include [default-scope-list](../../../_includes/iam/default-scope-list.md) %}

      * `--expires-at` — дата и время истечения срока действия ключа в формате `YYYY-MM-DDThh:mm:ssZ`. Например: `2026-01-01T21:00:00Z`. Необязательный параметр.
      * `api_key.yaml` — файл, в который сохраняется ответ.
      
      В результате вы получите файл `api_key.yaml`, который содержит значение API-ключа в поле `secret`:

      ```yaml
      api_key:
        id: ajeuo7ng2p6u********
        service_account_id: ajegtlf2q28a********
        created_at: "2025-04-04T10:23:08.722440521Z"
        scopes:
          - yc.monitoring.read
          - yc.serverless.functions.invoke
          - yc.postbox.send
        expires_at: "2026-01-01T21:00:00Z"
      secret: AQVN3sHvAWTemWB8QxHkunfG2x4q7G3O********
      ```

      Надежно сохраните полученное значение ключа: повторно получить его будет невозможно.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        description        = "<описание_ключа>"
        scopes              = ["<область_действия_1>", "<область_действия_2>", ..., "<область_действия_n>"]
        expires_at         = "<дата_и_время>"
        pgp_key            = "<pgp-ключ>"
        output_to_lockbox  {
          secret_id             = "<идентификатор_секрета_Lockbox>"
          entry_for_secret_key = "<ключ_секрета>"
        }
      }
      ```

      Где:

      * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
      * `description` — описание ключа. Необязательный параметр.
      * `scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Можно указать одну или несколько областей действия. Необязательный параметр.

          Если параметр не задан, API-ключу будут по умолчанию назначены следующие области действия:

          {% include [default-scope-list](../../../_includes/iam/default-scope-list.md) %}

      * `expires_at` — дата и время истечения срока действия ключа в формате `YYYY-MM-DDThh:mm:ssZ`. Например: `2026-01-01T21:00:00Z`. Необязательный параметр.
      * `pgp_key` — дополнительный PGP-ключ для шифрования закрытого ключа. Указывается публичная часть ключа в кодировке base64, либо в виде `keybase:keybaseusername`. Необязательный параметр.
      * `output_to_lockbox` — описание [секрета](../../../lockbox/concepts/secret.md) {{ lockbox-full-name }}, в который будет сохранено значение API-ключа, во избежание его возможной утечки через файл состояния `terraform.tfstate`. Необязательный параметр. Вложенные параметры:
          * `secret_id` — идентификатор секрета {{ lockbox-full-name }}, в который будет сохранено значение API-ключа. Секрет должен быть [пользовательского типа](../../../lockbox/concepts/secret.md#secret-type).
          * `entry_for_secret_key` — ключ секрета, который будет присвоен сохраняемому значению API-ключа.

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_api_key).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/):

      ```bash
      yc iam api-key list --service-account-id <идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/ApiKey/create.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md):

  ```bash
  export SERVICEACCOUNT_ID=<идентификатор_сервисного_аккаунта>
  export IAM_TOKEN=<токен>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --data "{
        \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
        \"scopes\": [\"<область_действия_1>\",\"<область_действия_2>\",...,\"<область_действия_n>\"],
        \"expiresAt\": \"<дата_и_время>\"
    }" \
    https://iam.{{ api-host }}/iam/v1/apiKeys
  ```

  Где:

  * `SERVICEACCOUNT_ID` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
  * `IAM_TOKEN` — [IAM-токен](../../concepts/authorization/iam-token.md). Обязательный параметр.
  * `scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Можно указать одну или несколько областей действия. Необязательный параметр.

      Если параметр не задан, API-ключу будут по умолчанию назначены следующие области действия:

      {% include [default-scope-list](../../../_includes/iam/default-scope-list.md) %}

  * `expiresAt` — дата и время истечения срока действия ключа с ограниченным доступом. Необязательный параметр.

  Также API-ключ можно создать с помощью вызова gRPC API [ApiKeyService/Create](../../api-ref/grpc/ApiKey/create.md).

{% endlist %}

О том, как передать ключ в запросе, читайте в документации [сервисов](../../concepts/authorization/api-key.md#supported-services), которые поддерживают такой способ аутентификации.

### Посмотреть доступные области действия API-ключа {#available-scopes}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы посмотреть доступные [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) API-ключа, выполните команду:

  ```bash
  yc iam api-key list-scopes
  ```

  Результат:


  ```text
  - yc.ai.foundationModels.execute
  - yc.ai.imageGeneration.execute
  - yc.ai.languageModels.execute
  - yc.ai.speechkitStt.execute
  - yc.ai.speechkitTts.execute
  - yc.ai.translate.execute
  - yc.ai.vision.execute
  - yc.monitoring.manage
  - yc.monitoring.read
  - yc.postbox.send
  - yc.search-api.execute
  - yc.serverless.containers.invoke
  - yc.serverless.functions.invoke
  - yc.ydb.tables.manage
  - yc.ydb.topics.manage
  ```

- API {#api}

  Чтобы посмотреть доступные [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) API-ключа, воспользуйтесь методом REST API [ListScopes](../../api-ref/ApiKey/listScopes.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md) или вызовом gRPC API [ApiKeyService/ListScopes](../../api-ref/grpc/ApiKey/listScopes.md).

{% endlist %}

### Примеры {#examples}

#### Добавить описание при создании API-ключа {#add-description}

Чтобы добавить описание API-ключа при его создании:

{% list tabs group=instructions %}

- CLI {#cli}

  ```bash
  yc iam api-key create \
    --service-account-name <имя_сервисного_аккаунта> \
    --description "this API-key is for my-robot" \
    --scopes yc.monitoring.read,yc.postbox.send,yc.serverless.functions.invoke
  ```

  Где:

  * `--service-account-name` — [имя](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
  * `--description` — описание API-ключа. Необязательный параметр.
  * `--scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Необязательный параметр.

- {{ TF }} {#tf}

  ```hcl
  resource "yandex_iam_service_account_api_key" "sa-api-key" {
    service_account_id = "<идентификатор_сервисного_аккаунта>"
    description        = "this API-key is for my-robot"
    scopes             = ["yc.monitoring.read", "yc.postbox.send", "yc.serverless.functions.invoke"]
  }
  ```

  Где:

  * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
  * `description` — описание ключа. Необязательный параметр.
  * `scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Необязательный параметр.

- API {#api}

  Отправьте запрос:

  ```bash
  export SERVICEACCOUNT_ID=<идентификатор_сервисного_аккаунта>
  export IAM_TOKEN=<IAM-токен>
  curl \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Bearer $IAM_TOKEN" \
    --data "{
        \"serviceAccountId\": \"$SERVICEACCOUNT_ID\",
        \"description\": \"this API-key is for my-robot\",
        \"scopes\": [\"yc.monitoring.read\",\"yc.postbox.send\",\"yc.serverless.functions.invoke\"]
    }" \
    https://iam.{{ api-host }}/iam/v1/apiKeys
  ```

  Где:

  * `SERVICEACCOUNT_ID` - [идентификатор сервисного аккаунта](../sa/get-id). Обязательный параметр.
  * `IAM_TOKEN` - [IAM-токен](../../concepts/authorization/iam-token.md). Обязательный параметр.
  * `scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Необязательный параметр.

{% endlist %}

## Удалить API-ключ {#delete-api-key}

Чтобы удалить API-ключ сервисного аккаунта:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}** и выберите нужный сервисный аккаунт.
  1. В блоке **{{ ui-key.yacloud.iam.folder.service-account.overview.section_api_keys }}** в строке с API-ключом, который нужно удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Получите список API-ключей для определенного сервисного аккаунта, указав его имя:

        ```bash
        yc iam api-key list \
          --service-account-name <имя_сервисного_аккаунта>
        ```

        Результат:

        ```text
        +----------------------+---------------------+
        |          ID          |     CREATED AT      |
        +----------------------+---------------------+
        | ajenhvftf77r******** | 2022-03-13 21:15:40 |
        | ajeq610sgh05******** | 2022-03-13 21:14:43 |
        +----------------------+---------------------+
        ```

        По умолчанию для поиска сервисного аккаунта используется каталог, указанный в профиле CLI. Вы можете указать другой каталог с помощью параметра `--folder-name` или `--folder-id`.

    1. Удалите API-ключ, указав его идентификатор:

        ```bash
        yc iam api-key delete <идентификатор_API-ключа>
        ```

- {{ TF }} {#tf}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    1. Откройте файл конфигурации {{ TF }} и удалите секцию с описанием API-ключа.

        Пример описания API-ключа в конфигурации {{ TF }}:

        ```hcl
        resource "yandex_iam_service_account_api_key" "sa-api-key" {
            service_account_id = "<идентификатор_сервисного_аккаунта>"
            description        = "<описание_ключа>"
            pgp_key            = "<pgp-ключ>"
        }
        ```

        Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/iam_service_account_api_key).

    1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

            ```bash
            terraform plan
            ```

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

            ```bash
            terraform apply
            ```

        1. Подтвердите создание или удаление ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

        После этого в указанном каталоге будут созданы или удалены все требуемые ресурсы. Проверить появление ресурсов и их настройки или удаление ресурсов можно в [консоли управления]({{ link-console-main }}), а также с помощью команды CLI:

        ```bash
        yc iam api-key list --service-account-id <идентификатор_сервисного_аккаунта>
        ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../../api-ref/ApiKey/delete.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md):

    ```bash
    export APIKEY_ID=<идентификатор_API-ключа>
    export IAM_TOKEN=<IAM-токен>
    curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        https://iam.{{ api-host }}/iam/v1/apiKeys/$APIKEY_ID
    ```

   Также API-ключ можно удалить вызовом gRPC API [ApiKeyService/Delete](../../api-ref/grpc/ApiKey/delete.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/authorization/api-key.md)
* [Сервисы {{ yandex-cloud }}, поддерживающие API-ключи](../../concepts/authorization/api-key.md#supported-services)