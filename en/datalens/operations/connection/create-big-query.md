# Creating a Google BigQuery connection

To create a BigQuery connection:


1. Go to the [connections page]({{ link-datalens-main }}/connections).
1. Click **Create connection**.



1. Select a **BigQuery** connection.
1. Specify the connection parameters:

   * **Project ID**. Specify the ID of your project in Google Cloud.
   * **Service account public key**. Click **Attach file** and upload a file with your service account's authorized key for authentication.
   * **Raw SQL level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).
   * **Cache TTL in seconds**. Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).

1. Click **Create connection**.
1. Enter the name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
