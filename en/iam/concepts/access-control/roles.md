# Roles

_A role_ is a set of user permissions to perform operations with Yandex.Cloud resources.

There are two types of roles:

- _Primitive roles_ contain permissions that apply to all types of Yandex.Cloud resources. These are the roles of `[!KEYREF roles-admin]`, `[!KEYREF roles-editor]` and `[!KEYREF roles-viewer]`.

- _Service roles_ contain permissions only for a specific type of resource in a particular service. The ID of a service role is specified in `service.resources.role` format. For example, the role of `[!KEYREF roles-image-user]` allows you to use images in the Yandex Compute Cloud service.

    A service role can be assigned to the resource that the role is intended for or the resource that access rights are inherited from. For example, the role of `[!KEYREF roles-image-user]` can be assigned for a folder or cloud, because images inherit permissions from them.

Currently, users are not allowed to create new roles with a custom set of permissions.

## Primitive roles {#primitive-roles}

#### [!KEYREF roles-viewer] {#viewer}

The role of `[!KEYREF roles-viewer]` grants permissions to read resources.

For example, the role of `[!KEYREF roles-viewer]` allows you to perform the following operations:

- View information about a resource.
- Get a list of nested resources, such as a list of VMs in a folder.
- View a list of operations with a resource.

#### [!KEYREF roles-editor] {#editor}

The role of `[!KEYREF roles-editor]` grants permissions to all operations relating to resource management, except for assigning roles to other users. The role of ` [!KEYREF roles-editor]` includes all permissions granted by the role of `[!KEYREF roles-viewer]`.

For example, the role of `[!KEYREF roles-editor]` allows you to perform the following operations:

- Create a resource.
- Update a resource.
- Delete a resource.

#### [!KEYREF roles-admin] {#admin}

The role of `[!KEYREF roles-admin]` grants all permissions to manage the resource, including assigning roles to other users. You can assign any roles except `[!KEYREF roles-cloud-owner]`.

The role of `[!KEYREF roles-admin]` includes all permissions granted by the role of `[!KEYREF roles-editor]`.

For example, the role of `[!KEYREF roles-admin]` allows you to perform the following operations:

- Set access rights to the resource.
- Change access rights to the resource.

## Service roles {#service-roles}

### Yandex Resource Manager {#yrm-roles}

[!INCLUDE [cloud-roles](../../../_includes/cloud-roles.md)]

### Yandex Compute Cloud {#compute-roles}

[!INCLUDE [roles-disks-user](../../../_includes/roles-disks-user.md)]

[!INCLUDE [roles-images-user](../../../_includes/roles-images-user.md)]

