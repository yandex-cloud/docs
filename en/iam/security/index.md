# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to the [!KEYREF iam-full-name] service resources (service accounts and their access keys), assign appropriate roles to the user from the list below. You can assign a user a role for the service account, the folder hosting the account, or the entire cloud: access rights are inherited in Yandex Cloud.

> [!NOTE]
>
> For more information about role inheritance, see [[!TITLE]](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the [!KEYREF resmgr-full-name] documentation.

## Assigning roles

To assign a user a role for the cloud or folder:

[!INCLUDE [grant-role-console](../../_includes/grant-role-console.md)]

## Roles

The list below shows all roles that are considered when verifying access rights in the [!KEYREF iam-short-name] service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service. When checking [!KEYREF iam-short-name] resource access rights, [!KEYREF resmgr-name] service roles are also taken into account.

### Yandex [!KEYREF iam-full-name] {#yrm-roles}

[!INCLUDE [roles-sa-user](../../_includes/roles-sa-user.md)]

### Yandex Resource Manager {#yrm-roles}

[!INCLUDE [cloud-roles](../../_includes/cloud-roles.md)]

### Primitive roles

You can assign primitive roles to any resource in any service.

#### [!KEYREF roles-viewer]

A user with the `[!KEYREF roles-viewer]` can view information about resources, for example, get a list of access keys for a service account.

#### [!KEYREF roles-editor]

A user with the `[!KEYREF roles-editor]` can manage any resources, for example, create a service account or its access keys.

In addition, the `[!KEYREF roles-editor]` role includes all permissions of the `[!KEYREF roles-viewer]` role.

#### [!KEYREF roles-admin]

A user with the `[!KEYREF roles-admin]` can manage access rights to resources, for example, allow other users to view service accounts or view information about them.

In addition, the `[!KEYREF roles-admin]` role includes all permissions of the role of `[!KEYREF roles-editor]`.

