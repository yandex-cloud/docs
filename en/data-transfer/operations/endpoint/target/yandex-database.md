# Configuring a {{ ydb-name }} target endpoint

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

   * {% include [Field Cleanup policy Disabled/Drop](../../../../_includes/data-transfer/fields/common/ui/cleanup-policy-disabled-drop.md) %}

   * **Table rotation**:

      * **Unit of measurement**: Hour, day, or month.

      * **Table size**: In the selected units of measurement.

         When the time interval equal to the selected unit of measurement ends, the oldest database table will be deleted and a new one will be created.

      * **Number of tables**: The required number of tables in the target database.

      * **Partition by column**: Split (_partition_) a table by the specified column's values. The column must be of the <q>time</q> type.

         {% if audience != "internal" %}

         For more information about table partitioning, see the [{{ ydb-full-name }}]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/datamodel/table#partitioning){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/datamodel/table#partitioning){% endif %} documentation.

         {% endif %}

      If this setting is used, the specified number of tables for data for different time intervals is created in the target database. The name of each table is selected automatically by the date and time of the start of the interval. Depending on the values in the specified column of the source table, the original rows are distributed across the corresponding tables in the target database.

   * **Renaming tables**: Fill in if you need to rename tables in the source database when transferring data to the target database.

   * **Sub directory for tables**: Specify the [subfolder]{% if lang == "ru" %}(https://ydb.tech/ru/docs/concepts/datamodel/dir){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/concepts/datamodel/dir){% endif %} to place tables in.

      Final table placement path: `<Path in Yandex Database>/<subfolder>/<table>`.

{% endlist %}
