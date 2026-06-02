---
title: How to create a Metrica connection in {{ datalens-full-name }}
description: Follow this guide to create a Metrica connection in {{ datalens-full-name }}.
---

# Creating a Metrica connection in {{ datalens-full-name }}


{% include [datalens-metrica-pro-note](../../../_includes/datalens/datalens-metrica-pro-note.md) %}


To create a Yandex Metrica connection:


1. Open the [connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **Metrica** connection.
1. Configure the connection as follows:

   * **OAuth token**: Click **Get token** or enter the [OAuth token](#get-oauth-token) manually to access the Yandex Metrica data.
   * **Counter**: Specify one or multiple tags to connect to.
    
     {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}

   * **Accuracy**: Set the data accuracy (sampling rate). You can change the accuracy after you create the connection.
   * Leave the **Automatically create dashboard, charts, and dataset on top of connection** option enabled if you need a folder with a standard set of datasets and charts and a ready-made dashboard.

1. Click **Create connection**.


1. Select the [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.


1. Enter a name for the connection and click **Create**.

{% include [datalens-metrica-note](../../../_includes/datalens/datalens-metrica-note.md) %}


Connections to the Yandex Metrica API do not support [public access](../../concepts/datalens-public.md) to objects created based on it. To share a dashboard or chart created based on this connection, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}


{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}


