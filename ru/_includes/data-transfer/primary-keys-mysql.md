Для типов трансфера _{{ dt-type-repl }}_ и _{{ dt-type-copy-repl }}_ таблицы без уникальных индексов не переносятся. 

Если в таблице, содержащей строку, есть первичный ключ, то при изменении строки в бинарный лог записываются только столбцы первичного ключа. Если первичного ключа нет, но есть уникальный индекс, все столбцы которого не равны `NULL`, то в бинарный лог записываются только эти столбцы. Если нет ни первичного ключа, ни уникального индекса без `NULL`, то в бинарный лог записываются все столбцы в строке.

Чтобы сохранить работоспособность трансфера при переносе базы, содержащей таблицы без уникальных индексов:

* Не переносите такие таблицы. Для этого добавьте их в список исключенных таблиц в [настройках эндпоинта для источника](../../data-transfer/operations/endpoint/source/mysql.md#additional-settings).

* Создайте уникальные индексы, например первичные ключи (`PRIMARY KEY`), в тех мигрируемых таблицах, где их нет.

    1. Чтобы получить список таблиц без первичного ключа, выполните запрос:

        ```sql
        SELECT
            tab.table_schema AS database_name,
            tab.table_name AS table_name,
            tab.table_rows AS table_rows,
            tco.*
        FROM information_schema.tables tab
            LEFT JOIN information_schema.table_constraints tco
                ON (tab.table_schema = tco.table_schema
                    AND tab.table_name = tco.table_name
        )
        WHERE
            tab.table_schema NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
            AND tco.constraint_type IS NULL
            AND tab.table_type = 'BASE TABLE';
        ```

    1. Изучите структуру таблиц без первичного ключа, которые необходимо перенести на приемник:

        ```sql
        SHOW CREATE TABLE <имя_базы>.<имя_таблицы>;
        ```

    1. Добавьте простой или составной первичный ключ к таблицам, которые необходимо перенести на приемник:

        ```sql
        ALTER TABLE <имя_таблицы> ADD PRIMARY KEY (<столбец_или_группа_столбцов>);
        ```

    1. Если в переносимой на приемник таблице нет столбца или группы столбцов, подходящих на роль первичного ключа, создайте новый столбец:

        ```sql
        ALTER TABLE <имя_таблицы> ADD id BIGINT PRIMARY KEY AUTO_INCREMENT;
        ```
