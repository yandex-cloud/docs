---
title: How to create a Bitrix24 connection
description: Follow this guide to create a Bitrix24 connection.
---

# Creating a Bitrix24 connection

{% include [datalens-bitrix24-connection-note](../../../_includes/datalens/operations/datalens-bitrix24-connection-note.md) %}

To create a Bitrix24 connection:

1. Open the [connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Partner connections**, select the **Bitrix24** connection.
1. Configure the connection as follows:

   * **Portal**: URL of your Bitrix24 portal in `test.bitrix24.com` format.
   * **Token**: Get a secret key in Bitrix24 by selecting **CRM** → **Analytics** → **BI analytics** in the **Yandex DataLens** tab. For more information, see [this guide](https://helpdesk.bitrix24.ru/open/17402692).
   * Leave the **Automatically create dashboard, charts, and dataset on top of connection** option enabled if you need a folder with a standard set of datasets and charts and a ready-made dashboard.

1. Optionally, test the connection by clicking **Check connection**.
1. Click **Create connection**.
1. Select the [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.


## Use cases {#examples}

* [{#T}](../../tutorials/data-from-bitrix24-visualization.md)
