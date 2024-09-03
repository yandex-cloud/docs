The `iam.admin` role enables managing service accounts and access to them and their keys, as well as managing folders, viewing info on IAM resource operations and quotas, and getting IAM tokens for service accounts.

Users with this role can:
* View the list of [service accounts](../../iam/concepts/users/accounts.md#sa) and info on them, as well as create, use, modify, and delete them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) assigned for service accounts and modify such permissions.
* Get [IAM tokens](../../iam/concepts/authorization/iam-token.md) for service accounts.
* View the list of service account [API keys](../../iam/concepts/authorization/api-key.md) and info on them, as well as create, modify, and delete them.
* View the list of service account [static access keys](../../iam/concepts/authorization/access-key.md) and info on them, as well as create, modify, and delete them.
* View info on service account [authorized keys](../../iam/concepts/authorization/key.md), as well as create, modify, and delete them.
* View info on [identity federations](../../iam/concepts/federations.md).
* View the list of operations and the info on Identity and Access Management resource operations.
* View info on Identity and Access Management [quotas](../../iam/concepts/limits.md#iam-quotas).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and its settings.
* View info on the relevant [folders](../../resource-manager/concepts/resources-hierarchy.md#folder) and their settings.
* Create, modify, delete, and setup folders.

This role also includes the `iam.editor` and `iam.serviceAccounts.admin` permissions.