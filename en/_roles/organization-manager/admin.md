The `organization-manager.admin` role enables managing organization settings, identity federations, user pools, SAML applications, OIDC applications, users and user groups, and users' access permissions to the organization and its resources.

{% cut "Users with this role can:" %}

* Link a [billing account](../../billing/concepts/billing-account.md) to an [{{ org-full-name }} organization](../../organization/concepts/organization.md).
* View and edit info on the relevant {{ org-full-name }} organization.
* View and edit organization settings.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for the organization and modify such permissions.
* View [access policies](../../iam/concepts/access-control/access-policies.md) assigned to the relevant organization, as well as assign and revoke such policies.
* View and edit the organization's [branding](../../organization/concepts/branding.md) settings.
* View the list of the organization's [users](../../organization/concepts/mfa.md), info on them (including their phone number), their latest authentication date, and the latest verification date for federated and local accounts via [two-factor authentication](../../organization/concepts/mfa.md).
* View info on access permissions granted for [entities](../../iam/concepts/access-control/index.md#subject) in an {{ org-full-name }} organization.
* Remove users from the organization.
* View info on invites to the organization sent to users, as well as [send](../../organization/operations/add-account.md#send-invitation) and delete such invites.
* View info on [identity federations](../../organization/concepts/add-federation.md) in an organization and create, modify, and delete such federations.
* Add and remove federated users.
* View info on identity federation [certificates](../../organization/concepts/add-federation.md#build-trust) and add, modify, and delete them.
* Configure [federated user](../../iam/concepts/users/accounts.md#saml-federation) group [mapping](../../organization/concepts/add-federation.md#group-mapping).
* View the lists of federated user group mappings and info on them, as well as create, edit, and delete such lists.
* View info on the attributes of [federated](../../iam/concepts/users/accounts.md#saml-federation) users, as well as create, modify, and delete such attributes.
* View info on [user pools](../../organization/concepts/user-pools.md) and create, modify, and delete them.
* View info on access permissions granted for user pools and modify such permissions.
* View info on [domains](../../organization/concepts/domains.md) linked to user pools, as well as add, confirm, and remove domains.
* Create, delete, activate, and deactivate [local](../../iam/concepts/users/accounts.md#local) users belonging to user pools.
* View info on the attributes of local users.
* View user audit events.
* Edit user data, such as usernames, passwords, domains, emails, full names, and phone numbers.
* View info on SAML and OIDC applications, as well as create, deactivate, activate, modify, and delete them.
* View info on access permissions granted for SAML and OIDC applications, as well as modify such permissions.
* View and edit the list of users added to SAML and OIDC applications.
* Get the certificates of SAML applications and create, modify, and delete such certificates.
* View the list of organization users that are [subscribed](../../organization/operations/subscribe-user-for-notifications.md) to technical notifications on organization events, as well as edit this list.
* View info on [MFA policies](../../organization/concepts/mfa.md#mfa-policies) and create, modify, activate, deactivate, and delete such policies.
* Delete [MFA factors](../../iam/concepts/users/accounts.md#saml-federation) for federated and [local](../../iam/concepts/users/accounts.md#saml-federation) user accounts.
* Reset the verification date for federated and local user accounts.
* View info on the organization's [{{ oslogin }}](../../organization/concepts/os-login.md) settings and modify them.
* View the list of users' and [service accounts'](../../iam/concepts/users/service-accounts.md) {{ oslogin }} [profiles](../../organization/concepts/os-login.md#os-login-profiles), as well as create, modify, and delete such profiles.
* View the list of the organization users' SSH keys and info on such keys, as well as create, modify, and delete them.
* View info on [user groups](../../organization/concepts/groups.md), as well as create, modify, and delete them.
* Add users and service accounts to groups and remove them from groups.
* View info on access permissions granted for user groups and modify such permissions.
* View the list of groups a certain user is a member of, as well as the list of users that are members of a certain group.
* View the list of and info on {{ org-full-name }} user groups associated with identity federations and user pools through synchronization with user groups in Active Directory or another external source.
* View the list of members belonging to {{ org-full-name }} user groups associated with user groups in Active Directory or another external source, as well as manage membership in such groups.
* Associate user groups with identity federations and user pools through synchronization with user groups in Active Directory or another external source, as well as disassociate them.
* Modify and delete {{ org-full-name }} user groups associated with user groups in Active Directory or another external source.
* Link {{ org-full-name }} to a billing account.
* View info on a subscription to the paid-for {{ org-full-name }} features.
* View info on stats regarding the use of the quotes within a subscription to the paid-for {{ org-full-name }} features, as well as edit these quotas.
* View the list of users who employ the {{ org-full-name }} authentication quota in the current [reporting period](../../billing/concepts/reporting-period.md).
* View and edit the [refresh token](../../iam/concepts/authorization/refresh-token.md) settings in an organization.
* View info on the organization users' refresh tokens, as well as revoke such tokens.
* View and terminate federated and local users' [sessions](../../organization/concepts/sessions.md).
* View info on {{ org-full-name }} quotas.
* View info on the effective tech support [service plan](../../support/pricing.md#effective-plans).
* View the list of technical support [requests](../../support/overview.md) and info on them, as well as create and close such requests, leave comments, and attach files to them.
* View, create, modify, and delete {{ src-name }} repositories.
* Read files from a {{ src-name }} repository.
* View, create, edit, and delete pull requests in {{ src-name }} repositories.
* Merge pull requests in {{ src-name }} repositories.
* Push changes to regular and protected {{ src-name }} repository branches.
* View, create, and edit private and public issues in {{ src-name }} repositories.
* Change the issue access type in {{ src-name }} repositories.
* Add reactions to issues in {{ src-name }} repositories.
* View, create, edit, and delete comments to pull requests and private and public issues in {{ src-name }} repositories, as well as mark such comments as resolved.
* View, create, edit, and delete {{ src-name }} repository tags.
* Manage access permissions for a {{ src-name }} repository.
* View, get, create, modify, and delete secrets in {{ src-name }} repositories.

{% endcut %}

This role includes the `organization-manager.editor`, `organization-manager.federations.admin`, `organization-manager.osLogins.admin`, `organization-manager.userpools.admin`, `organization-manager.samlApplications.admin`, `organization-manager.oauthApplications.admin`, `organization-manager.groups.memberAdmin`, `organization-manager.groups.externalCreator`, `organization-manager.groups.externalManager`, `organization-manager.idpInstances.billingAdmin`, and `src.repositories.admin` permissions.

To configure user group mapping, the role must be assigned for the {{ org-full-name }} groups you intend to map.