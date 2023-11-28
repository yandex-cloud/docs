# Resolving the consequences of cluster storage overflow with WAL logs



## Issue description {#issue-description}

You see one or more of the following issues in the operation of your Managed Services for PostgreSQL cluster:

* As a result of Yandex Data Transfer operation, the database storage has been overflown.
* The number of replication slots for the cluster has been exceeded.
* New data is not written to your cluster's database tables.

## Solution {#case-resolution}

The error might occur due to issues with replication slots when Yandex Data Transfer performs operations with cluster databases.

Each running transfer creates a replication slot in the database.
A replication slot is a pointer to a position in the WAL log. If the slot is not in use, the position in the log does not change.
If data from this slot has not been read for some reason, the size of the WA log continues to increase until the free space in the cluster storage runs out, or the [`Max slot wal keep size` parameter](../../../managed-postgresql/concepts/settings-list.md) is exceeded.

You can find out which replication slots are open in the database by connecting to one of the cluster databases using `psql` and running this query: `select * from pg_replication_slots where slot_type = 'logical';`.

{% cut "Example output of the `select * from pg_replication_slots where slot_type = 'logical';` command" %}

    ```sql
    select * from pg_replication_slots where slot_type = 'logical';
    -[ RECORD 1 ]-------+---------------------
    slot_name           | dtt7v7vbpuogkku0oce9
    plugin              | wal2json
    slot_type           | logical
    ```

{% endcut %}

If the `plugin` field in the logical replication slot has the `wal2json`value, it means that Data Transfer is currently interacting with the databases of this cluster.
Possibly, an error occurred during the transfer process for one or more replication slots.
Try deleting replication slots using the `select pg_drop_replication_slot('$REPLICATION_SLOT_NAME');`  command, where `$REPLICATION_SLOT_NAME` is the name of the stuck replication port (in the example provided above, it is `dtt8d6vbqjdikau1oaq1`).

If upon deletion of the replication slot you see this error: `replication slot "$REPLICATION_SLOT_NAME" is active for PID $PID_NUM`, try stopping the  transfer on the Data Transfer side or delete the involved endpoint from the transfer parameters.

{% cut "Example output of the `select pg_drop_replication_slot('$REPLICATION_SLOT_NAME');` command:" %}

```sql
db-name=> select pg_drop_replication_slot('$REPLICATION_SLOT_NAME');
ERROR: replication slot "$REPLICATION_SLOT_NAME" is active for PID 12345
```
{% endcut %}

You can also specify the maximum size of the WAL log, after which the Data Transfer operation will be stopped. To do this, change the value of the [`Max slot wal keep` size parameter](../../../managed-postgresql/concepts/settings-list.md). If the size of your database's WAL log exceeds the size specified in this parameter, the transfer will stop.
This will prevent filling up all the free space in the cluster storage.

After an error (or successful completion of transfer), the WAL log is deleted, and the storage space occupied by it is freed up.
If the transfer does not successfully complete after changing the `Max slot wal keep size` parameter, increase the cluster storage following [this guide](../../../managed-postgresql/operations/update.md#change-disk-size).

You can learn more about the operation of replication slots [from the PostgreSQL developer documentation](https://www.postgresql.org/docs/current/view-pg-replication-slots.html).