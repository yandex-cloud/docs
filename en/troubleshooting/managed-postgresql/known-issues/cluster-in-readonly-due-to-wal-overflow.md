# Resolving the consequences of cluster storage overflow with WAL logs



## Issue description {#issue-description}

Your {{ mpg-name }} cluster encountered one or multiple issues listed below:

* A {{ data-transfer-name }} caused the database storage overflow.
* The number of replication slots for the cluster is exceeded.
* New data is not written to your cluster's database tables.

## Solution {#case-resolution}

Errors may occur because of issues with replication slots when {{ data-transfer-name }} performs operations with your cluster databases.

Each running transfer creates a replication slot in the database. A replication slot points to a position in the WAL log. If the slot is not in use, the position in the log does not change.

If data from this slot has not been read for some reason, the size of the WAL log continues to increase until the free space in the cluster storage runs out, or the [`Max slot wal keep size`](../../../managed-postgresql/concepts/settings-list.md) value is exceeded.

You can find out which replication slots are open in the database by connecting to one of the cluster databases using `psql` and running this query: `SELECT * FROM pg_replication_slots WHERE slot_type = 'logical';`.

{% cut "Example of the `SELECT * FROM pg_replication_slots WHERE slot_type = 'logical';` command output" %}

    ```sql
    SELECT * FROM pg_replication_slots WHERE slot_type = 'logical';
    -[ RECORD 1 ]-------+---------------------
    slot_name           | dtt*****************
    plugin              | wal2json
    slot_type           | logical
    ```

{% endcut %}

* If the `plugin` field in the logical replication slot has the `wal2json` value, it means that {{ data-transfer-name }} is currently working with the databases of this cluster.

* If an error occurred during the transfer process for one or more replication slots, delete the slot by using the `SELECT pg_drop_replication_slot('$REPLICATION_SLOT_NAME');` command, where `$REPLICATION_SLOT_NAME` is the name of the stuck replication slot. In the example above, it is `dtt*****************`.

* If after deleting the replication slot you see the `replication slot "$REPLICATION_SLOT_NAME" is active for PID $PID_NUM` error, try stopping the transfer on the {{ data-transfer-name }} side or delete the involved endpoint from the transfer parameters.

{% cut "Example of the `select pg_drop_replication_slot('$REPLICATION_SLOT_NAME');` command output" %}

```sql
db-NAME=> SELECT pg_drop_replication_slot('$REPLICATION_SLOT_NAME');
ERROR: replication slot "$REPLICATION_SLOT_NAME" IS active FOR PID 12345
```
{% endcut %}

You can also specify the maximum size of the WAL log ,after reaching which {{ data-transfer-name }} will stop. To do this, edit the [`Max slot wal keep size`](../../../managed-postgresql/concepts/settings-list.md) value. If the size of your database's WAL log exceeds this value, the transfer will stop. This will prevent filling up all free space in the cluster storage.

After an error (or successful completion of the transfer), the WAL log is deleted, and the storage space it occupied is freed up. If the transfer does not successfully complete after changing `Max slot wal keep size`, increase the cluster storage following [this guide](../../../managed-postgresql/operations/update.md#change-disk-size).

You can learn more about the operation of replication slots in the [PostgreSQL developer guide](https://www.postgresql.org/docs/current/view-pg-replication-slots.html).