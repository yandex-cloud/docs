# Users and roles in {{ mmg-name }}

The data in {{ mmg-name }} is handled on behalf of the cluster users. To differentiate user access permissions, the role model is used. To grant any form of access permissions for a database, [issue](../operations/cluster-users.md) a relevant role for this database to the user.

## Database user roles {#db-user-roles}

These are regular roles available to any user database.

### read {#read}

Users with the `read` role have the read access to all non-system collections in the database and to the `system.js` collection. 

### readWrite {#readWrite}

Users with the `readWrite` role have the write and read access to all non-system collections in the database and to the `system.js` collection. 

### mdbDbAdmin {#mdbDbAdmin}

Database administrator role. Grants the user the [readWrite](#readWrite) role permissions, as well as the permissions required for database administration:

  * `collMod`
  * `planCacheWrite`
  * `planCacheRead`
  * planCacheIndexFilter allows you to use the `planCacheListFilters`, `planCacheClearFilters`, and `planCacheSetFilter` commands.
  * `bypassDocumentValidation`

## Cluster administrator roles {#cluster-admin-roles}

These roles are required for cluster monitoring and administration. They are assigned for the privileged MongoDB `admin` database.

### mdbMonitor {#mdbMonitor}

This role is required for collecting statistics and monitoring. It grants the following permissions to the user:

* Working with the cluster:

  * `connPoolStats`
  * `getLog`
  * `getParameter`
  * `getShardMap`
  * `hostInfo`
  * `inprog`
  * `listDatabases`
  * `listSessions`
  * `listShards`
  * `netstat`
  * `replSetGetConfig`
  * `replSetGetStatus`
  * `serverStatus`
  * `shardingState`
  * `top`

* Working with all databases in the cluster:

  * `collStats`
  * `dbStats`
  * `getShardVersion`
  * `indexStats`
  * `useUUID`

* Working with all `system.profile` collections in all databases:

  * `find`

* Working with the `system.indexes`, and `system.js`, `system.namespaces` collections of the `local` and `config` databases:

  * `collStats`
  * `dbHash`
  * `dbStats`
  * `find`
  * `killCursors`
  * `listCollections`
  * `listIndexes`
  * `planCacheRead`

### mdbShardingManager {#mdbShardingManager}

This role is used for managing cluster sharding. It grants the following permissions to the user:

* Working with the `admin` database:

  * `viewRole`

* Working with any resource in the cluster:

  * `enableSharding`
  * `flushRouterConfig`
  * `getShardVersion`
  * `getShardMap`
  * `shardingState`
  * `moveChunk`
  * `splitChunk`
  * `splitVector`

* Working with the `config` database:

  * `find`
