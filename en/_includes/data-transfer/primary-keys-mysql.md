For _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers, tables without unique indexes are not transferred. 

If a table containing a row has a primary key, only the primary key columns get written to the binary log when the row is modified. If there is no primary key but there is a unique index where all columns are not `NULL`, only these columns get written to the binary log. If there is no primary key or unique index without `NULL` columns, all columns in the row get written to the binary log.

To make sure the transfer works correctly if the database you need to migrate contains tables with no unique indexes:

* Do not transfer such tables. You can add them to the list of excluded tables in [source endpoint settings](../../data-transfer/operations/endpoint/source/mysql.md#additional-settings).

* Create unique indexes, e.g., primary keys (`PRIMARY KEY`), in the tables which do not have them.

    1. To get a list of tables without a primary key, run the query:

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

    1. Study the structure of tables without a primary key that need to be transferred to the target:

        ```sql
        SHOW CREATE TABLE <database_name>.<table_name>;
        ```

    1. Add a simple or complex primary key to the tables that need to be transferred to the target:

        ```sql
        ALTER TABLE <table_name> ADD PRIMARY KEY (<column_or_group_of_columns>);
        ```

    1. If the table being transferred to the target has no column or group of columns suitable for the role of the primary key, create a new column:

        ```sql
        ALTER TABLE <table_name> ADD id BIGINT PRIMARY KEY AUTO_INCREMENT;
        ```
