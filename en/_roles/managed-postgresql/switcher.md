The `managed-postgresql.switcher` role enables re-assigning the master host in PostgreSQL clusters, viewing info on PostgreSQL clusters, hosts, databases, and users, as well as viewing cluster logs, quotas, and resource operations.

Users with this role can:
* Re-assign the master host in [PostgreSQL clusters](../../managed-postgresql/concepts/index.md).
* View info on PostgreSQL clusters and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-postgresql/concepts/maintenance.md) tasks for PostgreSQL clusters.
* View info on PostgreSQL cluster [hosts](../../managed-postgresql/concepts/instance-types.md).
* View info on PostgreSQL databases.
* View info on PostgreSQL [users](../../managed-postgresql/concepts/roles.md).
* View info on PostgreSQL cluster [backups](../../managed-postgresql/concepts/backup.md).
* View info on PostgreSQL alerts.
* View PostgreSQL cluster logs.
* View info on the results of PostgreSQL cluster performance diagnostics.
* View info on [quotas](../../managed-postgresql/concepts/limits.md#mpg-quotas) for Managed Service for PostgreSQL.
* View info on resource operations for Managed Service for PostgreSQL.

This role includes the `managed-postgresql.viewer` permissions.