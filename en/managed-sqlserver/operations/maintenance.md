# Database maintenance

You can [clear the procedure (plan) cache](#free-proc-cache) in a database and [rebuild indexes or update their statistics](#indexes).

## Clearing the procedure (plan) cache {#free-proc-cache}

To clear the procedure (plan) cache in a database:

1. [Connect](connect.md) to the desired database using an account that has the `DB_OWNER` role.
2. Run the query:

   ```sql
   EXECUTE msdb.dbo.mdb_freeproccache (<object ID>);
   ```

   Leave the `<object ID>` value empty to have the procedure remove all items from the cache or assign it one of the values below to point to a specific object in the cache:
   * Plan handle (plan_handle) to clear a specific plan.
   * SQL token (sql_handle) to clear a specific batch.
   * Resource pool name (pool_name) to clear all the cache entries for a specific resource pool.

   For more information on getting an object ID, see [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql#arguments).

## Index maintenance {#indexes}

To rebuild indexes or update query optimization statistics:

1. [Connect](connect.md) to the desired database using an account that has the `DB_OWNER` role.
2. Run the query:

   ```sql
   EXECUTE msdb.dbo.IndexOptimize <parameters>;
   ```

   For more information about procedure parameters, see the [documentation](https://ola.hallengren.com/sql-server-index-and-statistics-maintenance.html).

   Example query to rebuild all the fragmented indexes and to update statistics in all user databases:

   ```sql
   EXECUTE msdb.dbo.IndexOptimize
   @Databases = 'USER_DATABASES',
   @FragmentationLow = NULL,
   @FragmentationMedium = 'INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
   @FragmentationHigh = 'INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE',
   @FragmentationLevel1 = 5,
   @FragmentationLevel2 = 30,
   @UpdateStatistics = 'ALL',
   @OnlyModifiedStatistics = 'Y';
   ```

