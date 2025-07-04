The `organization-manager.admin` role enables managing organization settings, identity federations, user pools, SAML applications, OIDC applications, as well as users and user groups.

{% cut "Users with this role can:" %}

* View and edit info on the relevant [organization](../../organization/concepts/organization.md) under Identity Hub.
* View and edit organization settings.
* View info on the [access permissions](../../iam/concepts/access-control/index.md) granted for the organization.
* View the list of the organization [users](../../overview/roles-and-resources.md#users) and info on them.
* View info on the [identity federations](../../organization/concepts/add-federation.md) in an organization and create, modify, and delete such federations.
* Add and remove federated users.
* View info on the identity federation [certificates](../../organization/concepts/add-federation.md#build-trust) and add, modify, and delete them.
* View the lists of [federated user](../../iam/concepts/users/accounts.md#saml-federation) group [mappings](../../organization/concepts/add-federation.md#group-mapping) and info on them, as well as create, edit, and delete such lists.
* View info on the federated user attributes, as well as create, modify, and delete them.
* View info on user pools and the access permissions granted for them.
* Create, modify, and delete user pools.
* View info on the domains linked to the user pools, as well as add, confirm, and remove domains.
* Create, delete, activate and deactivate users belonging to user pools.
* View the attributes of users belonging to user pools.
* View the factors of [multi-factor authentication (MFA)](https://en.wikipedia.org/wiki/Multi-factor_authentication).
* View the user audit events.
* Edit the data of users belonging to user pools, such as usernames, passwords, domains, emails, full names, and phone numbers.
* View info on SAML and OIDC applications, as well as the access permissions granted for them.
* Create, deactivate, activate, modify, and delete SAML and OIDC applications.
* View the list of the users added to SAML and OIDC applications.
* Get certificates of SAML applications and create, modify, and delete such certificates.
* View the list of the organization users that are [subscribed](../../organization/operations/subscribe-user-for-notifications.md) to technical notifications on organization events, as well as edit this list.
* View info on the organization's [OS Login](../../organization/concepts/os-login.md) settings.
* View the list of OS Login [profiles](../../organization/concepts/os-login.md#os-login-profiles) for users and service accounts.
* View the list of the organization users' SSH keys and the info on such keys.
* View info on [user groups](../../organization/concepts/groups.md), as well as create, modify, and delete them.
* View info on access permissions granted for user groups.
* View the list of groups a certain user is a member of, as well as the list of users that are members of a certain group.
* View and edit the [refresh token](../../iam/concepts/authorization/refresh-token.md) settings in an organization.
* View the info on the refresh tokens of the organization’s users, as well as revoke such tokens.
* View info on the Identity Hub quotas.
* View the info on the effective tech support [service plan](../../support/pricing.md#effective-plans).
* View the list of technical support [requests](../../support/overview.md) and the info on them, as well as create and close such requests, leave comments, and attach files to them.

{% endcut %}

This role includes the `organization-manager.viewer`, `organization-manager.federations.editor`, `organization-manager.userpools.editor`, `organization-manager.samlApplications.editor`, and `organization-manager.oauthApplications.editor` permissions.