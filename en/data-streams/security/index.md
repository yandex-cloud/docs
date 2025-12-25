# Access management in {{ yds-name }}

{{ yds-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access permissions.

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To allow access to {{ yds-full-name }} resources (data streams, {{ ydb-full-name }} databases for streams and their users), assign relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource, such as a folder or cloud. Roles are inherited by nested resources.

To assign a role for a resource, you should have the `yds.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## What roles exist in this service {#roles-list}

The list below shows all roles used for access control in {{ yds-name }}.

{% include [data-streams](../../_mermaid/roles/data-streams.md) %}

### Service roles {#service-roles}

#### yds.auditor {#yds-auditor}

{% include [yds.auditor](../../_roles/yds/auditor.md) %}

#### yds.viewer {#yds-viewer}

{% include [yds.viewer](../../_roles/yds/viewer.md) %}

#### yds.writer {#yds-writer}

{% include [yds.writer](../../_roles/yds/writer.md) %}

#### yds.editor {#yds-editor}

{% include [yds.editor](../../_roles/yds/editor.md) %}

#### yds.admin {#yds-admin}

{% include [yds.admin](../../_roles/yds/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}