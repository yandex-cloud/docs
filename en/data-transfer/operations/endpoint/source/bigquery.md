# Transferring data from a BigQuery endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, make sure to configure BigQuery access.

{{ data-transfer-full-name }} enables you to export data from BigQuery to {{ yandex-cloud }} managed databases and implement various data processing and transformation scenarios. To set up a transfer:

1. [Review the available data transfer scenarios](#scenarios).
1. [Prepare the BigQuery database](#prepare) for the transfer.
1. [Set up a source endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) and [launch](../../transfer.md#activate) the transfer.
1. If you run into any problems, [check the available solutions](../../../../data-transfer/troubleshooting/index.md) for troubleshooting.

## BigQuery transfer scenarios {#scenarios}

You can export data from BigQuery to managed databases for cloud storage, processing, and further loading into data marts for visualization.

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing your BigQuery database {#prepare}

{% include [prepare bigquery db](../../../../_includes/data-transfer/endpoints/sources/bigquery-prepare.md) %}

## Configuring the BigQuery source endpoint {#settings}

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.project_id.title }}**: Specify the ID of the [Google Cloud project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) that contains the target BigQuery dataset.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.dataset_id.title }}**: Optionally, specify the ID of the dataset for discovering tables and views. Setting the value in this field restricts the transfer to the specified [schema](https://cloud.google.com/bigquery/docs/datasets-intro), leading to faster schema detection.
    * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.credentials_json.title }}**: Paste the contents of the JSON file with the [service account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

{% endlist %}

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ MY }}](../target/mysql.md)
* [{{ MG }}](../target/mongodb.md)
* [{{ CH }}](../target/clickhouse.md)
* [{{ GP }}](../target/greenplum.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)
* [{{ KF }}](../target/kafka.md)
* [{{ DS }}](../target/data-streams.md)
* [{{ PG }}](../target/postgresql.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

{% include [Internet access](../../../../_includes/data-transfer/notes/internet-access.md) %}

Once you have configured the source and target, [create and launch the transfer](../../transfer.md#create).
