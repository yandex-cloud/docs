To assign a role for a cloud or folder to a service account, use the `updateAccessBindings` REST API method for the [Cloud](../../resource-manager/api-ref/Cloud/index.md) or [Folder](../../resource-manager/api-ref/Folder/index.md) resource:

1. Select a role to assign to the service account. For role descriptions, see the [{{ yandex-cloud }} role reference](../../iam/roles-reference.md) in the {{ iam-full-name }} documentation.
1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder with service accounts.
1. [Get](../../iam/operations/iam-token/create.md) an IAM token for authentication in the {{ yandex-cloud }} API.
1. Get a list of service accounts in the folder to find out their IDs:

    ```bash
    export FOLDER_ID=<folder_ID>
    export IAM_TOKEN=<IAM_token>
    curl \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
    ```

    Result:


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

1. Create a request body, e.g., in the `body.json` file. Specify `ADD` in the `action` property:

    ```json
    {
      "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
          "roleId": "<role>",
          "subject": {
            "id": "<service_account_ID>",
            "type": "serviceAccount"
          }
        }
      }]
    }
    ```

    Where:

    * `roleId`: Role.
    * `subject`: [Subject](../../iam/concepts/access-control/index.md#subject) getting the role.

        {% cut "Subject designations" %}

        {% include [subjects-designations-api](subjects-designations-api.md) %}

        {% endcut %}

1. {% include [grant-role-folder-via-curl-step](grant-role-folder-via-curl-step.md) %}