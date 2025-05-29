# Migrating data to {{ mch-name }} using {{ CH }}

You can migrate data from your {{ CH }} cluster to a {{ mch-name}} cluster by using:

* [Built-in `remote` function](#transfer-remote). This method is suitable for migrating individual tables.
* [Built-in backup/restore commands and an {{ objstorage-full-name }} bucket](#backup-objstorage). This method is suitable for migrating individual tables or a whole database.

You can also migrate a database from a {{ CH }} cluster to a {{ mch-name}} cluster with the help of {{ data-transfer-name }}. For more information about how to do this, see [this tutorial](../../tutorials/dataplatform/ch-to-mch-migration.md).

## Migrating data using `remote` {#transfer-remote}

You can use `remote` to migrate individual tables from a third-party {{ CH }} cluster. This method does not require installing {{ ZK }} and additional tools, nor upgrading the source cluster's {{ CH }} version. 

{% note tip %}

Before migrating data, we recommend you to stop ongoing merges into the source cluster using the `STOP MERGES` and `STOP TTL MERGES` commands and to disable consumers.

{% endnote %}

To migrate a table from a third-party {{ CH }} cluster to a {{ mch-name }} cluster:

1. [Create a {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md#create-cluster) target cluster.
1. Connect to the cluster you want to migrate the data from.
1. Get the text of the table creation query:

   ```sql
   SELECT create_table_query FROM system.tables WHERE database = '<name_of_DB_to_migrate>';
   ```

   For example, your DB named `db1` stores a table named `tasks` with the list of tasks. The response to your query will look as follows:

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

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) you want to migrate the data to and create a new table on it from the query text you received earlier.

   If the source cluster did not use replicas, while the target cluster does, switch to a Replicated family engine.

   To create an object on all the target cluster hosts, use the `ON CLUSTER` expression in the `CREATE` command.

1. Run the following query in the source cluster:

   ```sql
   INSERT INTO FUNCTION
   remoteSecure('<Managed_Service_for_ClickHouse®_cluster_host_FQDN>:9440',
                '<target_cluster_DB_name>.<target_table_name>',
                '<username_in_target_cluster>',
                '<user_password_in_target_cluster>')
   SELECT * from <DB_name>.<table_name>;
   ```

   To learn how to get host FQDN, see [this guide](../../managed-clickhouse/operations/connect/fqdn.md).

1. In the target cluster, check that the table from the source cluster has appeared in the DB:

   ```sql
   SHOW TABLES FROM <DB_name>;
   ```

1. Check that the table contains data from the source cluster table:

   ```sql
   SELECT * FROM <DB_name>.<table_name>;
   ```

For more information about using the `remote` function, see the [{{ CH }} documentation]({{ ch.docs }}/sql-reference/table-functions/remote).

## Migrating data using the backup/restore commands and an {{ objstorage-name }} bucket {#backup-objstorage}

{% note warning %}

You need {{ CH }} version 22.10 or later to work with the backup/restore commands in a third-party cluster.

{% endnote %}

You can use the backup/restore commands and an {{ objstorage-name }} bucket to migrate individual tables or the whole database from a third-party {{ CH }} cluster. To do this:

1. [Create a {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md#create-cluster) target cluster.
1. [Create a service account](../../iam/operations/sa/create.md#create-sa) with the `storage.editor` role.
1. [Create a static key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account.

    Save the key ID and the key itself: you will need them for the next steps.

1. [Create an {{ objstorage-name }}](../../storage/operations/buckets/create.md) bucket.
1. Connect to the cluster you want to migrate the data from.
1. Run this command to save a table's backup to an {{ objstorage-name }} bucket:

    ```sql
    BACKUP TABLE <DB_name>.<table_name> TO S3('<Object_Storage_bucket_endpoint>', '<service_account_static_key_ID>', '<service_account_static_key>');
    ```

    If you want to migrate the whole database, run this command:

    ```sql
    BACKUP DATABASE <DB_name> TO S3('<Object_Storage_bucket_endpoint>', '<service_account_static_key_ID>', '<service_account_static_key>');
    ```

1. [Connect to the {{ mch-name }} cluster](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) you want to migrate the data to.
1. Run this command to restore your table from a backup:

    ```sql
    RESTORE TABLE <DB_name>.<table_name> FROM S3('<Object_Storage_bucket_endpoint>', '<service_account_static_key_ID>', 'service_account_static_key>');
    ```

    If you want to restore a database, use this command: 

    ```sql
    RESTORE DATABASE <DB_name> FROM S3('<Object_Storage_bucket_endpoint>', '<service_account_static_key_ID>', 'service_account_static_key>');
    ```

1. Make sure restoring from backup was successful:

    * If it was a table you restored, run this command:

        ```sql
        SELECT * FROM <DB_name>.<table_name>;
        ```

    * If it was a database you restored, run this command:

        ```sql
        SHOW DATABASES;
        ```

For more information on using the backup/restore commands with an S3 storage, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/operations/backup#backuprestore-using-an-s3-disk).
