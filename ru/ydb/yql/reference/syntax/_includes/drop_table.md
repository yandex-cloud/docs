---
sourcePath: core/yql/reference/yql-docs-core-2/syntax/_includes/drop_table.md
sourcePath: yql/reference/yql-docs-core-2/syntax/_includes/drop_table.md
---

# DROP TABLE

Удаляет указанную таблицу.{% if feature_mapreduce %}  Таблица по имени ищется в базе данных, заданной оператором [USE](../use.md).{% endif %}

Если таблицы с таким именем не существует, возвращается ошибка. 

**Примеры:**

``` yql
DROP TABLE my_table;
```
