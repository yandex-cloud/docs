# Access management

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them.
If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ iot-short-name }} resources (registers and devices), assign users applicable roles from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ iot-short-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-viewer }} {#viewer}

Users with the `{{ roles-viewer }}` role can view information about resources, for example, a list of devices and their certificates.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage devices, such as creating registries and devices or adding and deleting certificates.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, such as allowing other users to view devices.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

