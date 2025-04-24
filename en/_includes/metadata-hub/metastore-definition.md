You can create [{{ metastore-full-name }}](../../metadata-hub/operations/metastore/cluster-create.md) clusters in {{ metadata-hub-name }}.

[{{ metastore-full-name }}](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore) is a table metadata server that:

* Provides client applications with the information on where to get the data to process and how to interpret it.
* Saves the table metadata between running the short-lived computing clusters.
* Shares the data space between concurrently run clusters.
* Links together different ETL systems and tools for working with shared data and simplifies their deployment.
* Provides [fault tolerance](../../architecture/fault-tolerance.md), scalable storage, and metadata backup.
* Simplifies sending logs and metrics, as well as the update and migration processes.
* Has a key role in cloud data processing scenarios by enabling different tools (Spark, Trino, Hive) to access the same metadata.

Some Apache products, including [Hive](https://hive.apache.org/), [Spark](https://spark.apache.org/), and [Impala](https://impala.apache.org/overview.html), feature {{ metastore-name }} support.