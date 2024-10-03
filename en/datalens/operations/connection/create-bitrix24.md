---
title: How to create a Bitrix24 connection
description: Follow this guide to create a Bitrix24 connection.
---

# Creating a Bitrix24 connection

To create a Bitrix24 connection:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Partner connections**, select the **Bitrix24** connection.
1. Specify the connection parameters:

   * **Portal**: URL of your Bitrix24 portal in `test.bitrix24.com` format.
   * **Token**: Get a secret key in Bitrix24 by selecting **CRM** → **Analytics** → **BI analytics** in the **Yandex DataLens** tab. For more information, see [this guide](https://helpdesk.bitrix24.ru/open/17402692).
   * Leave the **Automatically create a dashboard, charts, and a dataset on the connection** option enabled if you need a folder with a standard set of datasets and charts and a ready-made dashboard.

1. (Optional) Make sure the connection works properly. To do this, click **Check connection**.
1. Click **Create connection**.
1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.