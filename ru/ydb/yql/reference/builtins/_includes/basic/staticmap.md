---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-core/builtins/_includes/basic/staticmap.md
sourcePath: ru/ydb/yql/reference/yql-core/builtins/_includes/basic/staticmap.md
---
## StaticMap

Преобразует структуру или кортеж, применяя лямбду к каждому элементу.

Аргументы:

* Структура или кортеж;
* Лямбда для обработки элементов.

Результат: структура или кортеж с аналогичным первому аргументу количеством и именованием элементов, а типы данных элементов определяются результатами лямбды.

**Примеры:**
``` yql
SELECT *
FROM (
    SELECT
        StaticMap(TableRow(), ($item) -> {
            return CAST($item AS String);
        })
    FROM my_table
) FLATTEN COLUMNS; -- преобразование всех колонок в строки
```

