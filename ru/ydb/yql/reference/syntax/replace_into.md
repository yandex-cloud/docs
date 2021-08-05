---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# REPLACE INTO

Сохраняет данные в таблицу по `PRIMARY_KEY` с перезаписью строк. Если заданный `PRIMARY_KEY` отсутствует, в таблицу будет добавлена новая строка. Если задан существующий `PRIMARY_KEY`, строка будет перезаписана. При этом значения столбцов, не участвующих в операции, заменяются на значения по умолчанию.

{% note info %}

В отличие от [`INSERT INTO`](insert_into.md) и [`UPDATE`](update.md), запросы [`UPSERT INTO`](upsert_into.md) и `REPLACE INTO` не требуют предварительного чтения данных, поэтому выполняются быстрее.

{% endnote %}

* Задание значений для `REPLACE INTO` c помощью `VALUES`.

  **Пример**

  ```sql
  REPLACE INTO my_table (Key1, Key2, Value2) VALUES
      (1u, "One", 101),
      (2u, "Two", 102);
  COMMIT;
  ```

* Получение значений для `REPLACE INTO` с помощью выборки `SELECT`.

  **Пример**

  ```sql
  REPLACE INTO my_table
  SELECT Key AS Key1, "Empty" AS Key2, Value AS Value1
  FROM my_table1;
  COMMIT;
  ```
