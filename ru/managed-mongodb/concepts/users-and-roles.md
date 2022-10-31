# Пользователи и роли в {{ mmg-name }}

Работа с данными в {{ mmg-name }} происходит от имени пользователей кластера. Для разграничения прав доступа пользователей используется [ролевая модель](https://docs.mongodb.com/manual/core/authorization/). Чтобы предоставить пользователю тот или иной тип доступа к базе данных, [выдайте ему](../operations/cluster-users.md) подходящую роль в этой базе.

## Роли пользователей баз данных {#db-user-roles}

Стандартные роли, доступные для любой пользовательской базы данных.

### read {#read}

Пользователи с ролью `read` имеют доступ на чтение ко всем несистемным коллекциям базы данных, а также к коллекции [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js). Подробнее о роли читайте в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/built-in-roles/#read).

### readWrite {#readWrite}

Пользователи с ролью `readWrite` имеют доступ на чтение и запись ко всем несистемным коллекциям базы данных, а также к коллекции [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js). Подробнее о роли читайте в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/built-in-roles/#readWrite).

### mdbDbAdmin {#mdbDbAdmin}

Роль администратора базы данных. Предоставляет все права роли [readWrite](#readWrite), а также права, необходимые для администрирования базы данных:

  * [collMod](https://docs.mongodb.com/manual/reference/privilege-actions/#collMod)
  * [planCacheWrite](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheWrite)
  * [planCacheRead](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheRead)
  * planCacheIndexFilter — позволяет использовать команды [planCacheListFilters](https://docs.mongodb.com/manual/reference/command/planCacheListFilters/index.html), [planCacheClearFilters](https://docs.mongodb.com/manual/reference/command/planCacheClearFilters/index.html) и [planCacheSetFilter](https://docs.mongodb.com/manual/reference/command/planCacheSetFilter/index.html).
  * [bypassDocumentValidation](https://docs.mongodb.com/manual/reference/privilege-actions/#bypassDocumentValidation)

## Роли администраторов кластера {#cluster-admin-roles}

Роли, необходимые для мониторинга и администрирования кластера. Назначаются для служебной базы данных [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database).

### mdbMonitor {#mdbMonitor}

Роль для сбора статистики и мониторинга. Предоставляет пользователю следующие права:

* Действия над кластером в целом:

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

* Действия над всеми базами в кластере:

  * [collStats](https://docs.mongodb.com/manual/reference/privilege-actions/#collStats)
  * [dbStats](https://docs.mongodb.com/manual/reference/privilege-actions/#dbStats)
  * [getShardVersion](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardVersion)
  * [indexStats](https://docs.mongodb.com/manual/reference/privilege-actions/#indexStats)
  * [useUUID](https://docs.mongodb.com/manual/reference/privilege-actions/#useUUID)

* Действия со всеми коллекциями [system.profile](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.profile) во всех базах:

  * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)

* Действия с коллекциями [system.indexes](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.indexes), [system.js](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.js), [system.namespaces](https://docs.mongodb.com/manual/reference/system-collections/index.html#%3Cdatabase%3E.system.namespaces) баз данных [local](https://docs.mongodb.com/manual/reference/local-database/) и [config](https://docs.mongodb.com/manual/reference/config-database/):

  * [collStats](https://docs.mongodb.com/manual/reference/privilege-actions/#collStats)
  * [dbHash](https://docs.mongodb.com/manual/reference/privilege-actions/#dbHash)
  * [dbStats](https://docs.mongodb.com/manual/reference/privilege-actions/#dbStats)
  * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)
  * [killCursors](https://docs.mongodb.com/manual/reference/privilege-actions/#killCursors)
  * [listCollections](https://docs.mongodb.com/manual/reference/privilege-actions/#listCollections)
  * [listIndexes](https://docs.mongodb.com/manual/reference/privilege-actions/#listIndexes)
  * [planCacheRead](https://docs.mongodb.com/manual/reference/privilege-actions/#planCacheRead)

### mdbShardingManager {#mdbShardingManager}

Роль для управления шардированием кластера. Предоставляет пользователю следующие права:

* Действия с базой данных [admin](https://docs.mongodb.com/manual/reference/glossary/#term-admin-database):

  * [viewRole](https://docs.mongodb.com/manual/reference/privilege-actions/#viewRole)

* Действия с любым ресурсом кластера:

  * [enableSharding](https://docs.mongodb.com/manual/reference/privilege-actions/#enableSharding)
  * [flushRouterConfig](https://docs.mongodb.com/manual/reference/privilege-actions/#flushRouterConfig)
  * [getShardVersion](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardVersion)
  * [getShardMap](https://docs.mongodb.com/manual/reference/privilege-actions/#getShardMap)
  * [shardingState](https://docs.mongodb.com/manual/reference/privilege-actions/#shardingState)
  * [moveChunk](https://docs.mongodb.com/manual/reference/privilege-actions/#moveChunk)
  * [splitChunk](https://docs.mongodb.com/manual/reference/privilege-actions/#splitChunk)
  * [splitVector](https://docs.mongodb.com/manual/reference/privilege-actions/#splitVector)

* Действия с базой данных [config](https://docs.mongodb.com/manual/reference/config-database/):

  * [find](https://docs.mongodb.com/manual/reference/privilege-actions/#find)
