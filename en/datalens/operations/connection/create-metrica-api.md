---
title: "How to create a Yandex Metrica connection in {{ datalens-full-name }}"
description: "Follow this guide to create a Yandex Metrica connection."
---

# Creating a Metrica connection


{% include [datalens-metrica-pro-note](../../../_includes/datalens/datalens-metrica-pro-note.md) %}


To create a Yandex Metrica connection:


1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.
1. Select **Metrica** as the connection type.
1. Specify the connection parameters:

   * **OAuth token**: Click **Get token** or enter the [OAuth token](#get-oauth-token) manually to access the Yandex Metrica data.
   * **Tag**: Specify one or more tracking tags to connect to.

      {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}

   * **Accuracy**: Set the data accuracy (sampling rate). You can change the accuracy after you create the connection.
   * Leave the **Automatically create a dashboard, charts, and a dataset on the connection** option enabled if you need a folder with a standard set of datasets and charts and a ready-made dashboard.

1. Click **Create connection**. If you use a new {{ datalens-short-name }} object model with [workbooks and collections](../../../datalens/workbooks-collections/index.md), select or create a workbook to save the connection to.
1. Enter a name for the connection and click **Create**.

{% include [datalens-metrica-note](../../../_includes/datalens/datalens-metrica-note.md) %}


Connections to the Yandex Metrica API do not support [public access](../../concepts/datalens-public.md) to the objects created based on it. To share a dashboard or chart created based on this connection, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}


{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
