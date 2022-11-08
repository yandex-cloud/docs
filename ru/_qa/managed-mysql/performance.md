# Проблемы с производительностью

#### Как выяснить причину снижения производительности в пиках нагрузки? {#degradation-at-peak}

Просмотрите лог медленных запросов:
1. В [настройках кластера {{ MY }}](../../managed-mysql/operations/update.md#change-mysql-config) установите значение **Long query time** больше нуля.
1. В [консоли управления]({{ link-console-main }}) на странице кластера выберите вкладку **Логи**.
1. В левом верхнем углу выберите из выпадающего списка `MYSQL_SLOW_QUERY`.

#### Как выяснить причину общего снижения производительности? {#general-degradation}

Проверьте графики мониторинга хостов:
1. Перейдите на страницу каталога и выберите сервис **{{ mmy-short-name }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
1. Перейдите на страницу **Мониторинги**:
   * Рекомендуется увеличить класс хостов:
      * При стабильно высоком значении `Steal` графика **CPU usage**.
      * При стабильно низком значении `Free` графика **Memory usage**.
   * При высоком значении `iowait` графика **CPU usage** возможно превышение лимитов IOPS дискового хранилища. Рекомендуется увеличить значение как минимум до следующего порога [блока размещения](../../compute/concepts/limits.md#compute-limits-disks) или использовать более быстрые диски. Подробнее о лимитах и производительности дисков см. в [документации {{ compute-full-name }}](../../compute/concepts/disk.md).

{% include [qa-replica-lagging](../../_includes/mdb/mmy/qa-replica-lagging.md) %}

#### Как выяснить причину долгой загрузки ресурсов? {#long-load}

Проверьте графики мониторинга хостов:
1. Перейдите на страницу каталога и выберите сервис **{{ mmy-short-name }}**.
1. Нажмите на имя нужного кластера, затем выберите вкладку **Хосты**.
1. Перейдите на страницу **Мониторинги**.
1. Найдите проблемный ресурс: график будет приближаться к границе или выйдет за нее.
1. Выберите другие хосты из выпадающего списка и проверьте их тоже.

Если по графикам ресурсы кластера не перегружены, воспользуйтесь рекомендациями из разделов [Причины блокировок](#locks) и [Оптимизация запросов](#query-optimization).

#### Как выяснить причину утилизации ресурса CPU? {#high-cpu}

Информацию о потреблении ресурса CPU можно получить с помощью системных представлений. Для доступа к ним потребуется [административная привилегия](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) `PROCESS` уровня кластера.

1. Выдайте пользователю привилегию `PROCESS`, выполнив команду [CLI](../../cli/):

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <имя пользователя> \
       --cluster-id <идентификатор кластера>
   ```

1. Получите список запросов в базу с наибольшим временем выполнения с помощью запроса:

   ```sql
   SELECT * FROM sys.statement_analysis LIMIT 10;
   ```

Обратите внимание на запросы с высокими значениями `rows_examined`, `rows_sorted` или флагом `full_scan` — с большой вероятностью именно они потребляют ресурсы CPU. Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/mysql-em-plugin/en/myoem-metric-sysschema-statementanalysis-category.html).

#### Как выяснить причину утилизации ресурса IO? {#high-io}

Приблизительную информацию о потреблении ресурса IO потоками в {{ MY }} можно получить с помощью системных представлений. Для доступа к ним потребуется [административная привилегия](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) `PROCESS` уровня кластера.

1. Выдайте пользователю привилегию `PROCESS`, выполнив команду [CLI](../../cli/):

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <имя пользователя> \
       --cluster-id <идентификатор кластера>
   ```

1. Получите список потоков с помощью запроса:

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
   ORDER BY io.bytes DESC;
   ```

Как правило, выше в таблице находятся потоки, обслуживающие буферный пул и репликацию. Такое состояние является нормой.

#### Как выяснить причину утилизации ресурса сети? {#high-network}

Повышенную нагрузку на сеть могут вызывать: `SELECT`, возвращающий большое число записей, `INSERT` больших объемов данных или `UPDATE`, изменяющий множество строк. В случае записи изменения будут реплицироваться на хосты-реплики, что вызовет дополнительный трафик.

Приблизительную информацию о потреблении ресурса сети потоками в {{ MY }} можно получить с помощью системных представлений. Для доступа к ним потребуется [административная привилегия](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) `PROCESS` уровня кластера.

1. Выдайте пользователю привилегию `PROCESS`, выполнив команду [CLI](../../cli/):

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <имя пользователя> \
       --cluster-id <идентификатор кластера>
   ```

1. Получите список потоков с помощью запроса:

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
   ORDER BY net.bytes DESC;
   ```

   Этот запрос возвращает статистику с момента запуска потоков, поэтому долгоживущие соединения (например, репликация) будут в нем выше.

#### Как выяснить причины блокировок? {#locks}

Если ресурсы кластера не перегружены, но запросы все равно выполняются долго, запросите информацию об ожиданиях блокировок с помощью системных представлений. Для доступа к ним потребуется [административная привилегия](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) `PROCESS` уровня кластера.

1. Выдайте пользователю привилегию `PROCESS`, выполнив команду [CLI](../../cli/):

   ```bash
   {{ yc-mdb-my }} user update \
       --global-permissions PROCESS <имя пользователя> \
       --cluster-id <идентификатор кластера>
   ```

1. Для просмотра блокировок уровня таблиц выполните запрос:

   ```sql
   SELECT * FROM sys.schema_table_lock_waits
   ```

1. Для просмотра блокировок уровня отдельных строк выполните запрос:

   ```sql
   SELECT * FROM sys.innodb_lock_waits
   ```

Подробнее см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/sys-schema-table-lock-waits.html).

#### Как оптимизировать проблемные запросы? {#query-optimization}

Обратитесь к официальной документации {{ MY }}:

* [Использование операции `EXPLAIN`](https://dev.mysql.com/doc/refman/5.7/en/using-explain.html).
* [Оптимизация запросов](https://dev.mysql.com/doc/refman/5.7/en/statement-optimization.html).
* [Оптимизация таблиц](https://dev.mysql.com/doc/refman/5.7/en/optimizing-innodb.html).
