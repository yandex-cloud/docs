---
title: '{{ yandex-cloud }} resource hierarchy'
description: All {{ yandex-cloud }} resources, such as VMs, disks, or networks, are placed in folders. Each folder belongs to a single cloud, while clouds belong to organizations.
---

# {{ yandex-cloud }} resource hierarchy

The {{ resmgr-name }} resource model is shown in the chart. Most {{ yandex-cloud }} services are based on this model.

![image](../../_assets/YC-resource-model-en.svg)

All {{ yandex-cloud }} resources, such as [VMs](../../compute/concepts/vm.md), [disks](../../compute/concepts/disk.md), or [networks](../../vpc/concepts/network.md#network), are placed in [folders](#folder). When creating a resource, its folder is specified.

Each folder belongs to a single [cloud](#cloud). There are no folders outside a cloud. You cannot create a folder inside another folder.

A [cloud](#cloud) belongs to an organization.

Organizations do not interact with each other. The resources of an organization cannot interact with the resources of another organization using {{ yandex-cloud }} tools. Organizations are managed with [{{ org-full-name }}](../../organization/).

Within your organization, you can configure access permissions for a resource at the following [levels](#access-rights-inheritance):
* Organization.
* Cloud.
* Folder.
* Individual resource if the relevant service supports such granular access management.

By default, a new user (organization member) has no access to the resources residing in the organization's clouds. Access permissions must be granted explicitly by assigning a role specifically for a resource or its folder, cloud, or organization.

## {{ resmgr-name }} Resources {#rm-resources}

### Cloud {#cloud}

A _cloud_ is an isolated space where folders are created.

By default, clouds are isolated from each other. You cannot move resources from one cloud to another. For resources that support cross-cloud interaction, you can configure it separately.

#### Cloud owner {#owner}

A newly created cloud gets an owner assigned. A _cloud owner_ is a user with the `{{ roles-cloud-owner }}` role assigned for the cloud.

An owner can perform any operation with the cloud and the resources within it.

An owner can grant access to the cloud to other users: assign and revoke various [roles](../../iam/concepts/access-control/roles.md). Only a cloud owner can assign and revoke the `resource-manager.clouds.owner` role. Cloud owners can also revoke this role from themselves.

A cloud must have at least one owner. The user creating a cloud becomes its owner automatically. Sole cloud owners cannot revoke the `resource-manager.clouds.owner` role from themselves.

#### Cloud member {#member}

The `{{ roles-cloud-member }}` role does not grant any rights to handle resources. This role is used in combination with other roles.

{% include [roles-cloud-member-organization](../../_includes/roles-cloud-member-organization.md) %}

### Folder {#folder}

A _folder_ is a space where {{ yandex-cloud }} resources are created and grouped.

Just like folders in your file system, {{ yandex-cloud }} folders make resource management simpler. You can group your resources into folders by the resource type, project, or department that uses those resources, or any other criteria of your choice.

## Inheriting access permissions {#access-rights-inheritance}

When a user ([subject](../../iam/concepts/access-control/index.md#subject)) performs an operation with a resource, {{ iam-name }} check the user's access permissions for the resource.

Resource access permissions are inherited as follows:
* Organization access permissions apply to the organization's resources:
  * [Federations](../../iam/concepts/federations.md).
  * Groups.
  * Organization clouds.
* Permissions to access the cloud apply to all folders within the cloud.
* Folder access permissions apply to all resources in the folder.

>Example for an organization named `myorganization` with the following hierarchy:
>* `mycloud` cloud:
>  * `robots` folder:
>    * `Alice` service account
>    * `Bob` service account
>
> A user with the `resource-manager.viewer` role for an organization will see a list of all its clouds, folders, and resources but will not be able to manage them.
> 
> An additional `{{ roles-editor }}` role for a cloud named `mycloud` will enable the user to manage all the cloud's resources, including the `Alice` and `Bob` service accounts, but not to grant another user access to them.
> 
> The `{{ roles-admin }}` role for the `robots` folder will allow the user to manage all the folder's resources, including `Alice` and `Bob`.

For some resources, you cannot assign a role directly, in which case a role should be assigned for a folder, cloud, or organization. If the folder access permissions are missing, {{ iam-name }} checks the cloud and organization access permissions.

## Deleting {{ resmgr-name }} resources {#deleting-resources}

You can delete a [cloud](../operations/cloud/delete.md) or [folder](../operations/folder/delete.md). When deleting one, you can specify whether to delete it immediately or after a certain delay. The default deletion delay is seven days. Throughout this period, the resources will be stopped, and the cloud/folder status will change to `PENDING_DELETION`.

Once the delay period ends, the cloud/folder status will change to `DELETING`. This status means it is being permanently deleted, which can take up to 72 hours. As a result, all resources created in the cloud/folder will be deleted together with it.

### Reasons why a folder cannot be deleted {#inability-to-delete}

The deletion of a folder in the `DELETING` status can be canceled by the system. Possible causes:

* The folder contains a {{ vpc-full-name }} [IP address](../../vpc/concepts/address.md) currently used by a [VM](../../compute/concepts/vm.md) in another folder.
* The folder contains deletion protected managed database clusters.

In which case the deletion will be stopped, the folder will regain its `ACTIVE` status, and the user will get a message stating why the folder could not be deleted. Yet some folder resources may still be deleted: these will not be restored after the deletion is canceled. Other resources may end up intact: these will remain billable.

#### See also {#see-also}

* [{#T}](../operations/cloud/set-access-bindings.md)
* [{#T}](../operations/folder/create.md)
* [{#T}](../operations/folder/set-access-bindings.md)