The `managed-metastore.admin` role allows you to manage Hive Metastore clusters, as well as view their runtime logs and information on service quotas of Yandex Cloud managed DBs.

Users with this role can:
* View info on Hive Metastore [clusters](../../metadata-hub/concepts/metastore.md), as well as create, modify, run, stop, and delete them.
* [Export and import](../../metadata-hub/operations/metastore/export-and-import.md) Hive Metastore clusters.
* View Hive Metastore cluster logs.
* View info on the Yandex Cloud managed DB service quotas.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `managed-metastore.editor` permissions.

To create clusters, you also need the `vpc.user` [role](../../vpc/security/index.md#vpc-user).
