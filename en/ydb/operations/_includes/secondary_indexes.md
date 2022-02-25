---
sourcePath: en/ydb/overlay/operations/_includes/secondary_indexes.md
---
# Working with secondary indexes

## Adding secondary indexes {#add-si}

To add a [secondary index](../../concepts/secondary_indexes.md) when creating a table, use the statement `INDEX IndexName GLOBAL ON (SomeKey1, ... SomeKeyN)`:

```sql
CREATE TABLE TableName (
    Key1 Type,
    Key2 Type,
    …
    PRIMARY KEY (SomeKey),
    INDEX IndexName1 GLOBAL ON (SomeKey),
    INDEX IndexName2 GLOBAL ON (SomeKey1, SomeKey2, ...)
);
COMMIT;
```

**Example**

The `series` table with the `views_index` secondary index for the `views` field and `users_index` secondary index for the `uploaded_user_id` field:

```sql
CREATE TABLE series (
    series_id Uint64,
    title Utf8,
    info Utf8,
    release_date Datetime,
    views Uint64,
    uploaded_user_id Uint64,
    PRIMARY KEY (series_id),
    INDEX views_index GLOBAL ON (views),
    INDEX users_index GLOBAL ON (uploaded_user_id)
);
```

## Using a Select by secondary index {#select-si}

To make a `SELECT` by secondary index statement, use the following:

```sql
SELECT *
    FROM TableName VIEW IndexName
    WHERE …
```

**Examples**

* Select all fields from the [table](../../yql/reference/syntax/create_table.md#si-add) `series` using the `views_index` index with the `views >= someValue` criteria:

  ```sql
  SELECT series_id, title, info, release_date, views, uploaded_user_id
      FROM series VIEW views_index
      WHERE views >= someValue
  ```

* [`JOIN`](../../yql/reference/syntax/join.md) the `series` and `users` tables on the `userName` field using the `users_index` and `name_index` indexes, respectively:

  ```sql
  SELECT t1.series_id, t1.title
      FROM series VIEW users_index AS t1
      INNER JOIN users VIEW name_index AS t2
      ON t1.uploaded_user_id == t2.user_id
      WHERE t2.name == userName;
  ```

