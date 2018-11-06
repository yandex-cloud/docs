# Authorization in the API

API requests can be made by users with a registered Yandex.Passport account.

**To use the API:**

1. Sign up for Yandex.Cloud.

   To learn more, see the section [Getting started](../billing/quickstart/index.md) in the documentation on Billing.

1. Assign the required [roles](../iam/concepts/access-control/roles.md)  to the user on whose behalf API requests will be made. Select one of the options:
    * The `resource-manager.cloud.owner` role for the cloud.
    * A pair of roles:  `resource-manager.cloud.member`  for the cloud and `admin` for the cloud or folder.
    * A pair of roles: `resource-manager.cloud.member` for the cloud and `editor` for the cloud or folder.

    To assign roles, execute:

    [!INCLUDE [grant-role-console](grant-role-console.md)]

1. If you already have a folder in Yandex.Cloud, open the page of that folder in the management console.

    > [!NOTE]
    >
    > If you have assigned the `admin` or `editor` role for a specific folder to the user who will make API requests, select that folder at this step.
    >

    If there is no folder yet, create one:

    [!INCLUDE [create-folder](create-folder.md)]

1. Find the folder ID in the URL of the folder page in the management console.

2. [Get an IAM token ](../iam/operations/iam-token/create.md).

3. In each API request to the service, pass:
    * IAM token in the `Authorization` header in the `Authorization: Bearer <IAM-token>` format.
    * Folder ID in the `folderId` parameter in the `folderId=<folder id>` format in the request body.

