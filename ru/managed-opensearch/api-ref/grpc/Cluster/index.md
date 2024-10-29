---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/index.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService

A set of methods for managing OpenSearch clusters.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified OpenSearch cluster. ||
|| [List](list.md) | Retrieves the list of OpenSearch clusters that belong to the specified folder. ||
|| [Create](create.md) | Creates an OpenSearch cluster in the specified folder. ||
|| [Update](update.md) | Updates the specified OpenSearch cluster. ||
|| [Delete](delete.md) | Deletes the specified OpenSearch cluster. ||
|| [Backup](backup.md) | Creates a backup for the specified OpenSearch cluster. ||
|| [DeleteBackup](deleteBackup.md) | Delete backup for the specified OpenSearch cluster. ||
|| [Restore](restore.md) | Creates a new OpenSearch cluster using the specified backup. ||
|| [RescheduleMaintenance](rescheduleMaintenance.md) | Reschedules a planned maintenance operation. ||
|| [ListBackups](listBackups.md) | Returns a list of available backups for the specified OpenSearch cluster. ||
|| [Move](move.md) | Moves the specified OpenSearch cluster to the specified folder. ||
|| [Start](start.md) | Starts the specified OpenSearch cluster. ||
|| [Stop](stop.md) | Stops the specified OpenSearch cluster. ||
|| [ListLogs](listLogs.md) | Retrieves logs for the specified OpenSearch cluster. ||
|| [StreamLogs](streamLogs.md) | Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics. ||
|| [ListOperations](listOperations.md) | Retrieves the list of Operation resources for the specified cluster. ||
|| [ListHosts](listHosts.md) | Retrieves a list of hosts for the specified cluster. ||
|| [AddOpenSearchNodeGroup](addOpenSearchNodeGroup.md) | Creates an OpenSearch type host group. ||
|| [DeleteOpenSearchNodeGroup](deleteOpenSearchNodeGroup.md) | Deletes an OpenSearch type host group. ||
|| [UpdateOpenSearchNodeGroup](updateOpenSearchNodeGroup.md) | Updates an OpenSearch type host group. ||
|| [AddDashboardsNodeGroup](addDashboardsNodeGroup.md) | Creates a Dashboards type host group. ||
|| [DeleteDashboardsNodeGroup](deleteDashboardsNodeGroup.md) | Deletes a Dashboards type host group. ||
|| [UpdateDashboardsNodeGroup](updateDashboardsNodeGroup.md) | Updates a Dashboards type host group. ||
|| [GetAuthSettings](getAuthSettings.md) | Retrieves auth settings for specified cluster. ||
|| [UpdateAuthSettings](updateAuthSettings.md) | Updates auth settings for specified cluster. ||
|#