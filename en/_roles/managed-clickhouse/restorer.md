
The `managed-clickhouse.restorer` role enables restoring {{ CH }} clusters from backups and viewing info on such clusters, their logs, and details on quotas and resource operations for {{ mch-name }}.

Users with this role can:
* Restore [{{ CH }} clusters](../../managed-clickhouse/concepts/index.md) from backups.
* View info on {{ CH }} clusters and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-clickhouse/concepts/maintenance.md) tasks for {{ CH }} clusters.
* View {{ CH }} cluster logs.
* View info on the results of {{ CH }} cluster performance diagnostics.
* View info on [quotas](../../managed-clickhouse/concepts/limits.md#mch-quotas) for {{ mch-name }}.
* View info on resource operations for {{ mch-name }}.

This role includes the `managed-clickhouse.viewer` permissions.