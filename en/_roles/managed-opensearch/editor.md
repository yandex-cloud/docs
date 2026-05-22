
The `managed-opensearch.editor` role enables managing {{ OS }} clusters.

Users with this role can:
* View info on [{{ OS }} clusters](../../managed-opensearch/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ OS }} clusters.
* Restore {{ OS }} clusters from backups.
* View info on [maintenance](../../managed-opensearch/concepts/maintenance.md) tasks for {{ OS }} clusters and modify such tasks.
* View {{ OS }} cluster logs.
* View info on [quotas](../../managed-opensearch/concepts/limits.md#quotas) for {{ mos-name }}.
* View info on resource operations for {{ mos-name }}.

This role includes the `managed-opensearch.viewer`, `managed-opensearch.user`, `managed-opensearch.restorer`, and `managed-opensearch.maintenanceTask.editor` permissions.

To create {{ OS }} clusters, you also need the `vpc.user` role.