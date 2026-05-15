
The `managed-opensearch.viewer` role enables viewing info on {{ OS }} clusters, their logs, and info on quotas and resource operations for {{ mos-name }}.

Users with this role can:
* View info on [{{ OS }} clusters](../../managed-opensearch/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-opensearch/concepts/maintenance.md) tasks for {{ OS }} clusters.
* View {{ OS }} cluster logs.
* View info on [quotas](../../managed-opensearch/concepts/limits.md#quotas) for {{ mos-name }}.
* View info on resource operations for {{ mos-name }}.

This role includes the `managed-opensearch.auditor` and `managed-opensearch.maintenanceTask.viewer` permissions.