# Roles

_A role_ is a set of user permissions to perform operations with Yandex Cloud resources.

When you assign a role, you specify the assigned subject and a resource to which the role applies. The subject can be a normal user, service account, or system subject. A subject can be assigned multiple roles for the same resource. For more information, see the section [[!TITLE]](access-bindings.md).

There are two types of roles:

- _Common roles_ are the roles that can be assigned to any Yandex Cloud resources. These are the roles of `[!KEYREF roles-admin]`, `[!KEYREF roles-editor]` and `[!KEYREF roles-viewer]`.

- _Service roles_ are the roles created for a specific service. The service role identifier is specified in the `service.resources.role`  format. For example, the role of `[!KEYREF roles-image-user]` allows you to use images in the Yandex Compute Cloud service.

    A service role cannot be assigned for any resource. It can only be assigned to the resource the role is intended for. For example, `[!KEYREF roles-cloud-member]` can only be assigned for a cloud.

    A service role can also be assigned for resources that access rights are inherited from. For example, `[!KEYREF roles-image-user]` can be assigned for a folder or cloud, because images inherit access rights from them.

Currently, users are not allowed to create new roles with a specific set of permissions.

> [!NOTE]
>
> To access a resource, you may need to have multiple roles at the same time. For example, to view information about a folder in a cloud, just the `[!KEYREF roles-viewer]` role is not enough — you also need the role of `[!KEYREF roles-cloud-member]` in this cloud. Read more in the section [[!TITLE]](../../../resource-manager/concepts/resources-hierarchy.md) in the Yandex Resource Manager documentation.

## Common roles {#common-roles}

#### [!KEYREF roles-viewer]

The role of `[!KEYREF roles-viewer]` grants the right to read resources.

For example, the role of `[!KEYREF roles-viewer]` allows you to perform the following operations:

- View information about a resource.
- Get a list of resources, such as a list of virtual machines in a folder.
- View a list of operations with the resource.

#### [!KEYREF roles-editor]

The role of `[!KEYREF roles-editor]` grants access rights to all operations relating to resource management, except for assigning roles to other users. The role of ` [!KEYREF roles-editor]` includes all access rights granted by the role of `[!KEYREF roles-viewer]`.

For example, the role of `[!KEYREF roles-editor]` allows you to perform the following operations:

- Create a resource.
- Update a resource.
- Delete a resource.

#### [!KEYREF roles-admin]

The role of `[!KEYREF roles-admin]` grants full access rights to manage the resource, including assigning roles to other users. You can assign any roles except `[!KEYREF roles-cloud-owner]`.

The role of `[!KEYREF roles-admin]` includes all access rights granted by the role of `[!KEYREF roles-editor]`.

For example, the role of `[!KEYREF roles-admin]` allows you to perform the following operations:

- Set access rights to the resource.
- Change access rights to the resource.

## Service roles {#service-roles}

### Yandex Resource Manager {#yrm-roles}

[!INCLUDE [cloud-roles](../../../_includes/cloud-roles.md)]

### Yandex Compute Cloud {#compute-roles}

[!INCLUDE [roles-images-user](../../../_includes/roles-images-user.md)]

