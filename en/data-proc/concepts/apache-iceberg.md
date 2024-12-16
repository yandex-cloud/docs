---
title: '{{ IBRG }} in {{ dataproc-full-name }}'
description: Below is the information about {{ IBRG }} and the compatibility table for different {{ IBRG }} and {{ dataproc-full-name }} versions.
---

# {{ IBRG }} in {{ dataproc-name }}

[{{ IBRG }}](https://iceberg.apache.org/) is an [open table format](https://iceberg.apache.org/spec/) for storing and processing large data arrays. It expands the feature set of the [{{ SPRK }}](https://spark.apache.org/) platform:

* Supports the high-performance {{ IBRG }} tables you use the same way as regular SQL tables.
* Provides the [schema evolution](https://iceberg.apache.org/docs/latest/evolution/#schema-evolution) mechanism which eliminates side effects when updating schemas.
* Provides [hidden partitioning](https://iceberg.apache.org/docs/latest/partitioning/) in auto mode thus preventing errors related to manual partitioning.
* Allows retrospective requests enabled by the [time travel](https://iceberg.apache.org/docs/latest/spark-queries/#time-travel) mechanism. You can use the feature to make reproducible requests based on table snapshots or compare changes.

   {% note info %}

   This mechanism requires {{ SPRK }} 3.3.x or higher.

   {% endnote %}

* Allows rolling tables back to previous versions (version rollback) for quick response to issues.
* Provides [advanced filtering](https://iceberg.apache.org/docs/latest/performance/#metadata-filtering) that relies on column-level and partition-level statistics as well as table metadata. This accelerates request processing, even for very large tables: data files unrelated to the request will not be processed.
* Enables the [serializable](https://iceberg.apache.org/docs/latest/reliability/) isolation level — the strictest one for transaction isolation. All changes in tables are atomic, and the readers will see only the committed ones.
* Supports [concurrent writing](https://iceberg.apache.org/docs/latest/reliability/#concurrent-write-operations) based on the optimistic strategy: a writer will retry an operation if their changes are in conflict with those of another writer.

You can [configure {{ IBRG }} in a {{ dataproc-name }} cluster](../operations/apache-iceberg.md) versions 2.0 or higher.


{% include [apache-iceberg-disclaimer](../../_includes/data-processing/apache-iceberg-disclaimer.md) %}


For more information about {{ IBRG }}, see the [official documentation](https://iceberg.apache.org/docs/latest/).

## Compatibility between {{ IBRG }} versions and {{ dataproc-name }} images {#compatibility}

{{ IBRG }} versions and {{ dataproc-name }} images are only compatible if the {{ IBRG }} version is compatible with the {{ SPRK }} version used in the cluster. The table below lists compatible versions and links to the library files you will need to configure {{ IBRG }} in your cluster.

#|
|| **{{ dataproc-name }} image** | **{{ SPRK }} version**   | **{{ IBRG }} version** | **JAR files**     ||
|| 2.0.x                          | 3.0.3
| [1.0.0](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.0.0)
| [{{ dp-libs.iceberg.dp20.jar }}]({{ dp-libs.iceberg.dp20.repo }}) ||
|| 2.1.x (2.1.0–2.1.3)            | 3.2.1
| [1.4.3](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.4.3)
| [{{ dp-libs.iceberg.dp21.spark32.jar }}]({{ dp-libs.iceberg.dp21.spark32.repo }}) ||
|| 2.1.x (2.1.4 and higher)           | 3.3.2
| [1.5.2](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.5.2)
| [{{ dp-libs.iceberg.dp21.spark33.jar }}]({{ dp-libs.iceberg.dp21.spark33.repo }}) ||
|| 2.2.x                          | 3.5.0
| [1.5.2](https://github.com/apache/iceberg/releases/tag/apache-iceberg-1.5.2)
| [{{ dp-libs.iceberg.dp22.jar }}]({{ dp-libs.iceberg.dp22.repo }}) ||
|#


{% note info %}

Access to image 2.2 is provided on request. Contact [technical support]({{ link-console-support }}) or your account manager.

{% endnote %}

