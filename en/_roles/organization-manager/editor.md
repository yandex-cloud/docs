The `organization-manager.editor` role enables managing organization settings, identity federations, user pools, SAML applications, OIDC applications, as well as users and user groups.

{% cut "Users with this role can:" %}

* View and edit info on the relevant [organization](../../organization/concepts/organization.md) under Identity Hub.
* View and edit organization settings.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for the organization.
* View the list of the organization’s [users](../../organization/concepts/mfa.md), info on them (including their phone number), their latest authentication date, and the latest verification date for federated and local accounts via [two-factor authentication](../../organization/concepts/mfa.md).
* View info on access permissions granted for [entities](../../iam/concepts/access-control/index.md#subject) in the Identity Hub organization.
* View info on the [identity federations](../../organization/concepts/add-federation.md) in an organization and create, modify, and delete such federations.
* Add and remove federated users.
* View info on identity federation [certificates](../../organization/concepts/add-federation.md#build-trust) and add, modify, and delete them.
* View the lists of [federated user](../../iam/concepts/users/accounts.md#saml-federation) group [mappings](../../organization/concepts/add-federation.md#group-mapping) and info on them, as well as create, edit, and delete such lists.
* View info on the attributes of [federated](../../iam/concepts/users/accounts.md#saml-federation) user, as well as create, modify, and delete such attributes.
* View info on [user pools](../../organization/concepts/user-pools.md) and access permissions granted for them.
* Create, modify, and delete user pools.
* View info on [domains](../../organization/concepts/domains.md) linked to user pools, as well as add, confirm, and remove domains.
* Create, delete, activate, and deactivate [local](../../iam/concepts/users/accounts.md#local) users belonging to user pools.
* View info on the attributes of local users.
* View user audit events.
* Edit user data, such as usernames, passwords, domains, emails, full names, and phone numbers.
* View info on SAML and OIDC applications, as well as access permissions granted for them.
* Create, deactivate, activate, modify, and delete SAML and OIDC applications.
* View the list of users added to SAML and OIDC applications.
* Get certificates of SAML applications and create, modify, and delete such certificates.
* View the list of organization users that are [subscribed](../../organization/operations/subscribe-user-for-notifications.md) to technical notifications on organization events, as well as edit this list.
* View info on [MFA policies](../../organization/concepts/mfa.md#mfa-policies) and create, modify, activate, deactivate, and delete such policies.
* Delete [MFA factors](../../iam/concepts/users/accounts.md#saml-federation) for federated and [local](../../iam/concepts/users/accounts.md#saml-federation) user accounts.
* Reset the verification date for federated and local user accounts.
* View info on the organization's [OS Login](../../organization/concepts/os-login.md) settings.
* View the list of OS Login [profiles](../../organization/concepts/os-login.md#os-login-profiles) for users and service accounts.
* View the list of the organization users' SSH keys and info on such keys.
* View info on [user groups](../../organization/concepts/groups.md), as well as create, modify, and delete them.
* View info on access permissions granted for user groups.
* View the list of groups a certain user is a member of, as well as the list of users that are members of a certain group.
* View and edit the [refresh token](../../iam/concepts/authorization/refresh-token.md) settings in an organization.
* View the info on the refresh tokens of the organization’s users, as well as revoke such tokens.
* View info on the Identity Hub quotas.
* View info on the effective tech support [service plan](../../support/pricing.md#effective-plans).
* View the list of technical support [requests](../../support/overview.md) and the info on them, as well as create and close such requests, leave comments, and attach files to them.

{% endcut %}

This role includes the `organization-manager.viewer`, `organization-manager.federations.editor`, `organization-manager.userpools.editor`, `organization-manager.samlApplications.editor`, `organization-manager.oauthApplications.editor`, and `organization-manager.groups.editor` permissions.