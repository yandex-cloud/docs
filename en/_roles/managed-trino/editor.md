
The `managed-trino.editor` role enables managing {{ TR }} clusters.

Users with this role can:
* View info on [{{ TR }} clusters](../../managed-trino/concepts/index.md) and [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, start, stop and delete {{ TR }} clusters.
* View info on [maintenance](../../managed-trino/concepts/maintenance.md) tasks for {{ TR }} clusters and modify such tasks.
* Use the {{ TR }} web UI.
* Send requests to the {{ TR }} API.
* View info on [quotas](../../managed-trino/concepts/limits.md#quotas) for {{ mtr-name }}.

This role includes the `managed-trino.user` and `managed-trino.maintenanceTask.editor` permissions.

To create {{ TR }} clusters, you also need the `vpc.user` role.