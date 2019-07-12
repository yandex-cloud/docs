# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them.
If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to resources of the Container Registry service (registries and Docker images),
assign applicable roles to the user from the list below. For now, a role can only be assigned to a parent resource (folder or cloud), whose roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [#T](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the Yandex Resource Manager documentation.

{% endnote %}

## Assigning roles

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles

The list below shows all roles that are considered when verifying access rights in the Container Registry service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles

You can assign primitive roles to any resource in any service.

#### viewer

A user with the `viewer` role can view information about resources, for example, view a list of registries or pull a Docker image.

#### editor

A user with the `editor` role can manage Docker images, for example, push or delete them.

In addition, the `editor` role includes all permissions of the `viewer` role.

#### admin

A user with the `admin` role can manage access rights to resources, for example, allow other users to view registries or work with Docker images.

In addition, the `admin` role includes all permissions of the role of `editor`.

