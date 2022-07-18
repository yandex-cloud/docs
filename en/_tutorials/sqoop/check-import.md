If the import was successful, you'll see the contents of the `persons` table.

### Verifying an import made to {{ objstorage-full-name }} {#check-object-storage}

[From](../../storage/operations/objects/download.md) `my-bucket`, download files with import results.

### Verifying an import made to an HDFS directory {#correct-hdfs}

1. [Connect](../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. Run the command:

   ```bash
   hdfs dfs -cat /user/root/import-directory/*
   ```

### Verifying an import made to Apache Hive {#check-hive}

1. [Connect](../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. Run the command:

   ```bash
   hive -e "SELECT * FROM import-table;"
   ```

### Verifying an import made to Apache HBase {#check-hbase}

1. [Connect](../../data-proc/operations/connect.md) over SSH to the {{ dataproc-name }} subcluster host to store the data.
1. Run the command:

   ```bash
   echo -e "scan 'import-table'" | hbase shell -n
   ```
