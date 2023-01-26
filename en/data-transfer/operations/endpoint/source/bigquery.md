# Configuring BigQuery source endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to BigQuery.

## {#settings} settings

{% list tabs %}

- Management console

   * **Project ID**: Specify the ID of the [Google Cloud project](https://cloud.google.com/resource-manager/docs/creating-managing-projects) that contains the BigQuery target's dataset.
   * (Optional) **Default dataset ID**: The dataset ID used for searching for tables and forms to view. If the field value is set, data is only transferred from the specified [schema](https://cloud.google.com/bigquery/docs/datasets-intro). This may speed up schema detection.
   * **JSON credentials**: Specify the contents of the [account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) JSON file.

{% endlist %}
