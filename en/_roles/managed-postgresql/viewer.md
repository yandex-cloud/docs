
The `managed-postgresql.viewer` role enables viewing info on {{ PG }} clusters, hosts, databases, users, and cluster logs, as well as on quotas and resource operations.

Users with this role can:
* View info on [{{ PG }} clusters](../../managed-postgresql/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-postgresql/concepts/maintenance.md) tasks for {{ PG }} clusters.
* View info on {{ PG }} cluster [hosts](../../managed-postgresql/concepts/instance-types.md).
* View info on {{ PG }} databases.
* View info on {{ PG }} [users](../../managed-postgresql/concepts/roles.md).
* View info on {{ PG }} cluster [backups](../../managed-postgresql/concepts/backup.md).
* View info on {{ PG }} alerts.
* View {{ PG }} cluster logs.
* View info on the results of {{ PG }} cluster performance diagnostics.
* View info on [quotas](../../managed-postgresql/concepts/limits.md#mpg-quotas) for {{ mpg-name }}.
* View info on resource operations for {{ mpg-name }}.

This role includes the `managed-postgresql.auditor` and `managed-postgresql.maintenanceTask.viewer` permissions.