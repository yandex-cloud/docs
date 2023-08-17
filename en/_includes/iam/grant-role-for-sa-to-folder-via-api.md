To assign the service account a role for a cloud or folder, use the `updateAccessBindings` REST API method for the [Cloud](../../resource-manager/api-ref/Cloud/index.md) or [Folder](../../resource-manager/api-ref/Folder/index.md) resource:

1. Select the role to assign to the service account. You can find a description of the roles in the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/roles.md).
1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder with service accounts.
1. [Get](../../iam/operations/iam-token/create.md) an IAM token required for authorization in the {{ yandex-cloud }} API.
1. Get a list of folder service accounts to find out their IDs:

   ```bash
   export FOLDER_ID=b1gvmob95yysaplct...
   export IAM_TOKEN=CggaATEVAgA...
   curl -H "Authorization: Bearer ${IAM_TOKEN}" \
     "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
   ```

   Result:


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

1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and the `roleId` property to the appropriate role, such as `{{ roles-editor }}`, and specify the `serviceAccount` type and service account ID in the `subject` property:

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
