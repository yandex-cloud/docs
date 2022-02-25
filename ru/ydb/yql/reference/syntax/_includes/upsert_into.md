---
sourcePath: ru/ydb/ydb-docs-core/ru/core/yql/reference/yql-docs-core-2/syntax/_includes/upsert_into.md
sourcePath: ru/ydb/yql/reference/yql-docs-core-2/syntax/_includes/upsert_into.md
---

# UPSERT INTO

Добавляет или обновляет множество строк в таблице на основании сравнения по первичному ключу. Отсутствующие строки добавляются. В присутствующих строках обновляются значения заданных столбцов, значения остальных столбцов остаются неизменными.


`UPSERT` и [`REPLACE`](../replace_into.md) являются операциями модификации данных, которые не требует их предварительного чтения, за счет чего работают быстрее и дешевле других операций.

Сопоставление столбцов при использовании `UPSERT INTO ... SELECT` производится по именам. Используйте `AS` для получения колонки с нужным именем в `SELECT`.

**Примеры**

``` yql
UPSERT INTO my_table
SELECT pk_column, data_column1, col24 as data_column3 FROM other_table  
```

``` yql
UPSERT INTO my_table ( pk_column1, pk_column2, data_column2, data_column5 )
VALUES ( 1, 10, 'Some text', Date('2021-10-07')),
       ( 2, 10, 'Some text', Date('2021-10-08'))
```
