---
title: "Component properties in {{ dataproc-full-name }}"
description: "In this tutorial, you will learn what cluster component properties are, how they are stored, and what settings they have."
---

# Component properties

The properties of cluster components, jobs, and environments are stored in the following format:

```text
<key>:<value>
```

The key can either be a simple string or contain a prefix indicating that it belongs to a [specific component](environment.md):

```text
<key_prefix>:<key_body>:<value>
```

Here is an example:

```text
hdfs:dfs.replication : 2
hdfs:dfs.blocksize : 1073741824
spark:spark.driver.cores : 1
```

## Updating component properties {#change-properties}

You can update the component properties in the following ways:

* At the cluster level when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md) it. The properties provided this way apply to any new cluster jobs by default.
* At the level of an individual [job](./jobs.md) when [creating](../operations/jobs.md) it. The properties provided this way only apply to this job and override the cluster-level properties set for it.

## Available component properties {#available-properties}

The available properties are listed in the official documentation for the components:

| Prefix | Path to the configuration file | Documentation |
|:---------------------|:----------------------------------------|:----------------------------------------------------------------------------------------------------------------------------|
| `core` | `/etc/hadoop/conf/core-site.xml` | [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml) |
| `hdfs` | `/etc/hadoop/conf/hdfs-site.xml` | [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml) |
| `yarn` | `/etc/hadoop/conf/yarn-site.xml` | [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml) |
| `mapreduce` | `/etc/hadoop/conf/mapred-site.xml` | [MapReduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml) |
| `capacity-scheduler` | `/etc/hadoop/conf/capacity-scheduler.xml` | [CapacityScheduler](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html) |
| `resource-type` | `/etc/hadoop/conf/resource-types.xml` | [ResourceTypes](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/ResourceModel.html) |
| `node-resources` | `/etc/hadoop/conf/node-resources.xml` | [NodeResources](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/ResourceModel.html) |
| `spark` | `/etc/spark/conf/spark-defaults.xml` | [Spark](https://spark.apache.org/docs/latest/configuration.html) |
| `hbase` | `/etc/hbase/conf/hbase-site.xml` | [HBASE](https://hbase.apache.org/book.html#config.files) |
| `hbase-policy` | `/etc/hbase/conf/hbase-policy.xml` | [HBASE](https://hbase.apache.org/book.html#config.files) |
| `hive` | `/etc/hive/conf/hive-site.xml` | [HIVE](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties) |
| `hivemetastore` | `/etc/hive/conf/hivemetastore-site.xml` | [HIVE Metastore](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties) |
| `hiveserver2` | `/etc/hive/conf/hiveserver2-site.xml` | [HIVE Server2](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties) |
| `tez` | `/etc/tez/conf/tez-site.xml` | [Tez 0.9.2](https://tez.apache.org/releases/0.9.2/tez-api-javadocs/configs/TezConfiguration.html) and [Tez 0.10.0](https://tez.apache.org/releases/0.10.0/tez-api-javadocs/configs/TezConfiguration.html) |
| `zeppelin` | `/etc/zeppelin/conf/zeppelin-site.xml` | [Zeppelin](https://zeppelin.apache.org/docs/0.9.0/setup/operation/configuration.html) |

Settings for running jobs are specified in special properties:

* `dataproc:version`: Version of the `dataproc-agent` that runs jobs, sends the property of a cluster state, and proxies the UI. This poperty is used for debugging. Its default value is `latest`.
* `dataproc:max-concurrent-jobs`: Number of concurrent jobs. The default value is `auto` (calculated based on the `min-free-memory-to-enqueue-new-job` and `job-memory-footprint` properties).
* `dataproc:min-free-memory-to-enqueue-new-job`: Minimum size of free memory to run a job, in bytes. The default value is `1073741824` (1 GB).
* `dataproc:job-memory-footprint`: Memory size to run a job on the cluster's master host, used to estimate the maximum number of jobs per cluster. The default value is `536870912` (512 MB).
* `dataproc:spark_executors_per_vm`: Maximum number of containers per computing host when running [Spark jobs](./spark-sql.md). The default values are:

   * `1`: For [lightweight clusters](./index.md#light-weight-clusters).
   * `2`: For clusters with HDFS.

* `dataproc:spark_driver_memory_fraction`: Computing host memory fraction reserved for the driver when running [Spark jobs](./spark-sql.md). The default value is `0.25`.

## JVM settings for Spark applications set in {{ dataproc-name }} by default {#jvm-settings-for-spark}

Generally, the following default settings are applied on the {{ dataproc-name }} clusters to improve JVM performance:

* **spark.driver.extraJavaOptions**:
   * `-XX:+UseConcMarkSweepGC`
   * `-XX:CMSInitiatingOccupancyFraction=70`
   * `-XX:MaxHeapFreeRatio=70`
   * `-XX:+CMSClassUnloadingEnabled`
   * `-XX:OnOutOfMemoryError='kill -9 %p'`
* **spark.executor.extraJavaOptions**:
   * `-verbose:gc`
   * `-XX:+PrintGCDetails`
   * `-XX:+PrintGCDateStamps`
   * `-XX:+UseConcMarkSweepGC`
   * `-XX:CMSInitiatingOccupancyFraction=70`
   * `-XX:MaxHeapFreeRatio=70`
   * `-XX:+CMSClassUnloadingEnabled`
   * `-XX:OnOutOfMemoryError='kill -9 %p'`

{% note info %}

Changing the `spark:spark.driver.defaultJavaOptions` or `spark:spark.executor.defaultJavaOptions` cluster properties for values conflicting with the `extraJavaOptions` settings may result in cluster configuration errors.

{% endnote %}

## Spark settings for integration with {{ objstorage-full-name }} {#spark-settings}

The following settings are available for Apache Spark:

| Setup | Default value | Description |
|:----------------------------------|:--------------------------------------------------------|:-----------------------------------------------------------------------------------|
| `fs.s3a.access.key` | N/A | [Static key](../../iam/concepts/authorization/access-key.md) ID |
| `fs.s3a.secret.key` | N/A | Secret key |
| `fs.s3a.endpoint` | `{{ s3-storage-host }}` | Endpoint to connect to {{ objstorage-name }} |
| `fs.s3a.signing-algorithm` | Empty value | Signature algorithm |
| `fs.s3a.aws.credentials.provider` | `org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider` | Credentials provider |

For more information, see the [Apache Hadoop documentation](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml).

## Installing Python packages {#python-packages-install}

To install additional Python packages, you can use the conda or pip package managers. Provide the package name in the cluster properties as follows:

| Package manager | Key | Value | Example |
|:------------------|:---------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------|
| conda | `conda:<package_name>` | Number of the package version according to the [conda specification](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/pkg-specs.html#package-match-specifications) | `conda:koalas : 1.5.0` |
| pip | `pip:<package_name>` | Number of the package version according to the [pip specification](https://www.python.org/dev/peps/pep-0440/#version-specifiers) | `pip:requests : 2.31.0` |

## Using Apache Spark Thrift Server {#spark-thrift-server}

You can use [Apache Spark Thrift Server](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html) as a distributed SQL query engine on top of Apache Spark.

To enable it, set `dataproc:hive.thrift.impl : spark`, and the server will be available on TCP port `10000`. The default value is `dataproc:hive.thrift.impl : hive`. It causes Apache HiveServer2 to launch on TCP port `10000` if the Hive service is being used.


This feature is available starting with [image version 2.0.48](../release-notes/images.md#2.0.48).

