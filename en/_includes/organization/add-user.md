# Adding a user to an organization

Add a user to your [organization](../../overview/roles-and-resources.md) and [grant](../../iam/operations/roles/grant.md) them the [role](../../iam/concepts/access-control/roles.md) needed to access {{ yandex-cloud }} resources. For example, enable the user to create managed DB clusters or track the status of VMs in use.

You can add [users with a Yandex account](../../iam/concepts/users/accounts.md#passport) as well as [federated users](../../iam/concepts/users/accounts.md#saml-federation). To do this, you need to be the organization administrator (`organization-manager.admin` role) or owner (`organization-manager.organizations.owner` role). To learn how to grant a role to a user, see [{#T}](../../iam/operations/roles/grant.md).

## Yandex account users {#useraccount}

{% include notitle [useraccount](./useraccount.md) %}

## Federated users {#user-sso}

{% include notitle [user-sso](./user-sso.md) %}
