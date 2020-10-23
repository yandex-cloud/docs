To make a `SELECT` by secondary index statement, use the following:

```sql
SELECT *
    FROM TableName VIEW IndexName
    WHERE …
```

**Examples**

* Select all fields from the [table](../yql/reference/syntax/create_table.md#si-add) `series` using the `views_index` index with the `views >= someValue` criteria:

  ```sql
  SELECT series_id, title, info, release_date, views, uploaded_user_id
      FROM series VIEW views_index
      WHERE views >= someValue
  ```

* [`JOIN`](../yql/reference/syntax/join.md) the `series` and `users` tables on the `userName` field using the `users_index` and `name_index` indexes, respectively:

  ```sql
  SELECT t1.series_id, t1.title
      FROM series VIEW users_index AS t1
      INNER JOIN users VIEW name_index AS t2
      ON t1.uploaded_user_id == t2.user_id
      WHERE t2.name == userName;
  ```

