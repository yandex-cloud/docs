# Database maintenance

You can [clear the procedure (plan) cache](#free-proc-cache) in a database and [rebuild indexes or update their statistics](#indexes).

## Clearing the procedure (plan) cache {#free-proc-cache}

To clear the procedure (plan) cache in a database:

1. [Connect](connect.md) to the desired database using an account with the `DB_OWNER` role.
1. Run the query:

   ```sql
   EXECUTE msdb.dbo.mdb_freeproccache (<object ID>);
   ```

   Leave the `<object ID>` value empty to have the procedure remove all items from the cache or assign it one of the values below to point to a specific cached object:
   * Plan handle (plan_handle) to clear a specific plan.
   * SQL token (sql_handle) to clear a specific a batch.
   * Resource pool name (pool_name) to clear all the cache entries for a specific resource pool.

   For more information about retrieving an object ID, please see the [{{ MS }} documentation]({{ ms.docs }}/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql#arguments).

## Index maintenance {#indexes}

To rebuild indexes or update query optimization statistics:

1. [Connect](connect.md) to the desired database using an account with the `DB_OWNER` role.
1. Run the query:

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

## Reading the error log {#read-errorlog}

To retrieve ERRORLOG information:

1. [Connect](connect.md) to the desired database using an account with the `DB_OWNER` role.
1. Run the query:

```sql
EXECUTE msdb.dbo.mdb_readerrorlog <parameters>;
```

Run the query without parameters to view a complete list of errors in all logs.
To find information on specific errors, use parameters in the following order:

1. Log number. To view the current log, specify `0`.
1. Log type. Use `1` to read the SQL Server error log.
1. Search criteria. Specify a string to search for messages that contain the string.
1. Additional search criteria. If both the terms are set, they have equal weights in the message search.
1. Start message filter date as `yyyy-mm-dd hh-mm-ss.msmsms`.
1. End message filter date as `yyyy-mm-dd hh-mm-ss.msmsms`.
1. Sort order. Specify `asc` for ascending or `desc` for descending sort order.

If you do not want to use a parameter, leave it blank.

An example query to view messages in the current SQL Server error log containing the word `invalid` and sorted in descending order:

```sql
EXECUTE msdb.dbo.mdb_readerrorlog 0, 1, N'invalid', N'', NULL, NULL, N'desc'
```
