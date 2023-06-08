You can assign roles to service accounts using the REST API:

1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder with service accounts.
1. Get a list of folder service accounts to find out their IDs:

   ```bash
   export FOLDER_ID=b1gvmob95yysaplct532
   export IAM_TOKEN=CggaATEVAgA...
   curl -H "Authorization: Bearer ${IAM_TOKEN}" \
     "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"
   ```

   Result:


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

1. Create a request body, for example, in a `body.json` file. Set the `action` property to `ADD` and specify the `serviceAccount` type and service account ID in the `subject` property:

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
