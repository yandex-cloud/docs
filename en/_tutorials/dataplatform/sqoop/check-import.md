If the import was successful, you will see the contents of the `persons` table.

{% list tabs group=storage_system %}

- {{ objstorage-name }} {#storage}

   [Download](../../../storage/operations/objects/download.md) the files with import results from the bucket.

- HDFS directory {#hdfs}

   1. [Connect](../../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run this command:

      ```bash
      hdfs dfs -cat /user/root/import-directory/*
      ```

- Apache Hive {#hive}

   1. [Connect](../../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run this command:

      ```bash
      hive -e "SELECT * FROM import-table;"
      ```

- Apache HBase {#hbase}

   1. [Connect](../../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run this command:

      ```bash
      echo -e "scan 'import-table'" | hbase shell -n
      ```

{% endlist %}
