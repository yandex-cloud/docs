---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Cluster/index.md
---

# Managed Service for PostgreSQL API, gRPC: ClusterService

A set of methods for managing PostgreSQL Cluster resources.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified PostgreSQL Cluster resource. ||
|| [List](list.md) | Retrieves the list of PostgreSQL Cluster resources that belong ||
|| [Create](create.md) | Creates a PostgreSQL cluster in the specified folder. ||
|| [Update](update.md) | Updates the specified PostgreSQL cluster. ||
|| [Delete](delete.md) | Deletes the specified PostgreSQL cluster. ||
|| [Start](start.md) | Start the specified PostgreSQL cluster. ||
|| [Stop](stop.md) | Stop the specified PostgreSQL cluster. ||
|| [Move](move.md) | Moves the specified PostgreSQL cluster to the specified folder. ||
|| [Backup](backup.md) | Creates a backup for the specified PostgreSQL cluster. ||
|| [Restore](restore.md) | Creates a new PostgreSQL cluster using the specified backup. ||
|| [RescheduleMaintenance](rescheduleMaintenance.md) | Reschedules planned maintenance operation. ||
|| [StartFailover](startFailover.md) | Start a manual failover on the specified PostgreSQL cluster. ||
|| [ListLogs](listLogs.md) | Retrieves logs for the specified PostgreSQL cluster. ||
|| [StreamLogs](streamLogs.md) | Same as ListLogs but using server-side streaming. Also allows for 'tail -f' semantics. ||
|| [ListOperations](listOperations.md) | Retrieves the list of Operation resources for the specified cluster. ||
|| [ListBackups](listBackups.md) | Retrieves the list of available backups for the specified PostgreSQL cluster. ||
|| [ListHosts](listHosts.md) | Retrieves a list of hosts for the specified cluster. ||
|| [AddHosts](addHosts.md) | Creates new hosts for a cluster. ||
|| [DeleteHosts](deleteHosts.md) | Deletes the specified hosts for a cluster. ||
|| [UpdateHosts](updateHosts.md) | Updates the specified hosts. ||
|#