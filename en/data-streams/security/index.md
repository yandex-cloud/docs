# Access management in {{ yds-name }}

{{ yds-name }} uses [roles](../../iam/concepts/access-control/roles.md) to manage access rights.

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user does not have any roles assigned, almost all operations are forbidden.

To allow access to {{ yds-full-name }} resources (data streams, {{ ydb-full-name }} databases storing them, and database users), assign the Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md) the required roles from the list below. Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ yds-name }} service.

{% include [yds-viewer](../../_includes/iam/roles/yds-viewer.md) %}

{% include [yds-writer](../../_includes/iam/roles/yds-writer.md) %}

{% include [yds-editor](../../_includes/iam/roles/yds-editor.md) %}

{% include [yds-admin](../../_includes/iam/roles/yds-admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-viewer }} {#viewer}

Users with the `{{ roles-viewer }}` role can view information about resources, for example, a list of streams, databases where they're created, and their properties.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage any resources, for example, create a stream or delete it. In addition, this role allows writing application data to streams.

The `{{ roles-editor }}` role also includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, for example, allow other users to create streams or view information about them.

The `{{ roles-admin }}` role also includes all permissions of the `{{ roles-editor }}` role.