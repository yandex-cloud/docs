---
sourcePath: en/ydb/overlay/operations/_includes/rename.md
---
# Renaming a table

{{ ydb-short-name }} lets you rename an existing table, move it to another directory of the same database, or replace one table with another, deleting the data in the replaced table. Only the metadata of the table is changed by operations (for example, its path and name). The table data is neither moved nor overwritten.

Operations are performed in isolation, the external process sees only two states of the table: before and after the operation. This is critical, for example, for table replacement: the data of the replaced table is deleted by the same transaction that renames the replacing table. During the replacement, there might be errors in queries to the replaced table that have [retryable statuses](../../reference/ydb-sdk/error_handling.md#termination-statuses).

To rename multiple tables, use the relevant SDK methods or the command [rename](../../reference/ydb-cli/commands/tools/rename.md) from the {{ ydb-short-name }} CLI. All actions defined within a given rename operation will be executed in a single transaction.

The speed of renaming is determined by the type of data transactions currently running against the table and doesn't depend on the table size.

## Use cases {#use-cases}

The code samples are executed against the database with the following schema:

```text
db ─┐ 
    ├─ cinema ───────────┐
    ├─ logs ─────────────┐
    |                    ├─ blank_logs
    |                    └─ current_logs
    ├─ new-project ──────┐
    |                    ├─ main_table
    |                    ├─ second_table
    |                    └─ third_table
    ├─ pre-prod-project ─┐
    |                    ├─ main_table
    |                    └─ other_table
    └─ prod-project ─────┐
                         ├─ main_table
                         └─ other_table
```

### Rename tables {#change-the-name}

{% list tabs %}

- CLI

  To rename the tables `main_table`, `second_table`, and `third_table`, in `episodes`, `seasons`, and `series`, respectively, run the commands:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=new-project/main_table,destination=new-project/episodes
  
  {{ ydb-cli }} tools rename \
    --item source=new-project/second_table,destination=new-project/seasons
  
  {{ ydb-cli }} tools rename \
    --item source=new-project/third_table,destination=new-project/series
  ```

  Tables will be renamed sequentially in different transactions. To rename tables in a single transaction, run the command:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=new-project/main_table,destination=new-project/episodes \
    --item source=new-project/second_table,destination=new-project/seasons \
    --item source=new-project/third_table,destination=new-project/series
  ```

  All tables will be renamed in one transaction. The external process will see only two states: before and after the renaming.

- YQL

  To rename the tables `main_table`, `second_table`, and `third_table`, in `episodes`, `seasons`, and `series`, respectively, run the query:

  ```sql
  ALTER TABLE `new-project/main_table` RENAME TO `new-project/episodes`;
  ALTER TABLE `new-project/second_table` RENAME TO `new-project/seasons`;
  ALTER TABLE `new-project/third_table` RENAME TO `new-project/series`;
  ```

  For each statement, the query will be executed in the autocommit mode: each table will be renamed in a separate transaction. From the external process viewpoint, the tables will be renamed sequentially one by one.

  To rename multiple tables within a single transaction, use the method invocations that ensure transactional execution, for example, the command [rename](../../reference/ydb-cli/commands/tools/rename.md) from the {{ ydb-short-name }} CLI.

{% endlist %}

### Move table {#move}

{% list tabs %}

- CLI

  To rename tables and move them to the `cinema` directory, run the commands:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=new-project/main_table,destination=cinema/episodes
  
  {{ ydb-cli }} tools rename \
    --item source=new-project/second_table,destination=cinema/seasons
  
  {{ ydb-cli }} tools rename \
    --item source=new-project/third_table,destination=cinema/series
  ```

  Tables will be renamed and moved sequentially in different transactions. To rename and move multiple tables in a single transaction, run the command:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=new-project/main_table,destination=cinema/episodes \
    --item source=new-project/second_table,destination=cinema/seasons \
    --item source=new-project/third_table,destination=cinema/series
  ```

  All tables will be renamed and moved in one transaction. The external process will see only two states: before and after all the tables have been renamed and moved.

- YQL

  To rename tables and move them to the `cinema` directory, run the query:

  ```sql
  ALTER TABLE `new-project/main_table` RENAME TO `cinema/episodes`;
  ALTER TABLE `new-project/second_table` RENAME TO `cinema/seasons`;
  ALTER TABLE `new-project/third_table` RENAME TO `cinema/series`;
  ```

  For each statement, the query will be executed in the autocommit mode: each table will be renamed and moved in a separate transaction. From the external process viewpoint, the tables will be renamed and moved sequentially one by one.

  To rename and move multiple tables in a transaction, use the method invocations that ensure transactional execution, for example, the command [rename](../../reference/ydb-cli/commands/tools/rename.md) from the {{ ydb-short-name }} CLI.

{% endlist %}

### Replacing a table {#replace}

Replacement is worthwhile if it's easier to prepare a new table with relevant data than to delete irrelevant data from the existing table.

{% note warning %}

During replacement, {{ ydb-short-name }} doesn't check for schema identity between the replaced and replacing tables.

Your queries to the replaced table will be recompiled after the replacement is complete. Queries can't be executed if the schema of the replaced table is incompatible with the replacing table schema.

{% endnote %}

{% list tabs %}

- CLI

  To replace a table, run the command:

  ```bash
  {{ ydb-cli }} tools rename \
    --item replace=True,Source=pre-prod-project/main_table,destination=prod-project/main_table
  ```

  To replace a table, specify the `replace=True` parameter.

  If you need to leave the replaced table as a backup data copy, run the command:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=prod-project/main_table,destination=prod-project/main_table.backup \
    --item source=pre-prod-project/main_table,destination=prod-project/main_table 
  ```

  The `replace=True` parameter isn't used because no table is being deleted. Operations are performed in the order of `--item` arguments in the command: first `prod-project/main_table` is moved to `prod-project/main_table.backup`, then `pre-prod-project/main_table` is renamed to `prod-project/main_table`. All operations are performed in one transaction.

  To replace multiple tables, run the command:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=prod-project/main_table,destination=prod-project/main_table.backup \
    --item source=pre-prod-project/main_table,destination=prod-project/main_table \
    --item source=prod-project/other_table,destination=prod-project/other_table.backup \
    --item source=pre-prod-project/other_table,destination=prod-project/other_table 
  ```

- YQL

  To replace a table, run the query:

  ```sql
  DROP TABLE `prod-project/main_table`;
  ALTER TABLE `pre-prod-project/main_table` RENAME TO `prod-project/main_table`;
  ```

  For each statement, the query will be executed in the autocommit mode: the replaced table is deleted first, and then the replacing table is moved and renamed. From the point of view of an external process, the table is first deleted and then re-created.

  To replace a table in a single transaction, use method invocations that ensure transactional execution, for example, the command [rename](../../reference/ydb-cli/commands/tools/rename.md) from the {{ ydb-short-name }} CLI.

{% endlist %}

### Rotate tables outside the user application {#rotation}

The user application saves data to the `logs/current_logs` table. Make sure to rotate the data in this table. Implement rotation using the tools external to the application.

Before rotating, prepare an empty `logs/blank_logs` table with a schema identical to the `logs/current_logs` table schema.

{% list tabs %}

- CLI

  To rotate the data, run the command:

  ```bash
  {{ ydb-cli }} tools rename \
    --item source=logs/current_logs,destination=logs/old_logs \
    --item source=logs/blank_logs,destination=logs/current_logs 
  ```

{% endlist %}

The data that was available in the `logs/current_logs` table before the operation, are now in `logs/old_logs`. The `logs/current_logs` table is empty because the `logs/blank` table was moved to this path. To repeat the rotation, re-create the `logs/blank` table.

