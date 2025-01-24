---
title: Hybrid storage in {{ mgp-name }}
description: How hybrid storage works in a {{ mgp-full-name }} cluster.
---

# Hybrid storage in {{ mgp-name }}


{% note info %}

This feature is at the [Preview](../../overview/concepts/launch-stages.md) stage and is free of charge.

{% endnote %}


{{ mgp-name }} clusters support _hybrid storage_: some data can be stored in cluster storage and some in cold storage. By default, data is stored in cluster storage [on disks of the selected type](./storage.md). Data used rarely but meant to be stored for a long time can be moved from the cluster storage to a cold storage – to a {{ objstorage-full-name }} service bucket. This will make data storage [less costly](../pricing/index.md#rules-storage).

You can enable hybrid storage in {{ GP }} clusters when [creating](../operations/cluster-create.md) or [updating](../operations/update.md#change-additional-settings) a cluster.

{% note warning %}

Once hybrid storage is enabled in a cluster, you cannot disable it.

{% endnote %}

## Hybrid storage scope of use {#usage-scope}

You can use hybrid storage only for [append-optimized](./tables.md) tables. When you migrate data between cluster storage and cold storage, whole tables are migrated. Tables are processed using the [{{ YZ }} extension](../operations/extensions/yezzey.md) by {{ yandex-cloud }}.

The data of append-optimized tables is stored as a set of segment files, compressed and encrypted, in an {{ objstorage-name }} service bucket. The number of segment files depends on the number of segments in the cluster and on the table structure.

## I/O management when using hybrid storage {#io-planning}

When running SQL queries against append-optimized tables, there are many requests to segment files in storage. SQL query execution time depends on how efficiently you schedule I/O requests to segment files. If you do not use I/O request scheduling, storage performance is impaired, RAM consumption and SQL query execution time increase. Using the scheduler allows you to protect the cluster from performance degradation when executing SQL queries that involve processing massive amounts of data.

When data is stored in cluster storage, I/O request scheduling is performed by the operating system on the cluster hosts.

When data is stored in cold storage, the operating system cannot schedule I/O requests to the {{ objstorage-name }} service bucket. Therefore, to avoid performance degradation, {{ mgp-name }} clusters use YProxy by {{ yandex-cloud }} to schedule such requests. Even if the table resides in a cold storage, the use of YProxy minimizes the impact on SQL query execution time.

Learn more about hybrid storage architecture from [this Habr article](https://habr.com/en/companies/yandex_cloud_and_infra/articles/831780/). The article also provides performance tests for different types of storage.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
