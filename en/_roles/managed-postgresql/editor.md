The `managed-postgresql.editor` role enables managing PostgreSQL clusters.

Users with this role can:
* View info on [PostgreSQL clusters](../../managed-postgresql/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for PostgreSQL clusters.
* View info on [maintenance](../../managed-postgresql/concepts/maintenance.md) tasks for PostgreSQL clusters and modify such tasks.
* View info on PostgreSQL cluster [hosts](../../managed-postgresql/concepts/instance-types.md), as well as create, modify, and delete them.
* Re-assign the master host in PostgreSQL clusters.
* View info on PostgreSQL databases, as well as create, modify, and delete them.
* View info on PostgreSQL [users](../../managed-postgresql/concepts/roles.md), as well as create, modify, and delete them.
* View info on PostgreSQL cluster [backups](../../managed-postgresql/concepts/backup.md), create and delete such backups, as well as restore clusters from backups.
* View info on PostgreSQL alerts, as well as create, modify, and delete them.
* View PostgreSQL cluster logs.
* View info on the results of PostgreSQL cluster performance diagnostics.
* View info on [quotas](../../managed-postgresql/concepts/limits.md#mpg-quotas) for Managed Service for PostgreSQL.
* View info on resource operations for Managed Service for PostgreSQL.

This role includes the `managed-postgresql.viewer`, `managed-postgresql.restorer`, `managed-postgresql.user`, `managed-postgresql.switcher`, and `managed-postgresql.maintenanceTask.editor` permissions.

To create PostgreSQL clusters, you also need the `vpc.user` role.