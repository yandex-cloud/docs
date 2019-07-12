# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If the user has no roles assigned, all operations are forbidden.

To allow access to the Yandex Identity and Access Management service resources (service accounts and their access keys), assign appropriate roles to the user from the list below. You can assign a user a role for the service account, the folder hosting the account, or the entire cloud: access rights are inherited in Yandex Cloud.

{% note info %}

For more information about role inheritance, see [#T](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the Yandex Resource Manager documentation.

{% endnote %}

## Assigning roles

To assign a user a role for the cloud or folder:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles

The list below shows all roles that are considered when verifying access rights in the IAM service.

### Service roles

_Service roles_ are roles that allow access to the resources of a particular service. When checking IAM resource access rights, Resource Manager service roles are also taken into account.

### Identity and Access Management {#yrm-roles}

{% include [roles-sa-user](../../_includes/roles-sa-user.md) %}

### Resource Manager {#yrm-roles}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles

You can assign primitive roles to any resource in any service.

#### viewer

A user with the `viewer` can view information about resources, for example, get a list of access keys for a service account.

#### editor

A user with the `editor` can manage any resources, for example, create a service account or its access keys.

In addition, the `editor` role includes all permissions of the `viewer` role.

#### admin

A user with the `admin` can manage access rights to resources, for example, allow other users to view service accounts or view information about them.

In addition, the `admin` role includes all permissions of the role of `editor`.

