# Access management in {{ yq-name }}

{{ yq-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access permissions.

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To allow access to {{ yq-full-name }} resources, assign relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource, such as a folder or cloud. Roles are inherited by nested resources.

To assign a role for a resource, you should have the `yq.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} guide.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles this service has {#roles-list}

You can manage access to {{ yq-name }} objects using both service and primitive roles. The chart below shows the roles existing in the service and their permission inheritance. For example, `editor` inherits all `viewer` permissions. You can find the role descriptions below the chart.

{% include [query](../../_mermaid/roles/query.md) %}

The list below shows all roles used for access control in {{ yq-name }}.

### Service roles {#service-roles}

#### yq.auditor {#query-auditor}

{% include [query.auditor](../../_roles/yq/auditor.md) %}

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
