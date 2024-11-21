The `yds.auditor` role enables viewing metadata of streams in Yandex Data Streams, establishing YDB database connections, and viewing info on YDB databases and the relevant access permissions granted for them, as well as on the YDB database schema objects and backups.

Users with this role can:
* View [streams](../../data-streams/concepts/glossary.md#stream-concepts) metadata in Yandex Data Streams.
* Establish [YDB database](../../ydb/concepts/resources.md#database) connections.
* View the list of YDB databases and info on them, as well as on the relevant [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on YDB database backups and the relevant access permissions granted for them.
* View the list of YDB database schema objects, such as tables, indexes, and folders, and info on them.
* View info on the [quotas](../../ydb/concepts/limits.md#ydb-quotas) for Managed Service for YDB.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `ydb.auditor` permissions.