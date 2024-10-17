---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/index.md
---

# Managed Service for ClickHouse API, REST: Cluster

A set of methods for managing ClickHouse clusters.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified ClickHouse cluster. ||
|| [List](list.md) | Retrieves a list of ClickHouse clusters that belong ||
|| [Create](create.md) | Creates a ClickHouse cluster in the specified folder. ||
|| [Update](update.md) | Updates the specified ClickHouse cluster. ||
|| [Delete](delete.md) | Deletes the specified ClickHouse cluster. ||
|| [Start](start.md) | Starts the specified ClickHouse cluster. ||
|| [Stop](stop.md) | Stops the specified ClickHouse cluster. ||
|| [Move](move.md) | Moves a ClickHouse cluster to the specified folder. ||
|| [AddZookeeper](addZookeeper.md) | Adds a ZooKeeper subcluster to the specified ClickHouse cluster. ||
|| [Backup](backup.md) | Creates a backup for the specified ClickHouse cluster. ||
|| [Restore](restore.md) | Creates a new ClickHouse cluster using the specified backup. ||
|| [RescheduleMaintenance](rescheduleMaintenance.md) | Reschedules planned maintenance operation. ||
|| [ListLogs](listLogs.md) | Retrieves logs for the specified ClickHouse cluster. ||
|| [StreamLogs](streamLogs.md) | Same as ListLogs but using server-side streaming. Also allows for `tail -f` semantics. ||
|| [ListOperations](listOperations.md) | Retrieves the list of Operation resources for the specified cluster. ||
|| [ListBackups](listBackups.md) | Retrieves the list of available backups for the specified ClickHouse cluster. ||
|| [ListHosts](listHosts.md) | Retrieves a list of hosts for the specified cluster. ||
|| [AddHosts](addHosts.md) | Creates new hosts for a cluster. ||
|| [UpdateHosts](updateHosts.md) | Updates the specified hosts. ||
|| [DeleteHosts](deleteHosts.md) | Deletes the specified hosts for a cluster. ||
|| [RestartHosts](restartHosts.md) |  ||
|| [GetShard](getShard.md) | Returns the specified shard. ||
|| [ListShards](listShards.md) | Retrieves a list of shards that belong to the specified cluster. ||
|| [AddShard](addShard.md) | Creates a new shard in the specified cluster. ||
|| [AddShards](addShards.md) | Creates one or more shards in the specified cluster. ||
|| [UpdateShard](updateShard.md) | Modifies the specified shard. ||
|| [DeleteShard](deleteShard.md) | Deletes the specified shard. ||
|| [DeleteShards](deleteShards.md) | Deletes the specified shards (one or more). ||
|| [GetShardGroup](getShardGroup.md) | Returns the specified shard group. ||
|| [ListShardGroups](listShardGroups.md) | Retrieves a list of shard groups that belong to specified cluster. ||
|| [CreateShardGroup](createShardGroup.md) | Creates a new shard group in the specified cluster. ||
|| [UpdateShardGroup](updateShardGroup.md) | Updates the specified shard group. ||
|| [DeleteShardGroup](deleteShardGroup.md) | Deletes the specified shard group. ||
|| [ListExternalDictionaries](listExternalDictionaries.md) | Retrieves a list of external dictionaries that belong to specified cluster. ||
|| [CreateExternalDictionary](createExternalDictionary.md) | Creates an external dictionary for the specified ClickHouse cluster. ||
|| [UpdateExternalDictionary](updateExternalDictionary.md) | Updates an external dictionary for the specified ClickHouse cluster. ||
|| [DeleteExternalDictionary](deleteExternalDictionary.md) | Deletes the specified external dictionary. ||
|#