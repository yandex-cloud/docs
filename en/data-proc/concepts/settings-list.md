# Component properties

When [creating a {{ dataproc-name }} cluster](../operations/cluster-create.md), you can specify the properties of cluster components, jobs, and environment in the following format:

```text
<key>:<value>
```

The key can either be a simple string or contain a prefix indicating that it belongs to a [specific component](environment.md):

```text
<key prefix>:<key body>:<value>
```

For example:

```text
hdfs:dfs.replication : 2
hdfs:dfs.blocksize : 1073741824
spark:spark.driver.cores : 1
```

The available properties are listed in the official documentation for the components:

| Prefix | Path to the configuration file | Documentation |
|:---------------------|:----------------------------------------|:----------------------------------------------------------------------------------------------------------------------------|
| `core` | `/etc/hadoop/conf/core-site.xml` | [Hadoop](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml) |
| `hdfs` | `/etc/hadoop/conf/hdfs-site.xml` | [HDFS](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml) |
| `yarn` | `/etc/hadoop/conf/yarn-site.xml` | [YARN](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-common/yarn-default.xml) |
| `mapreduce` | `/etc/hadoop/conf/mapred-site.xml` | [mapreduce](https://hadoop.apache.org/docs/current/hadoop-mapreduce-client/hadoop-mapreduce-client-core/mapred-default.xml) |
| `capacity-scheduler` | `/etc/hadoop/capacity-scheduler.xml` | [CapacityScheduler](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/CapacityScheduler.html) |
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

Settings for running the jobs are specified in special properties:

* `dataproc:version`: The version of the dataproc-agent that runs jobs, passes the property of a cluster state, and proxies the UI. Used for debugging. Default value: `latest`.
* `dataproc:max-concurrent-jobs`: The number of concurrent jobs. Default value: `auto` (calculated based on the `min-free-memory-to-enqueue-new-job` and `job-memory-footprint` properties).
* `dataproc:min-free-memory-to-enqueue-new-job`: The minimum size of free memory to run the job (in bytes). Default value: `1073741824` (1 GB).
* `dataproc:job-memory-footprint`: The memory size to run the job on the cluster's master host, used to estimate the maximum number of jobs in the cluster. Default value: `536870912` (512 MB).

## JVM settings for Spark applications set in {{ dataproc-name }} by default {#jvm-settings-for-spark}

In general cases, the following default settings are applied on the {{ dataproc-name }} clusters to improve JVM performance:

- **spark.driver.extraJavaOptions**
   `-XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:MaxHeapFreeRatio=70 -XX:+CMSClassUnloadingEnabled -XX:OnOutOfMemoryError='kill -9 %p'`
- **spark.executor.extraJavaOptions**
   `-verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=70 -XX:MaxHeapFreeRatio=70 -XX:+CMSClassUnloadingEnabled -XX:OnOutOfMemoryError='kill -9 %p'`

{% note info %}

Changing the cluster properties `spark:spark.driver.defaultJavaOptions` or `spark:spark.executor.defaultJavaOptions` for values conflicting with `extraJavaOptions` settings may result in cluster configuration errors.

{% endnote %}

## Spark settings for integration with {{ objstorage-full-name }} {#spark-settings}

The following settings are available for Apache Spark:

| Configuration | Default value | Description |
|:----------------------------------|:--------------------------------------------------------|:-----------------------------------------------------------------------------------|
| `fs.s3a.access.key` | — | [Static key](../../iam/concepts/authorization/access-key.md) ID |
| `fs.s3a.secret.key` | — | Private key |
| `fs.s3a.endpoint` | `{{ s3-storage-host }}` | Endpoint to connect to {{ objstorage-name }} |
| `fs.s3a.signing-algorithm` | Empty value | Signature algorithm |
| `fs.s3a.aws.credentials.provider` | `org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider` | Identity provider |

For more information, see the [Apache Hadoop documentation](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/core-default.xml).

## Installing Python packages {#python-packages-install}

To install additional Python packages, you can use the conda or pip package managers. Pass the package name in the cluster properties as follows:

| Package manager | Key | Value | Example |
|:------------------|:---------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------|
| conda | `conda:<package name>` | Number of the package version according to the [conda specification](https://docs.conda.io/projects/conda/en/latest/user-guide/concepts/pkg-specs.html#package-match-specifications) | `conda:koalas : 1.5.0` |
| pip | `pip:<package name>` | Number of the package version according to the [pip specification](https://www.python.org/dev/peps/pep-0440/#version-specifiers) | `pip:psycopg2 : 2.7.0` |

## Using Apache Spark Thrift Server {#spark-thrift-server}

You can use [Apache Spark Thrift Server](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html) as a distributed SQL query engine on top of Apache Spark.

To enable it, set `dataproc:hive.thrift.impl : spark`, and the server will be available on TCP port `10000`. The default value is `dataproc:hive.thrift.impl : hive`. It causes Apache HiveServer2 to launch on TCP port `10000` if the Hive service is being used.


The functionality is available starting with [image version 2.0.48](../release-notes/images.md#2.0.48).

