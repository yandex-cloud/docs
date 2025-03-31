# Настройка доступа к {{ foundation-models-full-name }} с помощью API-ключа

Сервис {{ foundation-models-full-name }} является частью платформы {{ yandex-cloud }} и использует ее систему аутентификации и авторизации. Вы можете отправлять запросы к моделям {{ foundation-models-name }} от имени своего пользовательского аккаунта, используя [IAM-токен](../../iam/concepts/authorization/iam-token.md) для авторизации. Это наиболее безопасный способ для быстрых экспериментов, поскольку время жизни IAM-токена не превышает 12 часов. Однако для работы с API мы рекомендуем использовать [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [API-ключом](../../iam/concepts/authorization/api-key.md).

Чтобы настроить авторизацию с API-ключом от имени сервисного аккаунта:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте сервисный аккаунт](#create-account).
1. [Назначьте роли сервисному аккаунту](#assign-roles).
1. [Создайте API-ключ](#run-client).

## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте сервисный аккаунт {#create-account}
   
{% list tabs group=instructions %}

- Консоль управления {#console}

   {% include [create-sa-via-console-without-role](../../_includes/iam/create-sa-via-console-without-role.md) %}

- CLI {#cli}

   {% include [name-format](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Создайте сервисный аккаунт:

   ```bash
   yc iam service-account create --name sa-api
   ```

   Где `--name` — имя сервисного аккаунта в формате:

   {% include [name-format](../../_includes/name-format.md) %}

   Результат:

   ```text
   id: ajehr0to1g8b********
   folder_id: b1gv87ssvu49********
   created_at: "2023-03-04T09:03:11.665153755Z"
   name: sa-api
   ```

- API {#api}

   Создайте сервисный аккаунт с помощью метода REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md):

   ```bash
   curl \
     --request POST \
     --header 'Content-Type: application/json' \
     --header "Authorization: Bearer <IAM-токен>" \
     --data '{
       "folderId": "<идентификатор_каталога>",
       "name": "<имя_сервисного_аккаунта>",
       "description": "service account for api"
     }' \
     https://iam.{{ api-host }}/iam/v1/serviceAccounts
   ```
   
   Где:
   * `<IAM-токен>` — действующий токен авторизации;
   * `<идентификатор_каталога>` — идентификатор каталога, в котором размещены сервисы;
   * `<имя_сервисного_аккаунта>` — имя сервисного аккаунта, например `sa-api`. Требования к формату имени:

      {% include [name-format](../../_includes/name-format.md) %}

   Также сервисный аккаунт можно создать с помощью вызова gRPC [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

{% endlist %}

## Назначьте роли сервисному аккаунту {#assign-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите нужное облако или каталог.
   1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
   1. Выберите созданный сервисный аккаунт.
   1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые роли:
      * Для работы с моделями генерации текста добавьте роль `ai.languageModels.user`.
      * Для работы с моделями генерации изображений добавьте роль `{{ roles-yaart-user }}`.
      * Для создания датасетов и дообучения моделей добавьте роли `ai.datasets.editor` и `ai.models.editor`.
      * Для создания ассистента добавьте роль `ai.assistants.editor`.
      
      Вы можете назначить несколько ролей одновременно. [Подробнее о ролях](../security/index.md) сервиса {{ foundation-models-name }}.

   1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI {#cli}

   Выполните команду:

   ```
   yc resource-manager folder add-access-binding <идентификатор_каталога> \
      --role <идентификатор_роли> \
      --subject serviceAccount:<идентификатор_сервисного_аккаунта>
   ```

   Где `--role` — роль для работы с {{ foundation-models-name }}:
      * `ai.languageModels.user` — для работы с моделями генерации текста.
      * `{{ roles-yaart-user }}` — для работы с моделями генерации изображений.
      * `ai.datasets.editor` и `ai.models.editor` — для создания датасетов и дообучения моделей.
      * `ai.assistants.editor` — для создания ассистента.
   
   [Подробнее о ролях](../security/index.md) сервиса {{ foundation-models-name }}.
      

- API {#api}

   Назначьте сервисному аккаунту роль с помощью метода REST API [setAccessBindings](../../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md):

   ```bash
   curl \
     --request POST \
     --header "Content-Type: application/json" \
     --header "Authorization: Bearer <IAM-токен>" \
     --data '{
       "accessBindingDeltas": [{
         "action": "ADD",
         "accessBinding": {
           "roleId": "<идентификатор_роли>",
           "subject": {
             "id": "<идентификатор_сервисного_аккаунта>",
             "type": "serviceAccount"
             }
           }
         }
       ]
      }' \
     https://resource-manager.{{ api-host }}/resource-manager/v1/folders/<идентификатор_каталога>:updateAccessBindings
   ```

   Где:

   * `<IAM-токен>` — действующий токен авторизации.
   * `<идентификатор_роли>` — роль для работы с {{ foundation-models-name }}:
      * `ai.languageModels.user` — для работы с моделями генерации текста.
      * `{{ roles-yaart-user }}` — для работы с моделями генерации изображений.
      * `ai.datasets.editor` и `ai.models.editor` — для создания датасетов и дообучения моделей.
      * `ai.assistants.editor` — для создания ассистента.
   
      [Подробнее о ролях](../security/index.md) сервиса {{ foundation-models-name }}.
   * `<идентификатор_сервисного_аккаунта>` — идентификатор ранее созданного сервисного аккаунта.

   Также назначить сервисному аккаунту роль можно с помощью вызова gRPC [ServiceAccountService/SetAccessBindings](../../iam/api-ref/grpc/ServiceAccount/setAccessBindings.md).

{% endlist %}

## Создайте API-ключ {#run-client}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, которому принадлежит сервисный аккаунт.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. На панели слева выберите ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
   1. Выберите сервисный аккаунт, для которого вы хотите создать API-ключ. При необходимости [создайте](../../iam/operations/sa/create.md) новый сервисный аккаунт.
   1. На панели сверху нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите пункт **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
   1. Задайте описание ключа, чтобы потом было проще найти его в консоли управления.
   1. Выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}**, чтобы определить, для каких целей будет использоваться API-ключ:
      
      * `yc.ai.languageModels.execute` — разрешает использовать API-ключ для работы с моделями генерации текста.
      * `yc.ai.imageGeneration.execute` — разрешает использовать API-ключ для работы с моделями генерации изображений.
      * `yc.ai.foundationModels.execute` — разрешает использовать API-ключ для работы со всеми моделями {{ foundation-models-name }}.

   1. (Опционально) Укажите **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. Сохраните идентификатор и секретный ключ.

  {% note alert %}

  После закрытия диалога значение ключа будет недоступно.

  {% endnote %}

- CLI {#cli}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания API-ключа:

      ```bash
      yc iam api-key create --help
      ```

  1. Выберите сервисный аккаунт, например `sa-api`:

      ```bash
      yc iam service-account list
      ```

      Результат:

      ```
      +----------------------+------------------+-------------------------------+
      |          ID          |       NAME       |          DESCRIPTION          |
      +----------------------+------------------+-------------------------------+
      | aje6o61dvog2******** | sa-api           |                               |
      +----------------------+------------------+-------------------------------+
      ```

  1. Создайте API-ключ для выбранного сервисного аккаунта и запишите ответ в файл:

      ```bash
      yc iam api-key create --service-account-name sa-api > api-key.yaml
      ```

      В ответе в свойстве `secret` будет содержаться API-ключ:

      ```
      api_key:
        id: ajeke74kbp5b********
        service_account_id: ajepg0mjt06********
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHs********
      ```

- API {#api}

   Создайте API-ключ с помощью метода REST API [create](../../iam/api-ref/ApiKey/create.md) для ресурса ApiKey:

   ```bash
   curl \
     --request POST \
     --header "Content-Type: application/json" \
     --header "Authorization: Bearer <IAM-токен>" \
     --data "{ \"serviceAccountId\": \"<идентификатор_сервисного_аккаунта>\" }" \
     https://iam.{{ api-host }}/iam/v1/apiKeys
   ```

   Где:

   * `<IAM-токен>` — действующий токен авторизации.
   * `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта `sa-api`.

   Также API-ключ можно создать с помощью вызова gRPC API [ApiKeyService/Create](../../iam/api-ref/grpc/ApiKey/create.md).

{% endlist %}

Теперь вы можете отправлять запросы к моделям {{ foundation-models-name }} от имени сервисного аккаунта.
