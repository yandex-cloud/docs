Specify the settings for the storage to import the data to:

{% list tabs %}

- Bucket {{ objstorage-name }}

   * **{{ ui-key.yacloud.mdb.cluster.overview.label_service-account }}**: Name of the previously created service account.
   * **{{ ui-key.yacloud.mdb.cluster.overview.label_bucket }}**: Name of the previously created bucket.
   * **{{ ui-key.yacloud.mdb.cluster.overview.label_services }}**: `Sqoop`.

- HDFS directory

   **Services**:

   * `HBase`
   * `HDFS`
   * `Sqoop`
   * `Yarn`
   * `Zookeeper`

- Apache Hive

   * **Services**:

      * `HDFS`
      * `Hive`
      * `Mapreduce`
      * `Sqoop`
      * `Yarn`

   * **Properties**: The `hive:hive.execution.engine` key with the `mr` value.

- Apache HBase

   **Services**:

   * `HBase`
   * `HDFS`
   * `Sqoop`
   * `Yarn`
   * `Zookeeper`

{% endlist %}
