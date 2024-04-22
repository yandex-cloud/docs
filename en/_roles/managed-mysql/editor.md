The `managed-mysql.editor` role allows you to manage MySQL® clusters and view their logs, as well as get information on service quotas and resource operations.

Users with this role can:
* View information on MySQL® [clusters](../../managed-mysql/concepts/index.md), as well as create, modify, delete, run, and stop them.
* View information on MySQL® cluster [hosts](../../managed-mysql/concepts/instance-types.md), as well as create, modify, and delete them.
* View information on MySQL® databases, as well as create, modify, and delete them.
* View information on MySQL® [users](../../managed-mysql/concepts/user-rights.md), as well as create, modify, and delete them.
* View information on MySQL® DB [backups](../../managed-mysql/concepts/backup.md), as well as create and delete them.
* View information on MySQL® alerts, as well as create, modify, and delete them.
* View MySQL® cluster logs.
* View information on the results of MySQL® cluster performance diagnostics.
* View information on [quotas](../../managed-mysql/concepts/limits.md#mmy-quotas) of Managed Service for MySQL®.
* View information on resource operations for Managed Service for MySQL®.

This role also includes the `managed-mysql.viewer` permissions.

To create MySQL® clusters, you also need the `vpc.user` role.