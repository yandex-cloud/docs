# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden. Regardless of the roles assigned, the user can view reference lists of availability zones and disk types.

To allow access to Yandex Compute Cloud resources (VMs, disks, images, and snapshots), assign the user the required roles from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [#T](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the Yandex Resource Manager documentation.

{% endnote %}

## Assigning roles

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles

The list below shows all roles that are considered when verifying access rights in the Compute Cloud service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service. When checking  Compute Cloud resource access rights, Compute Cloud and Resource Manager service roles are considered.

{% include [roles-disks-user](../../_includes/roles-disks-user.md) %}

{% include [roles-images-user](../../_includes/roles-images-user.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles

You can assign primitive roles to any resource in any service.

#### viewer

A user with the `viewer` role can view information about resources (for example, view a list of disks or obtain information about a VM).

#### editor

A user with the `editor` role can manage any resources (for example, create, stop, or start a VM, and attach or detach a disk).

In addition, the `editor` role includes all permissions of the `viewer` role.

#### admin

A user with the `admin` role can manage access rights to resources (for example, allow other users to create VMs or view information about them).

In addition, the `admin` role includes all permissions of the role of `editor`.

