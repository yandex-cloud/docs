# Identity and access management

Yandex Cloud users can only apply those operations to resources that are allowed by their assigned roles. As long as the user has no roles assigned, no operations are allowed.

To allow access to the [!KEYREF iam-full-name] service resources (service accounts and their access keys), assign appropriate roles to the user from the list below. You can assign a user a role for the service account, the folder hosting the account, or the entire cloud: access rights are inherited in Yandex Cloud.

> [!NOTE]
>
> For more information about role inheritance, see [[!TITLE]](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the [!KEYREF resmgr-full-name] service documentation.

## Assign roles

To assign a user a role for the cloud or folder:

[!INCLUDE [grant-role-console](../../_includes/grant-role-console.md)]

## Roles

Below is a list of all roles that are used for verifying access rights in the [!KEYREF iam-short-name] service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service. When resource access rights are checked, [!KEYREF iam-short-name] service roles are taken into account[!KEYREF resmgr-name].

[!INCLUDE [cloud-roles](../../_includes/cloud-roles.md)]

### Common roles

You can assign common roles to any resource in any service.

#### [!KEYREF roles-viewer]

A user with the role of `[!KEYREF roles-viewer]` can view information about resources, for example, get a list of access keys for a service account.

#### [!KEYREF roles-editor]

A user with the role of `[!KEYREF roles-editor]` can manage any resources, for example, create a service account or its access keys.

In addition, the role `[!KEYREF roles-editor]` includes all permissions of the role `[!KEYREF roles-viewer]`.

#### [!KEYREF roles-admin]

A user with the role of `[!KEYREF roles-admin]` can manage access rights to resources, for example, allow other users to view service accounts or view information about them.

In addition, the role `[!KEYREF roles-admin]` includes all permissions of the role of `[!KEYREF roles-editor]`.

