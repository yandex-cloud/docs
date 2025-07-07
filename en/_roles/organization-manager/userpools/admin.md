The `organization-manager.userpools.admin` role enables managing user pools and access to them, as well as the users that belong to them.

Users with this role can:
* View info on the user pools and create, modify, and delete them.
* View info on the [access permissions](../../../iam/concepts/access-control/index.md) granted for the relevant user pools and modify such permissions.
* Create, delete, activate and deactivate users belonging to user pools.
* View the attributes of users belonging to user pools.
* View the factors of [multi-factor authentication (MFA)](https://en.wikipedia.org/wiki/Multi-factor_authentication).
* View the user audit events.
* Edit the data of users belonging to user pools, such as usernames, passwords, domains, emails, full names, and phone numbers.
* View info on the domains linked to the user pools, as well as add, confirm, and remove domains.
* Revoke [refresh tokens](../../../iam/concepts/authorization/refresh-token.md) from users.
* View the list of the organization [users](../../../overview/roles-and-resources.md#users) and info on them.
* View the list of the [groups](../../../organization/concepts/groups.md) the organization users are members of.

This role includes the `organization-manager.userpools.editor` permissions.