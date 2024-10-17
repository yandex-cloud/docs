---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/Cluster/index.md
---

# Managed Service for Redis API, gRPC: ClusterService

A set of methods for managing Redis clusters.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified Redis cluster. ||
|| [List](list.md) | Retrieves the list of Redis clusters that belong ||
|| [Create](create.md) | Creates a Redis cluster in the specified folder. ||
|| [Update](update.md) | Updates the specified Redis cluster. ||
|| [Delete](delete.md) | Deletes the specified Redis cluster. ||
|| [Start](start.md) | Start the specified Redis cluster. ||
|| [Stop](stop.md) | Stop the specified Redis cluster. ||
|| [Move](move.md) | Moves a Redis cluster to the specified folder. ||
|| [Backup](backup.md) | Creates a backup for the specified Redis cluster. ||
|| [Restore](restore.md) | Creates a new Redis cluster using the specified backup. ||
|| [RescheduleMaintenance](rescheduleMaintenance.md) | Reschedules planned maintenance operation. ||
|| [StartFailover](startFailover.md) | Start a manual failover on the specified Redis cluster. ||
|| [ListLogs](listLogs.md) | Retrieves logs for the specified Redis cluster. ||
|| [StreamLogs](streamLogs.md) | Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics. ||
|| [ListOperations](listOperations.md) | Retrieves the list of operations for the specified cluster. ||
|| [ListBackups](listBackups.md) | Retrieves the list of available backups for the specified Redis cluster. ||
|| [ListHosts](listHosts.md) | Retrieves a list of hosts for the specified cluster. ||
|| [AddHosts](addHosts.md) | Creates new hosts for a cluster. ||
|| [DeleteHosts](deleteHosts.md) | Deletes the specified hosts for a cluster. ||
|| [UpdateHosts](updateHosts.md) | Updates the specified hosts. ||
|| [GetShard](getShard.md) | Returns the specified shard. ||
|| [ListShards](listShards.md) | Retrieves a list of shards. ||
|| [AddShard](addShard.md) | Creates a new shard. ||
|| [DeleteShard](deleteShard.md) | Deletes the specified shard. ||
|| [Rebalance](rebalance.md) | Rebalances the cluster. Evenly distributes all the hash slots between the shards. ||
|| [EnableSharding](enableSharding.md) | Enable Sharding on non sharded cluster ||
|#