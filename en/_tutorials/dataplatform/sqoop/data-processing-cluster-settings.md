Specify the settings for the storage to import the data to:

{% list tabs group=storage_system %}

- {{ objstorage-name }} {#storage}

    * **{{ ui-key.yacloud.mdb.cluster.overview.label_service-account }}**: Name of the previously created service account.
    * **{{ ui-key.yacloud.mdb.cluster.overview.label_bucket }}**: Name of the bucket you created earlier.
    * **{{ ui-key.yacloud.mdb.cluster.overview.label_services }}**: `Sqoop`.

- HDFS directory {#hdfs}

    **Services**:

    * `HBase`
    * `HDFS`
    * `Sqoop`
    * `Yarn`
    * `Zookeeper`

- Apache Hive {#hive}

    * **Services**:

        * `HDFS`
        * `Hive`
        * `Mapreduce`
        * `Sqoop`
        * `Yarn`

    * **Properties**: `hive:hive.execution.engine` key with the `mr` value.

- Apache HBase {#hbase}

    **Services**:

    * `HBase`
    * `HDFS`
    * `Sqoop`
    * `Yarn`
    * `Zookeeper`

{% endlist %}
