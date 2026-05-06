
The `managed-mysql.restorer` role enables restoring {{ MY }} clusters from backups and viewing info on {{ MY }} clusters, hosts, databases, and users, viewing cluster logs, as well as viewing info on quotas and resource operations.

Users with this role can:
* View info on {{ MY }} [cluster](../../managed-mysql/concepts/index.md) backups and restore clusters from [backups](../../managed-mysql/concepts/backup.md).
* View info on {{ MY }} clusters and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on [maintenance](../../managed-mysql/concepts/maintenance.md) tasks for {{ MY }} clusters.
* View info on {{ MY }} cluster [hosts](../../managed-mysql/concepts/instance-types.md).
* View info on {{ MY }} databases.
* View info on {{ MY }} [users](../../managed-mysql/concepts/user-rights.md).
* View info on {{ MY }} alerts.
* View {{ MY }} cluster logs.
* View info on the results of {{ MY }} cluster performance diagnostics.
* View info on [quotas](../../managed-mysql/concepts/limits.md#mmy-quotas) for {{ mmy-name }}.
* View info on resource operations for {{ mmy-name }}.

This role includes the `managed-mysql.viewer` permissions.