The `managed-greenplum.viewer` role enables viewing info on Greenplum® clusters and their hosts within Yandex MPP Analytics for PostgreSQL, as well as viewing cluster logs and info on quotas and service resource operations.

Users with this role can:
* View info on [Greenplum® clusters](../../managed-greenplum/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-greenplum/concepts/maintenance.md) tasks for Greenplum® clusters.
* View info on Greenplum® cluster [hosts](../../managed-greenplum/concepts/instance-types.md).
* View info on Greenplum® cluster [backups](../../managed-greenplum/concepts/backup.md).
* View Greenplum® cluster logs.
* View info on the results of Greenplum® cluster performance diagnostics.
* View info on [quotas](../../managed-greenplum/concepts/limits.md#quotas) for Yandex MPP Analytics for PostgreSQL.
* View info on resource operations for Yandex MPP Analytics for PostgreSQL.

This role includes the `managed-greenplum.auditor` and `managed-greenplum.maintenanceTask.viewer` permissions.