# Adding a user

## Inviting a Yandex user {#add-or-invite-user-account}

If your employees have Yandex accounts, e.g., `{{login-example}}`, they can use them to access {{yandex-cloud}} services enabled in your organization.

{% note info %}

Users can be invited by an organization administrator (the `organization-manager.admin` role) or owner (the `organization-manager.organizations.owner` role). For information on assigning roles to users, see [Roles](roles.md#admin).

{% endnote %}

To invite a user to an organization:

{% include [invite-user](../_includes/organization/invite-user.md) %}

## Add federated users {#add-user-sso}

If you did not enable the **Automatically create users** option when [setting up a federation](add-federation.md#federation-usage), you will have to add federated users to your organization manually.

To do this, you need to know the Name IDs of the users that the Identity Provider Server (IdP) returns along with the successful authentication confirmation. This is usually the user's primary email address. If you do not know what the server returns as the Name ID, contact the administrator who configured authentication for your federation.

To add federation users to an organization:

{% include [add-federateduser](../_includes/organization/add-federateduser.md) %}

#### What's next {#what-is-next}

* [Assign roles to the new users](../iam/operations/roles/grant.md).
