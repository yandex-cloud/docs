
The `managed-greenplum.editor` role enables managing {{ mgp-name }} clusters in {{ mgp-full-name }}.

Users with this role can:
* View info on [{{ mgp-name }} clusters](../../managed-greenplum/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ mgp-name }} clusters.
* View info on [maintenance](../../managed-greenplum/concepts/maintenance.md) tasks for {{ mgp-name }} clusters and modify such tasks.
* View info on {{ mgp-name }} cluster [hosts](../../managed-greenplum/concepts/instance-types.md), as well as create, modify, and delete them.
* View info on {{ mgp-name }} cluster [backups](../../managed-greenplum/concepts/backup.md), create and delete such backups, as well as restore clusters from backups.
* View {{ mgp-name }} cluster logs.
* View info on the results of {{ mgp-name }} cluster performance diagnostics.
* View info on [quotas](../../managed-greenplum/concepts/limits.md#quotas) for {{ mgp-full-name }}.
* View info on resource operations for {{ mgp-full-name }}.

This role includes the `managed-greenplum.viewer`, `managed-greenplum.user`, `managed-greenplum.restorer`, and `managed-greenplum.maintenanceTask.editor` permissions.

To create {{ mgp-name }} clusters within {{ mgp-full-name }}, you also need the `vpc.user` role.