If the import was successful, you'll see the contents of the `persons` table.

{% list tabs %}

* {{ objstorage-name }}

   [From](../../storage/operations/objects/download.md) `my-bucket`, download files with import results.

* HDFS directory

   1. [Connect](../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run the command:

      ```bash
      hdfs dfs -cat /user/root/import-directory/*
      ```

* Apache Hive

   1. [Connect](../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run the command:

      ```bash
      hive -e "SELECT * FROM import-table;"
      ```

* Apache HBase

   1. [Connect](../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run the command:

      ```bash
      echo -e "scan 'import-table'" | hbase shell -n
      ```

{% endlist %}
