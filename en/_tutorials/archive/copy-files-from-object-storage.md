# Using {{ objstorage-full-name }} in {{ dataproc-name }}

This section describes the ways processes running in {{ dataproc-name }} clusters can access objects in {{ objstorage-name }} [buckets](../../storage/concepts/bucket.md).

{% note info %}

[Configure a cluster network](../../data-proc/tutorials/configure-network.md) before setting up access to the {{ yandex-cloud }} services and internet resources.

{% endnote %}

Component settings impact bucket file read and write speed:

* The settings specified when [creating](../../data-proc/operations/cluster-create.md) a cluster affect all the jobs running in the cluster.
* The settings specified when creating jobs override cluster-level settings and can be job-specific.

## DistCp {#distcp}

To copy files from {{ objstorage-name }} to HDFS, use [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html). This utility helps copy data both within a cluster and between clusters and external storage.

To authenticate in {{ objstorage-name }}:

1. Use the [IAM token of the cluster service account](../../iam/operations/iam-token/create-for-sa.md).
1. Use [CredentialProvider](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/CredentialProviderAPI.html).
1. Provide the `access key` and `secret key` parameters of [static access keys](../../iam/concepts/authorization/access-key.md) when creating jobs.

### Accessing S3 with authentication via the IAM token of a cluster service account {#s3-access-using-iam}

1. When creating a cluster, specify a [service account](../../iam/operations/sa/create.md#create-sa). If you already have the cluster, add a service account using the **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** button in the management console.

    Make sure to [assign](../../iam/operations/sa/assign-role-for-sa.md) the following roles to the service account:

    {% include [sa-roles](../../_includes/data-processing/sa-roles.md) %}

1. The service account must have access to the relevant bucket. Therefore, grant the service account permissions in the [bucket ACL](../../storage/concepts/acl), or the `storage.viewer` or `storage.editor` role.

    For more information about these roles, see the [{{ objstorage-name }} documentation](../../storage/security/index.md).

> For example, to get a list of files located in the `yc-mdb-examples` public bucket at `dataproc/example01/set01` you need to [connect](../../data-proc/operations/connect.md) to the cluster and run the command:
>
> ```bash
> hadoop fs -ls s3a://yc-mdb-examples/dataproc/example01/set01
> ```
>
> Result:
> 
> ```text
> Found 12 items
> -rw-rw-rw-   1 root root   19327838 2019-09-13 17:17 s3a://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_1.parquet
> -rw-rw-rw-   1 root root   21120204 2019-09-13 17:17 s3a://yc-mdb-examples/dataproc/example01/set01/On_Time_Reporting_Carrier_On_Time_Performance_(1987_present)_2018_10.parquet
> -rw-rw-rw-   1 root root   20227757 2019-09-13 17:17 s3a://yc-mdb-examples/dataproc/example01/set01/
> ...
> ```

### Copying via CredentialProvider {#copying-via-credentialprovider}

To use a secret storage provider, place the secrets within the components that need access to {{ objstorage-name }}. To do this, you can use [JCEKS](https://docs.oracle.com/javase/8/docs/technotes/guides/security/crypto/CryptoSpec.html) (Java Cryptography Extension KeyStore). 
In this example, you first create a file with secrets and then place it in HDFS:

1. Specify the static and secret keys, e.g.:

    ```bash
    hadoop credential create fs.s3a.access.key \
           -value <static_key> \
           -provider localjceks://file/home/jack/yc.jceks && \
    hadoop credential create fs.s3a.secret.key \
           -value <secret_key> \
           -provider localjceks://file/home/jack/yc.jceks
    ```

1. Copy the secrets file to your local HDFS:

    ```bash
    hdfs dfs -put /home/jack/yc.jceks /user/root/
    ```

1. Copy the file from {{ objstorage-name }} directly to HDFS:

    ```bash
    hadoop distcp \
           -D fs.s3a.bucket.dataproc-examples.endpoint={{ s3-storage-host }} \
           -D hadoop.security.credential.provider.path=jceks://hdfs/user/root/yc.jceks \
           -update \
           -skipcrccheck \
           -numListstatusThreads 10 \
           s3a://yc-mdb-examples/dataproc/example01/set01 \
           hdfs://<HDFS_host>/<path>/
    ```

    `<HDFS_host>`: Your target HDFS server. You can get the default server using this command:

    ```bash
    hdfs getconf -confKey fs.defaultFS
    ```

Example of the command to copy files from the bucket:

```bash
hadoop distcp \
       -D fs.s3a.bucket.dataproc-examples.endpoint={{ s3-storage-host }} \
       -D hadoop.security.credential.provider.path=jceks://hdfs/user/root/yc.jceks \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.{{ dns-zone }}/user/root/datasets/set01/
```

### Copying files by providing keys in arguments {#copying-files-by-passing-keys-in-arguments}

Instead of creating a secrets file, you can provide keys in the command arguments:

```bash
hadoop distcp \
       -D fs.s3a.bucket.dataproc-examples.endpoint={{ s3-storage-host }} \
       -D fs.s3a.bucket.dataproc-examples.access.key=<static_key> \
       -D fs.s3a.bucket.dataproc-examples.secret.key=<secret_key> \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.{{ dns-zone }}/user/root/datasets/set01/
```


## Optimizing file reads from {{ objstorage-name }} {#s3-read-optimize}

The `fs.s3a.experimental.input.fadvise` [setting](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/performance.html#Improving_data_input_performance_through_fadvise) defines bucket data reads. Its value depends on the image version used:

* Image versions `1.0` through `1.4` use `sequential` as the default value. It is a good choice for sequential file reads, but slow for random access. If you use random file access more frequently, add `random` to the cluster component properties or job settings.
* For version `2.0` images, the default is `normal`: file reads are sequential; however, if an application accesses data randomly, the `random` mode activates automatically.

For more information on the component versions used, see [{#T}](../../data-proc/concepts/environment.md).


## Optimizing file writes to {{ objstorage-name }} {#s3-write-optimize}

To speed up file writes to {{ objstorage-name }}, you can:

* [Use S3A committers](#s3a-committers).
* [Configure Apache Hadoop](#s3-write-optimize-hadoop).
* [Configure Apache Spark](#s3-write-optimize-spark).

### Using S3A committers {#s3a-committers}

S3A committers are Apache Hadoop software modules used for writing data to an object storage over the S3 protocol to ensure efficient and near-atomic commits of the changes made. For more information, see the [Apache Hadoop](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/committers.html) and [Apache Spark](https://spark.apache.org/docs/3.5.3/cloud-integration.html) documentation.

{% note info %}

S3A committers are not used or required for operations with tables managed using the tools of the [DeltaLake](https://delta.io) library that implements its own logic of working with data in object storages.

{% endnote %}

S3A committers run in three basic modes:

| Mode         | Environment            | HDFS required             | Writing data to partitioned</br>tables | Write speed |
|---------------|------------------|----------------------------|-------------------------------------|-----------------|
| `directory`   | MapReduce, Spark | Yes^*^                      | Complete overwrite                   | Standard         |
| `magic`       | MapReduce, Spark | No (data writes directly to S3) | Not supported                   | Maximum    |
| `partitioned` | Spark            | Yes^*^                      | Replacing and appending partitions        | Standard         |

^*^ In the `directory` and `partitioned` modes, there are no checks for actual presence of HDFS for storing intermediate data. Some jobs may be successfully completed without HDFS. However, this may cause issues with complex jobs, such as _file not found_ errors or incomplete writes of job results to {{ objstorage-name }}.

To enable S3A committers, [set](../../data-proc/concepts/settings-list.md) the following:

* `core:fs.s3a.committer.magic.enabled : true` if jobs will use the `magic` mode.
* `core:fs.s3a.committer.name` with `directory`, `magic`, or `partitioned` as the default mode.
* `core:fs.s3a.committer.staging.abort.pending.uploads : false` for Hadoop 3.2.2 as part of the [{{ dataproc-name }}](../../data-proc/concepts/environment.md#current-images) image 2.0, or `core:fs.s3a.committer.abort.pending.uploads : false` for Hadoop 3.3.2 as part of image 2.1 if multiple concurrent jobs are writing data to the same table.
* `core:mapreduce.outputcommitter.factory.scheme.s3a : org.apache.hadoop.fs.s3a.commit.S3ACommitterFactory`.
* `spark:spark.hadoop.fs.s3a.committer.name` with `directory`, `magic`, or `partitioned` as the default mode.
* `spark:spark.sql.parquet.output.committer.class : org.apache.spark.internal.io.cloud.BindingParquetOutputCommitter`.
* `spark:spark.sql.sources.commitProtocolClass : org.apache.spark.internal.io.cloud.PathOutputCommitProtocol`.
* Optionally, `core:fs.s3a.committer.staging.conflict-mode`: Action if existing data partitions are found in the target table (for the `partitioned` mode):
    * `append`: Append new data to an existing partition.
    * `fail`: When attempting to overwrite an existing partition, the job terminates with an error.
    * `replace`: Existing partition data is replaced with new partition data.

The current S3A committer mode may be overridden for a specific job by setting `fs.s3a.committer.name` and `spark.hadoop.fs.s3a.committer.name` to `directory`, `magic`, or `partitioned` as required.

Do not change the default value for `spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version` because {{ objstorage-full-name }} does not support atomic folder renames.

### Apache Hadoop settings {#s3-write-optimize-hadoop}

The `core:fs.s3a.fast.upload` setting defines data writes to an {{ objstorage-name }} bucket. Its value depends on the image version used:

* Image versions `1.0` through `1.4` use `false` as the default value to save RAM. Set it to `true` in the cluster component properties or job settings. This will speed up bucket writes of large files and prevent node storages from filling up.
* In image `2.0`, `fs.s3a.fast.upload` is enabled by default.

If required, specify values for [other settings](https://hadoop.apache.org/docs/r2.10.0/hadoop-aws/tools/hadoop-aws/index.html) for the write mode in {{ objstorage-name }}:

* `fs.s3a.committer.threads`: Number of threads committing changes in {{ objstorage-name }} towards the end of the job.
* `fs.s3a.connection.maximum`: Number of allowed {{ objstorage-name }} connections.
* `fs.s3a.connection.timeout`: Maximum {{ objstorage-name }} connection timeout in milliseconds.
* `fs.s3a.fast.upload.active.blocks`: Maximum number of blocks in a single output thread.
* `fs.s3a.fast.upload.buffer`: Type of buffer used for temporary storage of the upload data:
    * `disk`: Save data to the folder specified in `fs.s3a.buffer.dir`.
    * `array`: Use arrays in the JVM heap.
    * `bytebuffer`: Use RAM from outside the JVM heap.
* `fs.s3a.max.total.tasks`: Size of queued {{ objstorage-name }} bucket operations that cannot run due to reaching the thread limit.
* `fs.s3a.multipart.size`: Size of data chunks in bytes when copying or uploading to a bucket.
* `fs.s3a.threads.max`: Number of threads in the AWS Transfer Manager.

{% note info %}

Large values of these parameters may increase the usage of computing resources on {{ dataproc-name }} cluster hosts.

{% endnote %}

For more information, see the [Apache Hadoop documentation](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/performance.html) and the [Component properties](../../data-proc/concepts/settings-list.md) section.

### Apache Spark settings {#s3-write-optimize-spark}

When accessing data in {{ objstorage-name }} from Spark jobs, we recommend setting `spark.sql.hive.metastorePartitionPruning` to `true`.

When working with data in Parquet format, use the following Spark job settings:

* `spark.hadoop.parquet.enable.summary-metadata : false`
* `spark.sql.parquet.mergeSchema : false`
* `spark.sql.parquet.filterPushdown : true`

When working with data in Parquet format and using dynamic partition overwrites, use the following settings:

* `spark:spark.sql.sources.partitionOverwriteMode : dynamic`
* `spark:spark.sql.parquet.output.committer.class : org.apache.parquet.hadoop.ParquetOutputCommitter`
* `spark:spark.sql.sources.commitProtocolClass : org.apache.spark.sql.execution.datasources.SQLHadoopMapReduceCommitProtocol`

When working with data in Orc format, use the following Spark job settings:

* `spark.sql.orc.cache.stripe.details.size : 10000`
* `spark.sql.orc.filterPushdown : true`
* `spark.sql.orc.splits.include.file.footer : true`

It may take a long time for the jobs creating or updating massive numbers (hundreds and thousands) of table partitions to update partition records in the [{{ metastore-full-name }} cluster](../../metadata-hub/concepts/metastore.md). To speed up this process, increase the following values:

* `hive:datanucleus.connectionPool.maxPoolSize`: Maximum size of the {{ metastore-name }} DB connection pool.
* `hive:hive.metastore.fshandler.threads`: Number of threads running background operations with the file system within {{ metastore-name }}.
* `spark:spark.sql.addPartitionInBatch.size`: Number of partitions updated per {{ metastore-name }} call. The optimal value is `10 × <hive:hive.metastore.fshandler.threads_setting_value>` or higher.

{% note info %}

If these values are excessively high, you may run out of {{ metastore-name }} system resources. A large {{ metastore-name }} database connection pool may require updating the settings and ramping up the cluster's computing resources.

{% endnote %}

For more information, see the [Apache Spark documentation](https://spark.apache.org/docs/3.5.3/cloud-integration.html) and the [Component properties](../../data-proc/concepts/settings-list.md) section.

## Using s3fs {#s3fs}

`s3fs` allows mounting {{ objstorage-name }} buckets using Fuse. [Read more about using s3fs](../../storage/tools/s3fs.md).

## Using {{ objstorage-name }} from Spark {#objstorage-spark}

{% list tabs %}

- Spark Shell

  Enable the access option you need:

  * Using JCEKS:

    ```scala
    sc.hadoopConfiguration.set("fs.s3a.endpoint", "{{ s3-storage-host }}");
    sc.hadoopConfiguration.set("fs.s3a.signing-algorithm", "");
    sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider");
    sc.hadoopConfiguration.set("hadoop.security.credential.provider.path", "jceks://hdfs/<path_to_JCEKS_file>");
    ```

  * Using your access key and secret:

    ```scala
    sc.hadoopConfiguration.set("fs.s3a.endpoint", "{{ s3-storage-host }}");
    sc.hadoopConfiguration.set("fs.s3a.signing-algorithm", "");
    sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider");
    sc.hadoopConfiguration.set("fs.s3a.access.key","<access_key>");
    sc.hadoopConfiguration.set("fs.s3a.secret.key","<bucket_secret>");
    ```

  You can then read the file from {{ objstorage-name }}:

  ```scala
  val sqlContext = new org.apache.spark.sql.SQLContext(sc)
  val df = sqlContext.read.parquet("s3a://<bucket_name>/<object_path>")
  ```

- PySpark Shell

  Select the access method:

  * Accessing the {{ objstorage-name }} objects using JCEKS:

    ```python
    sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "{{ s3-storage-host }}")
    sc._jsc.hadoopConfiguration().set("fs.s3a.signing-algorithm", "")
    sc._jsc.hadoopConfiguration().set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider")
    sc._jsc.hadoopConfiguration().set("hadoop.security.credential.provider.path", "jceks://hdfs/<path_to_JCEKS_file>")
    ```

  * Reading a file using an access key and bucket secret:

    ```python
    sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "{{ s3-storage-host }}")
    sc._jsc.hadoopConfiguration().set("fs.s3a.signing-algorithm", "")
    sc._jsc.hadoopConfiguration().set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider")
    sc._jsc.hadoopConfiguration().set("fs.s3a.access.key","<access_key>")
    sc._jsc.hadoopConfiguration().set("fs.s3a.secret.key","<bucket_secret>")
    ```

  Once you have access, you can read the file directly from {{ objstorage-name }}:

  ```python
  from pyspark.sql import SQLContext

  sql = SQLContext(sc)
  df = sql.read.parquet("s3a://<bucket_name>/<object_path>")
  ```

{% endlist %}

For more information, see [{#T}](../../data-proc/concepts/settings-list.md#spark-settings).
