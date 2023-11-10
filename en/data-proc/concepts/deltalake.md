# Delta Lake in {{ dataproc-name }}

[Delta Lake](https://delta.io/) is open-source software that expands the functionality of [{{ SPRK }}](https://spark.apache.org/):

* Adds an optimized storage layer for table data with [ACID transaction](https://docs.delta.io/2.0.2/concurrency-control.html) support.
* Enables scalable processing of metadata.
* Allows updating data in analytical tables stored as Parquet files in HDFS or S3-compatible storage.
* Allows updating batch requests and running data streaming operations.

You can set up Delta Lake in {{ dataproc-name }} clusters:

* In [single-cluster mode](../operations/deltalake/one-cluster-mode.md) for {{ dataproc-name }} 2.0 and 2.1
* In [multi-cluster mode](../operations/deltalake/multi-cluster-mode.md) for {{ dataproc-name }} 2.1 and higher

Although single-cluster mode allows using tables from different clusters and {{ SPRK }} jobs, concurrent data writes from a variety of sources may lead to table data loss. To avoid this, additional setup of data writes is required.

In multi-cluster mode, access to Delta Lake tables from different clusters and {{ SPRK }} jobs is controlled by an auxiliary database. In {{ yandex-cloud }}, the [{{ ydb-full-name }}](../../ydb/index.yaml) database is used for that.


{% include [deltalake-disclaimer](../../_includes/data-proc/deltalake-disclaimer.md) %}


For more information about Delta Lake, see the [Delta Lake documentation](https://docs.delta.io/latest/index.html).

## Delta Lake and {{ dataproc-name }} version compatibility {#compatibility}

Delta Lake and {{ dataproc-name }} versions are only compatible if the Delta Lake version is compatible with the {{ SPRK }} version used in the cluster. The table below lists compatible versions and links to library files that you will need to set up Delta Lake in your cluster.

#|
|| **{{ dataproc-name }} version** | **{{ SPRK }} version** | **Delta Lake version**                                              | **JAR files**                                                                                                         ||
|| 2.0.x                          | 3.0.3                   | [0.8.0](https://github.com/delta-io/delta/releases/tag/v0.8.0)     | [delta-core_2.12-0.8.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar)  ||
|| 2.1.0 and 2.1.3                  | 3.2.1                   | [2.0.2](https://github.com/delta-io/delta/releases/tag/v2.0.2)     | [delta-core_2.12-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.0.2/delta-core_2.12-2.0.2.jar),
[delta-storage-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.0.2/delta-storage-2.0.2.jar)        ||
|| 2.1.4 and higher                   | 3.3.2                   | [2.3.0](https://github.com/delta-io/delta/releases/tag/v2.3.0)     | [delta-core_2.12-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.3.0/delta-core_2.12-2.3.0.jar),
[delta-storage-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.3.0/delta-storage-2.3.0.jar)        ||
|#

{% note info %}

{{ dataproc-name }} clusters 2.1.x are at the [Preview stage](../../overview/concepts/launch-stages.md) and provided upon request. Please contact [support]({{ link-console-support }}) or your account manager.

{% endnote %}

## Main advantages of Delta Lake 2.x {#advantages}

Main advantages of Delta Lake 2.x as compared to version 0.8.0 include:

* Support for [multi-cluster mode](https://docs.delta.io/2.0.2/delta-storage.html#multi-cluster-setup) provides automated orchestration of changes to data in a single table from different {{ SPRK }} jobs and {{ dataproc-name }} clusters.
* The [idempotent data write](https://docs.delta.io/latest/delta-streaming.html#idempotent-table-writes-in-foreachbatch) feature allows maintaining exactly-once processing of data streams.
* The [Change Data Feed](https://docs.delta.io/2.0.2/delta-change-data-feed.html) feature allows tracking changes to data in Delta Lake tables.
* The [Z-Ordering](https://docs.delta.io/2.0.2/optimizations-oss.html#z-ordering-multi-dimensional-clustering) feature implements multidimensional clustering of Delta Lake tables. It speeds up execution of requests with restrictions on columns used for clustering.
* Support for [dynamic partition overwrites](https://docs.delta.io/2.0.2/delta-batch.html#dynamic-partition-overwrites).
* [Request performance optimization](https://docs.delta.io/2.0.2/optimizations-oss.html#compaction-bin-packing) by merging small files into larger ones.
* Support for [table rollbacks](https://docs.delta.io/2.0.2/delta-utility.html#restore-a-delta-table-to-an-earlier-state) to the previous state.
