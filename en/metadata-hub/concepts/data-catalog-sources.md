---
title: Data sources in {{ data-catalog-name }}
description: A data source is the connection to a database or service used to load metadata into the catalog. The set of loaded metadata depends on the source type.
---


# Data sources

A data source is the connection to a database or service used to load metadata into the [catalog](data-catalog.md). User data itself is not loaded. When profiling is enabled, additional read queries are executed on data or samples to calculate statistics on columns and tables.

The metadata with the following resource information is loaded into the catalog:

| Source details | Description  |
| ----------------------- | --------- |
| Storage objects | Databases, schemas, tables, views, indexes |
| Data structure | Column/field names, their data types, and whether they can store `NULL` values (nullable), nested columns/fields |
| Comments | Descriptions of tables and columns |
| Data lineage | Links between tables and views |
| Data profiling | Statistics on tables and columns |
| Deleted objects | Objects that were deleted from the source since the previous upload |


## Source metadata

The set of loaded metadata depends on the data source:

* [{{ PG }}](#source-pg)
* [{{ MY }}](#source-my)
* [{{ CH }}](#source-ch)
* [{{ OS }}](#source-os)
* [{{ mgp-name }}/{{ GP }}](#source-gp)
* [{{ SD }}/{{ MG }}](#source-mg)
* [{{ data-transfer-full-name }}](#source-dt)
* [{{ websql-full-name }}](#source-websql)
* [{{ datalens-full-name }}](#source-datalens)
* {{ TR }}
* {{ AF }}


### {{ PG }} {#source-pg}

The metadata with the following resource information is loaded into the catalog from {{ PG }}:

| Source details | Description  |
| ----------------------- | --------- |
| Databases and schemas | Databases and schemas available in the source |
| Tables | Tables, their technical names and the schema they belong to |
| Views | Views and their SQL definitions |
| Stored procedures | Stored procedures and their SQL definitions |
| Columns | Names, data types, and the schema they belong to |
| Comments | Table and column descriptions defined via `COMMENT ON` |
| Data lineage | Links between tables and views, as well as between views |
| Column-level data lineage | Links between columns in views |
| Data profiling | Statistics on tables, rows, and columns |
| Deleted objects | Objects that were deleted from the source since the previous upload |

In the catalog, metadata is structured as: database → schema → table/view → column.

Data lineage can be determined by:

* Parsing SQL definitions of views.
* Analyzing SQL queries.
  
  SQL query analysis requires {{ PG }} version `13` or higher and the `pg_stat_statements` extension.

For data profiling, the user needs `SELECT` privileges on the tables.


### {{ MY }} {#source-my}

The metadata with the following resource information is loaded into the catalog from {{ MY }}:

| Source details | Description  |
| ----------------------- | --------- |
| Databases | Databases available in the source |
| Tables | Tables and the database they belong to |
| Views | Views and their SQL definitions |
| Stored procedures | Stored procedures and their SQL definitions |
| Columns | Names and data types |
| Comments | Comments on tables and columns |
| Data lineage | Links between tables and views, as well as between views |
| Column-level data lineage | Links between source columns and view columns |
| Data profiling | Statistics on tables and columns |
| Deleted objects | Objects that were deleted from the source since the previous upload |

Metadata is loaded from the {{ MY }} system tables. In the catalog, metadata is structured as: database → table/view → column.

Data lineage is determined by parsing SQL definitions of views.

To collect metadata, the user needs the following privileges:

* `SHOW VIEW`: For views.
* `SELECT` for the tables: For data profiling metrics.

Learn more about [user privileges in {{ MY }}](../../managed-mysql/concepts/user-rights.md).


### {{ CH }} {#source-ch}

The metadata with the following resource information is loaded into the catalog from {{ CH }}:

| Source details | Description  |
| ----------------------- | --------- |
| Databases | Databases available in the source |
| Tables | User tables |
| Views | Views and their SQL definitions |
| Materialized views | Materialized views and their SQL definitions |
| [Dictionaries](../../managed-clickhouse/concepts/dictionaries.md) | Dictionaries and their structure |
| Columns | Names and data types |
| Comments | Comments on tables and columns |
| Data lineage | Links between tables and views, as well as between views |
| Column-level data lineage | Links between columns |
| Use of objects | Object access statistics |
| Data profiling | Statistics on tables and columns |
| Deleted objects | Objects that were deleted from the source since the previous upload |

Metadata is loaded from the {{ CH }} system tables using `SQLAlchemy`. In the catalog, metadata is structured as: database → table/view → column.

Data lineage is determined by parsing SQL definitions of views stored in `system.tables.create_table_query`.

For data profiling, the user needs `SELECT` privileges on the tables.


### {{ OS }} {#source-os}

The metadata with the following resource information is loaded into the catalog from {{ OS }}:

| Source details | Description  |
| ----------------------- | --------- |
| [Indexes](../../managed-opensearch/concepts/indexing.md) | Indexes available in the source |
| Index fields | Fields included in indexes |
| Field types | Field data types |
| Index templates | Rules applied when creating indexes |
| Data profiling | Statistics on indexes and fields |
| Deleted objects | Indexes that were deleted from the source since the previous upload |

Metadata is loaded from {{ OS }} using the API. In the catalog, each index is represented as a dataset with fields. The field name and type are determined based on the index schema.

For data profiling, the user needs read permissions on the indexes.


### {{ mgp-name }}/{{ GP }} {#source-gp}

{% note warning %}

Exporting metadata from {{ mgp-name }} with {{ CB }} DBMS is not supported.

{% endnote %}

The metadata with the following resource information is loaded into the catalog from {{ GP }} and [{{ mgp-name }}](../../managed-greenplum/index.yaml):

| Source details | Description  |
| ----------------------- | --------- |
| Databases and schemas | Databases and schemas available in the source |
| Tables | Tables, their technical names and the schema they belong to |
| Views | Views and their SQL definitions |
| Materialized views | Materialized views and their SQL definitions |
| [External tables](../../managed-greenplum/concepts/external-tables.md) | Information about external tables |
| Columns | Names, data types, and the schema they belong to |
| Limitations | Check the data integrity |
| Indexes | Table indexes |
| Comments | Table and column descriptions defined via `COMMENT ON` |
| Data lineage | Links between tables, views, and materialized views |
| Data profiling | Statistics on tables and columns |
| Deleted objects | Objects that were deleted from the source since the previous upload |

In the catalog, metadata is structured as: database → schema → table/view → column.

Data lineage can be determined by:

* Parsing SQL definitions of views.
* Analyzing SQL queries.

For data profiling, the user needs `SELECT` privileges on the tables.


### {{ SD }}/{{ MG }} {#source-mg}

The metadata with the following resource information is loaded into the catalog from [{{ SD }}](../../storedoc/index.yaml) and {{ MG }}:

| Source details | Description  |
| ----------------------- | --------- |
| Databases | Databases available in the source |
| Collections | Names, database they belong to, list of fields and their types, document structure, technical attributes |
| Fields | Names, nested fields, types, whether they can store `NULL` values, mixed types |
| Deleted objects | Collections that were deleted from the source since the previous upload |

In the catalog, metadata is structured as: database → collection → field.

In {{ SD }} and {{ MG }}, there is no unified collection schema, as documents may have different structures. If schema inference is enabled, a merged collection schema is built based on a sample of documents. To build the schema, you need read permissions on the databases from which metadata is loaded.


### {{ data-transfer-full-name }} {#source-dt}

Metadata from [{{ data-transfer-name }}](../../data-transfer/index.yaml) is loaded into the catalog for [transfers](../../data-transfer/concepts/index.md#transfer) running in selected [{{ yandex-cloud }} folders](../../resource-manager/concepts/resources-hierarchy.md#folder).

The metadata contains the following information about the transfer:

* Links between storages, tables and columns.
* [Data transformation](../../data-transfer/concepts/data-transformation.md).

A storage without an active source is created for each transfer participant with no [source created](../operations/data-catalog/create-source.md) in the catalog. In this case, only the metadata obtained within the transfer will be available in the catalog. Later, you can create a source for each storage and configure metadata loading.


### {{ websql-full-name }} {#source-websql}

Metadata from [{{ websql-name }}](../../websql/index.yaml) is loaded into the catalog for SQL queries and database objects used in queries. Query results are not loaded. Queries are loaded only for databases for which a source was created in the catalog.

In the catalog, a user sees only their own queries or queries for which they have view permissions.


### {{ datalens-full-name }} {#source-datalens}

Metadata from [{{ datalens-name }}](../../datalens/index.yaml) is loaded into the catalog for the following objects:

* [Datasets](../../datalens/dataset/index.md)
* [Charts](../../datalens/concepts/chart/index.md)
* [Dashboards](../../datalens/concepts/dashboard.md)
* [Reports](../../datalens/reports/index.md)
* [Workbooks and collections](../../datalens/workbooks-collections/index.md)

Metadata is loaded for selected [connections](../../datalens/concepts/connection/index.md). If no connections are selected, metadata is loaded for all available connections.

To load metadata, the [service account](../../iam/concepts/users/service-accounts.md) needs the `datalens.visitor` and `datalens.admin` roles for the organization. Instead of the `datalens.admin` role, you can grant permissions to access individual {{ datalens-name }} resources (e.g., `datalens.workbooks.viewer`). In that case, only metadata for resources to which the service account has access is loaded.

[Learn more about roles in {{ datalens-name }}](../../datalens/security/roles.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
