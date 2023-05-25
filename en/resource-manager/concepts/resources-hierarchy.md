---
title: "{{ yandex-cloud }} resource hierarchy"
description: "All {{ yandex-cloud }} resources, such as VMs, disks, or networks, are placed in folders. Each folder belongs to a single cloud, while clouds belong to organizations."
---

# {{ yandex-cloud }} resource hierarchy


The {{ resmgr-name }} resource model is shown in the chart. Most {{ yandex-cloud }} services are based on this model.


![image](../../_assets/YC-resource-model-en.svg)



All {{ yandex-cloud }} resources, such as [VMs](../../compute/concepts/vm.md), [disks](../../compute/concepts/disk.md), or [networks](../../vpc/concepts/network.md#network), are placed in [folders](#folder). When creating a resource, its folder is specified.

Each folder belongs to a single [cloud](#cloud). There are no folders outside a cloud. You cannot create a folder inside another folder.

A [cloud](#cloud) belongs to an organization.

Organizations do not interact with each other. The resources of an organization can't interact with the resources of another organization using {{ yandex-cloud }} tools. Organization management is performed by [{{ org-full-name }}](../../organization/).

Within your organization, you can configure resource access rights at the following [levels](#access-rights-inheritance):
* Organization.
* Cloud.
* Folder.
* Individual resource if the service supports access control at this level.

A new user (organization member) is not granted access to resources within organization clouds by default. The access rights must be granted to them explicitly by assigning the respective role for a resource or a folder, the resource's cloud or organization.

## {{ resmgr-name }} Resources {#rm-resources}

### Cloud {#cloud}

A _cloud_ is an isolated space where folders are created.

By default, clouds are isolated from each other. For resources that support cross-cloud interaction, you can configure it separately.

#### Cloud owner {#owner}

When a cloud is created, the owner is assigned to it. The _cloud owner_ is a user assigned the `{{ roles-cloud-owner }}` role for this cloud.

The owner can perform any operation with the cloud and its resources.

The owner can grant access to the cloud to other users: assign [roles](../../iam/concepts/access-control/roles.md) or revoke them. For example, the owner can appoint other cloud owners or denounce their owner role.

A cloud must have at least one owner. The sole owner of a cloud may not give up this role.

#### Cloud member {#member}

The `{{ roles-cloud-member }}` role does not grant any rights to handle resources. This role is used in combination with other roles.

See a detailed description of the role in the [{{ iam-full-name }}](../../iam/concepts/access-control/roles.md#member) documentation.

#### Public access to the cloud {#public-access}

You can make your cloud (and any of its resources) public by [assigning a role to the system group](../../iam/operations/roles/grant.md#access-to-all). Then to access a resource, you don't have to be a cloud member. You just need to know the resource ID. Learn more about [system groups](../../iam/concepts/access-control/system-group.md).

### Folder {#folder}

A _folder_ is a space where {{ yandex-cloud }} resources are created and grouped.

Just like folders in your file system, {{ yandex-cloud }} folders make resource management simpler. You can group your resources into folders by the resource type, project, or department that uses those resources, or any other criteria of your choice.

## Inheritance of access rights {#access-rights-inheritance}

When a user ([subject](../../iam/concepts/access-control/index.md#subject)) performs an operation with a resource, the {{ iam-name }} service verifies the user's access rights to this resource.

Resource access rights are inherited:
* Organization access rights apply to the organization's resources:
   * [Federations](../../iam/concepts/federations.md).
   * Groups.
   * Organization clouds.
* Rights to access the cloud apply to all folders within the cloud.
* Folder access rights apply to all resources in the folder.

> For example, for an organization named `myorganization` with the following hierarchy:
> * `Mycloud` cloud:
>    * `Robots` folder:
>       * `Alice` service account.
>       * `Bob` service account.
>
> If you assign a user the `resource-manager.viewer` role for the organization, they can view a list of all clouds, folders, and resources in the organization, but can't manage them.
>
> If you additionally assign them the `{{ roles-editor }}` role for the `mycloud` cloud, they can manage all the cloud's resources, including the `Alice` and `Bob` service accounts, but can't grant other users access to them.
>
> The `{{ roles-admin }}` role for the `robots` folder allows the user to manage all the resources in the folder, including the `Alice` and `Bob` service accounts.

You can't assign a role for some resources directly. In this case, a role is assigned for a folder, cloud, or organization. For example, you cannot currently assign a role for a VM. If a user makes an attempt to read information about a VM, {{ iam-name }} checks the user's access rights to the folder this VM belongs to. If the folder access rights are missing, {{ iam-name }} checks the cloud and organization access rights.

#### See also {#see-also}

* [{#T}](../operations/cloud/set-access-bindings.md).
* [{#T}](../operations/folder/create.md).
* [{#T}](../operations/folder/set-access-bindings.md).
