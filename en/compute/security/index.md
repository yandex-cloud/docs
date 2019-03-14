# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden. Regardless of the roles assigned, the user can view reference lists of availability zones and disk types.

To allow access to [!KEYREF compute-full-name] resources (VMs, disks, images, and snapshots), assign the user the required roles from the list below. At this time, a role can only be assigned to a parent resource (folder or cloud), and the roles are inherited by nested resources.

> [!NOTE]
>
> For more information about role inheritance, see [[!TITLE]](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the [!KEYREF resmgr-full-name] documentation.

## Assigning roles

To assign a role to a user:

[!INCLUDE [grant-role-console](../../_includes/grant-role-console.md)]

## Roles

The list below shows all roles that are considered when verifying access rights in the [!KEYREF compute-short-name] service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service. When checking  [!KEYREF compute-short-name] resource access rights, [!KEYREF compute-short-name] and [!KEYREF resmgr-name] service roles are considered.

[!INCLUDE [roles-disks-user](../../_includes/roles-disks-user.md)]

[!INCLUDE [roles-images-user](../../_includes/roles-images-user.md)]

[!INCLUDE [cloud-roles](../../_includes/cloud-roles.md)]

### Primitive roles

You can assign primitive roles to any resource in any service.

#### [!KEYREF roles-viewer]

A user with the `[!KEYREF roles-viewer]` can view information about resources, for example, view a list of disks or obtain information about a VM.

#### [!KEYREF roles-editor]

A user with the `[!KEYREF roles-editor]` can manage any resources, such as create, stop, or start a VM, and attach or detach a disk.

In addition, the `[!KEYREF roles-editor]` role includes all permissions of the `[!KEYREF roles-viewer]` role.

#### [!KEYREF roles-admin]

A user with the `[!KEYREF roles-admin]` can manage access rights to resources, for example, allow other users to create VMs or view information about them.

In addition, the `[!KEYREF roles-admin]` role includes all permissions of the role of `[!KEYREF roles-editor]`.

