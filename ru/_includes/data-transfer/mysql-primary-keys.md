1. Чтобы получить список таблиц без первичного ключа, выполните запрос:

    ```sql
    SELECT
        tab.table_schema AS database_name,
        tab.table_name AS table_name,
        tab.table_rows AS table_rows
    FROM information_schema.tables tab
        LEFT JOIN information_schema.table_constraints tco
            ON (tab.table_schema = tco.table_schema
                AND tab.table_name = tco.table_name
                AND tco.constraint_type = 'PRIMARY KEY')
    WHERE
        tab.table_schema NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys')
        AND tco.constraint_type IS NULL
        AND tab.table_type = 'BASE TABLE';
    ```

1. Изучите структуру таблиц без первичного ключа, которые необходимо перенести на приемник:

    ```sql
    SHOW CREATE TABLE <имя базы>.<имя таблицы>;
    ```

1. Добавьте простой или составной первичный ключ к таблицам, которые необходимо перенести на приемник:

    ```sql
    ALTER TABLE <имя таблицы> ADD PRIMARY KEY (<столбец или группа столбцов>);
    ```

1. Если в переносимой на приемник таблице нет столбца или группы столбцов, подходящих на роль первичного ключа, создайте новый столбец:

    ```sql
    ALTER TABLE <имя таблицы> ADD id BIGINT PRIMARY KEY AUTO_INCREMENT;
    ```
