# Обслуживание баз данных

Вы можете [очистить кэш процедур (планов)](#free-proc-cache) в базе данных, а также [перестроить индексы или обновить их статистику](#indexes).

## Очистка кэша процедур (планов) {#free-proc-cache}

Чтобы очистить кэш процедур (планов) в базе данных:

1. [Подключитесь](connect.md) к нужной базе данных с помощью учетной записи с ролью `DB_OWNER`.
1. Выполните запрос:

   ```sql
   EXECUTE msdb.dbo.mdb_freeproccache (<идентификатор объекта>);
   ```
   
   Оставьте значение параметра `<идентификатор объекта>` пустым, чтобы процедура удалила все элементы из кэша, или задайте одно из следующих значений, чтобы указать на конкретный объект в кэше:
   * Дескриптор плана (plan_handle), чтобы удалить указанный план.
   * SQL-токен пакета (sql_handle), чтобы удалить указанный пакет.
   * Имя пула ресурсов (pool_name), чтобы удалить все записи кэша, связанные с указанным пулом ресурсов.

   Подробнее о том, как получить идентификатор объекта, см. в [документации {{ MS }}]{% if lang == "ru" %}(https://docs.microsoft.com/ru-ru/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql#arguments){% endif %}{% if lang == "en" %}(https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql#arguments){% endif %}.

## Обслуживание индексов {#indexes}

Чтобы перестроить индексы или обновить статистику оптимизации запросов:

1. [Подключитесь](connect.md) к нужной базе данных с помощью учетной записи с ролью `DB_OWNER`.
1. Выполните запрос:

   ```sql
   EXECUTE msdb.dbo.IndexOptimize <параметры>;
   ```

   Подробнее о параметрах процедуры см. в [документации](https://ola.hallengren.com/sql-server-index-and-statistics-maintenance.html).

   Пример запроса, выполнение которого перестроит все фрагментированные индексы и обновит статистику во всех пользовательских базах данных:

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