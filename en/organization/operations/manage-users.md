# Managing user accounts

With {{ org-full-name }}, you can manage user accounts and access to corporate apps via SAML and OpenID Connect (identity provider) protocols in a centralized way.

You can connect your employees using their [Yandex accounts](../../iam/concepts/users/accounts.md#passport), which will give them access to your [organization's](../concepts/organization.md) services.

If your company uses a different credential management system, you can [set up an identity federation](./manage-federations.md). You can also create [local users](../../iam/concepts/users/accounts.md#local) within a [user pool](../concepts/user-pools.md) and use this pool to manage user authentication in third-party services via {{ yandex-cloud }} [IdP](https://en.wikipedia.org/wiki/Identity_provider).

* [Add a user](add-account.md).
* [Get user info](users-get.md).
* [Update user data](user-pools/edit-user.md).
* [Reset a local user's password](user-pools/reset-user-password.md).
* [View all groups the user belongs to](get-users-groups).
* [Deactivate a user](user-pools/deactivate-user.md).
* [Activate a user](user-pools/activate-user.md).
* [Assign access permissions to a user](add-role.md).
* [Delete a user account](edit-account.md).
* [Leave an organization](leave-organization.md).