# Анализ производительности и оптимизация {{ mmy-name }}

К снижению производительности кластера {{ mmy-name }} обычно приводят следующие проблемы:

* [высокая утилизация CPU, дискового I/O и сети](#cpu-io-deficit);
* [неэффективное выполнение запросов в {{ MY }}](#inefficient-queries);
* [блокировки](#localize-locking-issues).

Инструменты [мониторинга](../../managed-mysql/operations/monitoring.md) {{ MY }} и [диагностики производительности](../../managed-mysql/operations/performance-diagnostics.md) кластера {{ mmy-name }}, а также специальные запросы {{ MY }} помогут эти проблемы обнаружить.

## Перед началом работы {#before-start}

1. Выберите базы данных для диагностики.
1. [Активируйте сбор статистики](../../managed-mysql/operations/performance-diagnostics.md).
1. Создайте [пользователя {{ MY }}](../../managed-mysql/operations/cluster-users.md#adduser) с привилегией [`PROCESS`](../../managed-mysql/operations/grant.md#db-privileges) для этих баз. Диагностические запросы необходимо выполнять от имени этого пользователя.

## Диагностика дефицита ресурсов {#cpu-io-deficit}

Дефицит ресурсов — одна из вероятных причин падения производительности кластера. Дефицит ресурсов виден по графикам [мониторинга кластера](../../managed-mysql/operations/monitoring.md) (CPU, дисковые операции I/O, сетевые соединения). Если постоянно росший график нагрузки на ресурс остановился на одном уровне, использование ресурса достигло [лимита](../../managed-mysql/concepts/limits.md) или выходит за границы гарантированного уровня обслуживания. 

Причины повышенной загрузки ресурсов можно установить специальными запросами:

- Чтобы оценить потребление Disk IO разными потоками {{ MY }}, выполните запрос:

   ```sql
   SELECT   t.name             AS thread_name,
            t.processlist_user AS user,
            t.processlist_info AS query,
            t.processlist_time AS time,
            io.bytes           AS bytes
   FROM     performance_schema.threads t
   JOIN
            (
                     SELECT   thread_id,
                              sum(number_of_bytes) AS bytes
                     FROM     performance_schema.events_waits_history_long
                     WHERE    object_type='FILE'
                     GROUP BY thread_id) io
   ON       t.thread_id = io.thread_id
   ORDER BY io.bytes DESC 
   ```
   
   Запрос возвращает список файловых потоков {{ MY }}, упорядоченных по убыванию занимаемого объема памяти. Как правило, в начале списка находятся потоки, обслуживающие репликацию и [буфер InnoDB](https://dev.mysql.com/doc/refman/8.0/en/innodb-buffer-pool.html) для кеширования таблиц и индексов.

- Чтобы оценить потребление ресурсов сети разными потоками {{ MY }}, выполните запрос:

   ```sql
   SELECT   t.name                       AS thread_name,
            t.processlist_user           AS user,
            t.processlist_info           AS query,
            t.processlist_time           AS time,
            net.bytes/t.processlist_time AS avg_bytes,
            net.bytes                    AS total_bytes
   FROM     performance_schema.threads t
   JOIN
            (
                     SELECT   thread_id,
                              Sum(variable_value) bytes
                     FROM     performance_schema.status_by_thread
                     WHERE    variable_name IN ('Bytes_sent',
                                                'Bytes_received')
                     GROUP BY thread_id ) net
   ON       t.thread_id = net.thread_id
   WHERE    t.processlist_time IS NOT NULL
   ORDER BY net.bytes DESC
   ```
   
   Этот запрос возвращает статистику с момента запуска потоков, поэтому долгоживущие соединения (например, репликация) будут возвращаться в первых строках.
   
   Следует обратить внимание на операции чтения и записи, работающие с большим числом строк. Они также могут вызывать повышенную нагрузку на сеть. В случае операций записи изменения в WAL будут переноситься на реплики и это дополнительно увеличит нагрузку на сеть.

- Отследить потребление CPU отдельными запросами в {{ MY }} невозможно, но можно выявить неэффективно выполнявшиеся запросы (см. далее). 

## Диагностика неэффективного выполнения запросов {#inefficient-queries}

Чтобы выявить проблемные запросы в {{ MY }}, выполните запрос:

```sql
SELECT *
FROM   sys.statement_analysis
LIMIT  10
```

Запрос возвращает 10 наиболее долго выполнявшихся запросов за всю историю сервера.

Следует обратить внимание на запросы с высокими значениями `ROWS_EXAMINED`, `ROWS_SORTED` или флагом `FULL_SCAN`.

Подробнее об информации в выдаче см. в [документации {{ MY }}](https://dev.mysql.com/doc/mysql-em-plugin/en/myoem-metric-sysschema-statementanalysis-category.html).

## Диагностика наличия блокировок {#localize-locking-issues}

Причиной низкой производительности кластера могут быть блокировки (locks), вызванные попытками одновременного доступа к одному и тому же ресурсу БД (таблице, строке).

Для диагностики проверьте очереди ожидания блокировок в запросах:

  - Очередь ожидания блокировок уровня таблиц:

    ```sql
    SELECT * FROM sys.schema_table_lock_waits 
    ```

  - Очередь ожидания блокировок уровня отдельных строк:

    ```sql
    SELECT * FROM sys.innodb_lock_waits
    ```

## Решение проблем {#solving} 

Найденные в результате диагностики проблемные запросы можно попробовать оптимизировать. Существует несколько способов оптимизации:

- проанализировать план запроса (query plan) с помощью [команды `EXPLAIN`](https://dev.mysql.com/doc/refman/5.7/en/using-explain.html) и воспользоваться приемами по оптимизации запросов из [документации {{ MY }}](https://dev.mysql.com/doc/refman/5.7/en/statement-optimization.html);

- [оптимизировать таблицы InnoDB](https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb.html), чтобы снизить нагрузку на диск.

Если не удается ни оптимизировать найденные проблемные запросы, ни отказаться от них, можно [поднять класс хостов](../../managed-mysql/operations/update.md#change-resource-preset).
