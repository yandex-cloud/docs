# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ iot-short-name }} resources (registries and devices), assign users applicable roles from the list below. Roles can currently only be assigned to parent resources (folder or cloud), whose roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ iot-short-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### {{ roles-viewer }} {#viewer}

A user with the `{{ roles-viewer }}` role can view information about resources, for example, a list of devices and their certificates.

### {{ roles-editor }} {#editor}

A user with the `{{ roles-editor }}` role can manage devices, for example, create registries and devices or add and delete certificates.

The `{{ roles-editor }}` role also includes all the permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

A user with the `{{ roles-admin }}` role can manage access rights to resources, for example, allow other users to view devices.

The `{{ roles-admin }}` role includes all permissions of the role of `{{ roles-editor }}`.

