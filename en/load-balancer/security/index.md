# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to resources in the Yandex Load Balancer service, assign the required roles to the user from the list below. At this time, a role can only be assigned to a parent resource (folder or cloud), and the roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see the section [Inheritance of access rights](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the Resource Manager documentation.

{% endnote %}

## Assigning roles

To manage load balancers, the user must have the appropriate permissions in the cloud and folders where operations will be performed.

To grant the user permissions:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles

The list below shows all roles that are considered when verifying access rights in the Load Balancer service.

### Service roles

Service roles are roles that allow access to the resources of a particular service. When Load Balancer resource access rights are checked, Resource Manager service roles are taken into account.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles

You can assign primitive roles to any resource in any service.

#### viewer

A user with the `viewer` role can view lists of load balancers and target groups.

#### editor

A user with the `editor` role can perform any operations on load balancers and target groups: create, delete, and update them.

In addition, the `editor` role includes all permissions of the `viewer` role.

#### admin

A user with the `admin` role can manage access rights to resources. For example, they can allow other users to create load balancers and target groups or view information about them.

In addition, the `admin` role includes all permissions of the role of `editor`.

## See also

[Hierarchy of Yandex.Cloud resources](../../resource-manager/concepts/resources-hierarchy.md)

