
The `managed-postgresql.editor` role enables managing {{ PG }} clusters.

Users with this role can:
* View info on [{{ PG }} clusters](../../managed-postgresql/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ PG }} clusters.
* View info on [maintenance](../../managed-postgresql/concepts/maintenance.md) tasks for {{ PG }} clusters and modify such tasks.
* View info on {{ PG }} cluster [hosts](../../managed-postgresql/concepts/instance-types.md), as well as create, modify, and delete them.
* Re-assign the master host in {{ PG }} clusters.
* View info on {{ PG }} databases, as well as create, modify, and delete them.
* View info on {{ PG }} [users](../../managed-postgresql/concepts/roles.md), as well as create, modify, and delete them.
* View info on {{ PG }} cluster [backups](../../managed-postgresql/concepts/backup.md), create and delete such backups, as well as restore clusters from backups.
* View info on {{ PG }} alerts, as well as create, modify, and delete them.
* View {{ PG }} cluster logs.
* View info on the results of {{ PG }} cluster performance diagnostics.
* View info on [quotas](../../managed-postgresql/concepts/limits.md#mpg-quotas) for {{ mpg-name }}.
* View info on resource operations for {{ mpg-name }}.

This role includes the `managed-postgresql.viewer`, `managed-postgresql.restorer`, `managed-postgresql.user`, `managed-postgresql.switcher`, and `managed-postgresql.maintenanceTask.editor` permissions.

To create {{ PG }} clusters, you also need the `vpc.user` role.