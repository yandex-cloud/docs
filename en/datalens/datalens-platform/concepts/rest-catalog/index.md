---
title: REST catalog in {{ datalens-platform-full-name }}
description: In this article, you will learn what a REST catalog in {{ datalens-platform-full-name }} is and how the storage for tables in {{ IBRG }} format is organized.
---

# REST catalog in {{ datalens-platform-full-name }}

A REST catalog is a repository for tables in {{ IBRG }} format that is compatible with the [Iceberg REST Catalog API](https://iceberg.apache.org/rest-catalog-spec/). A REST catalog stores tables, views, and namespaces, which you can access via a unified REST interface.

You can use a REST catalog for the following tasks:

* Centralized storage and versioning of Iceberg table metadata.
* Single point of access to tables for different engines irrespective of the REST catalog implementation.
* Table arrangement in logical namespaces.
* Transactional table modification with ACID guarantees and snapshot isolation.
* Data access management on the catalog, namespace, table, or view level.

A REST catalog is integrated with object storage: catalog table data is stored in an object storage bucket.

To get started, create a [REST catalog](../../operations/rest-catalog/create-rest-catalog.md).

A REST catalog serves simultaneously as a registry of tables and views and as a point for managing access to data. Within a catalog, data is organized into _namespaces_. You can define [data access](../../operations/rest-catalog/work-with-rest-catalog.md#access-rest-catalog) at the catalog level, at the namespace level, and at the level of individual objects (tables).

## Namespaces {#namespace}

A namespace is a logical group of tables and views within a catalog; it is analogous to a database or a schema. Namespaces can be multi-level (e.g., `analytics.finance`), which makes it possible to build a hierarchy and group tables by teams, projects, or functional areas.

Each namespace stores its data in a bucket: either a parent bucket (catalog bucket) or buckets created within the namespaces.

Learn more about [creating a namespace](../../operations/rest-catalog/create-namespace.md) and [changing its settings](../../operations/rest-catalog/work-with-rest-catalog.md#edit-namespace).

## Tables and views {#tables-and-views}

A table is a data object in {{ IBRG }} format. The schema, partitioning specifications, sort order, and snapshots of table data are stored in the catalog, while the actual data resides in files within a bucket. A view is a stored query, the metadata for which is also kept in the catalog.

Views are not validated for whether they can be executed within a specific engine. The query was not verified by the cluster during its execution.

To upload data into the REST catalog, create a [data delivery](../data-transfer/index.md).