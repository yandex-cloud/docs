# Access management

Yandex.Cloud users can only perform operations on resources that are permitted under the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ mch-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles

The list below shows all roles that are considered when verifying access rights in the {{ mch-name }} service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles

You can assign primitive roles to any resource in any service.

#### {{ roles-viewer }}

Users with the `{{ roles-viewer }}` role can view information about resources. For example, they can view a list of hosts or get information about a database cluster.

#### {{ roles-editor }}

Users with the `{{ roles-editor }}` role can manage any resource, including creating a database cluster and creating or deleting cluster hosts.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

#### {{ roles-admin }}

Users with the `{{ roles-admin }}` role can manage resource access rights, including allowing other users to create database clusters and to view information about them.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

