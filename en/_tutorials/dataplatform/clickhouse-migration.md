# Migrating data to {{ mch-name }} using {{ CH }}

You can migrate data from your {{ CH }} cluster to a {{ mch-name}} cluster by using:

* [Built-in `remote` function](#transfer-remote). This method is suitable for migrating individual tables.
* [Built-in backup/restore commands and a {{ objstorage-full-name }} bucket](#backup-objstorage). Use this method to migrate both individual tables and an entire database.

You can also migrate a database from a {{ CH }} cluster to a {{ mch-name}} cluster using {{ data-transfer-name }}. For more information about this method, see [this tutorial](../../tutorials/dataplatform/ch-to-mch-migration.md).

## Data migration using the remote function {#transfer-remote}

You can use `remote` to migrate individual tables from a third-party {{ CH }} cluster. This method does not require installing {{ ZK }}, additional tools, or upgrading the source cluster's {{ CH }} version. 

{% note tip %}

Before migrating data, we recommend pausing merge operations on the source cluster using the `STOP MERGES` and `STOP TTL MERGES` commands. You should also disable all consumers.

{% endnote %}

To migrate a table from a third-party {{ CH }} cluster to a {{ mch-name }} cluster:

1. [Create a {{ mch-name }} target cluster](../../managed-clickhouse/operations/cluster-create.md#create-cluster).
1. Connect to the source cluster.
1. Get the create table statement text:

   ```sql
   SELECT create_table_query FROM system.tables WHERE database = '<name_of_DB_to_migrate>';
   ```

   For example, your database named `db1` stores a table named `tasks` with the list of tasks. The response to your query will look as follows:

   ```sql
   CREATE TABLE db1.tasks (`task_id` Int32,
                           `title` String, 
                           `start_date` Date, 
                           `due_date` Date, 
                           `priority` Int8 DEFAULT 3, 
                           `description` String) 
                  ENGINE = MergeTree 
                  PRIMARY KEY tuple(task_id) 
                  ORDER BY tuple(task_id) 
                  SETTINGS index_granularity = 8192;
   ```

1. [Connect to the target {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) and create a new table using the statement text you got earlier.

   If the source cluster did not use replicas, while the target cluster does, switch to a **Replicated** table engine.

   To create an object on all hosts of the target cluster, use the `ON CLUSTER` clause in the `CREATE` command.

1. Run the following query on the source cluster:

   ```sql
   INSERT INTO FUNCTION
   remoteSecure('<Managed_Service_for_ClickHouse®_cluster_host_FQDN>:9440',
                '<target_cluster_DB_name>.<target_table_name>',
                '<username_in_target_cluster>',
                '<user_password_in_target_cluster>')
   SELECT * from <DB_name>.<table_name>;
   ```

   To learn how to get a host FQDN, see [this guide](../../managed-clickhouse/operations/connect/fqdn.md).

1. On the target cluster, check that the table from the source cluster has appeared in the database:

   ```sql
   SHOW TABLES FROM <DB_name>;
   ```

1. Check that the target table contains the same data as the source table:

   ```sql
   SELECT * FROM <DB_name>.<table_name>;
   ```

For more details on using the `remote` function, see [this {{ CH }} guide]({{ ch.docs }}/sql-reference/table-functions/remote).

## Migrating data using the backup/restore commands and an {{ objstorage-name }} bucket {#backup-objstorage}

{% note warning %}

You need {{ CH }} version 22.10 or later to work with the backup/restore commands in a third-party cluster.

{% endnote %}

You can use the backup/restore commands and an {{ objstorage-name }} bucket to migrate both individual tables and an entire database from a third-party {{ CH }} cluster. To do this:

1. [Create a {{ mch-name }} target cluster](../../managed-clickhouse/operations/cluster-create.md#create-cluster).
1. [Create a service account](../../iam/operations/sa/create.md#create-sa) with the `storage.editor` role.
1. [Create a static key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account.

    Save both the key and its ID, as you will need them in the next steps.

1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md).
1. Connect to the source cluster.
1. Run the following command to save the backup of your table to the {{ objstorage-name }} bucket:

    ```sql
    BACKUP TABLE <DB_name>.<table_name> TO S3('<Object_Storage_bucket_endpoint>', '<service_account_static_key_ID>', '<service_account_static_key>');
    ```

    To migrate the entire database, run the command below:

    ```sql
    BACKUP DATABASE <DB_name> TO S3('<Object_Storage_bucket_endpoint>', '<service_account_static_key_ID>', '<service_account_static_key>');
    ```

1. [Connect to the target {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client).
1. Run the following command to restore your table from a backup:

    ```sql
    RESTORE TABLE <DB_name>.<table_name> FROM S3('<Object_Storage_bucket_endpoint>', '<service_account_static_key_ID>', 'service_account_static_key>');
    ```

    To restore an entire database, use this command: 

    ```sql
    RESTORE DATABASE <DB_name> FROM S3('<Object_Storage_bucket_endpoint>', '<service_account_static_key_ID>', 'service_account_static_key>');
    ```

1. Check that the restore operation was successful:

    * If you restored a table, run this command:

        ```sql
        SELECT * FROM <DB_name>.<table_name>;
        ```

    * If you restored an entire database, run this command:

        ```sql
        SHOW DATABASES;
        ```

For more details on using the backup/restore commands with an S3 storage, see [this {{ CH }} guide](https://clickhouse.com/docs/en/operations/backup#backuprestore-using-an-s3-disk).
