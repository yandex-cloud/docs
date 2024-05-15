# Transferring data from a BigQuery source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to BigQuery.

{{ data-transfer-full-name }} enables you to upload data from BigQuery storage to {{ yandex-cloud }} managed databases and implement various data processing and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Prepare the BigQuery database](#prepare) for the transfer.
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. In case of any issues, [use ready-made solutions](../../../../data-transfer/troubleshooting/index.md) to resolve them.

## Scenarios for transferring data from BigQuery {#scenarios}

You can upload data from BigQuery cloud storage to managed databases for further storage in the cloud, processing and loading into data marts for further visualization.

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Preparing your BigQuery database {#prepare}

{% include [prepare bigquery db](../../../../_includes/data-transfer/endpoints/sources/bigquery-prepare.md) %}

## Configuring the BigQuery source endpoint {#settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.project_id.title }}**: Specify the ID of the [Google Cloud project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) that contains the BigQuery target's dataset.
   * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.dataset_id.title }}**: Dataset ID used for searching for tables and forms to view. If the field value is set, data is only transferred from the specified [schema](https://cloud.google.com/bigquery/docs/datasets-intro). This may speed up schema detection.
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.credentials_json.title }}**: Specify the contents of the [account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) JSON file.

{% endlist %}

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ MY }}](../target/mysql.md).
* [{{ MG }}](../target/mongodb.md).
* [{{ CH }}](../target/clickhouse.md).
* [{{ GP }}](../target/greenplum.md).
* [{{ ydb-full-name }}](../target/yandex-database.md).
* [{{ KF }}](../target/kafka.md).
* [{{ DS }}](../target/data-streams.md).
* [{{ PG }}](../target/postgresql.md).

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

{% include [Internet access](../../../../_includes/data-transfer/notes/internet-access.md) %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).