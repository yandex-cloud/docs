Specify the settings for the storage to import the data to:

{% list tabs %}

* Bucket {{ objstorage-name }}

   * **Service account**: The name of the previously created service account.
   * **Bucket name**: The name of the previously created bucket.
   * **Services**: `Sqoop`.

* HDFS directory

   **Services**:

   * `HBase`,
   * `HDFS`,
   * `Sqoop`,
   * `Yarn`,
   * `Zookeeper`.

* Apache Hive

   * **Services**:

      * `HDFS`,
      * `Hive`,
      * `Mapreduce`,
      * `Sqoop`,
      * `Yarn`.

   * **Properties**: The `hive:hive.execution.engine` key with the `mr` value.

* Apache HBase

   **Services**:

   * `HBase`,
   * `HDFS`,
   * `Sqoop`,
   * `Yarn`,
   * `Zookeeper`.

{% endlist %}
