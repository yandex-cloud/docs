# Managed Service for Greenplum® API, gRPC: ClusterService

A set of methods for managing Greenplum® clusters.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified Greenplum® cluster. ||
|| [List](list.md) | Retrieves a list of Greenplum® clusters that belong to the specified folder. ||
|| [Create](create.md) | Creates a Greenplum® cluster in the specified folder. ||
|| [Update](update.md) | Updates the specified Greenplum® cluster. ||
|| [Expand](expand.md) | Expands the specified Greenplum® cluster. ||
|| [Delete](delete.md) | Deletes the specified Greenplum® cluster. ||
|| [Start](start.md) | Starts the specified Greenplum® cluster. ||
|| [Stop](stop.md) | Stops the specified Greenplum® cluster. ||
|| [Move](move.md) | Moves the specified Greenplum® cluster to the specified folder. ||
|| [RescheduleMaintenance](rescheduleMaintenance.md) | Reschedule planned maintenance operation. ||
|| [ListOperations](listOperations.md) | Retrieves the list of Operation resources for the specified cluster. ||
|| [ListMasterHosts](listMasterHosts.md) | Retrieves a list of master hosts for the specified cluster. ||
|| [ListSegmentHosts](listSegmentHosts.md) | Retrieves a list of segment hosts for the specified cluster. ||
|| [ListLogs](listLogs.md) | Retrieves logs for the specified Greenplum® cluster. ||
|| [StreamLogs](streamLogs.md) | Same as [ListLogs](#ListLogs) but using server-side streaming. Also allows for `tail -f` semantics. ||
|| [ListBackups](listBackups.md) | Retrieves a list of available backups for the specified Greenplum® cluster. ||
|| [Backup](backup.md) | Creates a backup for the specified Greenplum cluster. ||
|| [Restore](restore.md) | Creates a new Greenplum® cluster using the specified backup. ||
|| [ListAccessBindings](listAccessBindings.md) | Retrieves a list of access bindings for the specified Greenplum® cluster. ||
|| [SetAccessBindings](setAccessBindings.md) | Sets access bindings for the specified Greenplum® cluster. ||
|| [UpdateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified Greenplum® cluster. ||
|#