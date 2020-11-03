# UPSERT INTO

Saves data to the table by `PRIMARY_KEY`, overwriting the rows. If the specified `PRIMARY_KEY` is missing, a new row is added to the table. If the given `PRIMARY_KEY` exists, the row is overwritten. The values of columns not involved in the operation are not changed.

{% note info %}

Unlike [`INSERT INTO`](insert_into.md) and [`UPDATE`](update.md), the queries `UPSERT INTO` and [`REPLACE INTO`](replace_into.md) don't need to pre-fetch the data, hence they run faster.

{% endnote %}

`UPSERT INTO` lets you perform the following operations:

* Saving constant values using `VALUES`. Appends the rows to the table or replaces the existing rows.

  **Example**

  ```sql
  UPSERT INTO my_table (Key1, Key2, Value2) VALUES
      (1u, "One", 101),
      (2u, "Two", 102);
  COMMIT;
  ```

* Saving the `SELECT` results. Copies rows from another table.

  **Example**

  ```sql
  UPSERT INTO my_table
  SELECT Key AS Key1, "Empty" AS Key2, Value AS Value1
  FROM my_table1;
  
  COMMIT;
  ```

