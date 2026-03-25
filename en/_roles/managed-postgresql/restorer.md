The `managed-postgresql.restorer` role enables restoring PostgreSQL clusters from backups and viewing info on PostgreSQL clusters, hosts, databases, and users, viewing cluster logs, as well as viewing info on quotas and resource operations.

Users with this role can:
* View info on [PostgreSQL cluster](../../managed-postgresql/concepts/index.md) backups and restore clusters from [backups](../../managed-postgresql/concepts/backup.md).
* View info on PostgreSQL clusters and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-postgresql/concepts/maintenance.md) tasks for PostgreSQL clusters.
* View info on PostgreSQL cluster [hosts](../../managed-postgresql/concepts/instance-types.md).
* View info on PostgreSQL databases.
* View info on PostgreSQL [users](../../managed-postgresql/concepts/roles.md).
* View info on PostgreSQL alerts.
* View PostgreSQL cluster logs.
* View info on the results of PostgreSQL cluster performance diagnostics.
* View info on [quotas](../../managed-postgresql/concepts/limits.md#mpg-quotas) for Managed Service for PostgreSQL.
* View info on resource operations for Managed Service for PostgreSQL.

This role includes the `managed-postgresql.viewer` permissions.