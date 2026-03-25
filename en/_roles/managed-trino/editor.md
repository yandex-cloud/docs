The `managed-trino.editor` role enables managing Trino clusters.

Users with this role can:
* View info on [Trino clusters](../../managed-trino/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, start, stop and delete Trino clusters.
* View info on [maintenance](../../managed-trino/concepts/maintenance.md) tasks for Trino clusters and modify such tasks.
* Use the Trino web UI.
* Send requests to the Trino API.
* View info on [quotas](../../managed-trino/concepts/limits.md#quotas) for Managed Service for Trino.

This role includes the `managed-trino.user` and `managed-trino.maintenanceTask.editor` permissions.

To create Trino clusters, you also need the `vpc.user` role.