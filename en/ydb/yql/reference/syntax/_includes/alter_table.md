---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/alter_table.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/alter_table.md
---

# ALTER TABLE

Using the ```ALTER TABLE``` command, you can change the composition of columns and additional table parameters. You can specify several actions in one command. In general, the ```ALTER TABLE``` command looks like this:

```sql
ALTER TABLE table_name action1, action2, ..., actionN;
```

```action```: Any action to change the table described below.

## Changing the composition of columns {#columns}

{{ backend_name }} lets you add columns to a table and delete non-key columns from it.

```ADD COLUMN```: Adds a column with the specified name and type. The code below adds the ```is_deleted``` column with the ```Bool data``` type to the ```episodes``` table.

```sql
ALTER TABLE episodes ADD COLUMN is_deleted Bool;
```

```DROP COLUMN```: Deletes the column with the specified name. The code below removes the ```is_deleted``` column from the ```episodes``` table.

```sql
ALTER TABLE episodes DROP column is_deleted;
```


## Adding or removing a secondary index {#secondary-index}

```ADD INDEX```: Adds an index with the specified name and type for a given set of columns. The code below adds a global index named ```title_index``` for the ```title``` column.

```sql
ALTER TABLE `series` ADD INDEX `title_index` GLOBAL ON (`title`);
```

You can specify any index parameters from the [`CREATE TABLE`](../create_table#secondary_index) command.

Deleting an index:

```DROP INDEX```: Deletes the index with the specified name. The code below deletes the index named ```title_index```.

```sql
ALTER TABLE `series` DROP INDEX `title_index`;
```

