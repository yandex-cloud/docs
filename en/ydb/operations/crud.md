# Reading and writing data

Queries can be sent to YDB in the following ways:

* From the [management console](#web-sql).
* From an application written using the [YDB SDK](../sdk/index.md) for [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk) or [Go](https://github.com/yandex-cloud/ydb-go-sdk).
* Using the [API compatible with Amazon DynamoDB](../docapi/api-ref/index.md) (for document tables).

In this section, we are going to use the management console to execute queries.

## Prerequisites {#prerequisite}

To run queries, you'll need to create a [database](create_manage_database.md) and [table](schema.md) in it.

## SQL queries in the management console {#web-sql}

To send an SQL query to the database from the management console:

1. In the [management console](https://console.cloud.yandex.ru), select the folder with the desired DB.
1. In the list of services, select **{{ ydb-name }}**.
1. Select the database from the list.
1. Click **SQL query** and enter the query text. When making queries, you can use the following templates:
   * To use one of the standard templates, select it from the drop-down list to the right of the **SQL query** button.
   * To insert data from a specific table into the template, click ![image](../../_assets/horizontal-ellipsis.svg) in the line with the desired table and select the template.
1. Click **Run**.

## Insert and update data {#change-data}

To insert data into {{ ydb-short-name }}, use [REPLACE](../yql/reference/syntax/replace_into.md), [UPSERT](../yql/reference/syntax/upsert_into.md), and [INSERT](../yql/reference/syntax/insert_into.md) statements.

When executing REPLACE and UPSERT statements, a blind write is performed. With an INSERT statement, data is read before writing. This ensures that the primary key is unique.

We recommend using REPLACE and UPSERT statements to write and modify data.

A single REPLACE, UPSERT, or INSERT query can insert multiple rows into a table.

{% note warning %}

The YQL management console includes PRAGMA AutoCommit. This means that COMMIT is automatically executed after each query. For example, if you enter multiple statements (as shown in the example below) and execute the query, COMMIT is run automatically after the query.

```sql
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 1, "Yesterday's Jam");
REPLACE INTO episodes (series_id, season_id, episode_id, title) VALUES (1, 1, 2, "Calamity Jen");
```

{% endnote %}

### REPLACE {#replace}

Once the ```series```, ```seasons```, and ```episodes``` tables are created, you can insert data into them using [REPLACE](../yql/reference/syntax/replace_into.md). Basic syntax:

```sql
REPLACE INTO table_name (column_list) VALUES (list_of_added_values);
```

Use [REPLACE](../yql/reference/syntax/replace_into.md) statements to add a new row or change an existing row based on the specified value of the primary key. If a row with the specified primary key value does not exist, it is created. If the row already exists, the column values of the existing row are replaced with the new values. *The values of columns not involved in the operation are set to their default values.* This is what makes it different from the UPSERT statement.

{% note info %}

When performing a REPLACE operation, a blind write is performed. For write or change operations, we recommend using REPLACE and UPSERT statements.

{% endnote %}

Data added using the following code sample will be used later in this section.

{% include notitle [replace-into-3-columns](../_includes/queries/replace-into-3-columns.md) %}

### UPSERT {#upsert}

Use [UPSERT](../yql/reference/syntax/upsert_into.md) statements to add a new row or change an existing row based on the specified value of the primary key. If a row with the specified primary key value does not exist, it is created. If the row already exists, the column values of the existing row are replaced with the new values. *The values of columns not involved in the operation are not changed. This is what makes it different from the REPLACE statement.*

{% note info %}

When making an UPSERT, a blind write is performed. For writing data, we recommend using REPLACE and UPSERT statements.

{% endnote %}

The code below inserts one row of data into the ```episodes``` table.

{% include notitle [upsert-into-3-columns](../_includes/queries/upsert-into-3-columns.md) %}

### INSERT {#insert}

Use [INSERT](../yql/reference/syntax/insert_into.md) statements to insert one or more rows. If you try to insert a row into a table with an existing primary key value, {{ ydb-short-name }} returns the error message ```Transaction rolled back due to constraint violation: insert_pk.```.

{% note info %}

When an INSERT operation is executed, the data is read before it is written. This makes it less efficient than the REPLACE and UPSERT operations. For writing data, we recommend using REPLACE and UPSERT operations.

{% endnote %}

The code below inserts one row of data into the ```episodes``` table.

{% include notitle [insert-into-3-columns](../_includes/queries/insert-into-3-columns.md) %}

### UPDATE {#update}

[UPDATE](../yql/reference/syntax/update.md) statements change the column value for table rows filtered by a WHERE predicate. Basic syntax:

```sql
UPDATE table_name SET column1_name=new_column1_value, ...,column_nameN=new_columnN_value WHERE row_filtering_criteria;
```

UPDATE statements can't change primary key values. Enter and execute the following UPDATE statement to change the value of the ```title``` column from "Test Episode" to "Test Episode Updated" for the episode with ```series_id = 2```, ```season_id = 1```, and ```episode_id = 3```.

{% include notitle [update-3-columns](../_includes/queries/update-3-columns.md) %}

### DELETE {#delete}

The [DELETE](../yql/reference/syntax/delete.md) statement deletes table rows filtered by the WHERE clause. The code below removes an episode with ```series_id = 2```, ```season_id = 5```, and ```episode_id = 21``` from the ```episodes``` table.

{% include notitle [delete-from-3-columns](../_includes/queries/delete-from-3-columns.md) %}

## Query data using SELECT {#select}

Use [SELECT](../yql/reference/syntax/select.md) statements to read data from a table.

To query data from the ```series``` table, execute the code shown below.

{% include notitle [select-from-3-columns](../_includes/queries/select-from-3-columns.md) %}

You can use an asterisk to select all the columns in a table. To obtain the values of all columns from the ```series``` table, execute the code shown below.

{% include notitle [select-all](../_includes/queries/select-all.md) %}

{% note info %}

For more information about how to query data by secondary index, see [{#T}](../yql/reference/syntax/select.md#si-select).

{% endnote %}

## Make a parameterized query {#param-queries}

Use parameterized queries to improve performance by reducing the frequency of compiling and recompiling your queries.

**Example**

```sql
DECLARE $seriesId AS Uint64;
DECLARE $seasonId AS Uint64;

$seriesId = 1;
$seasonId = 2;

SELECT sa.title AS season_title, sr.title AS series_title
FROM seasons AS sa
INNER JOIN series AS sr
ON sa.series_id = sr.series_id
WHERE sa.series_id = $seriesId AND sa.season_id = $seasonId;
```

