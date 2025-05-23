The `ydb.admin` role enables managing databases and access to them, as well as schema objects and database backups. It also allows you to query DBs for both reading and writing.

Users with this role can:
* View the list of [databases](../../ydb/concepts/resources.md#database) and info on them, as well as create, run, stop, modify, and delete them.
* View info on granted [access permissions](../../iam/concepts/access-control/index.md) to databases and modify such permissions.
* Establish connections with databases and query them for reading and writing.
* View info on database backups, as well as create and delete them and use them to restore databases.
* View info on granted access permissions to backups and modify such permissions.
* View the list of schema objects, such as tables, indexes, and folders, and info on those, as well as create, modify, and delete such objects.
* View info on the [quotas](../../ydb/concepts/limits.md#ydb-quotas) for Managed Service for YDB.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `ydb.editor` permissions.