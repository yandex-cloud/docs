
The `managed-clickhouse.editor` role enables managing {{ CH }} clusters.

Users with this role can:
* View info on [{{ CH }} clusters](../../managed-clickhouse/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ CH }} clusters.
* View info on [maintenance](../../managed-clickhouse/concepts/maintenance.md) tasks for {{ CH }} clusters and modify such tasks.
* Restore {{ CH }} clusters from backups.
* View {{ CH }} cluster logs.
* View info on the results of {{ CH }} cluster performance diagnostics.
* View info on [quotas](../../managed-clickhouse/concepts/limits.md#mch-quotas) for {{ mch-name }}.
* View info on resource operations for {{ mch-name }}.

This role includes the `managed-clickhouse.viewer`, `managed-clickhouse.user`, `managed-clickhouse.restorer`, and `managed-clickhouse.maintenanceTask.editor` permissions.

To create {{ CH }} clusters, you also need the `vpc.user` role.