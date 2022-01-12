---
sourcePath: core/yql/reference/yql-docs-core-2/builtins/_includes/basic/weakfield.md
sourcePath: yql/reference/yql-docs-core-2/builtins/_includes/basic/weakfield.md
---

## WeakField {#weakfield}

Вытаскивает колонку таблицы из строгой схемы, если оно там есть, либо из полей `_other` и `_rest`. В случае отсутствия значения возвращается `NULL`.

Синтаксис: `WeakField([<table>.]<field>, <type>[, <default_value>])`.

Значение по умолчанию используется только в случае отсутствия колонки в схеме данных. Чтобы подставить значение по умолчанию в любом случае можно воспользоваться [COALESCE](#coalesce).

**Примеры:**
``` yql
SELECT
    WeakField(my_column, String, "no value"),
    WeakField(my_table.other_column, Int64)
FROM my_table;
```