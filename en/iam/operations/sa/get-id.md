# Getting the service account ID

If you do not have a service account, [create one](create.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Choose a service account and click the row with its name.
   1. The **{{ ui-key.yacloud.iam.folder.service-account.overview.label_title }}** page will show the service account **{{ ui-key.yacloud.iam.folder.service-account.overview.label_id }}** as a string in the `aje9sb6ffd2u********` format.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   If you know the service account name, use the `get` command to get the account ID:

   ```bash
   yc iam service-account get my-robot
   ```

   Result:

   ```
   id: aje6o61dvog2********
   ...
   ```

   If you don't know the name, get a list of service accounts in the default folder:

   ```bash
   yc iam service-account list
   ```

   Result:

   ```
   +----------------------+------------------+-------------------------------+
   |          ID          |       NAME       |          DESCRIPTION          |
   +----------------------+------------------+-------------------------------+
   | aje6o61dvog2******** | my-robot         |                               |
   | aje9sda1ufvq******** | account_name     | account_description           |
   +----------------------+------------------+-------------------------------+
   ```

- API {#api}

   1. [Find out the ID of the folder](../../../resource-manager/operations/folder/get-id.md) where the service account was created.
   1. Get information about the service accounts in the folder using the [list](../../api-ref/ServiceAccount/list.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource:

      ```bash
      export FOLDER_ID=b1gvmob95yys********
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"

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

      You can also get information about the service accounts in the folder using the [ServiceAccountService/List](../../api-ref/grpc/ServiceAccount/list.md) gRPC API call.

{% endlist %}
