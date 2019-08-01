# Access management

Yandex.Cloud users can only perform operations on resources that are permitted under the roles assigned to them.
If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to resources in the {{ monitoring-full-name }} service, assign the required roles to the user from the list below. Roles can currently only be assigned to parent resources (folders or clouds), whose roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [#T](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#assignment}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ monitoring-full-name }} service.

### Service roles {#service-roles}

_Service roles_ are roles that allow access to the resources of a particular service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles {#primitive-roles}

You can assign primitive roles to any resource in any service.

#### {{ roles-viewer }}

Users with the `{{ roles-viewer }}` role can view created dashboards and widgets, as well as written metrics.

#### {{ roles-editor }}

Users with the `{{ roles-editor }}` role can create dashboards and widgets, as well as write metrics.

In addition, the `{{ roles-editor }}` role includes all permissions of the `{{ roles-viewer }}` role.

#### {{ roles-admin }}

Users with the `{{ roles-admin }}` role can create dashboards and widgets, as well as write metrics.

In addition, the `{{ roles-admin }}` role includes all permissions of the `{{ roles-editor }}` role.

