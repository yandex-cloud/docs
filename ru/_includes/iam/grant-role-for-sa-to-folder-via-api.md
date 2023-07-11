Чтобы назначить сервисному аккаунту роль на облако или каталог, воспользуйтесь методом REST API `updateAccessBindings` для ресурса [Cloud](../../resource-manager/api-ref/Cloud/index.md) или [Folder](../../resource-manager/api-ref/Folder/index.md):

1. Выберите роль, которую хотите назначить сервисному аккаунту. Описание ролей можно найти в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/roles.md).
1. [Узнайте](../../resource-manager/operations/folder/get-id.md) ID каталога с сервисными аккаунтами.
1. [Получите](../../iam/operations/iam-token/create.md) IAM-токен для авторизации в API {{ yandex-cloud }}.
1. Получите список сервисных аккаунтов в каталоге, чтобы узнать их идентификаторы:

    ```bash
    export FOLDER_ID=b1gvmob95yysaplct...
    export IAM_TOKEN=CggaATEVAgA...
    curl -H "Authorization: Bearer ${IAM_TOKEN}" \
      "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
    ```

    Результат:


    ```json
    {
     "serviceAccounts": [
      {
       "id": "ajebqtreob2dpblin...",
       "folderId": "b1gvmob95yysaplct...",
       "createdAt": "2018-10-18T13:42:40Z",
       "name": "my-robot",
       "description": "my description"
      }
     ]
    }
    ```

1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, в свойстве `roleId` — нужную роль, например `{{ roles-editor }}`, а в свойстве `subject` — тип `serviceAccount` и идентификатор сервисного аккаунта:

    **body.json:**
    ```json
    {
      "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
          "roleId": "editor",
          "subject": {
            "id": "ajebqtreob2dpblin...",
            "type": "serviceAccount"
          }
        }
      }]
    }
    ```
1. {% include [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md) %}
