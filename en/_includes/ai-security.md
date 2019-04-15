# Access management

The service does not create any resources, so access management is implemented through [folders](../resource-manager/concepts/resources-hierarchy.md#folder). You specify the folder ID in each request to the service. If you don't have the required permissions for this folder, the service returns an error.

To be able to use the service, you must have one of the following combinations of [roles](../iam/concepts/access-control/roles.md):

* `resource-manager.cloud.member` + `editor`
* `resource-manager.cloud.member` + `admin`
* `resource-manager.cloud.owner`

The [service account](../iam/concepts/users/service-accounts.md) and [system group](../iam/concepts/access-control/system-group.md) do not require the `resource-manager.cloud.member` role.

A user with a Yandex account is assigned the `resource-manager.cloud.member` role automatically when [being added to the cloud](../iam/operations/users/create.md).

> [!NOTE]
>
> The `editor` and `admin` roles can be assigned for a folder or cloud: all cloud access rights are [inherited](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

#### What's next

* [How to assign a folder role](../resource-manager/operations/folder/set-access-bindings.md)
* [How to assign a cloud role](../resource-manager/operations/cloud/set-access-bindings.md)
* [Learn more about roles in Yandex.Cloud](../iam/concepts/access-control/roles.md)

