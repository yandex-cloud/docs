---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Cluster/index.md
---

# Managed Service for Elasticsearch API, REST: Cluster

A set of methods for managing Elasticsearch clusters.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified Elasticsearch cluster. ||
|| [List](list.md) | Retrieves the list of Elasticsearch clusters that belong to the specified folder. ||
|| [Create](create.md) | Creates a new Elasticsearch cluster in the specified folder. ||
|| [Update](update.md) | Updates the specified Elasticsearch cluster. ||
|| [Delete](delete.md) | Deletes the specified Elasticsearch cluster. ||
|| [Move](move.md) | Moves the specified Elasticsearch cluster to the specified folder. ||
|| [Start](start.md) | Starts the specified Elasticsearch cluster. ||
|| [Stop](stop.md) | Stops the specified Elasticsearch cluster. ||
|| [Backup](backup.md) | Create a backup for the specified ElasticSearch cluster. ||
|| [ListBackups](listBackups.md) | Returns the list of available backups for the specified Elasticsearch cluster. ||
|| [Restore](restore.md) | Creates a new ElasticSearch cluster from the specified backup. ||
|| [ListLogs](listLogs.md) | Retrieves logs for the specified Elasticsearch cluster. ||
|| [StreamLogs](streamLogs.md) | Same as [ListLogs](#ListLogs) but using server-side streaming. Also supports `tail -f` semantics. ||
|| [ListOperations](listOperations.md) | Retrieves the list of operations for the specified Elasticsearch cluster. ||
|| [ListHosts](listHosts.md) | Retrieves a list of hosts for the specified Elasticsearch cluster. ||
|| [AddHosts](addHosts.md) | Adds new hosts to the specified Elasticsearch cluster. ||
|| [DeleteHosts](deleteHosts.md) | Deletes specified hosts from the specified Elasticsearch cluster. ||
|| [RescheduleMaintenance](rescheduleMaintenance.md) | Reschedule planned maintenance operation. ||
|#