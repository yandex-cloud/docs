---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# INSERT INTO

Добавляет строки в таблицу. `INSERT INTO` выполняет предварительное чтение и не предусматривает перезаписи данных, поэтому `PRIMARY_KEY` новой строки не должен повторять существующие значения.

`INSERT INTO` позволяет выполнять следующие операции:

* Добавление константных значений с помощью `VALUES`. Добавляет строки в таблицу.

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

{% note warning %}

При попытке вставить в таблицу строку с уже существующим значением первичного ключа операция завершится ошибкой с кодом `PRECONDITION_FAILED` и текстом `Operation aborted due to constraint violation: insert_pk`.

{% endnote %}
