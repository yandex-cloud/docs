The `organization-manager.admin` role enables managing organization settings, identity federations, user pools, SAML applications, OIDC applications, users and user groups, and user access permissions to the organization and its resources.

{% cut "Users with this role can:" %}

* Link a [billing account](../../billing/concepts/billing-account.md) to an [Identity Hub organization](../../organization/concepts/organization.md).
* View and edit info on the relevant organization under Identity Hub.
* View and edit organization settings.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for the relevant organization and modify such permissions.
* View the list of the organization’s [users](../../organization/concepts/mfa.md), info on them (including their phone number), their latest authentication date, and the latest verification date for federated and local accounts via [two-factor authentication](../../organization/concepts/mfa.md).
* View info on access permissions granted for [entities](../../iam/concepts/access-control/index.md#subject) in the Identity Hub organization.
* Remove users from the organization.
* View info on invites to the organization sent to the users, as well as [send](../../organization/operations/add-account.md#send-invitation) and delete such invites.
* View info on the [identity federations](../../organization/concepts/add-federation.md) in an organization and create, modify, and delete such federations.
* Add and remove federated users.
* View info on identity federation [certificates](../../organization/concepts/add-federation.md#build-trust) and add, modify, and delete them.
* Configure [federated user](../../iam/concepts/users/accounts.md#saml-federation) group [mapping](../../organization/concepts/add-federation.md#group-mapping).
* View the lists of federated user group mappings and info on them, as well as create, edit, and delete such lists.
* View info on the attributes of [federated](../../iam/concepts/users/accounts.md#saml-federation) user, as well as create, modify, and delete such attributes.
* View info on [user pools](../../organization/concepts/user-pools.md) and create, modify, and delete them.
* View info on access permissions granted for the relevant user pools and modify such permissions.
* View info on [domains](../../organization/concepts/domains.md) linked to user pools, as well as add, confirm, and remove domains.
* Create, delete, activate, and deactivate [local](../../iam/concepts/users/accounts.md#local) users belonging to user pools.
* View info on the attributes of local users.
* View user audit events.
* Edit user data, such as usernames, passwords, domains, emails, full names, and phone numbers.
* View info on SAML and OIDC applications, as well as create, deactivate, activate, modify, and delete them.
* View info on access permissions granted for SAML and OIDC applications, as well as modify such permissions.
* View and edit the list of users added to SAML and OIDC applications.
* Get certificates of SAML applications and create, modify, and delete such certificates.
* View the list of organization users that are [subscribed](../../organization/operations/subscribe-user-for-notifications.md) to technical notifications on organization events, as well as edit this list.
* View info on [MFA policies](../../organization/concepts/mfa.md#mfa-policies) and create, modify, activate, deactivate, and delete such policies.
* Delete [MFA factors](../../iam/concepts/users/accounts.md#saml-federation) for federated and [local](../../iam/concepts/users/accounts.md#saml-federation) user accounts.
* Reset the verification date for federated and local user accounts.
* View info on the organization's [OS Login](../../organization/concepts/os-login.md) settings and modify them.
* View the list of users' and [service accounts’](../../iam/concepts/users/service-accounts.md) OS Login [profiles](../../organization/concepts/os-login.md#os-login-profiles), as well as create, modify, and delete such profiles.
* View the list of the organization users' SSH keys and info on such keys, as well as create, modify, and delete them.
* View info on [user groups](../../organization/concepts/groups.md), as well as create, modify, and delete them.
* Add users and service accounts to and remove them from groups.
* View info on access permissions granted for the relevant user groups and modify such permissions.
* View the list of groups a certain user is a member of, as well as the list of users that are members of a certain group.
* View and edit the [refresh token](../../iam/concepts/authorization/refresh-token.md) settings in an organization.
* View the info on the refresh tokens of the organization’s users, as well as revoke such tokens.
* View info on the Identity Hub quotas.
* View info on the effective tech support [service plan](../../support/pricing.md#effective-plans).
* View the list of technical support [requests](../../support/overview.md) and info on them, as well as create and close such requests, leave comments, and attach files to them.
* View, create, modify, and delete SourceCraft repositories.
* Read files from a SourceCraft repository.
* View, create, edit, and delete pull requests in SourceCraft repositories.
* Merge pull requests in SourceCraft repositories.
* Push changes to regular and protected SourceCraft repository branches.
* View, create, and edit private and public issues in SourceCraft repositories.
* Change the issue access type in SourceCraft repositories.
* Add reactions to issues in SourceCraft repositories.
* View, create, edit, and delete comments to pull requests and private and public issues in SourceCraft repositories, as well as mark such comments as resolved.
* View, create, edit, and delete SourceCraft repository tags.
* Manage access permissions for a SourceCraft repository.
* View, get, create, modify, and delete secrets in SourceCraft repositories.

{% endcut %}

This role includes `organization-manager.editor`, `organization-manager.federations.admin`, `organization-manager.osLogins.admin`, `organization-manager.userpools.admin`, `organization-manager.samlApplications.admin`, `organization-manager.oauthApplications.admin`, `organization-manager.groups.memberAdmin`, and `src.repositories.admin` permissions.