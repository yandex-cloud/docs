Чтобы назначить сервисному аккаунту роль на облако или каталог, воспользуйтесь методом REST API `updateAccessBindings` для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или [Folder](../../resource-manager/api-ref/Folder/index.md):

1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации {{ iam-full-name }} в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md).
1. [Узнайте](../../resource-manager/operations/folder/get-id.md) ID каталога с сервисными аккаунтами.
1. [Получите](../../iam/operations/iam-token/create.md) IAM-токен для аутентификации в API {{ yandex-cloud }}.
1. Получите список сервисных аккаунтов в каталоге, чтобы узнать их идентификаторы:

    ```bash
    export FOLDER_ID=<идентификатор_каталога>
    export IAM_TOKEN=<IAM-токен>
    curl \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
    ```

    Результат:


    ```json
    {
     "serviceAccounts": [
      {
       "id": "ajebqtreob2d********",
       "folderId": "b1gvmob95yys********",
       "createdAt": "2018-10-18T13:42:40Z",
       "name": "my-robot",
       "description": "my description"
      }
     ]
    }
    ```

1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`:

    ```json
    {
      "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
          "roleId": "<роль>",
          "subject": {
            "id": "<идентификатор_сервисного_аккаунта>",
            "type": "serviceAccount"
          }
        }
      }]
    }
    ```

    Где:

    * `roleId` — назначаемая роль.
    * `subject` — [субъект](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

        {% cut "Обозначения субъектов" %}

        {% include [subjects-designations-api](subjects-designations-api.md) %}

        {% endcut %}

1. {% include [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md) %}