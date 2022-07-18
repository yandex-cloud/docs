Specify the settings for the storage to import the data to:

{% list tabs %}

- Bucket {{ objstorage-full-name }}

   * **Service account**: `bucket-sa`.
   * **Bucket name**: `my-bucket`.
   * **Services**: `Sqoop`.

- HDFS directory

   **Services**:

   * `HBase`,
   * `HDFS`,
   * `Sqoop`,
   * `Yarn`,
   * `Zookeeper`.

- Apache Hive

   * **Services**:

      * `HDFS`,
      * `Hive`,
      * `Mapreduce`,
      * `Sqoop`,
      * `Yarn`.

   * **Properties**: The `hive:hive.execution.engine` key with the `mr` value.

- Apache HBase

   **Services**:

   * `HBase`,
   * `HDFS`,
   * `Sqoop`,
   * `Yarn`,
   * `Zookeeper`.

{% endlist %}
