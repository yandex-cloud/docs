The `organization-manager.auditor` role enables viewing info on the organization and its settings, identity federations that belong to the organization, user pools, SAML and OIDC applications, and the organization’s users and user groups.

{% cut "Users with this role can:" %}

* View info on the Identity Hub [organization](../../organization/concepts/organization.md) and its settings.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for the organization.
* View the list of the organization’s [users](../../organization/concepts/domains.md), info from the user accounts (except phone numbers), the latest authentication date, as well as the latest verification date for federated and local accounts via [two-factor authentication](../../organization/concepts/domains.md).
* View info on access permissions granted for [entities](../../iam/concepts/access-control/index.md#subject) in the Identity Hub organization.
* View info on the organization’s [identity federations](../../organization/concepts/add-federation.md).
* View info on identity federation [certificates](../../organization/concepts/add-federation.md#build-trust).
* View the list of [federated user](../../iam/concepts/users/accounts.md#saml-federation) group [mappings](../../organization/concepts/add-federation.md#group-mapping) and info on them.
* View info on the attributes of [federated](../../iam/concepts/users/accounts.md#saml-federation) users.
* View info on [user pools](../../organization/concepts/user-pools.md) and access permissions granted for them.
* View info on the attributes of [local](../../iam/concepts/users/accounts.md#local) users belonging to user pools.
* View info on [domains](../../organization/concepts/domains.md) linked to the user pools.
* View info on SAML and OIDC applications, as well as access permissions granted for them.
* View the list of users added to SAML and OIDC applications.
* Get the certificates of SAML applications.
* View the list of organization users that are [subscribed](../../organization/operations/subscribe-user-for-notifications.md) to technical notifications on organization events.
* View info on [MFA policies](../../iam/concepts/users/accounts.md#local).
* View info on the organization's [OS Login](../../organization/concepts/os-login.md) settings.
* View the list of OS Login [profiles](../../organization/concepts/os-login.md#os-login-profiles) for users and service accounts.
* View the list of the organization users' SSH keys and info on such keys.
* View info on [user groups](../../organization/concepts/groups.md) and access permissions granted for them.
* View the list of groups a certain user is a member of, as well as the list of users that are members of a certain group.
* View info on the [refresh tokens](../../iam/concepts/authorization/refresh-token.md) of the organization’s users and on the refresh token settings.
* View info on the Identity Hub quotas.
* View info on the effective tech support [service plan](../../support/pricing.md#effective-plans).
* View the list of technical support [requests](../../support/overview.md) and the info on them, as well as create and close such requests, leave comments, and attach files to them.

{% endcut %}

This role includes the `iam.userAccounts.refreshTokenViewer`, `organization-manager.federations.auditor`, `organization-manager.osLogins.viewer`, `organization-manager.userpools.auditor`, `organization-manager.samlApplications.auditor`, and `organization-manager.oauthApplications.auditor` permissions.