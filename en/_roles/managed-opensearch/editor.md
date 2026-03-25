The `managed-opensearch.editor` role enables managing OpenSearch clusters.

Users with this role can:
* View info on [OpenSearch clusters](../../managed-opensearch/concepts/index.md), as well as create, use, modify, delete, run, and stop them.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for OpenSearch clusters.
* Restore OpenSearch clusters from backups.
* View info on [maintenance](../../managed-opensearch/concepts/maintenance.md) tasks for OpenSearch clusters and modify such tasks.
* View OpenSearch cluster logs.
* View info on [quotas](../../managed-opensearch/concepts/limits.md#quotas) for Managed Service for OpenSearch.
* View info on resource operations for Managed Service for OpenSearch.

This role includes the `managed-opensearch.viewer`, `managed-opensearch.user`, `managed-opensearch.restorer`, and `managed-opensearch.maintenanceTask.editor` permissions.

To create OpenSearch clusters, you also need the `vpc.user` role.