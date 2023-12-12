---
title: "{{ metastore-full-name }} clusters"
description: "You can create {{ metastore-full-name }} clusters in {{ dataproc-name }}."
---

# {{ metastore-full-name }} clusters

{% include [Доступ по запросу](../../_includes/note-preview-by-request.md) %}

You can create [{{ metastore-full-name }} clusters](../operations/metastore/cluster-create.md) in {{ dataproc-name }}.

[{{ metastore-full-name }}](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore) is a table metadata server that:

* Provides client applications with the information on where to get the data to process and how to interpret it.
* Saves the table metadata between running the short-lived computing clusters.
* Shares the data space between concurrently run clusters.
* Links together different ETL systems and tools for working with shared data and simplifies their deployment.
* Provides fault tolerance, scalable storage, and metadata backup.
* Simplifies sending logs and metrics, as well as the update and migration processes.

Certain Apache products, such as [Hive](https://hive.apache.org/), [Spark](https://spark.apache.org/), and [Impala](https://impala.apache.org/overview.html), support working directly with {{ metastore-name }}.

For more information about {{ metastore-full-name }}, see the [Apache® documentation](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore).
