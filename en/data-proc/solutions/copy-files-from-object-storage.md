# Using {{ objstorage-full-name }} in {{ dataproc-name }}

This section describes various ways that processes running in {{ dataproc-name }} clusters can access objects from {{ objstorage-name }} buckets.

{% note info %}

Before you begin setting up access to {{ yandex-cloud }} services and internet resources, make sure that the cluster network is [configured properly](./configure-network.md).

{% endnote %}

Component settings impact bucket file read and write performance:

* The settings specified when [creating](../operations/cluster-create.md) a cluster affect all the jobs running in the cluster.
* The settings specified when creating jobs override cluster-level settings and can be job-specific.

## DistCp {#distcp}

To copy files from {{objstorage-name}} to HDFS, we recommend that you use the [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html) utility designed for copying data both within clusters and between clusters and external storages.

You can use two approaches to authenticate in {{objstorage-name}}:

1. Use [CredentialProvider](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/CredentialProviderAPI.html).
1. Pass the `access key` and the `secret key` parameters when creating a job.

### Copying via CredentialProvider {#copying-via-credentialprovider}

To use a secret storage provider, place the secrets within the components that need access to {{objstorage-name}}. To do this, you can use [JCEKS](https://docs.oracle.com/javase/8/docs/technotes/guides/security/crypto/CryptoSpec.html) (Java Cryptography Extension KeyStore): in this example, first you create a file with secrets and then place it in HDFS.

1. Specify the `access key` and `secret key`, for example:

    ```bash
    hadoop credential create fs.s3a.access.key -value <access key> -provider localjceks://file/home/jack/yc.jceks
    hadoop credential create fs.s3a.secret.key -value <secret key> -provider localjceks://file/home/jack/yc.jceks
    ```

1. Copy the secrets file to your local HDFS:

    ```bash
    hdfs dfs -put /home/jack/yc.jceks /user/root/
    ```

1. Copy the file from {{objstorage-name}} directly to HDFS:

    ```bash
    hadoop distcp \
           -D fs.s3a.bucket.dataproc-examples.endpoint=storage.yandexcloud.net \
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
       -D fs.s3a.bucket.dataproc-examples.endpoint=storage.yandexcloud.net \
       -D hadoop.security.credential.provider.path=jceks://hdfs/user/root/yc.jceks \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.mdb.yandexcloud.net/user/root/datasets/set01/
```

## Copying files by passing keys in arguments {#copying-files-by-passing-keys-in-arguments}

Instead of creating a secrets file, you can pass keys in command arguments:

```bash
hadoop distcp \
       -D fs.s3a.bucket.dataproc-examples.endpoint=storage.yandexcloud.net \
       -D fs.s3a.bucket.dataproc-examples.access.key=<access_key> \
       -D fs.s3a.bucket.dataproc-examples.secret.key=<secret_key> \
       -update \
       -skipcrccheck \
       -numListstatusThreads 10 \
       s3a://yc-mdb-examples/dataproc/example01/set01 \
       hdfs://rc1b-dataproc-m-d31bs470ivkyrz60.mdb.yandexcloud.net/user/root/datasets/set01/
```

## Optimizing file reads from {{ objstorage-name }} {#optimize-s3-reading}

The method for reading data from a bucket depends on the [property](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/performance.html#Improving_data_input_performance_through_fadvise) `fs.s3a.experimental.input.fadvise`. Its value depends on the image version used:

* In image versions `1.0` through `1.4`, the default value is `sequential`. It is a good choice for sequential file reads, but slow for random access. If you use random file access more frequently, add `random` to the cluster component properties or job settings.
* For version `2.0` images, the default is `normal`: files are accessed sequentially but if an application is performing random access operations, the mode automatically switches to `random`.

For more information on the component versions used, see [{#T}](../concepts/environment.md).

## Optimizing file writes to {{objstorage-name}} {#optimize-s3-writing}

The method of writing data to a {{ objstorage-name }} bucket depends on the `core:fs.s3a.fast.upload` property. Its value depends on the image version used:

* In image versions `1.0` through `1.4`, the default value is `false` to save RAM. Set this property to `true` in the cluster component properties or the job settings. This will improve bucket write performance for large files and prevent node storage from filling up.
* In a version `2.0` image, the `fs.s3a.fast.upload` property is enabled by default.

If required, specify the values of the [other settings](https://hadoop.apache.org/docs/r2.10.0/hadoop-aws/tools/hadoop-aws/index.html) responsible for the write mode in {{ objstorage-name }}:

* `fs.s3a.fast.upload.active.blocks`: Maximum number of blocks in a single output stream.
* `fs.s3a.fast.upload.buffer`: Type of buffer used for the temporary storage of uploaded data:
    * `disk`: Data is stored to the folder specified in the `fs.s3a.buffer.dir` property.
    * `array`: Arrays on the JVM heap are used.
    * `bytebuffer`: RAM from outside the JVM heap is used.
* `fs.s3a.multipart.size`: The size of chunks in bytes that data bucket copy or upload operations will partition the data into.

For more information on the component versions used, see [{#T}](../concepts/environment.md).

## Using s3fs {#s3fs}

`s3fs` lets you mount {{objstorage-name}} buckets using Fuse. Read more at [s3fs](../../storage/tools/s3fs.md).

## Using {{objstorage-name}} from Spark {#objstorage-spark}

{% list tabs %}

- Spark Shell

  Implement the desired access option:

  * Using JCEKS:

    ```scala
    sc.hadoopConfiguration.set("fs.s3a.endpoint", "storage.yandexcloud.net");
    sc.hadoopConfiguration.set("hadoop.security.credential.provider.path", "jceks://hdfs/<path to JCEKS file>");
    ```

  * Using your access key and secret:

    ```scala
    sc.hadoopConfiguration.set("fs.s3a.endpoint", "storage.yandexcloud.net");
    sc.hadoopConfiguration.set("fs.s3a.access.key","<access key>>");
    sc.hadoopConfiguration.set("fs.s3a.secret.key","<secret_key>");
    ```

  You can then read the file from {{objstorage-name}}:

  ```scala
  val sqlContext = new org.apache.spark.sql.SQLContext(sc)
  val df = sqlContext.read.parquet("s3a://<bucket name>/<object path>")
  ```

- PySpark Shell

  Select the access method:

  * Accessing the {{objstorage-name}} objects using JCEKS:

    ```python
    sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "storage.yandexcloud.net")
    sc._jsc.hadoopConfiguration().set("hadoop.security.credential.provider.path", "jceks://hdfs/<path to JCEKS file>")
    ```

  * Reading a file using an access key and bucket secret:

    ```python
    sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "storage.yandexcloud.net")
    sc._jsc.hadoopConfiguration().set("fs.s3a.access.key","<access key>")
    sc._jsc.hadoopConfiguration().set("fs.s3a.secret.key","<bucket secret>")
    ```

  Once you have access, you can read the file directly from {{objstorage-name}}:

  ```python
  sql = SQLContext(sc)
  df = sql.read.parquet("s3a://<bucket_name>/<path_to_file_or_directory>")
  ```

{% endlist%}

