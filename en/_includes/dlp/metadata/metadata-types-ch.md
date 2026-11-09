| Source information | Description  |
| ---------------------- | --------- |
| Databases | Databases available in the source |
| Tables | User tables |
| Views | Views and their SQL definitions |
| Materialized views | Materialized views and their SQL definitions |
| Dictionaries| Dictionaries and their structure |
| Columns | Names and data types |
| Comments | Comments to tables and columns |
| Data lineage | Links between tables and views, as well as between views |
| Column-level data lineage | Links between columns |
| Use of objects | Object access statistics |
| Data profiling | Statistics on tables and columns |
| Deleted objects | Objects removed from the source since the previous ingestion |

Metadata is ingested from the {{ CH }} system tables using `SQLAlchemy`. Within a catalog, metadata has the following structure: database → table/view → column.

Data lineage is traced by parsing SQL definitions of views stored in `system.tables.create_table_query`.

For data profiling, the user needs the `SELECT` permissions for the tables.