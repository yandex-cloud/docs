# Users and roles in {{ mmg-name }}

The data in {{ mmg-name }} is handled on behalf of the cluster users. To differentiate user access rights, the [role model](https://docs.mongodb.com/manual/core/authorization/) is used. To assign specific access rights for the database to a user, you will need to [grant them](../operations/cluster-users.md) an appropriate role in this database.

## Database user roles {#db-user-roles}

These are regular roles available to any user database.

### read {#read}

Users with the `read` role have the read access to all non-system collections in the database and to the [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js) collection. You can read more about this role in the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/built-in-roles/#read).

### readWrite {#readWrite}

Users with the `readWrite` role have the write and read access to all non-system collections in the database and to the [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js) collection. You can read more about this role in the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/built-in-roles/#readWrite).


### mdbDbAdmin {#mdbDbAdmin}

Database administrator role. Grants the user the [readWrite](#readWrite) role permissions, as well as the permissions required for database administration:


  * [collMod](https://docs.mongodb.com/manual/reference/privilege-actions/#collMod)
  * [planCacheWrite](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheWrite)
  * [planCacheRead](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheRead)
  * planCacheIndexFilter (which allows you to use the [planCacheListFilters](https://docs.mongodb.com/manual/reference/command/planCacheListFilters/index.html), [planCacheClearFilters](https://docs.mongodb.com/manual/reference/command/planCacheClearFilters/index.html), and [planCacheSetFilter](https://docs.mongodb.com/manual/reference/command/planCacheSetFilter/index.html) commands)
  * [bypassDocumentValidation](https://docs.mongodb.com/manual/reference/privilege-actions/#bypassDocumentValidation)

## Cluster administrator roles {#cluster-admin-roles}

These roles are required for cluster monitoring and administration. They are assigned for the privileged MongoDB [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database) database.

### mdbMonitor {#mdbMonitor}

This role is required for collecting statistics and monitoring. It grants the following permissions to the user:

* Working with the cluster:

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

* Working with all databases in the cluster:

  * [collStats](https://docs.mongodb.com/manual/reference/privilege-actions/#collStats)
  * [dbStats](https://docs.mongodb.com/manual/reference/privilege-actions/#dbStats)
  * [getShardVersion](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardVersion)
  * [indexStats](https://docs.mongodb.com/manual/reference/privilege-actions/#indexStats)
  * [useUUID](https://docs.mongodb.com/manual/reference/privilege-actions/#useUUID)

* Working with all [system.profile](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.profile) collections in all databases:

  * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)

* Working with the [system.indexes](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.indexes), [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js), and [system.namespaces](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.namespaces) collections of the [local](https://docs.mongodb.com/manual/reference/local-database/) and [config](https://docs.mongodb.com/manual/reference/config-database/) databases:

  * [collStats](https://docs.mongodb.com/manual/reference/privilege-actions/#collStats)
  * [dbHash](https://docs.mongodb.com/manual/reference/privilege-actions/#dbHash)
  * [dbStats](https://docs.mongodb.com/manual/reference/privilege-actions/#dbStats)
  * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)
  * [killCursors](https://docs.mongodb.com/manual/reference/privilege-actions/#killCursors)
  * [listCollections](https://docs.mongodb.com/manual/reference/privilege-actions/#listCollections)
  * [listIndexes](https://docs.mongodb.com/manual/reference/privilege-actions/#listIndexes)
  * [planCacheRead](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheRead)

### mdbShardingManager {#mdbShardingManager}

This role is used for managing cluster sharding. It grants the following permissions to the user:

* Working with the [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database) database:

  * [viewRole](https://docs.mongodb.com/manual/reference/privilege-actions/#viewRole)

* Working with any resource in the cluster:

  * [enableSharding](https://docs.mongodb.com/manual/reference/privilege-actions/#enableSharding)
  * [flushRouterConfig](https://docs.mongodb.com/manual/reference/privilege-actions/#flushRouterConfig)
  * [getShardVersion](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardVersion)
  * [getShardMap](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardMap)
  * [shardingState](https://docs.mongodb.com/manual/reference/privilege-actions/#shardingState)
  * [moveChunk](https://docs.mongodb.com/manual/reference/privilege-actions/#moveChunk)
  * [splitChunk](https://docs.mongodb.com/manual/reference/privilege-actions/#splitChunk)
  * [splitVector](https://docs.mongodb.com/manual/reference/privilege-actions/#splitVector)

* Working with the [config](https://docs.mongodb.com/manual/reference/config-database/) database:

  * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)
