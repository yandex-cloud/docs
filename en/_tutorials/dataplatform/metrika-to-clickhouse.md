
# Loading data from {{ metrika }} to a {{ CH }} data mart using {{ data-transfer-full-name }}


{% include [note-metrica-pro](../../_includes/data-transfer/note-metrica-pro.md) %}

{{ data-transfer-name }} enables you to transfer metrics from [{{ metrika }}]({{ metrika-link }}) to a {{ CH }} cluster. This approach guarantees the completeness of the data transferred from {{ metrika }} and allows:

* Processing data with {{ CH }} tools.
* Streaming data from {{ CH }} to other locations.
* Visualizing data with [{{ datalens-full-name }}]({{ link-datalens-main }}) or other services.

To transfer data:

1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mch-name }} cluster: Use of computing resources allocated to hosts, storage and backup size (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* [Metrica Pro]({{ link-yandex }}/support/metrica/pro/price.html).


## Getting started {#before-you-begin}

Set up the infrastructure:

1. [Select]({{ link-yandex }}/support/metrica/general/tag-id.html) an existing metric in {{ metrika }} or [create and install]({{ link-yandex }}/support/metrica/general/creating-counter.html) a new one.

1. Create a [target {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-create.md) with your preferred configuration.

## Set up and activate the transfer {#prepare-transfer}

1. [Create an endpoint](../../data-transfer/operations/endpoint/index.md#create) for the [`{{ metrika-endpoint }}` source](../../data-transfer/operations/endpoint/source/metrika.md).

    Hits and sessions are transferred as separate tables.

1. [Create a target endpoint](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `ClickHouse`
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`

        Select your target cluster from the list and specify its [connection settings](../../data-transfer/operations/endpoint/target/clickhouse.md).

1. [Create](../../data-transfer/operations/transfer.md#create) a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**-type transfer configured to use the new endpoints.
1. [Activate](../../data-transfer/operations/transfer.md#activate) the transfer.

Transfers process only the latest data, leaving historical data untouched. If you deactivate and then reactivate the transfer:

1. Data collected by the {{ metrika }} tracking tag while the transfer was deactivated will not be migrated.
1. Depending on the cleanup policy selected in the target endpoint, existing data tables will be:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DROP.title }}**: Deleted along with all data and recreated with the same names.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.TRUNCATE.title }}**: Truncated while preserving their schemas.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.CleanupPolicy.DISABLED.title }}**: Left intact for future data writing.

## Test your transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Make sure the metric data from {{ metrika }} has been transferred to the {{ mch-name }} database:

    1. [Connect to the cluster](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) via `clickhouse-client`.

    1. Verify that the hit and session tables have appeared in the database:

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

    1. Check whether the hit and session tables contain the relevant metric data:

        ```sql
        SELECT * FROM <name_of_hit_or_visit_table>
        ```

## Delete the resources you created {#clear-out}

{% include [note before delete resources](../../_includes/mdb/note-before-delete-resources.md) %}

To reduce the consumption of resources you do not need, delete them:

1. [Delete the transfer](../../data-transfer/operations/transfer.md#delete-transfer).
1. [Delete the source and target endpoints](../../data-transfer/operations/endpoint/index.md#delete).
1. [Delete the {{ mch-name }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
1. Delete the {{ metrika }} tracking counter from your [Yandex Metrica Pro]({{ link-yandex }}/support/metrica/pro/intro.html) account.
