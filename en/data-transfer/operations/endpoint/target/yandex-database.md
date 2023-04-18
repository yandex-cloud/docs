# Configuring {{ ydb-name }} target endpoints

When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* {{ ydb-full-name }} DB connection settings. These are required parameters.
* [Additional parameters](#additional-settings).

## {{ ydb-full-name }} cluster {#managed-service}

Connecting to the database with the cluster ID specified in {{ yandex-cloud }}. Available only for clusters deployed in [{{ ydb-full-name }}](../../../../ydb/).

{% list tabs %}

- Management console

   {% include [YDB UI](../../../../_includes/data-transfer/necessary-settings/ui/yandex-database.md) %}

{% endlist %}

## Additional settings {#additional-settings}

{% list tabs %}

- Management console

   * **Number of shards**: Specify the required `N` number of shards.

      If the setting is specified, the `_shard_col` column is added to tables. The values in it are calculated as the remainder of `H/N`, where `H` is the result of the hash function at the current time and `N` is the number of shards specified by the setting.


    * **Table rotation**:

        * **Time measurement unit**: Hour, day, or month.

        * **Table size**: In the selected units.

            When the time interval equal to the selected unit of measurement ends, the oldest database table will be deleted and a new one will be created.

        * **Number of tables**: Required number of tables in the target database.

        * **Split by column**: Split (_partition_) a table by the specified column's values. The column must be of the <q>time</q> type.

            
            For more information about table partitioning, see the [{{ ydb-full-name }}](https://ydb.tech/en/docs/concepts/datamodel/table#partitioning) documentation.


        If this setting is used, the specified number of data tables for different intervals is created in the target database. The name of each table is selected automatically by the date and time of the start of the interval. Depending on the values in the specified column of the source table, the original rows are distributed across the respective tables in the target database.

    * **Rename tables**: Fill it in if you need to rename tables in the source database when transferring data to the target database.

    * **Subdirectory for tables**: Specify the [subdirectory](https://ydb.tech/en/docs/concepts/datamodel/dir) to place tables in.

        The table path you should get is `<path in Yandex Database>/<subdirectory>/<table>`.

{% endlist %}
