---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/select/order_by.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/select/order_by.md
---

## ORDER BY {#order-by}

Сортировка результата `SELECT` по разделенному запятыми перечню критериев сортировки. В качестве критерия может выступать значение столбца, или выражение над столбцами. Не поддерживается указание порядкового номера колонки выборки (`ORDER BY N`, где `N` - номер).

Направление сортировки может быть указано после каждого критерия:
- `ASC` — по возрастанию. Применяется по умолчанию.
- `DESC` — по убыванию.

Несколько критериев сортировки будут применены слева направо.

**Пример**

``` yql
SELECT key, string_column
FROM my_table
ORDER BY key DESC, LENGTH(string_column) ASC;
```
Ключевое слово `ORDER BY` также может использоваться в механизме [оконных функций](../../window.md).
