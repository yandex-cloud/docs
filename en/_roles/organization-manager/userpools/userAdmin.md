The `organization-manager.userpools.userAdmin` role enables managing organization users belonging to user pools.

Users with this role can:
* View the list of the organization’s [users](../../../organization/concepts/mfa.md), info on them (including their phone number), their latest authentication date, as well as the latest verification date for federated and local accounts via [two-factor authentication](../../../organization/concepts/mfa.md).
* Create, delete, activate, and deactivate local users belonging to [user pools](../../../iam/concepts/users/accounts.md#saml-federation).
* Edit user data, such as usernames, passwords, domains, emails, full names, and phone numbers.
* Delete [MFA factors](../../../iam/concepts/users/accounts.md#saml-federation) for [federated](../../../iam/concepts/users/accounts.md#saml-federation) and [local](../../../iam/concepts/users/accounts.md#saml-federation) user accounts.
* Reset the verification date for federated and local user accounts.
* Revoke [refresh tokens](../../../iam/concepts/authorization/refresh-token.md) from users.
* View the list of [groups](../../../organization/concepts/groups.md) that users are members of.
* View the attributes of federated and local users.

This role includes the `iam.userAccounts.refreshTokenRevoker` permissions.