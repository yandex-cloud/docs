# Setting up Delta Lake in single-cluster mode

{{ dataproc-name }} 2.0 or higher supports using Delta Lake in single-cluster mode.

For more information about Delta Lake, see the [Delta Lake in {{ dataproc-name }}](../../concepts/deltalake.md) section in the [Delta Lake documentation](https://docs.delta.io/latest/index.html).


{% include [deltalake-disclaimer](../../../_includes/data-processing/deltalake-disclaimer.md) %}


{% note warning %}

If different Spark jobs in single-cluster mode are concurrently updating table data, this may cause data loss.

Set up the Spark jobs to avoid concurrent data modifications or use [multi-cluster mode](./multi-cluster-mode.md). For more information, see the [Delta Lake documentation](https://docs.delta.io/latest/delta-storage.html#single-cluster-setup-default).

{% endnote %}

## Prepare the infrastructure {#prereq}

1. If you do not have a {{ dataproc-name }} cluster, [create one](../cluster-create.md).
1. If you attached a [{{ objstorage-full-name }} bucket](../../../storage/concepts/bucket.md) for data storage to your cluster:

    1. Create a folder named `warehouse` in the bucket.
    1. [Set](../../concepts/settings-list.md#change-properties) the `spark.sql.warehouse.dir` property to: `s3a://<bucket_name>/warehouse/`.

1. [Create](../../../metadata-hub/operations/metastore/cluster-create.md) a {{ metastore-full-name }} cluster and [connect](../../../metadata-hub/operations/metastore/data-processing-connect.md) it to your {{ dataproc-name }} cluster.

## Set up the component properties to work with Delta Lake {#settings}

1. Set the following [properties](../../concepts/settings-list.md) at cluster or individual job level:

    * Set `spark.sql.extensions` to `io.delta.sql.DeltaSparkSessionExtension`.
    * Set `spark.sql.catalog.spark_catalog` to `org.apache.spark.sql.delta.catalog.DeltaCatalog`.

1. Add the Delta Lake libraries to the dependencies of your cluster or individual job (the required library versions [depend on the {{ dataproc-name }} version](../../concepts/deltalake.md#compatibility)):

    {% list tabs %}

    - {{ dataproc-name }} 2.0.x

        Use one of these methods:

        * Download the [delta-core_2.12-0.8.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar) library file, save it to your {{ objstorage-name }} bucket, and provide the file URL in the `spark.jars` property:

            `spark.jars=s3a://<bucket_name>/<path_to_file>`

            Make sure the cluster service account has read access to the bucket.

        * Set up cluster access to the [Maven](https://maven.apache.org/index.html) repository and set the `spark.jars.packages` property to `io.delta:delta-core_2.12:0.8.0`.

            {% include [maven-setup](../../../_includes/data-processing/maven-setup.md) %}

        * Download the [delta-core_2.12-0.8.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar) library file, copy it to all the cluster nodes manually or using [initialization scripts](../../concepts/init-action.md), and provide the full file path in the `spark.driver.extraClassPath` and `spark.executor.extraClassPath` properties.

    - {{ dataproc-name }} 2.1.0 or 2.1.3

        Use one of these methods:

        * Download the [delta-core_2.12-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.0.2/delta-core_2.12-2.0.2.jar) and [delta-storage-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.0.2/delta-storage-2.0.2.jar) library files, save them to your {{ objstorage-name }} bucket, and provide the comma-separated file URLs in the `spark.jars` property:

            `spark.jars=s3a://<bucket_name>/<path_to_core_file>,s3a://<bucket_name>/<path_to_storage_file>`

            Make sure the cluster service account has read access to the bucket.

        * Set up cluster access to the [Maven](https://maven.apache.org/index.html) repository and set the `spark.jars.packages` property to `io.delta:delta-core_2.12:2.0.2,io.delta:delta-storage:2.0.2`.

            {% include [maven-setup](../../../_includes/data-processing/maven-setup.md) %}

        * Download the [delta-core_2.12-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.0.2/delta-core_2.12-2.0.2.jar) and [delta-storage-2.0.2.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.0.2/delta-storage-2.0.2.jar) library files, copy them to all the cluster nodes manually or using [initialization scripts](../../concepts/init-action.md), and provide the full file path in the `spark.driver.extraClassPath` and `spark.executor.extraClassPath` properties.

    - {{ dataproc-name }} 2.1.4 and higher

        Use one of these methods:

        * Download the [delta-core_2.12-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.3.0/delta-core_2.12-2.3.0.jar) and [delta-storage-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.3.0/delta-storage-2.3.0.jar) library files, save them to your {{ objstorage-name }} bucket, and provide the comma-separated file URLs in the `spark.jars` property:

            `spark.jars=s3a://<bucket_name>/<path_to_core_file>,s3a://<bucket_name>/<path_to_storage_file>`

            Make sure the cluster service account has read access to the bucket.

        * Set up cluster access to the [Maven](https://maven.apache.org/index.html) repository and set the `spark.jars.packages` property to `io.delta:delta-core_2.12:2.3.0,io.delta:delta-storage:2.3.0`.

            {% include [maven-setup](../../../_includes/data-processing/maven-setup.md) %}

        * Download the [delta-core_2.12-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-core_2.12/2.3.0/delta-core_2.12-2.3.0.jar) and [delta-storage-2.3.0.jar](https://repo1.maven.org/maven2/io/delta/delta-storage/2.3.0/delta-storage-2.3.0.jar) library files, copy them to all the cluster nodes manually or using [initialization scripts](../../concepts/init-action.md), and provide the full file path in the `spark.driver.extraClassPath` and `spark.executor.extraClassPath` properties.

    {% endlist %}

You can now use Delta Lake in your {{ dataproc-name }} cluster.

If the above Spark properties are provided at the cluster level, you can use [Spark Thrift Server](../../concepts/settings-list.md#spark-thrift-server) to work with Delta Lake tables.

## Delta Lake usage example {#example}

The use case was tested on a {{ dataproc-name }} cluster version 2.0 with access to the Maven Central repository.

1. [Use SSH to connect](../connect.md#data-proc-ssh) to the {{ dataproc-name }} cluster's master host.

1. Run a Spark session in the cluster by providing the required parameters:

    ```bash
    spark-sql \
        --conf spark.jars.packages=io.delta:delta-core_2.12:0.8.0 \
        --conf spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension \
        --conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog
    ```

1. Within the active session, create a database and switch to it:

    ```sql
    CREATE DATABASE testdelta;
    USE testdelta;
    ```

1. Create a test table and populate it with data:

    ```sql
    CREATE TABLE tab1(a INTEGER NOT NULL, b VARCHAR(100)) USING DELTA;
    INSERT INTO tab1 VALUES (1,'One'), (2,'Two'), (3,'Three');
    ```

1. Replace the `b` column values by adding to them the `a` column values converted to a string:

    ```sql
    UPDATE tab1 SET b=b || ' ** ' || CAST(a AS VARCHAR(10));
    ```

1. Check the result:

    ```sql
    SELECT * FROM tab1;
    ```

    ```sql
    3	Three ** 3
    2	Two ** 2
    1	One ** 1
    ```
