The `ydb.editor` role enables managing databases, schema objects, and database backups, as well as querying DBs for both reading and writing.

Users with this role can:
* View the list of [databases](../../ydb/concepts/resources.md#database), info on them and the [access permissions](../../iam/concepts/access-control/index.md) granted to them, as well as create, run, stop, modify, and delete DBs.
* Establish connections with databases and query them for reading and writing.
* View info on database backups and the access permissions granted to them, as well as create and delete them and use them to restore databases.
* View the list of schema objects, such as tables, indexes, and folders, and info on those, as well as create, modify, and delete such objects.
* View info on the [quotas](../../ydb/concepts/limits.md#ydb-quotas) for Managed Service for YDB.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `ydb.viewer` permissions.