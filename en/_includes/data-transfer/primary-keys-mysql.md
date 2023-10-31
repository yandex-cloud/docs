For _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers, tables without primary keys are not transferred. To make sure the transfer is running properly when migrating a database with such tables:

* Do not transfer tables without primary keys. For this purpose, add them to the list of excluded tables in [source endpoint settings](../../data-transfer/operations/endpoint/source/mysql.md#additional-settings).

* Create `PRIMARY KEYS` in those tables to be migrated where there are no keys.

    1. To get a list of tables without a primary key, run the query:

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

    1. Study the structure of tables without a primary key that need to be transferred to the target:

        ```sql
        SHOW CREATE TABLE <database_name>.<table_name>;
        ```

    1. Add a simple or complex primary key to the tables that need to be transferred to the target:

        ```sql
        ALTER TABLE <table_name> ADD PRIMARY KEY (<column_or_column_group>);
        ```

    1. If the table being transferred to the target has no column or group of columns suitable for the role of the primary key, create a new column:

        ```sql
        ALTER TABLE <table_name> ADD id BIGINT PRIMARY KEY AUTO_INCREMENT;
        ```
