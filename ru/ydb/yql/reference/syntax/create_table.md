---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# CREATE TABLE

Создает таблицу с указанной схемой данных и `PRIMARY KEY` (ключевыми столбцами):

```sql
CREATE TABLE table_name (
    column1 type1,
    column2 type2,
    ...
    columnN typeN,
    PRIMARY KEY (column, ...)
)
```

Для ключевых и неключевых столбцов допускаются только [примитивные](../types/primitive.md) типы данных.

Обязательно указание `PRIMARY KEY` с непустым списком столбцов. Эти столбцы становятся частью ключа в порядке перечисления.

**Пример**

```sql
CREATE TABLE my_table (
    a Uint64,
    b Bool,
    c Float,
    PRIMARY KEY (b, a)
)
```

## Добавление вторичных индексов {#si-add}

{% include [add_secondary_index](../../../_includes/add-secondary-index.md) %}
