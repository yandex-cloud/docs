# Access management

Yandex.Cloud users can only perform operations on resources that are permitted under the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ dataproc-name }} service resources (clusters and subclusters), assign the user the required roles from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [#T](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#assign-role}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

Below is a list of all roles that are used to verify access rights in {{ dataproc-name }}.

### Service roles {#service-roles}

_Service roles_ are roles that allow access to the resources of a particular service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [mdb.dataproc.agent](../../_includes/roles-dataproc-agent.md) %}

### Primitive roles {#primitive-roles}

You can assign primitive roles to any resource in any service.

#### {{ roles-viewer }} {#viewer}

Users with the `{{ roles-viewer }}` role can connect to hosts in the
{{ dataproc-name }} cluster if its SSH keys are linked to this cluster.

#### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage any resource, including creating clusters and creating and deleting their subclusters.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

#### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, including allowing other users to create {{ dataproc-name }} clusters and to view information about user rights.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

