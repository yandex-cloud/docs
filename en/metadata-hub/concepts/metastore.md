---
title: '{{ metastore-full-name }} clusters'
description: You can create {{ metastore-full-name }} clusters in {{ metadata-hub-full-name }}.
---

# {{ metastore-full-name }} clusters

{% include [Preview](../../_includes/note-preview.md) %}

{% include [connection](../../_includes/metadata-hub/metastore-definition.md) %}

## Why use {{ metastore-full-name }} {#metastore-objectives}

When handling big data and analytics in the cloud, there is often a need to transform file sets into tables so you can easily work with them using SQL. {{ metastore-name }} is a _persistent_ database with a data dictionary. Persistence means that information is saved to a disk and remains available after computer shutdown or system restart. A data dictionary contains definitions describing the structure and format of data. {{ metastore-name }} retains data about tables physically located in {{ objstorage-full-name }}. It includes information about the location of data files, their arrangement, column structure, data types, partitioning, etc. Essentially, {{ metastore-name }} creates abstraction over raw files, converting them into logical tables you can manage with SQL.

One may compare this to cataloging books in a library. In a large library with thousands of books, you would have to check every shelf to find the book you need unless you had a catalog to help you quickly locate it. {{ metastore-name }} has a similar role when it comes to {{ objstorage-name }} data.

In relational databases (Oracle, {{ PG }}), the data dictionary is built into the DBMS itself. When you create a table in {{ PG }}, information about its structure is stored in system tables within the same database. However, in big data ecosystems where files may be stored independently from processing tools, you need a dedicated service to store such information, {{ metastore-name }}.

## Use cases {#scenarios}

{{ metastore-name }} does not solve any business tasks, yet it is an essential tool for certain use cases. 

### Operations with data from different analytical tools {#analytic-tools}

Modern data processing architectures often use multiple tools to work with the same data in {{ objstorage-name }}. This is because different tools are optimal for different tasks. For example, you may want to use {{ SPRK }} for bulk data processing and ETL (Extract, Transform, Load), and {{ TR }}, for interactive analytics and quick queries.

If there is no single common cluster, each tool will maintain its own copy of metadata, which creates problems when the data structure changes. When you add a new column to a table and update metadata in {{ SPRK }} without making the same updates in {{ TR }}, queries from {{ TR }} will return incomplete data or produce errors.

{{ metastore-name }} prevents this by providing a single source of truth for all metadata. The table structure is described once, and all connected tools automatically get access to up-to-date information. This streamlines administration and significantly reduces the risk of metadata inconsistency errors.

For example, if a team of data analysts uses {{ TR }} for interactive queries while an engineering team uses {{ SPRK }} for ETL, a single shared {{ metastore-name }} will provide both teams with consistent data ensuring accurate results.

### Cluster lifecycle management {#cluster-lifecycle}

One of the key cloud computing advantages is that you pay only for resources you actually use. This is relevant for data processing tasks you may only have occasionally.

A lot of {{ yandex-cloud }} customers use powerful compute clusters ({{ dataproc-name }} with {{ SPRK }} or custom Apache Hadoop® clusters) exclusively for such tasks: report generation, overnight batch processing, analytical model updates, etc.

Such clusters may consist of hundreds of CPU cores and terabytes of RAM and are very expensive to use. Having these resources available all the time is not cost-effective, especially if they are only used for a few hours a day.

A better approach is to create temporary clusters for specific tasks and then delete them. However, in traditional Apache Hadoop® architectures, {{ metastore-name }} is a component within a cluster, so if you delete a cluster, you will lose all table metadata. With the next run, you would need to redefine table structure manually, which is an error-prone and labor-intensive process.

You may tackle this by creating a standalone managed {{ metastore-name }} cluster. It is independent of compute clusters and retains all metadata even after cluster deletion. When creating a new cluster for the next processing session, it connects to the same {{ metastore-name }} and gets access to all table definitions.

In {{ yandex-cloud }}, many users implement this scenario with the help of {{ maf-short-name }}, which is a workflow orchestration tool. {{ maf-short-name }} schedules the creation of powerful {{ dataproc-name }} clusters for data processing and then, once the computations are complete, deletes them to optimize costs. All metadata is retained in a separate managed {{ metastore-name }} cluster, ensuring a seamless user experience.

### Working with modern data formats for analytics {#analytic-tasks}

In recent years, new data formats have been developed, designed specifically for analytical tasks: Apache Iceberg, Delta Lake, Apache Hudi. Compared to traditional ones such as CSV or Parquet, these formats offer more capabilities and are more user-friendly.
Here are the features they provide:

* Automic transactions for data writes.
* Data versioning and time travel.
* Schemas and schema evolution.
* Table optimization and size management.
* Query isolation from parallel writes.

To implement these features, formats such as Iceberg and Delta Lake will benefit from centralized metadata management. They need storage for information about table versions, transactions, schema changes, etc., and {{ metastore-name }} provides an optimal infrastructure for that.

Without {{ metastore-name }}, using these advanced formats would be a lot more complex, and some features would be entirely unavailable. With {{ metastore-name }}, you can leverage all the benefits of modern data formats without creating a custom infrastructure for metadata management.

In {{ yandex-cloud }}, {{ metastore-name }} is particularly useful for creating data lakes (Data Lake) and analytical data lakes (Data Lakehouse) using Delta Lake and Iceberg formats. It provides the required infrastructure for storing these formats' metadata and makes their use simple and reliable.

## {{ metastore-name }} integration with {{ yandex-cloud }} services {#integrations}

In {{ yandex-cloud }}, {{ metastore-name }} integrates with other services, enhancing their data capabilities and simplifying the creation of comprehensive solutions.

### {{ dataproc-name }} and {{ metastore-name }} {#data-processing}

[{{ dataproc-name }}](../../data-proc/concepts/index.md) is a service for running distributed computations using [{{ SPRK }}](https://spark.apache.org/), [Apache Hive](https://hive.apache.org/), and other Apache Hadoop® ecosystem tools. {{ SPRK }} actively uses {{ metastore-name }} to store table schemas and access data through an SQL interface.

Connecting {{ dataproc-name }} to a managed {{ metastore-name }} cluster in {{ yandex-cloud }} is simple: when creating a cluster, specify the {{ metastore-name }} URI in the additional settings. {{ SPRK }} will then automatically connect to {{ metastore-name }} and get access to all tables defined in it.

This offers many data management capabilities:

* Using SparkSQL to run complex analytical queries on {{ objstorage-name }} data.
* Using different {{ dataproc-name }} clusters with the same tables without duplicating definitions.
* Creating and deleting clusters as you need without losing table metadata.

For example, {{ dataproc-name }} can be used to create ETL pipelines that read data from various sources, transform it, and write it to tables defined in {{ metastore-name }}. This data then becomes available for analytics through any other service connected to the same {{ metastore-name }}.

### {{ mtr-short-name }} and {{ metastore-name }} {#managed-trino}

{{ TR }} is a distributed SQL engine for analytical queries. {{ TR }} can work various data sources, including files in {{ objstorage-name }}. {{ yandex-cloud }} offers [{{ mtr-short-name }}](../../managed-trino/quickstart.md) with {{ metastore-name }} connectivity.

{{ TR }} uses a connector system to access different data sources. {{ metastore-name }} uses the Hive connector for data management. When [creating a {{ mtr-short-name }} cluster](../../managed-trino/operations/cluster-create.md), you can add a **Hive** folder and specify the {{ metastore-name }} URI, then {{ TR }} will get access to all tables defined in {{ metastore-name }}.

Integrating {{ mtr-short-name }} with {{ metastore-name }} is particularly useful for interactive analytics. Analysts can run SQL queries against {{ objstorage-name }} data without knowing its physical storage details. They work with table abstractions while {{ metastore-name }} and {{ TR }} handle all tasks related to data access.

For example, a business analyst can connect to {{ mtr-short-name }} via {{ websql-name }} or a BI tool, run complex analytical query against data processed using {{ dataproc-name }}, and get results in just a few seconds. There is no need to know file locations, partitioning methods, or storage formats: {{ TR }} retrieves all this information from {{ metastore-name }}.

## Some current aspects of using {{ metastore-name }} {#current-implementation}

Currently, there are some important aspects of using managed {{ metastore-name }} clusters in {{ yandex-cloud }} for you to consider when designing and deploying solutions.

The first one is service availability. Currently, {{ metastore-name }} only works with storage objects within {{ yandex-cloud }} and does not support connections to external S3-compatible storages. This means it cannot be used with data stored in services like Amazon S3 or MinIO deployed in private data centers.

Additionally, {{ metastore-name }} is only accessible via an internal VPC IP address and does not have a public DNS name. This provides additional security but requires all services connecting to {{ metastore-name }} to be in the same VPC or have configured network access.

One more aspect to consider is network security. For {{ metastore-name }} to work properly, you need to configure security groups correctly to allow the required network traffic. Othewise clusters may indicate a `DEAD` state, which makes it difficult to diagnose issues (see [Security group setup guide](../../metadata-hub/operations/metastore/configure-security-group.md)).

For more information about {{ metastore-name }}, see the [Apache® documentation](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore).
