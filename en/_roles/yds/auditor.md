
The `yds.auditor` role enables viewing metadata of streams in {{ yds-full-name }}, establishing {{ ydb-short-name }} database connections, and viewing info on {{ ydb-short-name }} databases and the relevant access permissions granted for them, as well as on the {{ ydb-short-name }} database schema objects and backups.

Users with this role can:
* View [streams](../../data-streams/concepts/glossary.md#stream-concepts) metadata in {{ yds-full-name }}.
* Establish [{{ ydb-short-name }} database](../../ydb/concepts/resources.md#database) connections.
* View the list of {{ ydb-short-name }} databases and info on them, as well as on the relevant [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on {{ ydb-short-name }} database backups and the relevant access permissions granted for them.
* View the list of {{ ydb-short-name }} database schema objects, such as tables, indexes, and folders, and info on them.
* View info on the [quotas](../../ydb/concepts/limits.md#ydb-quotas) for {{ ydb-name }}.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `ydb.auditor` permissions.