# Настройка доступа с помощью API-ключа

Для безопасной работы с сервисами {{ vision-full-name }} и {{ translate-full-name }} рекомендуется использовать авторизацию от имени [сервисного аккаунта](../iam/concepts/users/service-accounts.md) с помощью [API-ключа](../iam/concepts/authorization/api-key.md).

Чтобы настроить авторизацию от имени сервисного аккаунта:

1. [Подготовьте облако к работе](#prepare-cloud).
1. [Создайте сервисный аккаунт](#create-account).
1. [Назначьте роли сервисному аккаунту](#assign-roles).
1. [Создайте API-ключ](#run-client).

 
## Подготовьте облако к работе {#prepare-cloud}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте сервисный аккаунт {#create-account}
   
{% list tabs %}

- Консоль управления

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
   1. На вкладке **Сервисные аккаунты** нажмите кнопку **Создать сервисный аккаунт**.
   1. Введите имя сервисного аккаунта, например `sa-api`.

      Требования к формату имени:

      {% include [name-format](./name-format.md) %}

   1. Нажмите кнопку **Создать**.

- CLI

   {% include [name-format](./cli-install.md) %}

   {% include [default-catalogue](./default-catalogue.md) %}

   Выполните команду для создания сервисного аккаунта:

   ```bash
   yc iam service-account create --name sa-api
   ```

   Где `name` — имя сервисного аккаунта в формате:

   {% include [name-format](./name-format.md) %}

   Результат:
   ```yaml
   id: ajehr0to1g8b********
   folder_id: b1gv87ssvu49********
   created_at: "2023-03-04T09:03:11.665153755Z"
   name: sa-api
   ```

- API

   Создайте сервисный аккаунт с помощью метода REST API [create](../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../iam/api-ref/ServiceAccount/index.md):

   ```bash
   curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-токен>" \
      -d '{
            "folderId": "<идентификатор_каталога>",
            "name": "sa-api",
            "description": "service account for api"
      }' \
      https://iam.{{ api-host }}/iam/v1/serviceAccounts
   ```
   Где:
   * `<IAM-токен>` — действующий токен авторизации;
   * `folderId` — идентификатор каталога, в котором размещены сервисы;
   * `name` — имя сервисного аккаунта в формате:

      {% include [name-format](./name-format.md) %}

   Также сервисный аккаунт можно создать с помощью вызова gRPC [ServiceAccountService/Create](../iam/api-ref/grpc/service_account_service.md#Create).

{% endlist %}

## Назначьте роли сервисному аккаунту {#assign-roles}

{% list tabs %}

- Консоль управления

   1. На [стартовой странице]({{ link-console-main }}) консоли управления выберите каталог.
   1. Перейдите на вкладку **Права доступа**.
   1. Найдите аккаунт `sa-api` в списке и нажмите значок ![image](../_assets/console-icons/ellipsis.svg).
   1. Нажмите кнопку **Изменить роли**.
   1. В открывшемся диалоге нажмите кнопку **Добавить роль** и выберите роль `ai.translate.user` для {{ translate-full-name }} или `ai.vision.user` для {{ vision-full-name }}.
   1. Нажмите кнопку **Сохранить**.

- CLI

   Выполните команду:
   ```
   yc resource-manager folder add-access-binding <идентификатор_каталога> \
      --role <идентификатор_роли> \
      --subject serviceAccount:<идентификатор_сервисного_аккаунта>
   ```

   Где:
   <идентификатор_роли> — `ai.translate.user` для {{ translate-full-name }} или `ai.vision.user` для {{ vision-full-name }}.

- API

   Назначьте сервисному аккаунту роль с помощью метода REST API [setAccessBindings](../iam/api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../iam/api-ref/ServiceAccount/index.md):

   ```bash
   curl -X POST \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer <IAM-токен>" \
     -d '{
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
   * `<IAM-токен>` — действующий токен авторизации;
   * `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта `sa-api`;
   * `<идентификатор_роли>` — `ai.translate.user` для {{ translate-full-name }} или `ai.vision.user` для {{ vision-full-name }}.

   Также назначить сервисному аккаунту роль можно с помощью вызова gRPC [ServiceAccountService/SetAccessBindings](../iam/api-ref/grpc/service_account_service.md#SetAccessBindings).

{% endlist %}

## Создайте API-ключ {#run-client}

{% list tabs %}

- Консоль управления

   {% include [create-console](./iam/create-api-key-console.md) %}  

- CLI

  {% include [default-catalogue](./default-catalogue.md) %}

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
      | aje6o61dvog2h6g9a33s | sa-api           |                               |
      +----------------------+------------------+-------------------------------+
      ```

  1. Создайте API-ключ для сервисного аккаунта `sa-api` и запишите ответ в файл:

      ```bash
      yc iam api-key create --service-account-name sa-api > api-key.yaml
      ```

      В ответе в свойстве `secret` будет содержаться API-ключ:

      ```
      api_key:
        id: ajeke74kbp5bfq7m6ka2
        service_account_id: ajepg0mjt06********
        created_at: "2019-04-09T08:41:27Z"
      secret: AQVN1HHJReSrfo9jU3aopsXrJyfq_UHsssT5ICtm
      ```

      О том, как передать ключ в запросе, читайте в документации [сервисов](../iam/concepts/authorization/api-key.md#supported-services), которые поддерживают такой способ авторизации.

- API

   Создайте API-ключ с помощью метода REST API [create](../iam/api-ref/ApiKey/create.md) для ресурса [ApiKey](../iam/api-ref/ApiKey/index.md):

   ```bash
   curl -X POST \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer <IAM-токен>" \
      -d "{ \"serviceAccountId\": \"<идентификатор_сервисного_аккаунта>\" }" \
      https://iam.{{ api-host }}/iam/v1/apiKeys
   ```

   Где:
   * `<IAM-токен>` — действующий токен авторизации;
   * `<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта `sa-api`.

   Также API-ключ можно создать с помощью вызова gRPC API [ApiKeyService/Create](../iam/api-ref/grpc/api_key_service.md#Create).

{% endlist %}

Теперь вы можете отправлять запросы в сервисы {{ vision-full-name }} и {{ translate-full-name }} от имени сервисного аккаунта.

Полученный API-ключ указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте API-ключ в заголовке `Authorization` в следующем формате:

```
Authorization: Api-Key <API-ключ>
```