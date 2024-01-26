# Configuring BigQuery source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to BigQuery.

## Settings {#settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.project_id.title }}**: Specify the ID of the [Google Cloud project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) that contains the BigQuery target's dataset.
   * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.dataset_id.title }}**: Dataset ID used for searching for tables and forms to view. If the field value is set, data is only transferred from the specified [schema](https://cloud.google.com/bigquery/docs/datasets-intro). This may speed up schema detection.
   * **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.bigquery_source.endpoint.airbyte.bigquery_source.BigQuerySource.credentials_json.title }}**: Specify the contents of the [account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) JSON file.

{% endlist %}
