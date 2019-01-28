# Authorization in the API

API requests can be made by users on behalf of a Yandex account or a service account.

**To use the API:**

1. Sign up for Yandex.Cloud.

   For more information, see the section [Getting started](../billing/quickstart/index.md) in the documentation on Billing.

1. Decide which [roles](../iam/concepts/access-control/roles.md) will be needed for the account that API requests will be made on behalf of. Select one of the options:
    * The `resource-manager.cloud.owner` role for the cloud.
    * A pair of roles: `resource-manager.cloud.member` for the cloud and `admin` for the cloud or folder.
    * A pair of roles: `resource-manager.cloud.member` for the cloud and `editor` for the cloud or folder.

    The `resource-manager.cloud.member` role doesn't have to be assigned for a service account.

1. Assign the selected roles to the account:
    * [Instructions](../resource-manager/operations/cloud/set-access-bindings.md) for how to assign a role to the cloud.
    * [Instructions](../resource-manager/operations/folder/set-access-bindings.md) for how to assign a role to a folder.

1. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console.

    > [!NOTE]
    >
    > If you assigned the `admin` or `editor` role to a user for a specific folder, select this folder at this step.

    If there is no folder, create one:

    [!INCLUDE [create-folder](create-folder.md)]

1. To get the folder ID, you can take it from the URL of the folder page in the management console:

    ```
    https://console.cloud.yandex.ru/folders/b5gfc3ntettogerelqed7p
    ```

    `b5gfc3ntettogerelqed7p` is the folder ID.

1. Get an IAM token:
    * [Instructions](../iam/operations/iam-token/create.md) for a Yandex account.
    * [Instructions](../iam/operations/iam-token/create-for-sa.md) for a service account.

1. In each API request to the service, pass:
    * The IAM token in the `Authorization` header in the `Authorization: Bearer <IAM token>` format.
    * The folder ID in the `folderId` parameter in the `folderId=<folder id>` format in the request body.

