The `organization-manager.userpools.userAdmin` role enables managing the organization users belonging to user pools.

Users with this role can:
* View the list of the organization [users](../../../overview/roles-and-resources.md#users) and info on them.
* View the list of the [groups](../../../organization/concepts/groups.md) the organization users are members of.
* Create, delete, activate and deactivate users belonging to user pools.
* View the attributes of users belonging to user pools.
* Edit the data of users belonging to user pools, such as usernames, passwords, domains, emails, full names, and phone numbers.
* Revoke [refresh tokens](../../../iam/concepts/authorization/refresh-token.md) from users.

This role includes the `iam.userAccounts.refreshTokenRevoker` permissions.