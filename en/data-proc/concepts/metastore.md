# {{ metastore-full-name }} clusters

{% include [Доступ по запросу](../../_includes/note-preview-by-request.md) %}

You can create [{{ metastore-full-name }} clusters](../operations/metastore/cluster-create.md) in {{ dataproc-name }}.

[{{ metastore-full-name }}](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore) is a table metadata server that:

* Provides client applications with the information on where to get the data to be processed and how to interpret them.
* Saves the table metadata between running the short-lived computing clusters.
* Shares the data space between the clusters run in parallel.
* Links together heterogeneous ETL systems and tools for working with shared data, simplifying their deployment.
* Provides fault tolerance, scalable storage, and metadata backup.
* Simplifies sending of logs and metrics, the processes of update and migration.

Several Apache products, including [Hive](https://hive.apache.org/), [Spark](https://spark.apache.org/), and [Impala](https://impala.apache.org/overview.html), can interact with {{ metastore-name }} directly.

For more information about {{ metastore-full-name }}, see the [Apache® documentation](https://cwiki.apache.org/confluence/display/hive/design#Design-Metastore).
