# Access management

Yandex.Cloud users can only perform operations on resources that are permitted under the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to {{ resmgr-full-name }} resources (clouds and folders), assign applicable roles to the user from the list below. The roles assigned to the parent resource are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../concepts/resources-hierarchy.md#access-rights-inheritance).

{% endnote %}

## Assigning roles

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles

The list below shows all roles that are considered when verifying access rights in the {{ resmgr-short-name }} service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles

You can assign primitive roles to any resource in any service.

#### {{ roles-viewer }}

Users with the `{{ roles-viewer }}` role can view information about resources. For example, they can view a list of folders in the cloud and get information about a folder.

#### {{ roles-editor }}

Users with the `{{ roles-editor }}` role can manage any resource, such as creating a folder.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

#### {{ roles-admin }}

Users with the `{{ roles-admin }}` role can manage resource access rights, such as allowing other users to create folders or view their details.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.

