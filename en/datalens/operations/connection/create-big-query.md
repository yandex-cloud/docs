# Creating a Google BigQuery connection

## Connecting to BigQuery {#bigquery-connection}

To create a BigQuery connection:



1. Go to the [connections page](https://datalens.yandex.ru/connections).
1. Click **Create connection**.




1. Select a **BigQuery** connection.
1. Specify the ID of your project in Google Cloud.
1. Upload a file with your service account's authorized key for authentication.
1. Configure an **SQL query access level**. It enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).
1. In the **Cache TTL in seconds** setting, specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
1. Check the connection, and if it's OK, click **Create connection**.
1. Enter the name for the connection and click **Create**.