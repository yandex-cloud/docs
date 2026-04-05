The `managed-mysql.editor` role enables managing MySQL® clusters.

Users with this role can:
* View info on MySQL® [clusters](../../managed-mysql/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for MySQL® clusters.
* View info on [maintenance](../../managed-mysql/concepts/maintenance.md) tasks for MySQL® clusters and modify such tasks.
* View info on MySQL® cluster [hosts](../../managed-mysql/concepts/instance-types.md), as well as create, modify, and delete them.
* Re-assign the master host in MySQL® clusters.
* View info on MySQL® databases, as well as create, modify, and delete them.
* View info on MySQL® [users](../../managed-mysql/concepts/user-rights.md), as well as create, modify, and delete them.
* View info on MySQL® cluster [backups](../../managed-mysql/concepts/backup.md), create and delete such backups, as well as restore clusters from backups.
* View info on MySQL® alerts, as well as create, modify, and delete them.
* View MySQL® cluster logs.
* View info on the results of MySQL® cluster performance diagnostics.
* View info on [quotas](../../managed-mysql/concepts/limits.md#mmy-quotas) for Managed Service for MySQL®.
* View info on resource operations for Managed Service for MySQL®.

This role includes the `managed-mysql.viewer`, `managed-mysql.restorer`, `managed-mysql.user`, `managed-mysql.switcher`, and `managed-mysql.maintenanceTask.editor` permissions.

To create MySQL® clusters, you also need the `vpc.user` role.