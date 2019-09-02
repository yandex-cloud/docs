# Roles

_A role_ is a set of user permissions to perform operations with Yandex.Cloud resources.

There are two types of roles:

- _Primitive roles_ contain permissions that apply to all types of Yandex.Cloud resources. These are the `{{ roles-admin }}`, `{{ roles-editor }}` and `{{ roles-viewer }}` roles.

- _Service roles_ contain permissions only for a specific type of resource in a particular service. The ID of a service role is specified in `service.resources.role` format. For example, the `{{ roles-image-user }}` role lets you use images in Yandex Compute Cloud.

    A service role can be assigned to the resource that the role is intended for or the resource that access rights are inherited from. For example, you can assign the `{{ roles-image-user }}` role for a folder or cloud, because images inherit permissions from them.

Currently, users are not allowed to create new roles with a custom set of permissions.

## Primitive roles {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

The `{{ roles-viewer }}` role grants permission to read resources.

For example, the `{{ roles-viewer }}` role lets you perform the following operations:

- View information about a resource.
- Get a list of nested resources, such as a list of VMs in a folder.
- View a list of operations with a resource.

#### {{ roles-editor }} {#editor}

The `{{ roles-editor }}` role grants permissions to perform any operation to management the resource, except assigning roles to other users. The `{{ roles-editor }}` role includes all permissions granted by the `{{ roles-viewer }}` role.

For example, the `{{ roles-editor }}` role lets you perform the following operations:

- Create a resource.
- Update a resource.
- Delete a resource.

#### {{ roles-admin }} {#admin}

The `{{ roles-admin }}` role grants all permissions to manage the resource, including assigning roles to other users. You can assign any role except `{{ roles-cloud-owner }}`.

The `{{ roles-admin }}` role includes all permissions granted by the `{{ roles-editor }}` role.

For example, the `{{ roles-admin }}` role lets you perform the following operations:

- Set access rights to the resource.
- Change access rights to the resource.

## Service roles {#service-roles}

### {{ resmgr-name }} {#yrm-roles}

{% include [cloud-roles](../../../_includes/cloud-roles.md) %}

### {{ iam-name }} {#iam-roles}

{% include [roles-sa-user](../../../_includes/roles-sa-user.md) %}

### {{ compute-name }} {#compute-roles}

{% include [roles-disks-user](../../../_includes/roles-disks-user.md) %}

{% include [roles-images-user](../../../_includes/roles-images-user.md) %}

### {{ dataproc-short-name }} {#mdb-roles}

{% include [mdb.dataproc.agent](../../../_includes/roles-dataproc-agent.md) %}

### {{ sf-short-name }} {#functions-roles}

{% include [serverless.functions.invoker](../../../_includes/roles-functions-invoker.md) %}

### {{ container-registry-name }} {#cr-roles}

{% include [container-registry-puller](../../../_includes/roles-container-registry-puller.md)%}

{% include [container-registry-pusher](../../../_includes/roles-container-registry-pusher.md)%}
