# Configuring BigQuery source endpoints

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to BigQuery.

## {#settings} settings

{% list tabs %}

- Management console

   * **Project ID**: specify the ID of [Google Cloud project](https://cloud.google.com/resource-manager/docs/creating-managing-projects).
   * (optional) **Default Dataset ID**: if a value is set in this field, data will be transferred only from the specified [schema](https://cloud.google.com/bigquery/docs/datasets-intro).
   * **Credentials JSON**: specify the contents of the JSON file [account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

{% endlist %}