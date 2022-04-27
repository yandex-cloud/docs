# DataSourceSpec

Поле-дискриминатор: `kind`


Спецификация источника данных: таблица, подзапрос и т. д.


## CHYTTableListDataSourceSpec

`kind`:`chyt_table_list`


 Поле | Тип | Описание
------|-----|----------
`tables` | **list** * |
`tables[]` | **str**  |
## CHYTTableRangeDataSourceSpec

`kind`:`chyt_table_range`


 Поле | Тип | Описание
------|-----|----------
`path` | **str** * |
`start` | **str** * |
`end` | **str** * |
## SchematizedTableDataSourceSpec

`kind`:`sql_table_in_schema`


 Поле | Тип | Описание
------|-----|----------
`db_name` | **str** * |
`table_name` | **str** * |
`schema_name` | **str** * |
## SubSelectDataSourceSpec

`kind`:`sql_query`


 Поле | Тип | Описание
------|-----|----------
`sql` | **str** * |
## TableDataSourceSpec

`kind`:`sql_table`


 Поле | Тип | Описание
------|-----|----------
`db_name` | **str** * |
`table_name` | **str** * |
