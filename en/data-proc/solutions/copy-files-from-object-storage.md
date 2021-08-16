# Using {{ objstorage-full-name }} in {{ dataproc-name }}

This section describes various ways that processes running in {{ dataproc-name }} clusters can access objects from {{ objstorage-name }} buckets.

{% note info %}

Before you begin setting up access to Yandex.Cloud services and internet resources, make sure that the cluster network is [configured properly](./configure-network.md).

{% endnote %}

## DistCp {#distcp}

To copy files from {{objstorage-name}} to HDFS, we recommend that you use the [DistCp](https://hadoop.apache.org/docs/current/hadoop-distcp/DistCp.html) utility designed for copying data both within clusters and between clusters and external storages.

You can use two approaches to authenticate in {{objstorage-name}}:

1. Use [CredentialProvider](https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/CredentialProviderAPI.html).
1. Pass the `access key` and `secret key` parameters when the job starts.

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

## Using s3fs {#s3fs}

`s3fs` lets you mount {{objstorage-name}} buckets using Fuse. Read more at [s3fs](../../storage/tools/s3fs.md)

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

