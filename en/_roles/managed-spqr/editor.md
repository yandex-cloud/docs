The `managed-spqr.editor` role enables managing Sharded PostgreSQL clusters.

Users with this role can:
* View info on Sharded PostgreSQL [clusters](../../iam/concepts/access-control/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, delete, run, and stop Sharded PostgreSQL clusters.
* View info on maintenance tasks for Sharded PostgreSQL clusters and modify such tasks.
* View info on Sharded PostgreSQL cluster [hosts](../../managed-spqr/concepts/instance-types.md), as well as create, modify, and delete them.
* View info on databases in Sharded PostgreSQL clusters as well as create, modify, and delete such databases.
* View info on users in Sharded PostgreSQL clusters as well as create, modify, and delete such users.
* View info on Sharded PostgreSQL cluster backups, create and delete such backups, as well as restore clusters from backups.
* View Sharded PostgreSQL cluster logs.
* View info on [quotas](../../managed-spqr/concepts/limits.md#mspqr-quotas) for Managed Service for Sharded PostgreSQL.
* View info on resource operations for Managed Service for Sharded PostgreSQL.

This role includes the `managed-spqr.viewer`, `managed-spqr.restorer` , and `managed-spqr.maintenanceTask.editor` permissions.
