# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ mmy-name }} service resources (database clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [#T](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles

The list below shows all roles that are considered when verifying access rights in the {{ mmy-name }} service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles

You can assign primitive roles to any resource in any service.

#### {{ roles-viewer }}

Users with the `{{ roles-viewer }}` role can view information about resources. For example, they can view a list of hosts or get information about a database cluster.

#### {{ roles-editor }}

User with the `{{ roles-editor }}` role can manage resources. For example, they can create a database cluster and create and delete cluster hosts.

Additionally, the `{{ roles-editor }}` role includes all the permissions of the `{{ roles-viewer }}` role.

#### {{ roles-admin }}

Users with the `{{ roles-admin }}` role can manage access rights to resources. For example, they can allow other users to create database clusters or view information about them.

Additionally, the `{{ roles-admin }}` role includes all the permissions of the `{{ roles-editor }}` role.

