
The `managed-clickhouse.viewer` role enables viewing info on {{ CH }} clusters, their logs, and on quotas and resource operations for {{ mch-name }}.

Users with this role can:
* View info on [{{ CH }} clusters](../../managed-clickhouse/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-clickhouse/concepts/maintenance.md) tasks for {{ CH }} clusters.
* View {{ CH }} cluster logs.
* View info on the results of {{ CH }} cluster performance diagnostics.
* View info on [quotas](../../managed-clickhouse/concepts/limits.md#mch-quotas) for {{ mch-name }}.
* View info on resource operations for {{ mch-name }}.

This role includes the `managed-clickhouse.auditor` and `managed-clickhouse.maintenanceTask.viewer` permissions.
