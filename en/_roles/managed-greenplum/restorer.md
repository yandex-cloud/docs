
The `managed-greenplum.restorer` role enables restoring {{ mgp-name }} clusters from backups within {{ mgp-full-name }}, viewing info on {{ mgp-name }} clusters and hosts, their logs, as well as info on quotas and service resource operations.

Users with this role can:
* View info on [{{ mgp-name }} cluster](../../managed-greenplum/concepts/index.md) backups and restore clusters from [backups](../../managed-greenplum/concepts/backup.md).
* View info on {{ mgp-name }} clusters and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-greenplum/concepts/maintenance.md) tasks for {{ mgp-name }} clusters.
* View info on {{ mgp-name }} cluster [hosts](../../managed-greenplum/concepts/instance-types.md).
* View {{ mgp-name }} cluster logs.
* View info on the results of {{ mgp-name }} cluster performance diagnostics.
* View info on [quotas](../../managed-greenplum/concepts/limits.md#quotas) for {{ mgp-full-name }}.
* View info on resource operations for {{ mgp-full-name }}.

This role includes the `managed-greenplum.viewer` permissions.