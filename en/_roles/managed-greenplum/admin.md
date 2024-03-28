The `managed-greenplum.admin` role allows you to manage Greenplum® clusters and view their logs, as well as get information about quotas and service resource operations.

Users with this role can:
* Manage access to Greenplum® clusters.
* View information about [Greenplum® clusters](../../managed-greenplum/concepts/index.md), as well as create, modify, delete, run, and stop them.
* View information about Greenplum® cluster [hosts](../../managed-greenplum/concepts/instance-types.md), as well as create, modify, and delete them.
* View information about Greenplum® [backups](../../managed-greenplum/concepts/backup.md), as well as create and delete them.
* View Greenplum® cluster logs.
* View information about the results of Greenplum® cluster performance diagnostics.
* View information about [quotas](../../managed-greenplum/concepts/limits.md#quotas) of Managed Service for Greenplum®.
* View information about resource operations for Managed Service for Greenplum®.

This role includes the permissions of the `managed-greenplum.editor` role.

To create Greenplum® clusters, you also need the `vpc.user` role.