# Configuring {{ ydb-name }} target endpoints

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* {{ ydb-full-name }} DB connection settings. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ ydb-full-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ ydb-full-name }}](../../../../ydb/).


{% note warning %}

To create or edit an endpoint of a managed database, you need the [`ydb.viewer` role](../../../../ydb/security/index.md#ydb-viewer) or the primitive [`viewer` role](../../../../iam/concepts/access-control/roles.md#viewer) issued for the folder hosting a cluster of this managed database.

{% endnote %}


{% list tabs %}

- Management console

   {% include [YDB UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-database.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.shard_count.title }}**: Specify the required `N` number of shards.

      If the setting is specified, the `_shard_col` column is added to tables. The values in it are calculated as the remainder of `H/N`, where `H` is the result of the hash function at the current time and `N` is the number of shards specified by the setting.


    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.partition_policy.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_type.title }}**: Hour, day, or month.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.part_size.title }}**: In the selected units.

            When the time interval equal to the selected unit of measurement ends, the oldest database table will be deleted and a new one will be created.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.keep_part_count.title }}**: Required number of tables in the target database.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbPartitionPolicy.time_column.title }}**: Split (_partition_) a table by the specified column's values. The column must be of the <q>time</q> type.

            
            For more information about table partitioning, see the [{{ ydb-full-name }}](https://ydb.tech/en/docs/concepts/datamodel/table#partitioning) documentation.


        If this setting is used, the specified number of data tables for different intervals is created in the target database. The name of each table is selected automatically by the date and time of the start of the interval. Depending on the values in the specified column of the source table, the original rows are distributed across the respective tables in the target database.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.alt_names.title }}**: Fill it in if you need to rename tables in the source database when transferring data to the target database.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTargetAdvancedSettings.path.title }}**: Specify the [subdirectory](https://ydb.tech/en/docs/concepts/datamodel/dir) to place tables in.

        The table path you should get is `<path in Yandex Database>/<subdirectory>/<table>`.

{% endlist %}
