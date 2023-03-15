Вы можете назначить роль сервисному аккаунту с помощью REST API:

1. Узнайте ID каталога с сервисными аккаунтами.
1. Получите список сервисных аккаунтов в каталоге, чтобы узнать их идентификаторы:

    ```bash
    export FOLDER_ID=b1gvmob95yysaplct532
    export IAM_TOKEN=CggaATEVAgA...
    curl -H "Authorization: Bearer ${IAM_TOKEN}" \
      "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
    ```

    Результат:


    ```json
    {
     "serviceAccounts": [
      {
       "id": "ajebqtreob2dpblin8pe",
       "folderId": "b1gvmob95yysaplct532",
       "createdAt": "2018-10-18T13:42:40Z",
       "name": "my-robot",
       "description": "my description"
      }
     ]
    }
    ```

1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `serviceAccount` и ID сервисного аккаунта:

    **body.json:**
    ```json
    {
        "accessBindingDeltas": [{
            "action": "ADD",
            "accessBinding": {
                "roleId": "editor",
                "subject": {
                    "id": "ajebqtreob2dpblin8pe",
                    "type": "serviceAccount"
                    }
                }
            }
        ]
    }
    ```
1. {% include [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md) %}
