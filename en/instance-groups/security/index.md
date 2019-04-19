# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden. Regardless of the roles assigned, the user can view reference lists of availability zones and disk types.

To allow access to the resources of the [!KEYREF ig-name] component of [!KEYREF compute-full-name] (instance groups, instances, disks, images, and snapshots), assign the user the required roles from the list below. For now, a role can only be assigned to a parent resource (folder or cloud), whose roles are inherited by nested resources.

> [!NOTE]
>
> For more information about role inheritance, see [[!TITLE]](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the [!KEYREF resmgr-full-name] documentation.

## Assigning roles

To assign a role to a user:

[!INCLUDE [grant-role-console.md](../../_includes/grant-role-console.md)]

## Roles

Below is a list of all roles that are considered when verifying access rights in the [!KEYREF ig-name] component of [!KEYREF compute-short-name].

### Primitive roles

You can assign primitive roles to any resource in any service.

#### [!KEYREF roles-owner]

A user with the `[!KEYREF roles-owner]` role can perform any operations on cloud resources.

#### [!KEYREF roles-viewer]

A user with the `[!KEYREF roles-viewer]` role can view information about resources (for example, view a list of disks or obtain information about a VM).

#### [!KEYREF roles-editor]

A user with the `[!KEYREF roles-editor]` role can manage any resources (for example, create, stop, or start a VM, and attach or detach a disk).

In addition, the `[!KEYREF roles-editor]` role includes all permissions of the `[!KEYREF roles-viewer]` role.

#### [!KEYREF roles-admin]

A user with the `[!KEYREF roles-admin]` role can manage access rights to resources (for example, allow other users to create VMs or view information about them).

In addition, the `[!KEYREF roles-admin]` role includes all permissions of the role of `[!KEYREF roles-editor]`.

