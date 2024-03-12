# Access management in {{ yds-name }}

{{ yds-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user does not have any roles assigned, almost all operations are forbidden.

To allow access to {{ yds-full-name }} resources (data streams, {{ ydb-full-name }} databases storing them, and database users), assign the Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md) the required roles from the list below. Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

Only users with the `admin`, `resource-manager.clouds.owner`, or `organization-manager.organizations.owner` role for a resource can assign roles for this resource.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ yds-name }} service.

### Service roles {#service-roles}

#### yds.viewer {#yds-viewer}

{% include [yds.viewer](../../_roles/yds/viewer.md) %}

#### yds.writer {#yds-writer}

{% include [yds.writer](../../_roles/yds/writer.md) %}

#### yds.editor {#yds-editor}

{% include [yds.editor](../../_roles/yds/editor.md) %}

#### yds.admin {#yds-admin}

{% include [yds.admin](../../_roles/yds/admin.md) %}

### Primitive roles {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

A user with the `{{ roles-viewer }}` role can view information about resources, e.g., lists of data streams and databases they are created in, their properties.

#### {{ roles-editor }} {#editor}

A user with the `{{ roles-editor }}` role can manage any resources, e.g., create a stream or delete it. In addition, this role allows writing application data to streams.

The `{{ roles-editor }}` role also includes all permissions of the `{{ roles-viewer }}` role.

#### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, for example, allow other users to create streams or view information about them.

The `{{ roles-admin }}` role also includes all permissions of the `{{ roles-editor }}` role.