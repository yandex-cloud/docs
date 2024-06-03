The `managed-metastore.editor` role allows you to manage Hive Metastore clusters, as well as view their runtime logs and information on the Yandex Cloud managed DB service quotas.

Users with this role can:
* View info on Hive Metastore [clusters](../../data-proc/concepts/metastore.md), as well as create, modify, run, stop, and delete them.
* [Export and import](../../data-proc/operations/metastore/export-and-import.md) Hive Metastore clusters.
* View Hive Metastore cluster [logs](../../data-proc/concepts/logs.md).
* View info on the Yandex Cloud managed DB service quotas.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `managed-metastore.viewer` permissions.

To create clusters, you also need the [vpc.user](../../vpc/security/index.md#vpc-user) `role`.