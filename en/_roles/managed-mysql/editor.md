
The `managed-mysql.editor` role enables managing {{ MY }} clusters.

Users with this role can:
* View info on {{ MY }} [clusters](../../managed-mysql/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ MY }} clusters.
* View info on [maintenance](../../managed-mysql/concepts/maintenance.md) tasks for {{ MY }} clusters and modify such tasks.
* View info on {{ MY }} cluster [hosts](../../managed-mysql/concepts/instance-types.md), as well as create, modify, and delete them.
* Re-assign the master host in {{ MY }} clusters.
* View info on {{ MY }} databases, as well as create, modify, and delete them.
* View info on {{ MY }} [users](../../managed-mysql/concepts/user-rights.md), as well as create, modify, and delete them.
* View info on {{ MY }} cluster [backups](../../managed-mysql/concepts/backup.md), create and delete such backups, as well as restore clusters from backups.
* View info on {{ MY }} alerts, as well as create, modify, and delete them.
* View {{ MY }} cluster logs.
* View info on the results of {{ MY }} cluster performance diagnostics.
* View info on [quotas](../../managed-mysql/concepts/limits.md#mmy-quotas) for {{ mmy-name }}.
* View info on resource operations for {{ mmy-name }}.

This role includes the `managed-mysql.viewer`, `managed-mysql.restorer`, `managed-mysql.user`, `managed-mysql.switcher`, and `managed-mysql.maintenanceTask.editor` permissions.

To create {{ MY }} clusters, you also need the `vpc.user` role.