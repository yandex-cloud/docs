# INSERT INTO

Добавляет строки в таблицу. `INSERT INTO` выполняет предварительное чтение и не предусматривает перезаписи данных, поэтому `PRIMARY_KEY` новой строки не должен повторять существующие значения.

`INSERT INTO` позволяет выполнять следующие операции:

* Добавление константных значений с помощью `VALUES`. Дописывает строки в конец таблицы.

  **Пример**

  ```sql
  INSERT INTO my_table (Key1, Key2, Value1, Value2) 
  VALUES (345987,'ydb', 'Яблочный край', 1414);
  COMMIT;
  ```

* Сохранение результата выборки `SELECT`. Копирует строки из другой таблицы.

  **Пример**

  ```sql
  INSERT INTO my_table
  SELECT Key AS Key1, "Empty" AS Key2, Value AS Value1
  FROM my_table1;

  COMMIT;
  ```