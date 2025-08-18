The `organization-manager.userpools.admin` role enables managing user pools and access to them, as well as the users that belong to them.

Users with this role can:
* View info on [user pools](../../../organization/concepts/user-pools.md) and create, modify, and delete them.
* View info on [access permissions](../../../iam/concepts/access-control/index.md) granted for the relevant user pools and modify such permissions.
* View info on [domains](../../../organization/concepts/domains.md) linked to user pools, as well as add, confirm, and remove domains.
* View the list of the organization’s [users](../../../organization/concepts/mfa.md), info on them (including their phone number), their latest authentication date, as well as the latest verification date for federated and local accounts via [two-factor authentication](../../../organization/concepts/mfa.md).
* Create, delete, activate, and deactivate users belonging to user pools.
* Edit user data, such as usernames, passwords, domains, emails, full names, and phone numbers.
* Delete [MFA factors](../../../iam/concepts/users/accounts.md#saml-federation) for [federated](../../../iam/concepts/users/accounts.md#saml-federation) and [local](../../../iam/concepts/users/accounts.md#saml-federation) user accounts.
* Reset the verification date for federated and local user accounts.
* Revoke [refresh tokens](../../../iam/concepts/authorization/refresh-token.md) from users.
* View user audit events.
* View the list of [groups](../../../organization/concepts/groups.md) that users are members of.
* View the attributes of federated and local users.

This role includes the `organization-manager.userpools.editor` permissions.