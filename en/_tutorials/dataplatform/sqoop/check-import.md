If the import was successful, you will see the contents of the `persons` table.

{% list tabs %}

- {{ objstorage-name }}

   [Download](../../../storage/operations/objects/download.md) the files with import results from the bucket.

- HDFS directory

   1. [Connect](../../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run this command:

      ```bash
      hdfs dfs -cat /user/root/import-directory/*
      ```

- Apache Hive

   1. [Connect](../../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run this command:

      ```bash
      hive -e "SELECT * FROM import-table;"
      ```

- Apache HBase

   1. [Connect](../../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
   1. Run this command:

      ```bash
      echo -e "scan 'import-table'" | hbase shell -n
      ```

{% endlist %}
