
The `yds.admin` role enables creating, modifying, and deleting streams in {{ yds-full-name }}, as well as reading and writing data from and to those streams.

Users with this role can:
* View info on [data streams](../../data-streams/concepts/glossary.md#stream-concepts) and create, modify, and delete them.
* Read and write data from and to streams in {{ yds-full-name }}.
* View the list of [{{ ydb-short-name }} databases](../../ydb/concepts/resources.md#database) and info on them, as well as create, run, stop, modify, and delete them.
* View info on granted [access permissions](../../iam/concepts/access-control/index.md) for the relevant {{ ydb-short-name }} databases and modify such permissions.
* Establish connections to {{ ydb-short-name }} databases and query them for reading and writing.
* View info on {{ ydb-short-name }} database backups, as well as create and delete them and use them to restore {{ ydb-short-name }} databases.
* View info on granted access permissions to backups and modify such permissions.
* View the list of {{ ydb-short-name }} database schema objects, such as tables, indexes, and folders, and info on them, as well as create, modify, and delete such objects.
* View info on the [quotas](../../ydb/concepts/limits.md#ydb-quotas) for {{ ydb-name }}.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `ydb.admin` permissions.