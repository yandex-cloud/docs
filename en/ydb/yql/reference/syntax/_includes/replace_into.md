---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/syntax/_includes/replace_into.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/syntax/_includes/replace_into.md
---

# REPLACE INTO

Saves data to a table, overwriting the rows based on the primary key. If the given primary key is missing, a new row is added to the table. If the given `PRIMARY_KEY` exists, the row is overwritten. The values of columns not involved in the operation are replaced by their default values.

{% note info %}

Unlike [`INSERT INTO`](../insert_into.md) and [`UPDATE`](../update.md), the queries [`UPSERT INTO`](../upsert_into.md) and `REPLACE INTO` don't need to pre-fetch the data, hence they run faster.

{% endnote %}

* Setting values for `REPLACE INTO` using `VALUES`.

  **Example**

  ```sql
  REPLACE INTO my_table (Key1, Key2, Value2) VALUES
      (1u, "One", 101),
      (2u, "Two", 102);
  COMMIT;
  ```

* Fetching values for `REPLACE INTO` using a `SELECT`.

  **Example**

  ```sql
  REPLACE INTO my_table
  SELECT Key AS Key1, "Empty" AS Key2, Value AS Value1
  FROM my_table1;
  COMMIT;
  ```

