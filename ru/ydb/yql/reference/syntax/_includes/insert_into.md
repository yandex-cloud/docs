---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/insert_into.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/insert_into.md
---

# INSERT INTO
Добавляет строки в таблицу. При попытке вставить в таблицу строку с уже существующим значением первичного ключа операция завершится ошибкой с кодом `PRECONDITION_FAILED` и текстом `Operation aborted due to constraint violation: insert_pk`.


`INSERT INTO` позволяет выполнять следующие операции:

* Добавление константных значений с помощью [`VALUES`](../values.md).

  ```sql
  INSERT INTO my_table (Key1, Key2, Value1, Value2)
  VALUES (345987,'ydb', 'Яблочный край', 1414);
  COMMIT;
  ```

  ``` sql
  INSERT INTO my_table (key, value)
  VALUES ("foo", 1), ("bar", 2);
  ```

* Сохранение результата выборки `SELECT`.

  ```sql
  INSERT INTO my_table
  SELECT Key AS Key1, "Empty" AS Key2, Value AS Value1
  FROM my_table1;
  ```
