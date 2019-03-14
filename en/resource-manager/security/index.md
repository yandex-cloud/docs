# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to the [!KEYREF resmgr-full-name] service resources (clouds and folders), assign applicable roles to the user from the list below. The roles assigned to the parent resource are inherited by nested resources.

> [!NOTE]
>
> For more information about role inheritance, see [[!TITLE]](../concepts/resources-hierarchy.md#access-rights-inheritance).

## Assigning roles

To assign a role to a user:

[!INCLUDE [grant-role-console](../../_includes/grant-role-console.md)]

## Roles

The list below shows all roles that are considered when verifying access rights in the [!KEYREF resmgr-short-name] service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service.

[!INCLUDE [cloud-roles](../../_includes/cloud-roles.md)]

### Primitive roles

You can assign primitive roles to any resource in any service.

#### [!KEYREF roles-viewer]

A user with the `[!KEYREF roles-viewer]` can view information about resources, for example, view a list of folders in the cloud or obtain information about a folder.

#### [!KEYREF roles-editor]

A user with the `[!KEYREF roles-editor]` can manage all resources, for example, create a folder.

In addition, the `[!KEYREF roles-editor]` role includes all permissions of the `[!KEYREF roles-viewer]` role.

#### [!KEYREF roles-admin]

A user with the `[!KEYREF roles-admin]` can manage access rights to resources, for example, allow other users to create folders or view information about them.

In addition, the `[!KEYREF roles-admin]` role includes all permissions of the role of `[!KEYREF roles-editor]`.

