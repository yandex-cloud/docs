# Access management

When making requests from [a Yandex account](../iam/concepts/index.md#passport), please specify [the ID of the folder](../resource-manager/operations/folder/get-id.md) that you have `editor` permissions for. If the required permissions are missing, the service returns an error.

Do not specify a folder for [service accounts](../iam/concepts/users/service-accounts.md): instead, use the folder where the account was created.

Permissions are granted when [roles are assigned](../iam/operations/roles/grant.md). A role can be assigned for a folder or cloud: all cloud access rights are [inherited](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

To use the service, you must have one of the following [roles](../iam/concepts/access-control/roles.md):

* `editor`
* `admin`
* `resource-manager.cloud.owner` (only assigned for the cloud)

{% note info %}

Users with a Yandex or [federated account](../iam/concepts/users/identity-federations.md) need the `resource-manager.cloud.member` role for the cloud along with the `editor` or `admin` role. This role is assigned to the user automatically when they are [added to the cloud](../iam/operations/users/create.md).

{% endnote %}

#### What's next

* [How to assign a folder role](../resource-manager/operations/folder/set-access-bindings.md)
* [How to assign a cloud role](../resource-manager/operations/cloud/set-access-bindings.md)
* [Learn more about roles in Yandex.Cloud](../iam/concepts/access-control/roles.md)

