---
title: "How to create a BigQuery connection"
description: "Follow this guide to create a BigQuery connection."
---

# Creating a Google BigQuery connection

{% note info %}

To create a connection for a service account in BigQuery, make sure the service account has the [BigQuery User](https://cloud.google.com/bigquery/docs/access-control#bigquery.user) role for a dataset.
This connection does not support operations with partitioned tables.

{% endnote %}

To create a BigQuery connection:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Databases**, select the **BigQuery** connection.
1. Specify the connection parameters:

   * **Project ID**. Specify the ID of your project in Google Cloud.
   * **Service account private key**. Click **Attach file** and upload a file with your Google Cloud service account's authorized key for authentication. For more information on how to get a file with a key, see the [Google documentation](https://cloud.google.com/iam/docs/keys-create-delete).
   * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).
   * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).

1. (Optional) Make sure the connection works properly. To do this, click **Check connection**.
1. Click **Create connection**.
1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.
