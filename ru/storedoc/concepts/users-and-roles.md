# Пользователи и роли в {{ mmg-name }}

Работа с данными в {{ mmg-name }} происходит от имени пользователей кластера. Для разграничения прав доступа пользователей используется ролевая модель. Чтобы предоставить пользователю тот или иной тип доступа к базе данных, [выдайте ему](../operations/cluster-users.md) подходящую роль в этой базе.

## Роли пользователей баз данных {#db-user-roles}

Стандартные роли, доступные для любой пользовательской базы данных.

### read {#read}

Пользователи с ролью `read` имеют доступ на чтение ко всем несистемным коллекциям базы данных, а также к коллекции `system.js`. 

### readWrite {#readWrite}

Пользователи с ролью `readWrite` имеют доступ на чтение и запись ко всем несистемным коллекциям базы данных, а также к коллекции `system.js`. 

### mdbDbAdmin {#mdbDbAdmin}

Роль администратора базы данных. Предоставляет права роли [readWrite](#readWrite), а также права, необходимые для администрирования базы данных:

  * `collMod`
  * `planCacheWrite`
  * `planCacheRead`
  * planCacheIndexFilter — позволяет использовать команды `planCacheListFilters`, `planCacheClearFilters` и `planCacheSetFilter`.
  * `bypassDocumentValidation`

## Роли администраторов кластера {#cluster-admin-roles}

Роли, необходимые для мониторинга и администрирования кластера. Назначаются для служебной базы данных `admin`.

### mdbMonitor {#mdbMonitor}

Роль для сбора статистики и мониторинга. Предоставляет пользователю следующие права:

* Действия над кластером в целом:

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

* Действия над всеми базами в кластере:

  * `collStats`
  * `dbStats`
  * `getShardVersion`
  * `indexStats`
  * `useUUID`

* Действия со всеми коллекциями `system.profile` во всех базах:

  * `find`

* Действия с коллекциями `system.indexes`, `system.js`, `system.namespaces` баз данных `local` и `config`:

  * `collStats`
  * `dbHash`
  * `dbStats`
  * `find`
  * `killCursors`
  * `listCollections`
  * `listIndexes`
  * `planCacheRead`

### mdbShardingManager {#mdbShardingManager}

Роль для управления шардированием кластера. Предоставляет пользователю следующие права:

* Действия с базой данных `admin`:

  * `viewRole`

* Действия с любым ресурсом кластера:

  * `enableSharding`
  * `flushRouterConfig`
  * `getShardVersion`
  * `getShardMap`
  * `shardingState`
  * `moveChunk`
  * `splitChunk`
  * `splitVector`

* Действия с базой данных `config`:

  * `find`
