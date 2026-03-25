The `managed-spqr.viewer` role enables viewing info on Sharded PostgreSQL clusters, hosts, databases, and users, cluster logs, and info on quotas and resource operations.

Users with this role can:
* View info on Sharded PostgreSQL [clusters](../../managed-spqr/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on maintenance tasks for Sharded PostgreSQL clusters.
* View info on Sharded PostgreSQL cluster [hosts](../../managed-spqr/concepts/instance-types.md).
* View info on databases in Sharded PostgreSQL clusters.
* View info on users in Sharded PostgreSQL clusters.
* View info on Sharded PostgreSQL cluster backups.
* View Sharded PostgreSQL cluster logs.
* View info on [quotas](../../managed-spqr/concepts/limits.md#mspqr-quotas) for Managed Service for Sharded PostgreSQL.
* View info on resource operations for Managed Service for Sharded PostgreSQL.

This role includes the `managed-spqr.auditor` and `managed-spqr.maintenanceTask.viewer` permissions.
