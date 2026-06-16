
The `yds.viewer` role enables reading data from streams in {{ yds-full-name }} and viewing their settings, as well as establishing connections to {{ ydb-short-name }} databases, querying them for reading, and viewing info on {{ ydb-short-name }} databases and the relevant access permissions granted for them.

Users with this role can:
* View metadata of [streams](../../data-streams/concepts/glossary.md#stream-concepts) in {{ yds-full-name }} and read data from those steams.
* Establish connections to [{{ ydb-short-name }} databases](../../ydb/concepts/resources.md#database) and query them for reading.
* View the list of {{ ydb-short-name }} databases and info on them, as well as on the relevant [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* View info on {{ ydb-short-name }} database backups and the relevant access permissions granted for them.
* View the list of {{ ydb-short-name }} database schema objects, such as tables, indexes, and folders, and info on them.
* View info on the [quotas](../../ydb/concepts/limits.md#ydb-quotas) for {{ ydb-name }}.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `ydb.viewer` permissions.