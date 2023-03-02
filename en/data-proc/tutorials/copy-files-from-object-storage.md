# Using {{ objstorage-full-name }} in {{ dataproc-name }}

This section describes various ways that processes running in {{ dataproc-name }} clusters can access objects from {{ objstorage-name }} [buckets](../../storage/concepts/bucket.md).

{% note info %}

[Configure a cluster network](./configure-network.md) before setting up access to {{ yandex-cloud }} services and internet resources.

{% endnote %}

Component settings impact bucket file read and write performance:

* The settings specified when [creating](../operations/cluster-create.md) a cluster affect all the jobs running in the cluster.
* The settings specified when creating jobs override cluster-level settings and can be job-specific.

## DistCp {#distcp}

To copy files from {{ objstorage-name }} to HDFS, use the [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html) utility. It is designed to copy data both within a cluster and between clusters and external storage.

To authenticate in {{ objstorage-name }}, you can use one of the following approaches:

1. Use the [IAM token of the cluster service account](../../iam/operations/iam-token/create-for-sa.md).
1. Use [CredentialProvider](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/CredentialProviderAPI.html).
1. Pass the `access key` and `secret key` parameters of [static access keys](../../iam/concepts/authorization/access-key.md) when creating a job.

### Accessing S3 with authentication via the IAM token of a cluster service account {#s3-access-using-iam}

1. When creating a cluster, specify a [service account](../../iam/operations/sa/create.md#create-sa). If a cluster is already created, add a service account using the **Edit cluster** button in the management console.

1. The service account must have access to the appropriate bucket. To do this, grant the service account privileges in the [bucket ACL](../../storage/concepts/acl), or the `storage.viewer` or `storage.editor` roles.

   For more information about these roles, see the [{{ objstorage-name }} documentation](../../storage/security/index.md).

> For example, get a list of files located in the `yc-mdb-examples` public bucket at the path `dataproc/example01/set01`. To do this, [connect](../operations/connect.md) to the cluster and run the command:
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

1. Specify the `access key` and `secret key`, for example:

   ```bash
   hadoop credential create fs.s3a.access.key \
          -value <access key> \
          -provider localjceks://file/home/jack/yc.jceks && \
   hadoop credential create fs.s3a.secret.key \
          -value <secret key> \
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
          hdfs://<HDFS host>/<path>/
   ```

   `<HDFS host>` is the target HDFS server you use. You can get the default server using the command:

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

### Copying files by passing keys in arguments {#copying-files-by-passing-keys-in-arguments}

Instead of creating a secrets file, you can pass keys in the command arguments:

```bash
hadoop distcp \
       -D fs.s3a.bucket.dataproc-examples.endpoint={{ s3-storage-host }} \
       -D fs.s3a.bucket.dataproc-examples.access.key=<access_key> \
       -D fs.s3a.bucket.dataproc-examples.secret.key=<secret_key> \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.{{ dns-zone }}/user/root/datasets/set01/
```

{% if product == "yandex-cloud" %}

## Optimizing file reads from {{ objstorage-name }} {#s3-read-optimize}

The method for reading data from a bucket depends on the `fs.s3a.experimental.input.fadvise` [setting](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/performance.html#Improving_data_input_performance_through_fadvise). Its value depends on the image version used:

* In image versions `1.0` through `1.4`, the default value is `sequential`. It is a good choice for sequential file reads, but slow for random access. If you use random file access more frequently, add `random` to the cluster component properties or job settings.
* For version `2.0` images, the default is `normal`: files are accessed sequentially but if an application is performing random access operations, the mode automatically switches to `random`.

For more information on the component versions used, see [{#T}](../concepts/environment.md).

{% endif %}

## Optimizing file writes to {{ objstorage-name }} {#s3-write-optimize}

To speed up file writes to {{ objstorage-name }}, you can:

* [Use S3A committers](#s3a-committers).
* [Configure the Apache Hadoop settings](#s3-write-optimize-hadoop).
* [Configure the Apache Spark settings](#s3-write-optimize-spark).

### Using S3A committers {#s3a-committers}

S3A committers are Apache Hadoop software modules used for writing data to object storage over the {% if product == "yandex-cloud" and lang == "ru" %}[S3 protocol](../../glossary/s3.md){% else %}S3 protocol{% endif %} to ensure efficient and near-atomic commits of the changes made. For more information, see the [Apache Hadoop](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/committers.html) and [Apache Spark](https://spark.apache.org/docs/3.0.3/cloud-integration.html) documentation.

{% note info %}

S3A committers are not used or required for operations with tables that are managed using the tools of the [DeltaLake](https://delta.io) library that implements its own logic of working with data in object stores.

{% endnote %}

S3A committers run in three basic modes:

| Mode | Environment | HDFS is required | Writing data to partitioned</br>tables | Write speed |
|---------------|------------------|----------------------------|-------------------------------------|-----------------|
| `directory` | MapReduce, Spark | Yes^*^ | Complete overwrite | Standard |
| `magic` | MapReduce, Spark | No (data is written directly to S3) | Not supported | Maximum |
| `partitioned` | Spark | Yes^*^ | Replacing partitions and appending them | Standard |

^*^ In `directory` and `partitioned` modes, no checks are made for whether there is HDFS for storing intermediate data. Some jobs may be successfully completed with no HDFS used. However, this might cause issues with complex jobs, such as "file not found" errors or incomplete uploads of job results to {{ objstorage-name }}.

To enable S3A committers, specify the values of the following [settings](../concepts/settings-list.md):

* `core:fs.s3a.committer.magic.enabled : true` if jobs are to run in `magic` mode.
* `core:fs.s3a.committer.name`: Default mode (`directory`, `magic`, or `partitioned`).
* `core:fs.s3a.committer.staging.abort.pending.uploads : false` for Hadoop 3.2.2 as part of the [{{ dataproc-name }} image](../concepts/environment.md#current-images) version 2.0 or `core:fs.s3a.committer.abort.pending.uploads : false` for Hadoop 3.3.2 as part of the image version 2.1, if multiple concurrent jobs are writing data to the same table.
* `core:mapreduce.outputcommitter.factory.scheme.s3a : org.apache.hadoop.fs.s3a.commit.S3ACommitterFactory`.
* `spark:spark.hadoop.fs.s3a.committer.name`: Default mode (`directory`, `magic`, or `partitioned`).
* `spark:spark.sql.parquet.output.committer.class : org.apache.spark.internal.io.cloud.BindingParquetOutputCommitter`.
* `spark:spark.sql.sources.commitProtocolClass : org.apache.spark.internal.io.cloud.PathOutputCommitProtocol`.
* (Optional) `core:fs.s3a.committer.staging.conflict-mode`: Action to perform if any existing data partitions are found in the target table (for `partitioned` mode):
   * `append`: Append new data to an existing partition.
   * `fail`: When making an attempt to overwrite the existing partition, the job fails.
   * `replace`: Data in the existing partition is replaced with a new partition's data.

The used S3A committer mode may be overridden for a specific job by setting `fs.s3a.committer.name` and `spark.hadoop.fs.s3a.committer.name` to the appropriate value (`directory`, `magic`, or `partitioned`).

Do not change the default `spark.hadoop.mapreduce.fileoutputcommitter.algorithm.version` setting value, since {{ objstorage-full-name }} does not support atomic directory renames.

### Apache Hadoop settings {#s3-write-optimize-hadoop}

{% if product == "yandex-cloud" %}

The method of writing data to a {{ objstorage-name }} bucket depends on the `core:fs.s3a.fast.upload` setting. Its value depends on the image version used:

* In image versions `1.0` through `1.4`, the default value is `false` to save RAM. Set this property to `true` in the cluster component properties or the job settings. This will improve bucket write performance for large files and prevent node storage from filling up.
* In image `2.0`, the `fs.s3a.fast.upload` setting is enabled by default.

{% endif %}

{% if product == "cloud-il" %}

The method of writing data to a {{ objstorage-name }} bucket depends on the `core:fs.s3a.fast.upload` setting. In all {{ dataproc-name }} image versions, it is enabled by default.

{% endif %}

If required, set values for [other settings](https://hadoop.apache.org/docs/r2.10.0/hadoop-aws/tools/hadoop-aws/index.html) responsible for write mode in {{ objstorage-name }}:

* `fs.s3a.committer.threads`: Number of threads that are committing changes in {{ objstorage-name }} when the job is completed.
* `fs.s3a.connection.maximum`: Number of allowed {{ objstorage-name }} connections.
* `fs.s3a.connection.timeout`: Maximum {{ objstorage-name }} connection timeout in milliseconds.
* `fs.s3a.fast.upload.active.blocks`: Maximum number of blocks in a single output stream.
* `fs.s3a.fast.upload.buffer`: Type of buffer used for the temporary storage of uploaded data:
   * `disk`: Data is saved to the folder specified in the `fs.s3a.buffer.dir` setting.
   * `array`: Arrays on the JVM heap are used.
   * `bytebuffer`: RAM from outside the JVM heap is used.
* `fs.s3a.max.total.tasks`: Size of queued {{ objstorage-name }} bucket operations that cannot be run due to reaching the thread limit.
* `fs.s3a.multipart.size`: Size of chunks in bytes that data bucket copy or upload operations will partition the data into.
* `fs.s3a.threads.max`: Number of threads in the AWS Transfer Manager.

{% note info %}

Large values of these parameters might cause an increase in the usage of computing resources on {{ dataproc-name }} cluster hosts.

{% endnote %}

For more information, see the [Apache Hadoop documentation](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/performance.html) and the [Component properties](../concepts/settings-list.md) section.

### Apache Spark settings {#s3-write-optimize-spark}

When accessing data in {{ objstorage-name }} from Spark jobs, we recommend setting `spark.sql.hive.metastorePartitionPruning` to `true`.

When working with data in Parquet format, the following Spark job settings are recommended:

* `spark.hadoop.parquet.enable.summary-metadata : false`
* `spark.sql.parquet.mergeSchema : false`
* `spark.sql.parquet.filterPushdown : true`

When working with data in Orc format, the following Spark job settings are recommended:

* `spark.sql.orc.cache.stripe.details.size : 10000`
* `spark.sql.orc.filterPushdown : true`
* `spark.sql.orc.splits.include.file.footer : true`

It may take a long time for the jobs creating or updating a large number (hundreds and thousands) of table partitions to update partition records in {{ metastore-full-name }}. To speed up this process, increase the values of the following settings:

* `hive:datanucleus.connectionPool.maxPoolSize`: Maximum size of the {{ metastore-full-name }} DB connection pool.
* `hive:hive.metastore.fshandler.threads`: Number of threads running background operations with the file system within {{ metastore-full-name }}.
* `spark:spark.sql.addPartitionInBatch.size`: Number of partitions updated per {{ metastore-full-name }} call. The optimal value is `10 × <hive:hive.metastore.fshandler.threads setting value>` or higher.

{% note info %}

If these parameters are set to too large a value, you might run out of {{ metastore-full-name }} system resources. If the size of the {{ metastore-full-name }} database connection pool is large, you might need to change the settings and increase the amount of your cluster's computing resources.

{% endnote %}

For more information, see the [Apache Spark documentation](https://spark.apache.org/docs/3.0.3/cloud-integration.html) and the [Component properties](../concepts/settings-list.md) section.

## Using s3fs {#s3fs}

`s3fs` allows you to mount {{ objstorage-name }} buckets using Fuse. Read more about using the utility at [s3fs](../../storage/tools/s3fs.md).

## Using {{ objstorage-name }} from Spark {#objstorage-spark}

{% list tabs %}

- Spark Shell

   Implement the desired access option:

   * Using JCEKS:

      ```scala
      sc.hadoopConfiguration.set("fs.s3a.endpoint", "{{ s3-storage-host }}");
      sc.hadoopConfiguration.set("fs.s3a.signing-algorithm", "");
      sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider");
      sc.hadoopConfiguration.set("hadoop.security.credential.provider.path", "jceks://hdfs/<path to JCEKS file>");
      ```
   * Using your access key and secret:

      ```scala
      sc.hadoopConfiguration.set("fs.s3a.endpoint", "{{ s3-storage-host }}");
      sc.hadoopConfiguration.set("fs.s3a.signing-algorithm", "");
      sc.hadoopConfiguration.set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider");
      sc.hadoopConfiguration.set("fs.s3a.access.key","<access key>");
      sc.hadoopConfiguration.set("fs.s3a.secret.key","<bucket secret>");
      ```

   You can then read the file from {{ objstorage-name }}:

   ```scala
   val sqlContext = new org.apache.spark.sql.SQLContext(sc)
   val df = sqlContext.read.parquet("s3a://<bucket name>/<object path>")
   ```

- PySpark Shell

   Select the access method:

   * Accessing the {{ objstorage-name }} objects using JCEKS:

      ```python
      sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "{{ s3-storage-host }}")
      sc._jsc.hadoopConfiguration().set("fs.s3a.signing-algorithm", "")
      sc._jsc.hadoopConfiguration().set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider")
      sc._jsc.hadoopConfiguration().set("hadoop.security.credential.provider.path", "jceks://hdfs/<path to JCEKS file>")
      ```
   * Reading a file using an access key and bucket secret:

      ```python
      sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "{{ s3-storage-host }}")
      sc._jsc.hadoopConfiguration().set("fs.s3a.signing-algorithm", "")
      sc._jsc.hadoopConfiguration().set("fs.s3a.aws.credentials.provider", "org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider")
      sc._jsc.hadoopConfiguration().set("fs.s3a.access.key","<access key>")
      sc._jsc.hadoopConfiguration().set("fs.s3a.secret.key","<bucket secret>")
      ```

   Once you have access, you can read the file directly from {{ objstorage-name }}:

   ```python
   sql = SQLContext(sc)
   df = sql.read.parquet("s3a://<bucket name>/<object path>")
   ```

{% endlist %}

For more information, see [{#T}](../concepts/settings-list.md#spark-settings).
