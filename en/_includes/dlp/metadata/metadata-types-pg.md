| Source information | Description  |
| ----------------------- | --------- |
| Databases and schemas | Databases and schemas available in the source |
| Tables | Tables, their technical names, and parent schema mapping |
| Views | Views and their SQL definitions |
| Stored procedures | Stored procedures and their SQL definitions |
| Columns | Names, data types, and parent schema mapping |
| Comments | Table and column descriptions defined via `COMMENT ON` |
| Data lineage | Links between tables and views, as well as between views |
| Column-level data lineage | Links between columns in views |
| Data profiling | Statistics on tables, rows, and columns |
| Deleted objects | Objects removed from the source since the previous ingestion |

Within a catalog, metadata has the following structure: database → schema → table/view → column.

There are two methods for data lineage tracing:

* Parsing the SQL definitions of views.
* Analyzing SQL queries.
  
  SQL query analysis requires {{ PG }} version `13` or higher and the `pg_stat_statements` extension.

For data profiling, the user needs the `SELECT` permissions for the tables.
