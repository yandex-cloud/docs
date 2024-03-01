---
noIndex: true
---

# Loading data from {{ metrika }} to a {{ CH }} data mart using {{ data-transfer-full-name }}

{% include [note-metrica-pro](../../_includes/data-transfer/note-metrica-pro.md) %}

With {{ data-transfer-name }}, you can transfer data from a [{{ metrika }}]({{ metrika-link }}) tag to a {{ CH }} cluster. Such a transfer ensures the data transferred from {{ metrika }} are complete and allows:

* Processing data with {{ CH }} tools.
* Streaming data from {{ CH }} to other locations.
* Visualizing data using [{{ datalens-full-name }}]({{ link-datalens-main }}) or other services.

To transfer data:

1. [Prepare and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

Prepare the infrastructure:

1. [Select]({{ link-yandex }}/support/metrica/general/tag-id.html) a {{ metrika }} tag or [create and install]({{ link-yandex }}/support/metrica/general/creating-counter.html) a new one.

1. Create a [{{ mch-name }} target cluster](../../managed-clickhouse/operations/cluster-create.md) with any suitable configuration.

## Prepare and activate the transfer {#prepare-transfer}

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [`{{ metrika-endpoint }}` source](../../data-transfer/operations/endpoint/source/metrika.md).

   The hits and sessions data is transferred as separate tables.

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the target:

   * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `{{ ui-key.yacloud.data-transfer.label_endpoint-type-CLICKHOUSE }}`.
   * **{{ ui-key.yacloud.data-transfer.forms.section-endpoint }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`

      Select a target cluster from the list and specify its [connection settings](../../data-transfer/operations/endpoint/target/clickhouse.md).

1. [Create a transfer](../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_** type that will use the created endpoints.
1. [Activate](../../data-transfer/operations/transfer.md#activate) your transfer.

A transfer only moves the current data and does not affect historical data. If you deactivate and activate the transfer again:

1. Data obtained by the {{ metrika }} tag before the transfer was disabled will not be transferred.
1. Depending on the cleanup policy selected in the target endpoint, the existing data tables will be:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}**: Deleted along with the data and created again with the same names.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}**: Purged of existing data without removing the tables and schemas.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}**: Used for further data writes.

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Make sure the data from the {{ metrika }} tag has been moved to the {{ mch-name }} database:

   1. [Connect to the cluster](../../managed-clickhouse/operations/connect.md) using `clickhouse-client`:

   1. Check that the tables with hit and session data appear in the database:

      ```sql
      SELECT table FROM system.tables
      WHERE database = '<{{ CH }}_database_name>'
      ```

      Result:

      ```text
      ┌─table───────────────────────┐
      │ hits_dt...                  │
      │ visits_dt...                │
      └─────────────────────────────┘
      ```

   1. Make sure the tables with hit and session data contain the tag data:

      ```sql
      SELECT * FROM <name_of_the_table_with_hit_or_session_data>
      ```

## Delete the resources you created {#clear-out}

{% include [note before delete resources](../../_includes/mdb/note-before-delete-resources.md) %}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Delete endpoints](../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.
1. [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
1. Delete the {{ metrika }} tag from your [Yandex Metrica Pro]({{ link-yandex }}/support/metrica/pro/intro.html) account.
