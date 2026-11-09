| Source information | Description  |
| ----------------------- | --------- |
| Databases | Databases available in the source |
| Tables | Tables and their parent database mapping |
| Views | Views and their SQL definitions |
| Stored procedures | Stored procedures and their SQL definitions |
| Columns | Names and data types |
| Comments | Comments to tables and columns |
| Data lineage | Links between tables and views, as well as between views |
| Column-level data lineage | Links between source columns and view columns |
| Data profiling | Statistics on tables and columns |
| Deleted objects | Objects removed from the source since the previous ingestion |

Metadata is ingested from the {{ MY }} system tables. Within a catalog, metadata has the following structure: database → table/view → column.

Data lineage is traced by parsing SQL definitions of views.

To collect metadata, the user needs the following privileges:

* `SHOW VIEW` for views.
* `SELECT` for tables to access data profiling metrics.