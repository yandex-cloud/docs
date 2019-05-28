# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to resources in the [!KEYREF message-queue-full-name] service, assign the required roles to the user from the list below. For now, a role can only be assigned to a parent resource (folder or cloud), whose roles are inherited by nested resources.

> [!NOTE]
>
> For more information about role inheritance, see the section [Inheritance of access rights](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the [!KEYREF resmgr-name] documentation.

## Assigning roles

To manage message queues, the user must have the appropriate permissions in the cloud and folders where operations will be performed.

To grant the user permissions:

[!INCLUDE [grant-role-console](../../_includes/grant-role-console.md)]

## Roles

The list below shows all roles that are considered when verifying access rights in the [!KEYREF service-name] service.

### Service roles

Service roles are roles that allow access to the resources of a particular service. When [!KEYREF service-name] resource access rights are checked, [!KEYREF resmgr-name] service roles are taken into account.

[!INCLUDE [cloud-roles](../../_includes/cloud-roles.md)]

### Primitive roles

You can assign primitive roles to any resource in any service.

#### [!KEYREF roles-viewer]

A user with the `[!KEYREF roles-viewer]` role can view lists of cloud message queues and messages.

#### [!KEYREF roles-editor]

A user with the `[!KEYREF roles-editor]` role can perform any operations on message queues and messages.

In addition, the `[!KEYREF roles-editor]` role includes all permissions of the `[!KEYREF roles-viewer]` role.

#### [!KEYREF roles-admin]

A user with the `[!KEYREF roles-admin]` role can manage access rights to resources. For instance, they can allow other users to create message queues and messages or view information about them.

In addition, the `[!KEYREF roles-admin]` role includes all permissions of the role of `[!KEYREF roles-editor]`.

## See also

[Hierarchy of Yandex.Cloud resources](../../resource-manager/concepts/resources-hierarchy.md)

