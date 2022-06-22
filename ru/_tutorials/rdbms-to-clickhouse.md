Из этого руководства вы узнаете, как перенести базу данных из {{ PG }} в {{ CH }} с помощью сервиса {{ data-transfer-full-name }}. Также будут рассмотрены особенности такого переноса и работы с данными на источнике и приемнике во время него. Для упрощения все нужные ресурсы будут созданы в {{ yandex-cloud }}.

Чтобы перенести базу данных из {{ PG }} в {{ CH }}:

1. [Создайте эндпоинт-источник](#create-endpoint-source).
1. [Создайте эндпоинт-приемник](#create-endpoint-target).
1. [Создайте трансфер](#create-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу репликации](#example-check-replication).
1. [Выполните выборку данных в приемнике](#working-with-data-ch).
1. [Выполните очистку удаленных данных в приемнике](#cleaning-data).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% list tabs %}

* {{ PG }}

  1. Создайте кластер-источник {{ mpg-full-name }} любой подходящей вам [конфигурации](../managed-postgresql/concepts/instance-types.md) со следующими настройками:
      * Имя базы — `db1`.
      * Имя пользователя — `user1`.
      * Пароль — `<пароль источника>`.

  1. Создайте в базе данных `db1` кластера {{ mpg-full-name }} таблицу `x_tab` и заполните ее данными:

     ```sql
     CREATE TABLE x_tab
     (
         id NUMERIC,
         name CHAR
     );
     CREATE INDEX ON x_tab (id);
     INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
     ```

  1. Создайте кластер-приемник {{ mch-full-name }} любой подходящей вам [конфигурации](../managed-clickhouse/concepts/instance-types.md) со следующими настройками:
      * Количество хостов {{ CH }} — не меньше 2 (для включения репликации в кластере).
      * Имя базы — `db1`.
      * Имя пользователя — `user1`.
      * Пароль — `<пароль приемника>`.

  1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:
     * [{{ mch-full-name }}](../managed-clickhouse/operations/connect.md#configuring-security-groups).
     * [{{ mpg-full-name }}](../managed-postgresql/operations/connect.md#configuring-security-groups).

{% endlist %}

## Создайте эндпоинт-источник {#create-endpoint-source}

{% list tabs %}

* {{ PG }}
  
  [Создайте эндпоинт-источник](../data-transfer/operations/endpoint/source/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к базе данных `db1`.

{% endlist %}

## Создайте эндпоинт-приемник {#create-endpoint-target}

[Создайте эндпоинт-приемник](../data-transfer/operations/endpoint/target/clickhouse.md) типа `{{ CH }}`.

## Создайте трансфер {#create-transfer}

[Создайте трансфер](../data-transfer/operations/transfer.md#create) типа [{{ dt-type-copy-repl }}](../data-transfer/concepts/index.md#transfer-type), использующий созданные эндпоинты.

## Активируйте трансфер {#activate-transfer}

1. [Активируйте трансфер](../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус {{ dt-status-repl }}. 
1. Чтобы проверить, что трансфер перенес данные с учетом репликации в приемнике, подключитесь к кластеру-приемнику {{ mch-full-name }} и посмотрите, что таблица `x_tab` в базе `db1` содержит те же колонки, что таблица `x_tab` в базе-источнике, а также [колонки с временными метками](#working-with-data-ch) `__data_transfer_commit_time` и `__data_transfer_delete_time`:

   ```sql
   SELECT * FROM db1.x_tab WHERE id = 41;
   ```
   
   ```text
   ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
   │ 41 │  User2 │   1633417594957267000          │ 0                             │
   └────┴────────┴────────────────────────────────┴───────────────────────────────┘
   ```

## Проверьте работу репликации {#example-check-replication}

{% list tabs %}

* {{ PG }}

  1. Подключитесь к кластеру-источнику.
  1. Удалите одну строку и измените другую в таблице `x_tab` базы-источника {{ PG }}:

     ```sql
     DELETE FROM x_tab WHERE id = 41;
     UPDATE x_tab SET name = 'Key3' WHERE id = 42;
     ```

  1. Убедитесь, что в таблице `x_tab` на приемнике {{ CH }} отобразились изменения:

     ```sql
     SELECT * FROM db1.x_tab WHERE (id >= 41) AND (id <= 42);
     ```

     ```text
     ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
     │ 41 │  User2 │   1633417594957267000          │ 1675417594957267000           │
     │ 42 │  Key3  │   1675417594957267000          │ 0                             │
     │ 42 │  User3 │   1633417594957268000          │ 1675417594957267000           │
     └────┴────────┴────────────────────────────────┴───────────────────────────────┘
     ```

{% endlist %}

## Выполните выборку данных в {{ CH }} {#working-with-data-ch}

На приемнике {{ CH }} с включенной [репликацией](../managed-clickhouse/concepts/replication.md) для воссоздания таблиц используются движки [ReplicatedReplacingMergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/replication/) и [ReplacingMergeTree](https://{{ ch-domain }}/docs/ru/engines/table-engines/mergetree-family/replacingmergetree/). В каждую таблицу автоматически добавляются колонки:

* `__data_transfer_commit_time` — время изменения строки на это значение, в формате `TIMESTAMP`;
* `__data_transfer_delete_time` — время удаления строки в формате `TIMESTAMP`, если строка удалена в источнике. Если строка не удалялась, то колонка заполняется значением `0`.

   Колонка `__data_transfer_commit_time` необходима для работы движка ReplicatedReplacedMergeTree. Если запись удаляется или изменяется, в таблицу вставляется новая строка со значением в этой колонке. Запрос по одному первичному ключу возвращает несколько записей с разными значениями в колонке `__data_transfer_commit_time`.

В статусе трансфера {{ dt-status-repl }} данные в источнике могут добавляться или удаляться. Чтобы обеспечить стандартное поведение команд SQL, когда первичный ключ указывает на единственную запись, дополните запросы к перенесенным таблицам в {{ CH }} конструкцией с фильтром по колонке `__data_transfer_delete_time`. Например, для таблицы `x_tab`:

```sql
SELECT name FROM x_tab FINAL WHERE name LIKE 'User%' AND __data_transfer_delete_time = 0;
```

{% note warning %}

Использование ключевого слова `FINAL` сильно снижает эффективность запросов. По возможности избегайте его применения при работе с большими таблицами.

{% endnote %}

## Выполните очистку удаленных данных в {{ CH }} {#cleaning-data}

Если трансфер перешел в статус {{ dt-status-repl }}, изменения данных на источнике переносятся на приемник {{ CH }} следующим образом:

* в реплицируемые таблицы будут добавлены новые строки, в колонках `__data_transfer_commit_time` и `__data_transfer_delete_time` которых будут указаны дата и время удаления или изменения этих строк в источнике;
* существующие строки с предыдущими значениями удалены не будут.

Таким образом, при изменении данных в источнике история изменений будет накапливаться в приемнике {{ CH }}, что приведет к перерасходу дискового пространства. Поэтому во время репликации периодически очищайте приемник {{ CH }} от строк, хранящих историю изменений данных в источнике:

1. Выполните запрос для удаления записей:

   ```sql
   DELETE FROM db1.x_tab WHERE id IN (
       SELECT id FROM db1.x_tab FINAL WHERE __data_transfer_delete_time != 0
   );
   ```

1. Запустите внеплановое объединение строк таблицы:

    ```sql
    OPTIMIZE TABLE db1.x_tab FINAL;
    ```

Повторите процедуру очистки после завершения трансфера.

{% note info %}

Выполнять очистку необходимо только для трансферов типа _{{ dt-type-copy-repl }}_ и _{{ dt-type-repl }}_.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

* [Деактивируйте трансфер](../data-transfer/operations/transfer.md#deactivate) и дождитесь его перехода в статус {{ dt-status-stopped }}.
* [Удалите](../data-transfer/operations/transfer.md#delete) остановленный трансфер.
* [Удалите эндпоинт-источник и эндпоинт-приемник](../data-transfer/operations/endpoint/index.md#delete).

Если кластер-источник или кластер-приемник размещены в одном из сервисов управляемых баз данных, удалите их:

* [Удалите кластер {{ mch-full-name }}](../managed-clickhouse/operations/cluster-delete.md).
* [Удалите кластер {{ mpg-full-name }}](../managed-postgresql/operations/cluster-delete.md).
