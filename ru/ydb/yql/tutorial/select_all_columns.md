---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Выборка данных из всех колонок

Выберите все колонки из таблицы с помощью оператора [SELECT](../reference/syntax/select.md).

{% include [yql-reference-prerequisites](../../_includes/yql_tutorial_prerequisites.md) %}

```sql
SELECT         -- Оператор выбора данных.

    *          -- Выбор всех колонок из таблицы.

FROM episodes; -- Таблица, из которой нужно выбрать данные.

COMMIT;
```
