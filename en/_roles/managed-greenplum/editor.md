The `managed-greenplum.editor` role enables managing Greenplum® clusters in Yandex MPP Analytics for PostgreSQL.

Users with this role can:
* View info on [Greenplum® clusters](../../managed-greenplum/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for Greenplum® clusters.
* View info on [maintenance](../../managed-greenplum/concepts/maintenance.md) tasks for Greenplum® clusters and modify such tasks.
* View info on Greenplum® cluster [hosts](../../managed-greenplum/concepts/instance-types.md), as well as create, modify, and delete them.
* View info on Greenplum® cluster [backups](../../managed-greenplum/concepts/backup.md), create and delete such backups, as well as restore clusters from backups.
* View Greenplum® cluster logs.
* View info on the results of Greenplum® cluster performance diagnostics.
* View info on [quotas](../../managed-greenplum/concepts/limits.md#quotas) for Yandex MPP Analytics for PostgreSQL.
* View info on resource operations for Yandex MPP Analytics for PostgreSQL.

This role includes the `managed-greenplum.viewer`, `managed-greenplum.user`, `managed-greenplum.restorer`, and `managed-greenplum.maintenanceTask.editor` permissions.

To create Greenplum® clusters within Yandex MPP Analytics for PostgreSQL, you also need the `vpc.user` role.