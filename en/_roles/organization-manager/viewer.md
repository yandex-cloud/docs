The `organization-manager.viewer` role enables viewing info on the organization and its settings, identity federations that belong to the organization, user pools, SAML and OIDC applications, and the organization's users and user groups.

{% cut "Users with this role can:" %}

* View info on the {{ org-full-name }} [organization](../../organization/concepts/organization.md) and its settings.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for the organization.
* View [access policies](../../iam/concepts/access-control/access-policies.md) assigned to the organization.
* View the organization's [branding](../../organization/concepts/branding.md) settings.
* View the list of the organization's [users](../../organization/concepts/mfa.md), info on them (including their phone number), their latest authentication date, and the latest verification date for federated and local accounts via [two-factor authentication](../../organization/concepts/mfa.md).
* View info on access permissions granted for [entities](../../iam/concepts/access-control/index.md#subject) in an {{ org-full-name }} organization.
* View info on the organization's [identity federations](../../organization/concepts/add-federation.md).
* View info on identity federation [certificates](../../organization/concepts/add-federation.md#build-trust).
* View the list of [federated user](../../iam/concepts/users/accounts.md#saml-federation) group [mappings](../../organization/concepts/add-federation.md#group-mapping) and info on them.
* View info on the attributes of [federated](../../iam/concepts/users/accounts.md#saml-federation) users.
* View info on [user pools](../../organization/concepts/user-pools.md) and access permissions granted for them.
* View info on the attributes of [local](../../iam/concepts/users/accounts.md#local) users belonging to user pools.
* View user audit events.
* View info on [domains](../../organization/concepts/domains.md) linked to user pools.
* View info on SAML and OIDC applications, as well as on access permissions granted for them.
* View the list of users added to SAML and OIDC applications.
* Get the certificates of SAML applications.
* View the list of organization users that are [subscribed](../../organization/operations/subscribe-user-for-notifications.md) to technical notifications on organization events.
* View info on [MFA policies](../../iam/concepts/users/accounts.md#local).
* View info on the organization's [{{ oslogin }}](../../organization/concepts/os-login.md) settings.
* View the list of {{ oslogin }} [profiles](../../organization/concepts/os-login.md#os-login-profiles) for users and service accounts.
* View the list of the organization users' SSH keys and info on such keys.
* View info on [user groups](../../organization/concepts/groups.md) and access permissions granted for them.
* View the list of groups a certain user is a member of, as well as the list of users that are members of a certain group.
* View the list of and info on {{ org-full-name }} user groups associated with identity federations and user pools through synchronization with user groups in Active Directory or another external source.
* View info on a subscription to the paid-for {{ org-full-name }} features.
* View stats regarding the use of quotes within a subscription to the paid-for {{ org-full-name }} features.
* View the list of users who employ the {{ org-full-name }} authentication quota in the current [reporting period](../../billing/concepts/reporting-period.md).
* View info on the organization users' [refresh tokens](../../iam/concepts/authorization/refresh-token.md) and on the refresh token settings.
* View federated and local users' [sessions](../../organization/concepts/sessions.md).
* View info on {{ org-full-name }} quotas.
* View info on the effective tech support [service plan](../../support/pricing.md#effective-plans).
* View the list of technical support [requests](../../support/overview.md) and info on them, as well as create and close such requests, leave comments, and attach files to them.

{% endcut %}

This role includes the `organization-manager.auditor`, `organization-manager.federations.viewer`, `organization-manager.users.viewer`, `organization-manager.samlApplications.viewer`, `organization-manager.oauthApplications.viewer`, `organization-manager.userpools.viewer`, and `organization-manager.idpInstances.billingViewer` permissions.