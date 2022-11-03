# Access management

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ yds-full-name }} resources (streams, {{ydb-full-name}} databases that store them, and DB users), assign the user the required roles from the list below. Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ yds-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### yds.viewer {#yds-viewer}

Users with the `yds.viewer` role can read data from {{ yds-name }} streams and view their settings. The `yds.viewer` role also includes all permissions of the `ydb.viewer` role.

### yds.editor {#yds-editor}

The `yds.writer` role allows writing data to {{ yds-name }} streams.

### yds.admin {#yds-admin}

Users with the `yds.admin` role can manage resource access rights, for example, allow other users to create {{ yds-name }} streams or view information about them.

The `{{ roles-admin }}` role also includes all permissions of the `ydb.admin` role.

### {{ roles-viewer }} {#viewer}

Users with the `{{ roles-viewer }}` role can view information about resources, for example, a list of streams, databases where they're created, and their properties.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage any resources, for example, create a stream or delete it. In addition, this role allows writing application data to streams.

The `{{ roles-editor }}` role also includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, for example, allow other users to create streams or view information about them.

The `{{ roles-admin }}` role also includes all permissions of the `{{ roles-editor }}` role.