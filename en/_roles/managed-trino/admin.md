The `managed-trino.admin` role enables managing Trino clusters and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [Trino clusters](../../managed-trino/concepts/index.md) and modify such permissions.
* View info on Trino clusters, as well as create, modify, run, stop, and delete them.
* View info on [maintenance](../../managed-trino/concepts/maintenance.md) tasks for Trino clusters and modify such tasks.
* Use the Trino web UI.
* Send requests to the Trino API.
* View info on [quotas](../../managed-trino/concepts/limits.md#quotas) for Managed Service for Trino.

This role includes the `managed-trino.editor` permissions.

To create Trino clusters, you also need the `vpc.user` role.