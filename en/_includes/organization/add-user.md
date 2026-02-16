# Adding a user to an organization

Add a user to your [organization](../../overview/roles-and-resources.md) and [assign](../../iam/operations/roles/grant.md) a relevant [role](../../iam/concepts/access-control/roles.md) for access to {{ yandex-cloud }} resources. Users need roles, for example, to create managed database clusters or keep track of current VM status.

You can add [users with a Yandex account](../../iam/concepts/users/accounts.md#passport), [federated users](../../iam/concepts/users/accounts.md#saml-federation), and [local users](../../iam/concepts/users/accounts.md#local). New users will become members of the organization, and you will be able to assign roles to them. An organization user without roles assigned has no access to resources in that organization's clouds. To learn how to grant a role to a user, see [{#T}](../../iam/operations/roles/grant.md).

To add users to an organization, you must be an administrator (`organization-manager.admin` role) or owner (`organization-manager.organizations.owner` role) of that organization, or have an administrator's role for the type of user accounts you want to add.

{% include [console-user-access](console-user-access.md) %}

## Yandex account users {#useraccount}

{% include notitle [useraccount](./useraccount.md) %}

## Federated users {#user-sso}

{% include notitle [user-sso](./user-sso.md) %}

## Local users {#local-users}

{% include notitle [local-user](./local-user.md) %}