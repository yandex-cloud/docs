---
title: "How to create a BigQuery connection"
description: "Follow this guide to create a BigQuery connection."
---

# Creating a Google BigQuery connection

{% note info %}

To create a BigQuery connection, make sure the service account is granted the [BigQuery Data Viewer](https://cloud.google.com/bigquery/docs/access-control#bigquery.dataViewer) role for a dataset.
This connection does not support operations with partitioned tables.

{% endnote %}

To create a BigQuery connection:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}



1. Go to the [connections page]({{ link-datalens-main }}/connections).
1. Click **Create connection**.



1. Select a **BigQuery** connection.
1. Specify the connection parameters:

   * **Project ID**: Specify the ID of your project in Google Cloud.
   * **Service account public key**: Click **Attach file** and upload a file with your service account's authorized key for authentication.
   * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).
   * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).

1. Click **Create connection**.
1. Enter a name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
