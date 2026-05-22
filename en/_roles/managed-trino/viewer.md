
The `managed-trino.viewer` role enables viewing info on {{ TR }} clusters and quotas for {{ mtr-name }}.

Users with this role can:
* View info on [{{ TR }} clusters](../../managed-trino/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-trino/concepts/maintenance.md) tasks for {{ TR }} clusters.
* View info on [quotas](../../managed-trino/concepts/limits.md#quotas) for {{ mtr-name }}.

This role includes the `managed-trino.auditor` and `managed-trino.maintenanceTask.viewer` permissions.