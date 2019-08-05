# Hierarchy of Yandex.Cloud resources

When you get access to Yandex.Cloud, you are allocated a separate workspace, i.e., a _cloud_. This is where you will create folders.

Folders contain resources such as virtual machines, disks, and others. When you create a resource, you specify a folder where it is created. Nested folders are not supported for now.

{{ resmgr-name }} provides the standard resource model shown in the following image. This model is used in most of the Yandex.Cloud services.

![image](../../_assets/resource-structure.png)

All resources inside the cloud are isolated from outside users by default. The cloud owner can manage access rights for the cloud and its resources.

Resource access rights are inherited within the cloud. Rights to access the cloud apply to all resources within the cloud. Folder access rights apply to all resources in the folder. For more information, see [{#T}](#access-rights-inheritance).

Some types of resources are not created in folders, so they have a separate logic for verifying access rights. For example, when a user manages access keys for a service account, the rights to access this service account are verified.

## A cloud as a Yandex.Cloud resource {#cloud}

_A cloud_ is an isolated space where folders are created.

When a resource is created within the cloud, no one except the cloud members and owners may access the resource.

### Cloud owner {#owner}

When a cloud is created, an owner is assigned to it. The cloud owner is a user assigned the role of `{{ roles-cloud-owner }}` for the cloud.

The owner can perform any operations with the cloud and its resources.

The owner can grant access to the cloud to other users: i.e., assign roles or revoke them. For example, the owner can appoint other cloud owners or denounce their owner role.

A cloud must have at least one owner. The sole owner of a cloud may not give up this role.

At this time, you can only own a single cloud. You can't create a cloud yourself or change information about it. Please contact technical support to change the cloud information.

### Cloud member {#member}

A cloud member is a user that has been assigned the role of `{{ roles-cloud-member }}` for this cloud.

The user needs the cloud member role to perform operations with cloud resources, except for resources that allow [public access](#public-access).

> For example, if a cloud member is assigned the role of `{{ roles-editor }}` for a cloud folder, they can create resources in this folder. If the cloud member role is revoked for a user, the user can no longer perform any operations.

The role of `{{ roles-cloud-member }}` itself does not grant any rights to do anything with resources. This role is used in combination with other roles.

{% note info %}

The role of `{{ roles-cloud-member }}` is not required for cloud owners and service accounts.

{% endnote %}

### Public access to the cloud {#public-access}

You can make your cloud  (and any of its resources) public. In this case, you don't have to be a cloud member to access them.

To make a cloud or resource public, you need to assign it a role for the [system group](../../iam/concepts/access-control/system-group.md) `{{ subjects-allAuthenticatedUsers }}`.

> For example, you can grant any user access to view all resources in the cloud. To do this, just assign the role of `{{ roles-viewer }}` to the subject `{{ subjects-allAuthenticatedUsers }}` for this cloud.

## A folder as a Yandex.Cloud resource {#folder}

_A folder_ is an isolated space where Yandex.Cloud resources are created and grouped.

Just like folders in your file system, folders in Yandex.Cloud make resource management easier for you. You can group your resources into folders by the resource type, project, department that uses those resources, or any other criteria of your choice.

You can manage access rights for all resources in the folder at once. Let's say your company has employees working with virtual machines only. You can create a folder containing virtual machines only and grant employees access to this folder.

You can view the contents of the folder in the management console. To find out which folder hosts a given resource, use the API or CLI `Get`  method for this resource (the `get`  command in the CLI).

## Access rights inheritance {#access-rights-inheritance}

When a user (subject) performs an operation with a resource, Yandex Identity and Access Management (IAM) service checks whether the user has the applicable access rights for this resource.

Rights to access resources inside the cloud are inherited based on the following hierarchy: Cloud → Folder → Resource.

> For example: in the `mycloud` cloud, the  `robots` folder contains the `Alice` and `Bob` service accounts.

If a user has been assigned, for the `mycloud` cloud, the roles of `{{ roles-cloud-member }}` and `{{ roles-viewer }}`, this user can view the list of all folders in the cloud and their content.

If a user is assigned the role of `{{ roles-editor }}` on `Alice`, this user can manage `Alice`, but not `Bob`.

If a user is assigned the role of `{{ roles-admin }}`  for the `robots` folder, this user gets the administrator permissions to manage this folder and all its resources, including `Alice` and `Bob`.

You can't assign roles for some resources because all their permissions are inherited from the folder. For example, currently you can't assign a role for a virtual machine. When someone tries to obtain information about the virtual machine, IAM checks their access rights for the folder hosting this virtual machine. If access rights have not been set for the folder, IAM checks that the subject has the applicable access rights for this cloud.

#### See also

- [{#T}](../operations/cloud/set-access-bindings.md)
- [{#T}](../operations/folder/create.md)
- [{#T}](../operations/folder/set-access-bindings.md)

