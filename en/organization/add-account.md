# Add a user


## Adding Yandex{#add-user-account} users

If your employees have Yandex (for example, `{{ login-example }}`) accounts, they can use them to access {{ yandex-cloud }} services enabled in your organization.

{% note info %}

A user can be added by an organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). For information on assigning roles to users, see [Roles](roles.md#admin).

{% endnote %}

To add employee accounts to the organization, follow these steps:

{% include [add-useraccount](../_includes/organization/add-useraccount.md) %}

{% note info %}

{% include [yandex-account-2fa-warning.md](../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}


## Add federated users {#add-user-sso}

If, when [setting up a federation](add-federation.md#federation-usage), you didn't enable the option to **Automatically create users**, you need to add your federated users to your organization manually.

To do this, you need to know the Name IDs of the users that the Identity Provider Server (IdP) returns along with the successful authentication confirmation. This is usually the user's primary email address. If you don't know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

{% include [add-federateduser](../_includes/organization/add-federateduser.md) %}


#### What's next {#what-is-next}

* [Assign roles to the new users](../iam/operations/roles/grant.md).
