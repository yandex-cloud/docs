---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# DISCARD

Вычисляет [`SELECT`](select.md), `PROCESS` или `REDUCE`, но не возвращает результат ни в клиент, ни в таблицу.

Полезно использовать в сочетании с [`Ensure`](../builtins/basic.md#ensure) для проверки выполнения пользовательских условий на финальный результат вычислений.

**Примеры**

```sql
DISCARD SELECT 1;
```
```sql
INSERT INTO result_table WITH TRUNCATE
SELECT * FROM
my_table
WHERE value % 2 == 0;

COMMIT;

DISCARD SELECT Ensure(
    0, -- will discard result anyway
    COUNT(*) > 1000,
    "Too small result table, got only " || CAST(COUNT(*) AS String) || " rows"
) FROM result_table;

```
