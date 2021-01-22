# Access management

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them.
If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ sf-name }} service resources (functions and their versions), assign users applicable roles from the list below. For now, a role can be assigned for a parent resource (folder or cloud) or a function.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ sf-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [functions-roles-invoker](../../_includes/roles-functions-invoker.md) %}

### {{ roles-viewer }} {#viewer}

The user with the `{{ roles-viewer }}` role can view information about resources, such as the list of functions or their versions and the function execution log.

### {{ roles-editor }} {#editor}

The user with the `{{ roles-editor }}` role can manage functions and their versions, such as creating or deleting a version or editing information about a function.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

### {{ roles-admin }} {#admin}

The user with the `{{ roles-admin }}` role can manage access rights to resources, such as allow other users to invoke functions or work with their versions.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

