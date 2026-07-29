---
title: Data sources in {{ data-catalog-name }}
description: A data source is a connection to a database or service used to ingest metadata into a catalog. The scope of ingested metadata depends on the source type.
---


# Data sources

A data source is a connection to a database or service used to ingest metadata into a [catalog](data-catalog.md). User data is never ingested. When profiling is enabled, the system runs additional read queries against data or samples to calculate column and table statistics.

The metadata ingested into a catalog contains the following source information:

| Source information | Description  |
| ----------------------- | --------- |
| Stored objects | Databases, schemas, tables, views, and indexes |
| Data structure | Column or field names, their data types and support for storing `NULL` values (nullability), nested columns or fields |
| Comments | Descriptions of tables and columns |
| Data lineage | Links between tables and views |
| Data profiling | Statistics on tables and columns |
| Deleted objects | Objects removed from the source since the previous ingestion |


## Source metadata

The scope of ingested metadata depends on the data source:

* [{{ PG }}](#source-pg)
* [{{ MY }}](#source-my)
* [{{ CH }}](#source-ch)
* [{{ OS }}](#source-os)
* [{{ mgp-name }}/{{ GP }}](#source-gp)
* [{{ SD }}/{{ MG }}](#source-mg)
* [{{ data-transfer-full-name }}](#source-dt)
* [{{ websql-full-name }}](#source-websql)
* [{{ datalens-full-name }}](#source-datalens)


### {{ PG }} {#source-pg}

Metadata with the following source information is ingested from {{ PG }} into the catalog:

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


### {{ MY }} {#source-my}

Metadata with the following source information is ingested from {{ MY }} into the catalog:

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

Learn more about [user privileges in {{ MY }}](../../managed-mysql/concepts/user-rights.md).


### {{ CH }} {#source-ch}

Metadata with the following source information is ingested from {{ CH }} into the catalog:

| Source information | Description  |
| ----------------------- | --------- |
| Databases | Databases available in the source |
| Tables | User tables |
| Views | Views and their SQL definitions |
| Materialized views | Materialized views and their SQL definitions |
| [Dictionaries](../../managed-clickhouse/concepts/dictionaries.md) | Dictionaries and their structure |
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


### {{ OS }} {#source-os}

Metadata with the following source information is ingested from {{ OS }} into the catalog:

| Source information | Description  |
| ----------------------- | --------- |
| [Indexes](../../managed-opensearch/concepts/indexing.md) | Indexes available in the source |
| Index fields | Fields included in indexes |
| Field types | Field data types |
| Index templates | Rules applied when creating indexes |
| Data profiling | Statistics on indexes and fields |
| Deleted objects | Indexes removed from the source since the previous ingestion |

Metadata is ingested from {{ OS }} via the API. Within a catalog, each index is represented as a dataset with fields. The field name and type are determined based on the index schema.

For data profiling, the user needs permissions to read indexes.


### {{ mgp-name }}/{{ GP }} {#source-gp}

{% note warning %}

Export of metadata from {{ mgp-name }} with {{ CB }} is not supported.

{% endnote %}

Metadata with the following source information is ingested from {{ GP }} and [{{ mgp-name }}](../../managed-greenplum/index.yaml) into the catalog:

| Source information | Description  |
| ----------------------- | --------- |
| Databases and schemas | Databases and schemas available in the source |
| Tables | Tables, their technical names, and parent schema mapping |
| Views | Views and their SQL definitions |
| Materialized views | Materialized views and their SQL definitions |
| [External tables](../../managed-greenplum/concepts/external-tables.md) | Information about external tables |
| Columns | Names, data types, and parent schema mapping |
| Limitations | Rules for maintaining data integrity |
| Indexes | Table indexes |
| Comments | Table and column descriptions defined via `COMMENT ON` |
| Data lineage | Links between tables, views, and materialized views |
| Data profiling | Statistics on tables and columns |
| Deleted objects | Objects removed from the source since the previous ingestion |

Within a catalog, metadata has the following structure: database → schema → table/view → column.

There are two methods for data lineage tracing:

* Parsing the SQL definitions of views.
* Analyzing SQL queries.

For data profiling, the user needs the `SELECT` permissions for the tables.


### {{ SD }}/{{ MG }} {#source-mg}

Metadata with the following source information is ingested from {{ MG }} and [{{ SD }}](../../storedoc/index.yaml) into the catalog:

| Source information | Description  |
| ----------------------- | --------- |
| Databases | Databases available in the source |
| Collections | Names, parent database mapping, list of fields and their types, document structure, technical attributes |
| Fields | Names, nested fields, types, support for storing `NULL` values, mixed types |
| Deleted objects | Collections removed from the source since the previous ingestion |

Within a catalog, metadata has the following structure: database → collection → field.

In {{ SD }} and {{ MG }}, there is no single collection schema, as individual documents may have varying structures. If schema inference is enabled, a unified collection schema is generated based on a sample of documents. To build the schema, you need read permissions for the databases metadata is ingested from.


### {{ data-transfer-full-name }} {#source-dt}

The metadata ingested from [{{ data-transfer-name }}](../../data-transfer/index.yaml) into a catalog constitutes metadata of [transfers](../../data-transfer/concepts/index.md#transfer) running within the selected [{{ yandex-cloud }} folders](../../resource-manager/concepts/resources-hierarchy.md#folder).

This metadata includes the following transfer information:

* Links between storages, tables, and columns.
* [Data transformations](../../data-transfer/concepts/data-transformation.md).

For each transfer participant without a corresponding [source](../operations/data-catalog/create-source.md) in the catalog, a storage without an active source is created. In this case, the catalog will only store metadata obtained during the transfer. You can later create a source for each storage and configure metadata ingestion.


### {{ websql-full-name }} {#source-websql}

The metadata ingested from [{{ websql-name }}](../../websql/index.yaml) into a catalog constitutes the metadata of SQL queries and database objects used in queries. Query results are not ingested. The ingested queries are restricted to databases which have a corresponding source in the catalog.

In the catalog, a user will only see their queries or queries for which they have view permissions.


### {{ datalens-full-name }} {#source-datalens}

A catalog ingests metadata for the following [{{ datalens-name }}](../../datalens/index.yaml) objects:

* [Datasets](../../datalens/dataset/index.md)
* [Charts](../../datalens/concepts/chart/index.md)
* [Dashboards](../../datalens/concepts/dashboard.md)
* [Reports](../../datalens/reports/index.md)
* [Workbooks and collections](../../datalens/workbooks-collections/index.md)

The ingested metadata is limited to the pre-selected [connections](../../datalens/concepts/connection/index.md). If no connections are selected, the system will ingest metadata from all available connections.

To ingest metadata, the [service account](../../iam/concepts/users/service-accounts.md) needs the `datalens.visitor` and `datalens.admin` roles for the organization. Instead of the `datalens.admin` role, you can grant granular permissions to access individual {{ datalens-name }} resources (e.g., `datalens.workbooks.viewer`). In this scenario, the ingested metadata will be limited to the specific resources to which the service account has access.

[Learn more about roles in {{ datalens-name }}](../../datalens/security/roles.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
