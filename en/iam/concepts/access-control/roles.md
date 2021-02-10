# Roles

_A role_ is a set of user permissions to perform operations with {{ yandex-cloud }} resources.

There are two types of roles:

- _Primitive roles_ contain permissions that apply to all types of {{ yandex-cloud }} resources. These are roles like `{{ roles-admin }}`, `{{ roles-editor }}`, and `{{ roles-viewer }}`.

- _Service roles_ contain permissions only for a specific type of resource in a particular service. Service role ID is specified in `service.resources.role` format. For example, the `{{ roles-image-user }}` role lets you use images in Yandex Compute Cloud.

    A service role can be assigned to the resource that the role is intended for or the resource that permissions are inherited from. For example, you can assign the `{{ roles-image-user }}` role for a folder or cloud, because images inherit permissions from them.

Currently, users aren't allowed to create new roles with a custom set of permissions.

## Primitive roles {#primitive-roles}

### {{ roles-viewer }} {#viewer}

The `{{ roles-viewer }}` role grants permission to read resources.

For example, the `{{ roles-viewer }}` role lets you perform the following operations:

- View information about a resource.
- Get a list of nested resources, such as a list of VMs in a folder.
- View a list of operations with a resource.

### {{ roles-editor }} {#editor}

The `{{ roles-editor }}` role grants permissions to perform any operation related to resource management, except assigning roles to other users. The `{{ roles-editor }}` role includes all permissions granted by the `{{ roles-viewer }}` role.

For example, the `{{ roles-editor }}` role lets you perform the following operations:

- Create a resource.
- Update a resource.
- Delete a resource.

### {{ roles-admin }} {#admin}

The `{{ roles-admin }}` role grants all permissions to manage the resource, including assigning roles to other users. You can assign any role except `{{ roles-cloud-owner }}`.

The `{{ roles-admin }}` role includes all permissions granted by the `{{ roles-editor }}` role.

For example, the `{{ roles-admin }}` role lets you perform the following operations:

- Set permissions to the resource.
- Change permissions to the resource.

## {{ certificate-manager-name }} {#certificate-manager-roles}

{% include [roles-certificate-manager-admin](../../../_includes/roles-certificate-manager-admin.md) %}

{% include [roles-certificate-manager-certificates-downloader](../../../_includes/roles-certificate-manager-certificates-downloader.md) %}

## {{ compute-name }} {#compute-roles}

{% include [roles-compute-admin](../../../_includes/roles-compute-admin.md) %}

{% include [roles-disks-user](../../../_includes/roles-disks-user.md) %}

{% include [roles-images-user](../../../_includes/roles-images-user.md) %}

## {{ container-registry-name }} {#cr-roles}

{% include [container-registry-admin](../../../_includes/roles-container-registry-admin.md) %}

{% include [container-registry-puller](../../../_includes/roles-container-registry-puller.md) %}

{% include [container-registry-pusher](../../../_includes/roles-container-registry-pusher.md) %}

## {{ dataproc-short-name }} {#mdb-roles}

{% include [mdb.dataproc.agent](../../../_includes/roles-dataproc-agent.md) %}

## {{ datalens-name }} {#datalens-roles}

{% include [datalens-instances-user](../../../_includes/roles-datalens-user.md) %}

{% include [datalens-instances-admin](../../../_includes/roles-datalens-admin.md) %}

## {{ ml-platform-name }} {#datasphere-roles}

{% include [datasphere-user](../../../_includes/roles-datasphere-user.md) %}

{% include [datasphere-admin](../../../_includes/roles-datasphere-admin.md) %}

## {{ sf-short-name }} {#functions-roles}

{% include [serverless.functions.invoker](../../../_includes/roles-functions-invoker.md) %}

## {{ iam-name }} {#iam-roles}

{% include [roles-sa-user](../../../_includes/roles-sa-user.md) %}

## {{ iot-name }} {#iot-roles}

{% include [iot-devices-writer](../../../_includes/roles-iot-devices-writer.md) %}

{% include [iot-registries-writer](../../../_includes/roles-iot-registries-writer.md) %}

## {{ network-load-balancer-name }} {#load-balancer-roles}

{% include [roles-lb-viewer](../../../_includes/roles-lb-viewer.md) %}

{% include [roles-lb-private-admin](../../../_includes/roles-lb-private-admin.md) %}

{% include [roles-lb-admin](../../../_includes/roles-lb-admin.md) %}

## {{ objstorage-name }} {#object storage}

{% include [storage.admin](../../../_includes/roles-storage-admin.md) %}

{% include [storage.configurer](../../../_includes/roles-storage-configurer.md) %}

{% include [storage.editor](../../../_includes/roles-storage-editor.md) %}

{% include [storage.uploader](../../../_includes/roles-storage-uploader.md) %}

{% include [storage.viewer](../../../_includes/roles-storage-viewer.md) %}

## {{ resmgr-name }} {#yrm-roles}

{% include [cloud-roles](../../../_includes/cloud-roles.md) %}

## {{ vpc-name }} {#vpc-roles}

{% include [roles-vpc-viewer](../../../_includes/roles-vpc-viewer.md) %}

{% include [roles-vpc-user](../../../_includes/roles-vpc-user.md) %}

{% include [roles-vpc-private-admin](../../../_includes/roles-vpc-private-admin.md) %}

{% include [roles-vpc-public-admin](../../../_includes/roles-vpc-public-admin.md) %}

{% include [roles-vpc-sg-admin](../../../_includes/roles-vpc-sg-admin.md) %}

{% include [roles-vpc-admin](../../../_includes/roles-vpc-admin.md) %}
