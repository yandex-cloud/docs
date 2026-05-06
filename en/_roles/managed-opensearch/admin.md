
The `managed-opensearch.admin` role enables managing {{ OS }} clusters and access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for [{{ OS }} clusters](../../managed-opensearch/concepts/index.md) and modify such permissions.
* View info on {{ OS }} clusters, as well as create, use, modify, delete, run, and stop them.
* Restore {{ OS }} clusters from backups.
* View info on [maintenance](../../managed-opensearch/concepts/maintenance.md) tasks for {{ OS }} clusters and modify such tasks.
* View {{ OS }} cluster logs.
* View info on [quotas](../../managed-opensearch/concepts/limits.md#quotas) for {{ mos-name }}.
* View info on resource operations for {{ mos-name }}.

This role includes the `managed-opensearch.editor` permissions.

To create {{ OS }} clusters, you also need the `vpc.user` role.