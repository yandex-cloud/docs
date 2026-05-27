
The `managed-trino.admin` role enables managing {{ TR }} clusters and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [{{ TR }} clusters](../../managed-trino/concepts/index.md) and modify such permissions.
* View info on {{ TR }} clusters, as well as create, modify, run, stop, and delete them.
* View info on [maintenance](../../managed-trino/concepts/maintenance.md) tasks for {{ TR }} clusters and modify such tasks.
* Use the {{ TR }} web UI.
* Send requests to the {{ TR }} API.
* View info on [quotas](../../managed-trino/concepts/limits.md#quotas) for {{ mtr-name }}.

This role includes the `managed-trino.editor` permissions.

To create {{ TR }} clusters, you also need the `vpc.user` role.