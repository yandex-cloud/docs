# Getting started with {{ iam-name }}

{{ iam-full-name }} allows you to manage access to {{ yandex-cloud }} resources. With {{ iam-short-name }}, only users with relevant access permissions can perform operations on resources.

## {{ yandex-cloud }} resource model {#resource-model}

All Yandex Cloud services work are based on a common _resource and role model_. When using {{ yandex-cloud }} services, you create _resources_: [VMs](../compute/concepts/vm.md), managed database clusters, [registries](../container-registry/concepts/registry.md), [secrets](../lockbox/concepts/secret.md), and more. Most services store the resources they create in [folders](../resource-manager/concepts/resources-hierarchy.md#folder). Folders belong to [clouds](../resource-manager/concepts/resources-hierarchy.md#cloud), and clouds belong to organizations.

_Organizations_ are logical entities that combine different types of resources and users into a single workspace. Organizations do not interact between themselves: their resources are isolated from one another.

Within an organization, you can configure access permissions for a resource at the following [levels](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance):

* Organization.
* Cloud.
* Folder.
* Individual resource if the relevant service supports such granular access management.

This approach enables the _minimum privilege principle_, wherein users get only those permissions that are essential for their tasks.

## Access management {#access-management}

Access management in {{ yandex-cloud }} leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant access to a resource, you assign [roles](concepts/access-control/roles.md) for the resource to the [subjects](#subjects). You can also assign a role to a parent resource from which child resources [inherit their access permissions](concepts/access-control/index.md#inheritance). For example, you can assign a role for a folder or cloud the VMs reside in.

In {{ yandex-cloud }}, [roles](roles-reference.md) and [resources for which roles can be assigned](concepts/access-control/resources-with-access-control.md) are predefined. Users cannot create custom roles.

[Roles can be assigned](operations/roles/grant.md) only by users with at least the primitive `admin` role or the `<service_name>.admin` role for an individual resource or one of its parent resources. The level of permissions granted by a user cannot be higher than the user's own.

{% cut "Example" %}

A role for an individual VM can be assigned by a user with one of the following roles:

* `admin`
* `compute.admin`
* `resource-manager.clouds.owner`
* `organization-manager.admin`
* `organization-manager.organizations.owner`

The user must have one of these roles assigned for the following resources:

* VM
* Folder the VM belongs to
* Cloud the folder is in
* Whole organization

{% endcut %}

If you want to prevent a subject from accessing a resource, [revoke](operations/roles/revoke.md) the relevant roles for this resource as well as for the resources access permissions can be inherited from.

## {{ yandex-cloud }} role model subjects {#subjects}

Roles for a resource are assigned to [subjects](concepts/access-control/index.md#subject). Each subject can get multiple roles.

There are the following subject types:

* [Yandex account](concepts/users/accounts.md#passport): Your Yandex or Yandex 360 account.
* [Service account](concepts/users/service-accounts.md): Additional account programs can use to perform operations in {{ yandex-cloud }}. Service accounts are free of charge and enable flexible access management for your programs.
* [Federated account](concepts/users/accounts.md#saml-federation): User account in an identity federation, e.g., Active Directory.
* [User group](../organization/concepts/groups.md): Group of users with the same access permissions.
* [System group](concepts/access-control/system-group.md): User group preinstalled in {{ iam-short-name }}.

## Working with {{ org-full-name }} {#organization}

{{ iam-short-name }} and [{{ org-full-name }}](../organization/) are closely related because {{ org-name }} also provides access management features – but at the organization level. For example, you can use {{ org-name }} for centralized [user management](../organization/operations/manage-users.md), which includes inviting new users.

You can also [create federations and manage them](../organization/operations/setup-federation.md) to pass single sign-on authentication in {{ yandex-cloud }} via your identity provider.

[User group management](../organization/operations/manage-groups.md) also takes place in {{ org-name }}. For example, you can use the service to issue access permissions to a group. To use other {{ yandex-cloud }} interfaces to set up group access permissions, first create a group and add members to it in {{ org-name }}. With that done, you will be able to manage the group in many ways, e.g., give it permissions for a folder in the management console.

## What's next {#whats-next}

* Learn [how to get started with {{ org-name }}](../organization/quickstart.md).
* Read about billing accounts: what they are for and [how to create one](../overview/quickstart.md).
* Learn about [resources and access management {{ yandex-cloud }}](../overview/roles-and-resources.md).
* [Learn how to manage access to resources](quickstart.md).
* See [what account types exist in {{ yandex-cloud }}](concepts/users/accounts.md) and [how to work with service accounts](quickstart-sa.md).
* Read about [authentication methods in {{ yandex-cloud }}](concepts/authorization/index.md).
