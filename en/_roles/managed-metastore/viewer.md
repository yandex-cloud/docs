
The `managed-metastore.viewer` role enables viewing info on {{ metastore-name }} clusters and their runtime logs, as well as info on the quotas for {{ yandex-cloud }} managed DB services.

Users with this role can:
* View info on {{ metastore-name }} [clusters](../../metadata-hub/concepts/metastore.md).
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ metastore-name }} clusters.
* View info on maintenance tasks for {{ metastore-name }} clusters.
* View {{ metastore-name }} cluster logs.
* View info on the quotas for {{ yandex-cloud }} managed DB services.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `managed-metastore.auditor` and `managed-metastore.maintenanceTask.viewer` permissions.
