# Adding a user to an organization

Add a user to your [organization](../../overview/roles-and-resources.md) and [grant](../../iam/operations/roles/grant.md) them the [role](../../iam/concepts/access-control/roles.md) needed to access {{ yandex-cloud }} resources. For example, enable the user to create managed DB clusters or track the status of VMs in use.

You can add [users with a Yandex account](../../iam/concepts/index.md#passport) and [federated users](../../iam/concepts/index.md#saml-federation). To do this, you need to be the organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). To learn how to grant roles to users, see [{#T}](../../iam/operations/roles/grant.md).

## Users with a Yandex account {#useraccount}

{% include notitle [useraccount](useraccount.md) %}

## Federated users {#user-sso}

{% include notitle [user-sso](user-sso.md) %}
