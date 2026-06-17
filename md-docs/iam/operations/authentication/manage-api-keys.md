# Управление API-ключами

[API-ключ](../../concepts/authorization/api-key.md) — секретный ключ, используемый для упрощенной аутентификации [сервисного аккаунта](../../concepts/users/service-accounts.md) в [API Yandex Cloud](../../../api-design-guide/index.md).

Если у вас еще нет сервисного аккаунта, [создайте его](../sa/create.md) и [назначьте ему роли](../sa/assign-role-for-sa.md).

## Посмотреть список API-ключей {#list-api-keys}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты** и выберите нужный сервисный аккаунт.
  1. В блоке **API-ключи** отобразится список API-ключей.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Получите список API-ключей для определенного сервисного аккаунта, указав его имя:
  
  ```bash
  yc iam api-key list \
    --service-account-name <имя_сервисного_аккаунта>
  ```
  
  Результат:
  
  ```text
  +----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
  |          ID          |     CREATED AT      | LAST USED AT |             SCOPE              |             SCOPES             | EXPIRES AT | MASKED KEY |
  +----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
  | aje5qvnhl67v******** | 2025-09-16 16:56:01 |              | yc.ai.foundationModels.execute | yc.ai.foundationModels.execute |            | ****rCG02w |
  | aje8be90datc******** | 2025-08-21 19:33:45 |              | yc.ai.foundationModels.execute | yc.ai.foundationModels.execute |            | ****u9hGKi |
  | aje1lmv2ipu3******** | 2025-09-16 16:56:25 |              | yc.ai.imageGeneration.execute  | yc.ai.imageGeneration.execute  |            | ****S5ejQ8 |
  +----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
  ```
  
  Для удобства [идентификации ключа](../../concepts/authorization/api-key.md#identify-key) в поле `MASKED KEY` отображаются последние шесть символов секретной части ключа.
  
  По умолчанию для поиска сервисного аккаунта используется каталог, указанный в профиле CLI. Вы можете указать другой каталог с помощью параметра `--folder-name` или `--folder-id`.

- API {#api}

  Воспользуйтесь методом REST API [List](../../api-ref/ApiKey/list.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md) или вызовом gRPC API [ApiKeyService/List](../../api-ref/grpc/ApiKey/list.md).

{% endlist %}

## Создать API-ключ {#create-api-key}

{% note info %}

Создание API-ключей сервисных аккаунтов может быть запрещено [политиками авторизации](../../concepts/access-control/access-policies.md) на уровне [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../../organization/concepts/organization.md).

{% endnote %}

Чтобы создать API-ключ сервисного аккаунта:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. Перейдите в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт, для которого вы хотите создать API-ключ. При необходимости [создайте](../sa/create.md) новый сервисный аккаунт.
  1. На панели сверху нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите пункт **Создать API-ключ**.
  1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
  1. В поле **Область действия** выберите одну или несколько [областей действия](../../concepts/authorization/api-key.md#scoped-api-keys).
  1. (Опционально) Укажите **Срок действия**.
  1. Нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ.
  
    {% note alert %}
  
    После закрытия диалога значение ключа будет недоступно.
  
    {% endnote %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

          * `yc.ai.imageGeneration.execute`;
          * `yc.ai.languageModels.execute`;
          * `yc.ai.speechkitStt.execute`;
          * `yc.ai.speechkitTts.execute`;
          * `yc.ai.translate.execute`;
          * `yc.ai.vision.execute`;
          * `yc.monitoring.manage`;
          * `yc.search-api.execute`;
          * `yc.serverless.containers.invoke`;
          * `yc.serverless.functions.invoke`.

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

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле Terraform параметры ресурсов, которые необходимо создать:

      ```hcl
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        description        = "<описание_ключа>"
        scopes              = ["<область_действия_1>", "<область_действия_2>", ..., "<область_действия_n>"]
        expires_at         = "<дата_и_время>"
        pgp_key            = "<pgp-ключ>"
        output_to_lockbox  {
          secret_id            = "<идентификатор_секрета_Lockbox>"
          entry_for_secret_key = "<ключ_секрета>"
        }
      }
      ```

      Где:

      * `service_account_id` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
      * `description` — описание ключа. Необязательный параметр.
      * `scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Можно указать одну или несколько областей действия. Необязательный параметр.

          Если параметр не задан, API-ключу будут по умолчанию назначены следующие области действия:

          * `yc.ai.imageGeneration.execute`;
          * `yc.ai.languageModels.execute`;
          * `yc.ai.speechkitStt.execute`;
          * `yc.ai.speechkitTts.execute`;
          * `yc.ai.translate.execute`;
          * `yc.ai.vision.execute`;
          * `yc.monitoring.manage`;
          * `yc.search-api.execute`;
          * `yc.serverless.containers.invoke`;
          * `yc.serverless.functions.invoke`.

      * `expires_at` — дата и время истечения срока действия ключа в формате `YYYY-MM-DDThh:mm:ssZ`. Например: `2026-01-01T21:00:00Z`. Необязательный параметр.
      * `pgp_key` — дополнительный PGP-ключ для шифрования закрытого ключа. Указывается публичная часть ключа в кодировке base64, либо в виде `keybase:keybaseusername`. Необязательный параметр.
      * `output_to_lockbox` — описание [секрета](../../../lockbox/concepts/secret.md) Yandex Lockbox, в который будет сохранено значение API-ключа, во избежание его возможной утечки через файл состояния `terraform.tfstate`. Необязательный параметр. Вложенные параметры:
          * `secret_id` — идентификатор секрета Yandex Lockbox, в который будет сохранено значение API-ключа. Секрет должен быть [пользовательского типа](../../../lockbox/concepts/secret.md#secret-type).
          * `entry_for_secret_key` — ключ секрета, который будет присвоен сохраняемому значению API-ключа.

      Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](../../../terraform/resources/iam_service_account_api_key.md).

  1. Создайте ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Terraform создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../../cli/index.md):

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
    https://iam.api.cloud.yandex.net/iam/v1/apiKeys
  ```

  Где:

  * `SERVICEACCOUNT_ID` — [идентификатор](../sa/get-id.md) сервисного аккаунта. Обязательный параметр.
  * `IAM_TOKEN` — [IAM-токен](../../concepts/authorization/iam-token.md). Обязательный параметр.
  * `scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Можно указать одну или несколько областей действия. Необязательный параметр.

      Если параметр не задан, API-ключу будут по умолчанию назначены следующие области действия:

      * `yc.ai.imageGeneration.execute`;
      * `yc.ai.languageModels.execute`;
      * `yc.ai.speechkitStt.execute`;
      * `yc.ai.speechkitTts.execute`;
      * `yc.ai.translate.execute`;
      * `yc.ai.vision.execute`;
      * `yc.monitoring.manage`;
      * `yc.search-api.execute`;
      * `yc.serverless.containers.invoke`;
      * `yc.serverless.functions.invoke`.

  * `expiresAt` — дата и время истечения срока действия ключа с ограниченным доступом. Необязательный параметр.

  Также API-ключ можно создать с помощью вызова gRPC API [ApiKeyService/Create](../../api-ref/grpc/ApiKey/create.md).

{% endlist %}

О том, как передать ключ в запросе, читайте в документации [сервисов](../../concepts/authorization/api-key.md#supported-services), которые поддерживают такой способ аутентификации.

## Посмотреть доступные области действия API-ключа {#available-scopes}

{% list tabs group=instructions %}

- Консоль управления

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
   1. В списке сервисов выберите **Identity and Access Management**.
   1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
   1. В открывшемся списке выберите сервисный аккаунт, области действия которого хотите посмотреть.
   1. На вкладке ![flag](../../../_assets/console-icons/flag.svg) **Обзор** в блоке **API-ключи** найдите нужный API-ключ.
   1. В строке с информацией о нем в столбце **Область действия** будут указаны все доступные области действия API-ключа.

- CLI {#cli}

  Чтобы посмотреть доступные [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) API-ключа, выполните команду:

  ```bash
  yc iam api-key list-scopes
  ```

- API {#api}

  Чтобы посмотреть доступные [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) API-ключа, воспользуйтесь методом REST API [ListScopes](../../api-ref/ApiKey/listScopes.md) для ресурса [ApiKey](../../api-ref/ApiKey/index.md) или вызовом gRPC API [ApiKeyService/ListScopes](../../api-ref/grpc/ApiKey/listScopes.md).

{% endlist %}

## Добавить описание при создании API-ключа {#add-description}

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

- Terraform {#tf}

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
    https://iam.api.cloud.yandex.net/iam/v1/apiKeys
  ```

  Где:

  * `SERVICEACCOUNT_ID` — [идентификатор сервисного аккаунта](../sa/get-id.md). Обязательный параметр.
  * `IAM_TOKEN` — [IAM-токен](../../concepts/authorization/iam-token.md). Обязательный параметр.
  * `scopes` — [области действия](../../concepts/authorization/api-key.md#scoped-api-keys) ключа. Необязательный параметр.

{% endlist %}

## Удалить API-ключ {#delete-api-key}

Чтобы удалить API-ключ сервисного аккаунта:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![image](../../../_assets/console-icons/layout-side-content-left.svg) или ![image](../../../_assets/console-icons/chevron-down.svg) и выберите каталог, которому принадлежит сервисный аккаунт.
  1. В списке сервисов выберите **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты** и выберите нужный сервисный аккаунт.
  1. В блоке **API-ключи** в строке с API-ключом, который нужно удалить, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Получите список API-ключей для определенного сервисного аккаунта, указав его имя:
     
     ```bash
     yc iam api-key list \
       --service-account-name <имя_сервисного_аккаунта>
     ```
     
     Результат:
     
     ```text
     +----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
     |          ID          |     CREATED AT      | LAST USED AT |             SCOPE              |             SCOPES             | EXPIRES AT | MASKED KEY |
     +----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
     | aje5qvnhl67v******** | 2025-09-16 16:56:01 |              | yc.ai.foundationModels.execute | yc.ai.foundationModels.execute |            | ****rCG02w |
     | aje8be90datc******** | 2025-08-21 19:33:45 |              | yc.ai.foundationModels.execute | yc.ai.foundationModels.execute |            | ****u9hGKi |
     | aje1lmv2ipu3******** | 2025-09-16 16:56:25 |              | yc.ai.imageGeneration.execute  | yc.ai.imageGeneration.execute  |            | ****S5ejQ8 |
     +----------------------+---------------------+--------------+--------------------------------+--------------------------------+------------+------------+
     ```
     
     Для удобства [идентификации ключа](../../concepts/authorization/api-key.md#identify-key) в поле `MASKED KEY` отображаются последние шесть символов секретной части ключа.
     
     По умолчанию для поиска сервисного аккаунта используется каталог, указанный в профиле CLI. Вы можете указать другой каталог с помощью параметра `--folder-name` или `--folder-id`.
  1. Удалите API-ключ, указав его идентификатор:

      ```bash
      yc iam api-key delete <идентификатор_API-ключа>
      ```

- Terraform {#tf}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и удалите секцию с описанием API-ключа.

      Пример описания API-ключа в конфигурации Terraform:

      ```hcl
      resource "yandex_iam_service_account_api_key" "sa-api-key" {
        service_account_id = "<идентификатор_сервисного_аккаунта>"
        description        = "<описание_ключа>"
        pgp_key            = "<pgp-ключ>"
      }
      ```

      Более подробную информацию о ресурсах, которые вы можете создать с помощью Terraform, см. в [документации провайдера](../../../terraform/resources/iam_service_account_api_key.md).

  1. Проверьте корректность конфигурационных файлов.

      1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
      1. Выполните проверку с помощью команды:

          ```bash
          terraform plan
          ```

      Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

      1. Если в конфигурации нет ошибок, выполните команду:

          ```bash
          terraform apply
          ```

      1. Подтвердите создание или удаление ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

      После этого в указанном каталоге будут созданы или удалены все требуемые ресурсы. Проверить появление ресурсов и их настройки или удаление ресурсов можно в [консоли управления](https://console.yandex.cloud), а также с помощью команды CLI:

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
      https://iam.api.cloud.yandex.net/iam/v1/apiKeys/$APIKEY_ID
  ```

  Также API-ключ можно удалить вызовом gRPC API [ApiKeyService/Delete](../../api-ref/grpc/ApiKey/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [API-ключ](../../concepts/authorization/api-key.md)
* [Сервисы Yandex Cloud, поддерживающие API-ключи](../../concepts/authorization/api-key.md#supported-services)