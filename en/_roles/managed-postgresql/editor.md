The `managed-postgresql.editor` role allows you to manage PostgreSQL clusters and view their logs, as well as get information on service quotas and resource operations.

Users with this role can:
* View information on PostgreSQL [clusters](../../managed-postgresql/concepts/index.md), as well as create, modify, delete, run, and stop them.
* View information on PostgreSQL cluster [hosts](../../managed-postgresql/concepts/instance-types.md), as well as create, modify, and delete them.
* View information on PostgreSQL databases, as well as create, modify, and delete them.
* View information on PostgreSQL [users](../../managed-postgresql/concepts/roles.md), as well as create, modify, and delete them.
* View information on PostgreSQL DB [backups](../../managed-postgresql/concepts/backup.md), as well as create and delete them.
* View information on PostgreSQL alerts, as well as create, modify, and delete them.
* View PostgreSQL cluster logs.
* View information on the results of PostgreSQL cluster performance diagnostics.
* View information on [quotas](../../managed-postgresql/concepts/limits.md#mpg-quotas) of Managed Service for PostgreSQL.
* View information on resource operations for Managed Service for PostgreSQL.

This role includes the permissions of the `managed-postgresql.viewer` role.

To create PostgreSQL clusters, you also need the `vpc.user` role.