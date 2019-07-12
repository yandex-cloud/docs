# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to the Yandex Resource Manager service resources (clouds and folders), assign applicable roles to the user from the list below. The roles assigned to the parent resource are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [#T](../concepts/resources-hierarchy.md#access-rights-inheritance).

{% endnote %}

## Assigning roles

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles

The list below shows all roles that are considered when verifying access rights in the Resource Manager service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles

You can assign primitive roles to any resource in any service.

#### viewer

A user with the `viewer` can view information about resources, for example, view a list of folders in the cloud or obtain information about a folder.

#### editor

A user with the `editor` can manage all resources, for example, create a folder.

In addition, the `editor` role includes all permissions of the `viewer` role.

#### admin

A user with the `admin` can manage access rights to resources, for example, allow other users to create folders or view information about them.

In addition, the `admin` role includes all permissions of the role of `editor`.

