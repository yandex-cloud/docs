The `managed-spqr.admin` role enables managing Sharded PostgreSQL clusters and viewing their logs, as well as getting info on quotas and service resource operations.

Users with this role can:
* View info on Sharded PostgreSQL [clusters](../../managed-spqr/concepts/index.md) as well as create, modify, restore, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for Sharded PostgreSQL clusters and modify such permissions.
* View info on SQL Server cluster [hosts](../../managed-spqr/concepts/instance-types.md), as well as create, modify, and delete them.
* View info on databases in Sharded PostgreSQL clusters as well as create, modify, and delete such databases.
* View info on users in Sharded PostgreSQL clusters as well as create, modify, and delete such users.
* View info on Sharded PostgreSQL cluster backups, create and delete such backups, as well as restore clusters from backups.
* View Sharded PostgreSQL cluster logs.
* View info on the Managed Service for Sharded PostgreSQL [quotas](../../managed-spqr/concepts/limits.md#mspqr-quotas).
* View info on resource operations for Managed Service for Sharded PostgreSQL.

This role includes the `managed-spqr.editor` permissions.
