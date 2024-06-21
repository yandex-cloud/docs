# Access management in {{ yq-name }}

{{ yq-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user does not have any roles assigned, almost all operations are forbidden.

To allow access to {{ yq-full-name }} resources, assign the required roles from the list below to the Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md). Currently, a role can only be assigned for a parent resource (folder or cloud). Roles are inherited by nested resources.

Roles for a resource can be assigned by users who have the `yq.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Which roles exist in the service {#roles-list}

You can manage access to {{ yq-name }} objects using both service and primitive roles. The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `editor` role includes all `viewer` role permissions. You can find the description of each role under the chart.

<center>

![image](../../_assets/query/service-roles-hierarchy.svg)

</center>

The list below shows all roles that are considered when verifying access rights in the {{ yq-name }} service.

### Service roles {#service-roles}

#### yq.viewer {#query-viewer}

{% include [query.viewer](../../_roles/yq/viewer.md) %}

#### yq.editor {#query-editor}

{% include [query.editor](../../_roles/yq/editor.md) %}

#### yq.admin {#query-admin}

{% include [query.admin](../../_roles/yq/admin.md) %}

#### yq.invoker {#query-invoker}

{% include [query.invoker](../../_roles/yq/invoker.md) %}

### Primitive roles {#primitive-roles}

#### {{ roles-viewer }}

Users with the `{{ roles-viewer }}` role can view information about resources, such as query runs.

#### {{ roles-editor }}

Users with the `{{ roles-editor }}` role can manage any resource, such as creating or deleting a query. The `{{ roles-editor }}` role includes all permissions of the `{{ roles-viewer }}` role.

#### {{ roles-admin }}

Users with the `{{ roles-admin }}` role can manage resource access rights, such as permitting other users to create queries. The `{{ roles-admin }}` role includes all permissions of the `{{ roles-editor }}` role.
