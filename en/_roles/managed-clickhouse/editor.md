The `managed-clickhouse.editor` role enables managing ClickHouse® clusters.

Users with this role can:
* View info on [ClickHouse® clusters](../../managed-clickhouse/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for ClickHouse® clusters.
* View info on [maintenance](../../managed-clickhouse/concepts/maintenance.md) tasks for ClickHouse® clusters and modify such tasks.
* Restore ClickHouse® clusters from backups.
* View ClickHouse® cluster logs.
* View info on the results of ClickHouse® cluster performance diagnostics.
* View info on [quotas](../../managed-clickhouse/concepts/limits.md#mch-quotas) for Managed Service for ClickHouse®.
* View info on resource operations for Managed Service for ClickHouse®.

This role includes the `managed-clickhouse.viewer`, `managed-clickhouse.user`, `managed-clickhouse.restorer`, and `managed-clickhouse.maintenanceTask.editor` permissions.

To create ClickHouse® clusters, you also need the `vpc.user` role.