---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# INSERT INTO

Adds rows to the table. `INSERT INTO` pre-fetches the data and doesn't support overwrite, hence `PRIMARY_KEY` of the new row must not repeat the existing values.

`INSERT INTO` lets you perform the following operations:

* Adding constant values using `VALUES`. Adds rows to the table.

  **Example**

  ```sql
  INSERT INTO my_table (Key1, Key2, Value1, Value2)
  VALUES (345987,'ydb', 'Pied piper', 1414);
  COMMIT;
  ```

* Saving the `SELECT` result. Copies rows from another table.

  **Example**

  ```sql
  INSERT INTO my_table
  SELECT Key AS Key1, "Empty" AS Key2, Value AS Value1
  FROM my_table1;
  
  COMMIT;
  ```

{% note warning %}

If you try to insert a row into a table with an existing primary key value, the operation fails with the `PRECONDITION_FAILED` error code and the `Operation aborted due to constraint violation: insert_pk` message returned.

{% endnote %}

