[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for Valkey™](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > Cluster > Overview

# Managed Service for Redis API, gRPC: ClusterService

A set of methods for managing Valkey clusters.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified Valkey cluster. ||
|| [List](list.md) | Retrieves the list of Valkey clusters that belong ||
|| [Create](create.md) | Creates a Valkey cluster in the specified folder. ||
|| [Update](update.md) | Updates the specified Valkey cluster. ||
|| [Delete](delete.md) | Deletes the specified Valkey cluster. ||
|| [Start](start.md) | Start the specified Valkey cluster. ||
|| [Stop](stop.md) | Stop the specified Valkey cluster. ||
|| [Move](move.md) | Moves a Valkey cluster to the specified folder. ||
|| [Backup](backup.md) | Creates a backup for the specified Valkey cluster. ||
|| [Restore](restore.md) | Creates a new Valkey cluster using the specified backup. ||
|| [RescheduleMaintenance](rescheduleMaintenance.md) | Reschedules planned maintenance operation. ||
|| [StartFailover](startFailover.md) | Start a manual failover on the specified Valkey cluster. ||
|| [ListLogs](listLogs.md) | Retrieves logs for the specified Valkey cluster. ||
|| [StreamLogs](streamLogs.md) | Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics. ||
|| [ListOperations](listOperations.md) | Retrieves the list of operations for the specified cluster. ||
|| [ListBackups](listBackups.md) | Retrieves the list of available backups for the specified Valkey cluster. ||
|| [ListHosts](listHosts.md) | Retrieves a list of hosts for the specified cluster. ||
|| [AddHosts](addHosts.md) | Creates new hosts for a cluster. ||
|| [DeleteHosts](deleteHosts.md) | Deletes the specified hosts for a cluster. ||
|| [UpdateHosts](updateHosts.md) | Updates the specified hosts. ||
|| [GetShard](getShard.md) | Returns the specified shard. ||
|| [ListShards](listShards.md) | Retrieves a list of shards. ||
|| [AddShard](addShard.md) | Creates a new shard. ||
|| [DeleteShard](deleteShard.md) | Deletes the specified shard. ||
|| [Rebalance](rebalance.md) | Rebalances the cluster. Evenly distributes all the hash slots between the shards. ||
|| [EnableSharding](enableSharding.md) | Enable Sharding on non sharded cluster. ||
|| [ListAccessBindings](listAccessBindings.md) | Retrieves a list of access bindings for the specified Valkey cluster. ||
|| [SetAccessBindings](setAccessBindings.md) | Sets access bindings for the specified Valkey cluster. ||
|| [UpdateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified Valkey cluster. ||
|#