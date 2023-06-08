# Getting the service account ID

If you do not have a service account, [create one](create.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the service account belongs to.
   1. At the top of the screen, go to the **Service accounts** tab.
   1. Choose a service account and click the line with its name.
   1. The **Overview** page will show the **ID** of the service account — a string in the format `aje9sb6....ffd2uv0i9`.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   If you know the service account name, use the `get` command to get the account ID:

   ```bash
   yc iam service-account get my-robot
   ```

   Result:

   ```
   id: aje6o61dvog2h6g9a33s
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
   | aje6o61dvog2h6g9a33s | my-robot         |                               |
   | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
   +----------------------+------------------+-------------------------------+
   ```

- API

   1. [Find out the ID of the folder](../../../resource-manager/operations/folder/get-id.md) where the service account was created.
   1. Get information about the service accounts in the folder using the [list](../../api-ref/ServiceAccount/list.md) REST API method for the [ServiceAccount](../../api-ref/ServiceAccount/index.md) resource:

      ```bash
      export FOLDER_ID=b1gvmob95yysaplct532
      export IAM_TOKEN=CggaATEVAgA...
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        "https://iam.{{ api-host }}/iam/v1/serviceAccounts?folderId=${FOLDER_ID}"

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

      You can also get information about the service accounts in the folder using the [ServiceAccountService/List](../../api-ref/grpc/service_account_service.md#List) gRPC API call.

{% endlist %}
