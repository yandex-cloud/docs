
The `managed-greenplum.viewer` role enables viewing info on {{ mgp-name }} clusters and their hosts within {{ mgp-full-name }}, as well as viewing cluster logs and info on quotas and service resource operations.

Users with this role can:
* View info on [{{ mgp-name }} clusters](../../managed-greenplum/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-greenplum/concepts/maintenance.md) tasks for {{ mgp-name }} clusters.
* View info on {{ mgp-name }} cluster [hosts](../../managed-greenplum/concepts/instance-types.md).
* View info on {{ mgp-name }} cluster [backups](../../managed-greenplum/concepts/backup.md).
* View {{ mgp-name }} cluster logs.
* View info on the results of {{ mgp-name }} cluster performance diagnostics.
* View info on [quotas](../../managed-greenplum/concepts/limits.md#quotas) for {{ mgp-full-name }}.
* View info on resource operations for {{ mgp-full-name }}.

This role includes the `managed-greenplum.auditor` and `managed-greenplum.maintenanceTask.viewer` permissions.