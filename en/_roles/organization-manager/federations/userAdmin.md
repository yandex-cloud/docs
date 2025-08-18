The `organization-manager.federations.userAdmin` role enables adding and removing federated users to/from an organization, revoking refresh tokens, managing user accounts’ MFA factors, and viewing the list of the organization’s users as well as info from their accounts.

Users with this role can:
* Add and remove [federated](../../../iam/concepts/users/accounts.md#saml-federation) users.
* Revoke federated users’ [refresh tokens](../../../iam/concepts/authorization/refresh-token.md).
* Delete [MFA factors](../../../iam/concepts/users/accounts.md#saml-federation) for federated and [local](../../../iam/concepts/users/accounts.md#saml-federation) user accounts.
* Reset the verification date for federated and local user accounts.
* View the list of the organization’s [users](../../../overview/roles-and-resources.md#users), info on them (including their phone number), their latest authentication date, and the latest verification date for federated and local accounts via [two-factor authentication](../../../organization/concepts/mfa.md).
* View the list of [groups](../../../organization/concepts/groups.md) that users are members of.
* View the [attributes](../../../organization/operations/setup-federation.md#claims-mapping) of federated and local users.

This role includes the `iam.userAccounts.refreshTokenRevoker` permissions.