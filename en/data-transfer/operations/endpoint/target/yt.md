# Configuring a YT source endpoint

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* Settings for connecting to a [YT cluster](#cluster). These are required parameters.
* [Additional settings](#additional-settings).


## YT cluster {#cluster}

{% list tabs %}

- Management console

   * **YT cluster**: Name of the YT source cluster, for example, `HAHN`, `ARNOLD`, or `FREUD`.

   * **Path**: Paths to data tables.

   * **Table type**: The type of tables to be created during the transfer: `Static tables`, `Dynamic tables`, `Sorted dynamic tables`, or `Versioned dynamic tables`.

      - For static tables:

         * **Chunk format**: `String-by-string` (the **scan** value is used to optimize scanning) or `Column-by-column` (the **lookup** value is used to optimize lookup).

      - For dynamic tables:

         * **Tablet-cell bundle**: Tablet cells to record quotas.

         * **Medium**: Data storage space. Select `HDD`, `SDD`, `SDD for logs`, or `RAM`.

         * **Chunk format**: `String-by-string` (the **scan** value is used to optimize scanning) or `Column-by-column` (the **lookup** value is used to optimize lookup).

         * **Allow schema changes**: If this option is selected, the table schemas will automatically change whenever the source schema is changed.

         * **Atomic transactions**: Using the `automicity=full` property for tables.

         * **TTL**: The lifetime of logs in milliseconds.

         * **Additional settings of dynamic tables**:

            * **Store raw data**: If this option is selected, all unprocessed changes will be retained in the table with the `_wal` postfix.

            * **Archive**: If this option is selected, all deleted data will be placed in the archived table.

            * **Column with a shard index**: The number of shards and the name of the sharding column to record the value, calculated based on the value of the other column.

            * **Additional indexes**: Specify the column for which the table will be created, in which this column will be the primary key.

            * **Copy with static table**: Select this option to perform copy operations via temporary static tables. For the `Drop` policy, existing data in the target is deleted once the copy is completed. If no drop mode is used, new and existing data will be merged.

      - For sorted dynamic tables:

         * **Tablet-cell bundle**: Tablet cells to record quotas.

         * **Medium**: Data storage space. Select `HDD`, `SDD`, `SDD for logs`, or `RAM`.

         * **Chunk format**: `String-by-string` (the **scan** value is used to optimize scanning) or `Column-by-column` (the **lookup** value is used to optimize lookup).

         * **Atomic transactions**: Using the `automicity=full` property for tables.

         * **TTL**: The lifetime of logs in milliseconds.

         * **Additional settings of dynamic tables**:

            * **Store raw data**: If this option is selected, all unprocessed changes will be retained in the table with the `_wal` postfix.

            * **Initial number of tablets**: The option defines how many tablets will be created by default.

      - For versioned dynamic tables:

         * **Tablet-cell bundle**: Tablet cells to record quotas.

         * **Medium**: Data storage space. Select `HDD`, `SDD`, `SDD for logs`, or `RAM`.

         * **Chunk format**: `String-by-string` (the **scan** value is used to optimize scanning) or `Column-by-column` (the **lookup** value is used to optimize lookup).

         * **Allow schema changes**: If this option is selected, the table schema will automatically change whenever the source schema is changed.

         * **Atomic transactions**: Using the `automicity=full` property for tables.**

         * **TTL**: The lifetime of logs in milliseconds.

         * **Column with a version**: Each time a string in the table is changed, the table searches for a string with such a primary key. If the version in the found string is higher than in the incoming string, the incoming string is ignored.

         * **Additional settings of versioned dynamic tables**:

            * **Store raw data**: If this option is selected, all unprocessed changes will be retained in the table with the `_wal` postfix.

            * **Column with a shard index**: Number of shards and name of the sharding column to record the value, calculated based on the value of the other column.

            * **Additional indexes**: Specify the columns to create separate tables for. The specified columns will be used as primary keys in these tables.

   * **Cleanup policy**: Cleanup policy for the activation, reactivation, and reboot processes. The default value is `Drop`.

{% endlist %}

## Advanced settings {#additional-settings}

{% list tabs %}

- Management console

   * **Rename tables**: Used to rename the tables created during the transfer.

   * **Rotate tables**: Splitting the incoming data stream by time. Specify the name of the column to partition, the type of partition (hour, day, month), the maximum number of tables to rotate, the number of partitions in the table, and the table naming pattern (<name>/<partition>, where <name> - Table name, and <partition> - Partition name based on time.)

   * **Maximum number of strings in a YT query**: The default value is 90000.

   * **Redefine table specification**: A custom specification for writing tables in JSON format. Click **Upload file** to add a specification.

{% endlist %}

## Required permissions to write data to YT clusters {#roles}

To configure a transfer to static tables, it's enough to have permissions to create and write data to a table (the `write` permission to the directory with tables). If data cleanup before a transfer is enabled, the `remove` permission is required. In addition, to perform a transfer, you'll need the `use` permission to the account associated with the directory where the tables will be located.

To configure a transfer to dynamic tables, apart from the `write`, `remove`, and `use` permissions, you'll need the `mount` permission to the tables and the `use` permission to the tablet-cell bundle used for the tables (the bundle name is specified in the [target settings](#cluster)).
If table rotation by time is enabled , permissions to delete the tables are required.

Currently, all operations are performed as a robot named `robot-lf-dyn-push`.

