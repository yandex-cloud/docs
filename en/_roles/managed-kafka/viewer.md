
The `managed-kafka.viewer` role enables viewing info on {{ KF }} clusters, their logs, as well as info on quotas and resource operations for {{ mkf-name }}.

Users with this role can:
* View info on [{{ KF }} clusters](../../managed-kafka/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-kafka/concepts/maintenance.md) tasks for {{ KF }} clusters.
* View {{ KF }} cluster logs.
* View info on [quotas](../../managed-kafka/concepts/limits.md#mkf-quotas) for {{ mkf-name }}.
* View info on resource operations for {{ mkf-name }}.

This role includes the `managed-kafka.auditor` and `managed-kafka.maintenanceTask.viewer` permissions.