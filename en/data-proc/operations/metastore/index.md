---
noIndex: true
---

# What is {{ metastore-full-name }}

[{{ metastore-full-name }}](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore) is a table metadata server that:

* Provides client applications with the information on where to get the data to be processed and how to interpret them.
* Saves the table metadata between running short-lived
   computing clusters.
* Shares the data space between the clusters
   run in parallel.
* Links together heterogeneous ETL systems and tools for working with shared data, simplifying their deployment.
* Provides fault tolerance, scalable storage, and metadata backup.
* Simplifies sending of logs and metrics, the processes of update and migration.

Several Apache products, including [Hive](https://hive.apache.org/), [Spark](https://spark.apache.org/), [Impala](https://impala.apache.org/overview.html) can work with {{ metastore-name }} directly.

You can:

* [Creating a {{ metastore-name }} server](./cluster-create.md).
* [Connecting {{ dataproc-name }} to {{ metastore-name }}](./dataproc-connect.md).
* [Deleting a {{ metastore-name }} server](./cluster-delete.md).
