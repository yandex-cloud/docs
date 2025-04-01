---
title: How to create an AppMetrica connection in {{ datalens-full-name }}
description: Follow this guide to create an AppMetrica connection.
---

# Creating an AppMetrica connection

To create an AppMetrica connection:


1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **AppMetrica** connection.
1. Specify the connection settings:

   * **OAuth token**: Click **Get token** or enter the [OAuth token](#get-oauth-token) manually to access the AppMetrica data.
   * **App**: Specify one or more applications to connect to.
   * **Accuracy**: Set the data accuracy (sampling rate). You can change the accuracy after you create the connection.

     {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}


1. Leave the **Automatically create a dashboard, charts, and a dataset on the connection** option enabled if you need a folder with a standard set of datasets and charts and a ready-made dashboard.


1. Click **Create connection**.


1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.


1. Enter a name for the connection and click **Create**.

{% include [datalens-appmetrica-note](../../../_includes/datalens/datalens-appmetrica-note.md) %}

For datasets based on AppMetrica connections, the following groups of metrics are available:

- Installations
- Audience
- Client events
- Push campaigns
- Audience + social demographic 


Connections to AppMetrica do not support [public access](../../concepts/datalens-public.md) to the objects created based on it. To share a dashboard or chart created based on this connection, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}


{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}


