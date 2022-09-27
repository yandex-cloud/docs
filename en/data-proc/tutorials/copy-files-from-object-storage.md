# Using {{ objstorage-full-name }} in {{ dataproc-name }}

This section describes various ways that processes running in {{ dataproc-name }} clusters can access objects from {{ objstorage-name }} [buckets](../../storage/concepts/bucket.md).

{% note info %}

[Configure a cluster network](./configure-network.md) before setting up access to {{ yandex-cloud }} services and internet resources.

{% endnote %}

Component settings impact bucket file read and write performance:

* The settings specified when [creating](../operations/cluster-create.md) a cluster affect all the jobs running in the cluster.
* The settings specified when creating jobs override cluster-level settings and can be job-specific.

## DistCp {#distcp}

To copy files from {{objstorage-name}} to HDFS, use the [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html) utility. It is designed to copy data both within a cluster and between clusters and external storage.

To authenticate in {{objstorage-name}}, you can use one of the following approaches:

1. Use the [IAM token of the cluster service account](../../iam/operations/iam-token/create-for-sa.md).
1. Use [CredentialProvider](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/CredentialProviderAPI.html).
1. Pass the `access key` and `secret key` parameters of [static access keys](../../iam/concepts/authorization/access-key.md) when creating a job.

### Accessing S3 with authentication via the IAM token of a cluster service account {#s3-access-using-iam}

1. When creating a cluster, specify a [service account](../../iam/operations/sa/create.md#create-sa). If a cluster is already created, add a service account using the **Edit cluster** button in the management console.

1. The service account must have access to the appropriate bucket. To do this, grant the service account privileges in the [bucket ACL](../../storage/concepts/acl), or the `storage.viewer` or `storage.editor` roles.

   For more information about these roles, see the [{{objstorage-name}} documentation](../../storage/security/index.md).

> For example, get a list of files located in the `yc-mdb-examples` public bucket at the path `dataproc/example01/set01`.
>
> 1. [Connect](../operations/connect.md) to the cluster.
> 1. Run the command:
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


## Optimizing file reads from {{ objstorage-name }} {#optimize-s3-reading}

The method for reading data from a bucket depends on the `fs.s3a.experimental.input.fadvise` [setting](https://hadoop.apache.org/docs/stable/hadoop-aws/tools/hadoop-aws/performance.html#Improving_data_input_performance_through_fadvise). Its value depends on the image version used:

* In image versions `1.0` through `1.4`, the default value is `sequential`. It is a good choice for sequential file reads, but slow for random access. If you use random file access more frequently, add `random` to the cluster component properties or job settings.
* For version `2.0` images, the default is `normal`: files are accessed sequentially but if an application is performing random access operations, the mode automatically switches to `random`.

For more information on the component versions used, see [{#T}](../concepts/environment.md).


## Optimizing file writes to {{objstorage-name}} {#optimize-s3-writing}


The method of writing data to a {{ objstorage-name }} bucket depends on the `core:fs.s3a.fast.upload` setting. Its value depends on the image version used:

* In image versions `1.0` through `1.4`, the default value is `false` to save RAM. Set this property to `true` in the cluster component properties or the job settings. This will improve bucket write performance for large files and prevent node storage from filling up.
* In image `2.0`, the `fs.s3a.fast.upload` setting is enabled by default.



If necessary, set values for [other settings](https://hadoop.apache.org/docs/r2.10.0/hadoop-aws/tools/hadoop-aws/index.html) responsible for write mode in {{ objstorage-name }}:

* `fs.s3a.fast.upload.active.blocks`: Maximum number of blocks in a single output stream.
* `fs.s3a.fast.upload.buffer`: Type of buffer used for the temporary storage of uploaded data:
   * `disk`: Data is saved to the folder specified in the `fs.s3a.buffer.dir` setting.
   * `array`: Arrays on the JVM heap are used.
   * `bytebuffer`: RAM from outside the JVM heap is used.
* `fs.s3a.multipart.size`: The size of chunks in bytes that data bucket copy or upload operations will partition the data into.

For more information, see [Component properties](../concepts/settings-list.md#spark-settings).

## Using s3fs {#s3fs}

`s3fs` lets you mount {{objstorage-name}} buckets using Fuse. Read more at [s3fs](../../storage/tools/s3fs.md).

## Using {{objstorage-name}} from Spark {#objstorage-spark}

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

   You can then read the file from {{objstorage-name}}:

   ```scala
   val sqlContext = new org.apache.spark.sql.SQLContext(sc)
   val df = sqlContext.read.parquet("s3a://<bucket name>/<object path>")
   ```

- PySpark Shell

   Select the access method:

   * Accessing the {{objstorage-name}} objects using JCEKS:

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

   Once you have access, you can read the file directly from {{objstorage-name}}:

   ```python
   sql = SQLContext(sc)
   df = sql.read.parquet("s3a://<bucket name>/<object path>")
   ```

{% endlist %}

For more information, see [{#T}](../concepts/settings-list.md#spark-settings).
