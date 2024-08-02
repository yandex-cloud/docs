# Изменение настроек {{ CH }} на уровне сервера

Вы можете задать [настройки {{ CH }} на уровне сервера](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings), чтобы настроить поведение баз данных или отдельных таблиц в кластере {{ mch-name }}. Указать настройки можно несколькими способами:

  * С помощью [интерфейсов {{ yandex-cloud }}](#yandex-cloud-interfaces). Так можно задать только настройки {{ CH }}, доступные в {{ yandex-cloud }}.
  * С помощью [SQL-запросов](#sql-queries). Так задаются настройки для таблиц MergeTree. Вы можете:

    * задать настройки при [создании таблицы](#set-settings-for-new-table);
    * [задать настройки](#change-settings-of-existing-table) существующей таблицы;
    * [вернуть значения по умолчанию](#reset-table-settings) для настроек существующей таблицы.

## Задать настройки {{ CH }} через интерфейсы {{ yandex-cloud }} {#yandex-cloud-interfaces}

Изменение некоторых [настроек сервера](../concepts/settings-list.md#server-level-settings) приводит к перезапуску серверов {{ CH }} на хостах кластера.

{% note info %}

Значение настройки [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) нельзя изменять напрямую. {{ mch-name }} выставляет для нее значение автоматически в зависимости от объема оперативной памяти хостов {{ CH }}. Чтобы изменить значение настройки, [измените класс хостов {{ CH }}](#change-resource-preset). Подробнее см. в разделе [Управление памятью](../concepts/memory-management.md).

{% endnote %}

{% include [change-clickhouse-settings](../../_includes/mdb/mch/change-clickhouse-settings.md) %}

## Проверить настройки таблицы MergeTree {#check-current-settings}

   {% list tabs group=instructions %}

   * SQL {#sql}

      1. [Подключитесь](connect/clients.md) к базе данных в кластере.
      1. Чтобы посмотреть все настройки, заданные на уровне таблицы, выполните запрос:

         ```sql
         SHOW CREATE TABLE <название_таблицы>;
         ```

         {% note warning %}

         Выдача `SHOW CREATE TABLE` содержит только переопределенные пользователем настройки. Если заданное пользователем значение настройки совпадает со значением по умолчанию, эта настройка тоже отображается в выдаче.

         {% endnote %}

   {% endlist %}

## Задать настройки таблиц MergeTree с помощью SQL-запросов {#sql-queries}

### Изменить настройки при создании таблицы MergeTree {#set-settings-for-new-table}

   {% list tabs group=instructions %}

   * SQL {#sql}

      1. [Подключитесь](connect/clients.md) к базе данных в кластере.
      1. Создайте таблицу. Чтобы задать ее настройки, перечислите их через запятую в параметре `SETTINGS`:

         ```sql
         CREATE TABLE <название_таблицы>
            (
            <описание_колонок_таблицы>
            )
            ENGINE = MergeTree
            PRIMARY KEY (<столбец_или_группа_столбцов>)
            SETTINGS
            <название_настройки> = <значение_настройки>,
            <название_настройки> = <значение_настройки>;
         ```

         Пример запроса для настроек [merge_with_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_ttl_timeout) и [merge_with_recompression_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout):

         ```sql
         CREATE TABLE <имя_таблицы>
            (
            user_id UInt32,
            message String,
            )
            ENGINE = MergeTree
            PRIMARY KEY (user_id)
            SETTINGS merge_with_ttl_timeout = 15000,
            merge_with_recompression_ttl_timeout = 15000;
         ```

      Подробнее о создании таблиц MergeTree см. в [документации {{ CH }}](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-creating-a-table).

   {% endlist %}

### Изменить настройки существующей таблицы MergeTree {#change-settings-of-existing-table}

   {% list tabs group=instructions %}

   * SQL {#sql}

      1. [Подключитесь](connect/clients.md) к базе данных в кластере.
      1. Чтобы изменить настройки для существующей таблицы, выполните запрос:

         ```sql
         ALTER TABLE <имя_таблицы> MODIFY SETTING <название_настройки> = <новое_значение_настройки>;
         ```
         Вы можете изменить несколько настроек в одном запросе. Для этого перечислите пары `<название_настройки> = <новое_значение_настройки>` через запятую.

   {% endlist %}

### Вернуть настройку таблицы MergeTree к значению по умолчанию {#reset-table-settings}

   {% list tabs group=instructions %}

   * SQL {#sql}

      1. [Подключитесь](connect/clients.md) к базе данных в кластере.
      1. Чтобы вернуть настройку существующей таблицы к значению по умолчанию, выполните запрос:

         ```sql
         ALTER TABLE <имя_таблицы> RESET SETTING <название_настройки>;
         ```
         Вы можете вернуть к значениям по умолчанию несколько настроек в одном запросе. Для этого перечислите названия настроек через запятую.

   {% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
