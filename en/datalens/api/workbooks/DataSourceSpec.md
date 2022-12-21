# DataSourceSpec

Discriminator field: `kind`


Specification of a data source: a table, subquery, and so on.


## CHYTTableListDataSourceSpec

`kind`:`chyt_table_list`


| Field | Type | Description |
------|-----|----------
| `tables` | **list** * |
| `tables[]` | **str** |
## CHYTTableRangeDataSourceSpec

`kind`:`chyt_table_range`


| Field | Type | Description |
------|-----|----------
| `path` | **str** * |
| `start` | **str** * |
| `end` | **str** * |
## SchematizedTableDataSourceSpec

`kind`:`sql_table_in_schema`


| Field | Type | Description |
------|-----|----------
| `db_name` | **str** * |
| `table_name` | **str** * |
| `schema_name` | **str** * |
## SubSelectDataSourceSpec

`kind`:`sql_query`


| Field | Type | Description |
------|-----|----------
| `sql` | **str** * |
## TableDataSourceSpec

`kind`:`sql_table`


| Field | Type | Description |
------|-----|----------
| `db_name` | **str** * |
| `table_name` | **str** * |
