---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/select/from_as_table.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/select/from_as_table.md
---

## FROM AS_TABLE {#as-table}

Обращение к именованным выражениям как к таблицам с помощью функции `AS_TABLE`.

`AS_TABLE($variable)` позволяет использовать значение `$variable` в качестве источника данных для запроса. При этом переменная `$variable` должна иметь тип `List<Struct<...>>`.

**Пример**

``` yql
$data = AsList(
    AsStruct(1u AS Key, "v1" AS Value),
    AsStruct(2u AS Key, "v2" AS Value),
    AsStruct(3u AS Key, "v3" AS Value));

SELECT Key, Value FROM AS_TABLE($data);
```
