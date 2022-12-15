# Users and roles in {{ mmg-name }} 

The data in {{ mmg-name }} is handled on behalf of the cluster users. To differentiate user access rights, the [role model](https://docs.mongodb.com/manual/core/authorization/) is used. To assign a user specific access rights for the database, [grant them](../operations/cluster-users.md) the relevant role in this database.

## Database user roles {#db-user-roles}

Standard roles available for any user database.

### read {#read}

Users granted the `read` role have read access to all non-system database collections and the [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js) collection. Learn more about this role in the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/built-in-roles/#read).

### readWrite {#readWrite}

Users granted the `readWrite` role have read and write access to all non-system database collections and the [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js) collection. Learn more about this role in the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/built-in-roles/#readWrite).

### mdbDbAdmin {#mdbDbAdmin}

Database administrator role. Grants all [readWrite](#readWrite) role rights and the rights needed for database administration:

* [collMod](https://docs.mongodb.com/manual/reference/privilege-actions/#collMod)
* [planCacheWrite](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheWrite)
* [planCacheRead](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheRead)
* planCacheIndexFilter: Lets you use the commands [planCacheListFilters](https://docs.mongodb.com/manual/reference/command/planCacheListFilters/index.html), [planCacheClearFilters](https://docs.mongodb.com/manual/reference/command/planCacheClearFilters/index.html) and [planCacheSetFilter](https://docs.mongodb.com/manual/reference/command/planCacheSetFilter/index.html).
* [bypassDocumentValidation](https://docs.mongodb.com/manual/reference/privilege-actions/#bypassDocumentValidation)

## Cluster administrator roles {#cluster-admin-roles}

Roles needed for cluster monitoring and administration. Those roles are assigned for the privileged MongoDB [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database) database.

### mdbMonitor {#mdbMonitor}

A role for collecting statistics and monitoring. It grants the following rights to the user:

* Actions on the cluster as a whole:

   * [connPoolStats](https://docs.mongodb.com/manual/reference/privilege-actions/#connPoolStats)
   * [getLog](https://docs.mongodb.com/manual/reference/privilege-actions/#getLog)
   * [getParameter](https://docs.mongodb.com/manual/reference/privilege-actions/#getParameter)
   * [getShardMap](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardMap)
   * [hostInfo](https://docs.mongodb.com/manual/reference/privilege-actions/#hostInfo)
   * [inprog](https://docs.mongodb.com/manual/reference/privilege-actions/#inprog)
   * [listDatabases](https://docs.mongodb.com/manual/reference/privilege-actions/#listDatabases)
   * [listSessions](https://docs.mongodb.com/manual/reference/privilege-actions/#listSessions)
   * [listShards](https://docs.mongodb.com/manual/reference/privilege-actions/#listShards)
   * [netstat](https://docs.mongodb.com/manual/reference/privilege-actions/#netstat)
   * [replSetGetConfig](https://docs.mongodb.com/manual/reference/privilege-actions/#replSetGetConfig)
   * [replSetGetStatus](https://docs.mongodb.com/manual/reference/privilege-actions/#replSetGetStatus)
   * [serverStatus](https://docs.mongodb.com/manual/reference/privilege-actions/#serverStatus)
   * [shardingState](https://docs.mongodb.com/manual/reference/privilege-actions/#shardingState)
   * [top](https://docs.mongodb.com/manual/reference/privilege-actions/#top)

* Actions on all databases in a cluster:

   * [collStats](https://docs.mongodb.com/manual/reference/privilege-actions/#collStats)
   * [dbStats](https://docs.mongodb.com/manual/reference/privilege-actions/#dbStats)
   * [getShardVersion](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardVersion)
   * [indexStats](https://docs.mongodb.com/manual/reference/privilege-actions/#indexStats)
   * [useUUID](https://docs.mongodb.com/manual/reference/privilege-actions/#useUUID)

* Actions with all [system.profile](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.profile) collections in all databases:

   * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)

* Actions with the [system.indexes](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.indexes), [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js), [system.namespaces](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.namespaces) collections of the [local](https://docs.mongodb.com/manual/reference/local-database/) and [config](https://docs.mongodb.com/manual/reference/config-database/) databases:

   * [collStats](https://docs.mongodb.com/manual/reference/privilege-actions/#collStats)
   * [dbHash](https://docs.mongodb.com/manual/reference/privilege-actions/#dbHash)
   * [dbStats](https://docs.mongodb.com/manual/reference/privilege-actions/#dbStats)
   * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)
   * [killCursors](https://docs.mongodb.com/manual/reference/privilege-actions/#killCursors)
   * [listCollections](https://docs.mongodb.com/manual/reference/privilege-actions/#listCollections)
   * [listIndexes](https://docs.mongodb.com/manual/reference/privilege-actions/#listIndexes)
   * [planCacheRead](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheRead)

### mdbShardingManager {#mdbShardingManager}

A role for managing cluster sharding. It grants the following rights to the user:

* Actions with the [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database) database:

   * [viewRole](https://docs.mongodb.com/manual/reference/privilege-actions/#viewRole)

* Actions with any resource in the cluster:

   * [enableSharding](https://docs.mongodb.com/manual/reference/privilege-actions/#enableSharding)
   * [flushRouterConfig](https://docs.mongodb.com/manual/reference/privilege-actions/#flushRouterConfig)
   * [getShardVersion](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardVersion)
   * [getShardMap](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardMap)
   * [shardingState](https://docs.mongodb.com/manual/reference/privilege-actions/#shardingState)
   * [moveChunk](https://docs.mongodb.com/manual/reference/privilege-actions/#moveChunk)
   * [splitChunk](https://docs.mongodb.com/manual/reference/privilege-actions/#splitChunk)
   * [splitVector](https://docs.mongodb.com/manual/reference/privilege-actions/#splitVector)

* Actions with the [config](https://docs.mongodb.com/manual/reference/config-database/) database:

   * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)
