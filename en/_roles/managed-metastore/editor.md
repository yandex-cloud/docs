
The `managed-metastore.editor` role enables managing {{ metastore-name }} clusters, as well as viewing their runtime logs and info on the quotas for {{ yandex-cloud }} managed DB services.

Users with this role can:
* View info on {{ metastore-name }} [clusters](../../metadata-hub/concepts/metastore.md), as well as create, modify, run, stop, and delete them.
* [Export and import](../../metadata-hub/operations/metastore/export-and-import.md) {{ metastore-name }} clusters.
* View {{ metastore-name }} cluster logs.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ metastore-name }} clusters.
* View info on maintenance tasks for {{ metastore-name }} clusters and modify such tasks.
* View info on the quotas for {{ yandex-cloud }} managed DB services.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `managed-metastore.viewer` and `managed-metastore.maintenanceTask.editor` permissions.

To create clusters, you also need the `vpc.user` [role](../../vpc/security/index.md#vpc-user).
