The `ydb.viewer` role enables establishing connections to databases and querying them for reading, viewing info on databases and access permissions granted to them, as well as on the database schema objects and backups.

Users with this role can:
* Establish connections with [databases](../../ydb/concepts/resources.md#database) and query them for reading.
* View the list of databases and info on them, as well as on the [access permissions](../../iam/concepts/access-control/index.md) granted to them.
* View info on database backups and the access permissions granted to them.
* View the list of database schema objects, such as tables, indexes, and folders, and info on them.
* View info on the [quotas](../../ydb/concepts/limits.md#ydb-quotas) for Managed Service for YDB.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `ydb.auditor` permissions.