The `organization-manager.userpools.admin` role enables managing user pools and the users that belong to them.

Users with this role can:
* View info on user pools and the [access permissions](../../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, and delete user pools.
* Create, delete, activate and deactivate users belonging to user pools.
* View the attributes of users belonging to user pools.
* View the factors of [multi-factor authentication (MFA)](https://en.wikipedia.org/wiki/Multi-factor_authentication).
* View the user audit events.
* Edit the data of users belonging to user pools, such as usernames, passwords, domains, emails, full names, and phone numbers.
* View info on the domains linked to the user pools, as well as add, confirm, and remove domains.
* Revoke [refresh tokens](../../../iam/concepts/authorization/refresh-token.md) from users.
* View the list of the organization [users](../../../overview/roles-and-resources.md#users) and info on them.
* View the list of the [groups](../../../organization/concepts/groups.md) the organization users are members of.

This role includes the `organization-manager.userpools.userAdmin` and `organization-manager.userpools.viewer` permissions.