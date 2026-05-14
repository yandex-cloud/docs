
The `managed-mongodb.viewer` role enables viewing info on {{ SD }} clusters, hosts, shards, databases, users, cluster logs, quotas, and resource operations.

Users with this role can:
* View info on [{{ SD }} clusters](../../storedoc/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../storedoc/concepts/maintenance.md) tasks for {{ SD }} clusters and modify such tasks.
* View info on {{ SD }} cluster [hosts](../../storedoc/concepts/instance-types.md).
* View info on {{ SD }} cluster [shards](../../storedoc/concepts/sharding.md).
* View info on {{ SD }} databases.
* View info on {{ SD }} [users](../../storedoc/concepts/users-and-roles.md).
* View info on {{ SD }} cluster [backups](../../storedoc/concepts/backup.md).
* View info on {{ SD }} alerts.
* View {{ SD }} cluster [logs](../../storedoc/operations/cluster-logs.md).
* View info on the results of {{ SD }} cluster performance diagnostics.
* View info on {{ mmg-name }} [quotas](../../storedoc/concepts/limits.md#mmg-quotas).
* View info on resource operations for {{ mmg-name }}.

This role includes the `managed-mongodb.auditor` and `managed-mongodb.maintenanceTask.viewer` permissions.