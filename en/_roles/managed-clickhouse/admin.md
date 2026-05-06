
The `managed-clickhouse.admin` role enables managing {{ CH }} clusters and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [{{ CH }} clusters](../../managed-clickhouse/concepts/index.md) and modify such permissions.
* View info on {{ CH }} clusters, as well as create, use, modify, delete, run, and stop them.
* View info on [maintenance](../../managed-clickhouse/concepts/maintenance.md) tasks for {{ CH }} clusters and modify such tasks.
* Restore {{ CH }} clusters from backups.
* View {{ CH }} cluster logs.
* View info on the results of {{ CH }} cluster performance diagnostics.
* View info on [quotas](../../managed-clickhouse/concepts/limits.md#mch-quotas) for {{ mch-name }}.
* View info on resource operations for {{ mch-name }}.

This role includes the `managed-clickhouse.editor` permissions.

To create {{ CH }} clusters, you also need the `vpc.user` role.