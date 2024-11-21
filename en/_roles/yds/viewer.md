The `yds.viewer` role enables reading data from streams in Yandex Data Streams and viewing their settings, as well as establishing connections to YDB databases, querying them for reading, and viewing info on YDB databases and the relevant access permissions granted for them.

Users with this role can:
* View metadata of [streams](../../data-streams/concepts/glossary.md#stream-concepts) in Yandex Data Streams and read data from those steams.
* Establish connections to [YDB databases](../../ydb/concepts/resources.md#database) and query them for reading.
* View the list of YDB databases and info on them, as well as on the relevant [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on YDB database backups and the relevant access permissions granted for them.
* View the list of YDB database schema objects, such as tables, indexes, and folders, and info on them.
* View info on the [quotas](../../ydb/concepts/limits.md#ydb-quotas) for Managed Service for YDB.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `ydb.viewer` permissions.