---
title: Setting up {{ IBRG }} in a {{ dataproc-name }} cluster
description: How to set up and use {{ IBRG }} in a {{ dataproc-name }} cluster.
---

# Setting up {{ IBRG }} in a {{ dataproc-name }} cluster

{{ dataproc-name }} 2.0 or higher supports using {{ IBRG }} tables together with the {{ SPRK }} engine.

For more information about {{ IBRG }}, see [{#T}](../concepts/apache-iceberg.md) and the [official documentation](https://iceberg.apache.org/docs/latest/).


{% include [apache-iceberg-disclaimer](../../_includes/data-processing/apache-iceberg-disclaimer.md) %}


## Set up component properties to work with {{ IBRG }} {#settings}

1. [Set the `spark:spark.sql.extensions` property](../concepts/settings-list.md#change-properties) to `org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions`. You can do this either at the cluster or individual job level.

1. Add the {{ IBRG }} libraries to the dependencies of your cluster or individual job. Library versions must be [compatible with the {{ dataproc-name }} version](../concepts/apache-iceberg.md#compatibility).

    {% list tabs %}

    - Image 2.0.x

        To add the required library versions, use one of the following methods:

        * Set up access to the [Maven](https://maven.apache.org/index.html) repository and [set the `spark:spark.jars.packages` property](../concepts/settings-list.md#change-properties) to `{{ dp-libs.iceberg.dp20.pkg }}`.

            {% include [maven-setup](../../_includes/data-processing/maven-setup.md) %}

        * Download the [{{ dp-libs.iceberg.dp20.jar }}]({{ dp-libs.iceberg.dp20.repo }}) library file and grant access to it using one of the following methods:

            {% include [libfile-manual-setup](../../_includes/data-processing/libfile-manual-setup.md) %}

    - Image 2.1.0–2.1.3

        To add the required library versions, use one of the following methods:

        * Set up access to the [Maven](https://maven.apache.org/index.html) repository and [set the `spark:spark.jars.packages` property](../concepts/settings-list.md#change-properties) to `{{ dp-libs.iceberg.dp21.spark32.pkg }}`.

            {% include [maven-setup](../../_includes/data-processing/maven-setup.md) %}

        * Download the [{{ dp-libs.iceberg.dp21.spark32.jar }}]({{ dp-libs.iceberg.dp21.spark32.repo }}) library file and grant access to it using one of the following methods:

            {% include [libfile-manual-setup](../../_includes/data-processing/libfile-manual-setup.md) %}

    - Image 2.1.4–2.1.x

        To add the required library versions, use one of the following methods:

        * Set up access to the [Maven](https://maven.apache.org/index.html) repository and [set the `spark:spark.jars.packages` property](../concepts/settings-list.md#change-properties) to `{{ dp-libs.iceberg.dp21.spark33.pkg }}`.

            {% include [maven-setup](../../_includes/data-processing/maven-setup.md) %}

        * Download the [{{ dp-libs.iceberg.dp21.spark33.jar }}]({{ dp-libs.iceberg.dp21.spark33.repo }}) library file and grant access to it using one of the following methods:

            {% include [libfile-manual-setup](../../_includes/data-processing/libfile-manual-setup.md) %}

    - Image 2.2.x

        To add the required library versions, use one of the following methods:

        * Set up access to the [Maven](https://maven.apache.org/index.html) repository and [set the `spark:spark.jars.packages` property](../concepts/settings-list.md#change-properties) to `{{ dp-libs.iceberg.dp22.pkg }}`.

            {% include [maven-setup](../../_includes/data-processing/maven-setup.md) %}

        * Download the [{{ dp-libs.iceberg.dp22.jar }}]({{ dp-libs.iceberg.dp22.repo }}) library file and grant access to it using one of the following methods:

            {% include [libfile-manual-setup](../../_includes/data-processing/libfile-manual-setup.md) %}

    {% endlist %}

You can now use {{ IBRG }} in your {{ dataproc-name }} cluster.

## {{ IBRG }} use case example {#example}

This use case was tested on a {{ dataproc-name }} cluster version 2.0 with:

* Spark and Hadoop components installed.
* {{ objstorage-name }} bucket connected, and the cluster's service account having read and write permissions for this bucket.
* Access to the Maven Central repository configured.
* Component properties [configured](#settings) to enable downloading {{ IBRG }} libraries from Maven Central.

To create an {{ IBRG }} table and start working with it:

1. Specify the [settings for the folder](https://iceberg.apache.org/docs/latest/spark-configuration/#catalogs) to contain the table.

    {{ IBRG }} operates with tables at the individual folder level. Folder settings are specified at the individual folder level; you cannot specify settings for all folders at the same time.

    To configure the `sample` [Hadoop](https://iceberg.apache.org/docs/latest/spark-configuration/#catalog-configuration) folder, [set up these properties](../concepts/settings-list.md#change-properties) at the cluster or individual job level as follows:

    * `spark:spark.sql.catalog.sample` property to `org.apache.iceberg.spark.SparkCatalog`
    * `spark:spark.sql.catalog.sample.type` property to `hadoop`
    * `spark:spark.sql.catalog.sample.warehouse` property to `s3a://<bucket_name>/warehouse/`

        Table data will be stored in the bucket at the `warehouse/` path.

    For more information about the properties affecting folder settings, this [{{ IBRG }} guide](https://iceberg.apache.org/docs/latest/spark-configuration/#catalog-configuration).

1. [Use SSH to connect](connect-ssh.md) to the {{ dataproc-name }} cluster's master host.

1. Run a Spark SQL session:

    ```bash
    spark-sql
    ```

    You will perform all further actions within this session.

1. Create a database named `db` in the `sample` folder:

    ```sql
    CREATE DATABASE sample.db;
    ```

1. Switch to the `db` database in the `sample` folder:

    ```sql
    USE sample.db;
    ```

1. Create a two-column table named `mytable`:

    ```sql
    CREATE TABLE mytable (id bigint, data string) USING iceberg;
    ```

1. View table details:

    ```sql
    DESC FORMATTED mytable;
    ```

    Result example:

    ```sql
    id      bigint
    data    string

    # Partitioning
    Not partitioned

    # Detailed Table Information
    Name    sample.db.mytable
    Location        s3a://<bucket_name>/warehouse/db/mytable
    Provider        iceberg
    Owner   ubuntu
    Table Properties        [current-snapshot-id=none,format=iceberg/parquet]
    ```

1. Insert some entries to the table:

    ```sql
    INSERT INTO mytable VALUES (1, 'a'), (2, 'b'), (3, 'c');
    ```

1. Run a test query to the table:

    ```sql
    SELECT count(1), data FROM mytable GROUP BY data;
    ```

    Result example:

    ```sql
    1       a
    1       b
    1       c
    ```
