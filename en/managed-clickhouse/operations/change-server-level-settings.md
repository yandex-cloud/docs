# Changing {{ CH }} settings at the server level

You can specify [{{ CH }} settings at the server level](https://clickhouse.com/docs/en/operations/server-configuration-parameters/settings) to configure the way the databases or individual tables work in a {{ mch-name }} cluster. You can specify settings in several ways:

  * Using the [{{ yandex-cloud }} interfaces](#yandex-cloud-interfaces). This way, you can specify only the {{ CH }} settings available in {{ yandex-cloud }}.
  * Using [SQL queries](#sql-queries). This way, you can specify settings for MergeTree tables. You can:

    * Specify the settings when [creating a table](#set-settings-for-new-table).
    * [Specify the settings](#change-settings-of-existing-table) of an existing table.
    * [Restore the default settings](#reset-table-settings) of an existing table.

## Specifying {{ CH }} settings using the {{ yandex-cloud }} interfaces {#yandex-cloud-interfaces}

Changing some [server settings](../concepts/settings-list.md#server-level-settings) will restart {{ CH }} servers on the cluster hosts.

{% note info %}

You cannot directly update the [Max server memory usage]({{ ch.docs }}/operations/server-configuration-parameters/settings/#max_server_memory_usage) value. {{ mch-name }} sets this value automatically depending on the amount of RAM available to {{ CH }} hosts. To edit this setting, you first need to [change the {{ CH }} host class](#change-resource-preset). For more information, see [Memory management](../concepts/memory-management.md).

{% endnote %}

{% include [change-clickhouse-settings](../../_includes/mdb/mch/change-clickhouse-settings.md) %}

## Checking MergeTree table settings {#check-current-settings}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. To view all table-level settings, run the following query:

         ```sql
         SHOW CREATE TABLE <table_name>;
         ```

         {% note warning %}

         The `SHOW CREATE TABLE` output only includes settings overridden by the user. If a user-defined value matches the default value, this setting is also displayed in the output.

         {% endnote %}

   {% endlist %}

## Specifying settings for MergeTree tables using SQL queries {#sql-queries}

### Changing settings when creating a MergeTree table {#set-settings-for-new-table}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. Create a table. To specify its settings, list them in the `SETTINGS` parameter, separated by commas:

         ```sql
         CREATE TABLE <table_name>
            (
            <table_column_description>
            )
            ENGINE = MergeTree
            PRIMARY KEY (<column_or_group_of_columns>)
            SETTINGS
            <setting_name> = <setting_value>,
            <setting_name> = <setting_value>;
         ```

         Example query for the [merge_with_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_ttl_timeout) and [merge_with_recompression_ttl_timeout](https://clickhouse.com/docs/en/operations/settings/merge-tree-settings#merge_with_recompression_ttl_timeout) settings:

         ```sql
         CREATE TABLE <table_name>
            (
            user_id UInt32,
            message String,
            )
            ENGINE = MergeTree
            PRIMARY KEY (user_id)
            SETTINGS merge_with_ttl_timeout = 15000,
            merge_with_recompression_ttl_timeout = 15000;
         ```

      For more information about creating MergeTree tables, see the [{{ CH }} documentation](https://clickhouse.com/docs/en/engines/table-engines/mergetree-family/mergetree#table_engine-mergetree-creating-a-table).

   {% endlist %}

### Changing the settings of an existing MergeTree table {#change-settings-of-existing-table}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. To change the settings for an existing table, run the following query:

         ```sql
         ALTER TABLE <table_name> MODIFY SETTING <setting_name> = <new_setting_value>;
         ```
         You can change multiple settings in a single query. To do this, list the `<setting_name> = <new_setting_value>` pairs separated by commas.

   {% endlist %}

### Restoring the default settings of a MergeTree table {#reset-table-settings}

   {% list tabs group=instructions %}

   - SQL {#sql}

      1. [Connect](connect/clients.md) to the database in the cluster.
      1. To restore a default setting value of an existing table, run the following query:

         ```sql
         ALTER TABLE <table_name> RESET SETTING <setting_name>;
         ```
         You can restore multiple default settings in a single query. To do this, list the names of the settings separated by commas.

   {% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
