---
title: How to create a connection to 1C Extractor
description: Follow this guide to create a connection to 1C Extractor.
---

# Creating a connection to 1C Extractor

Before creating a connection, [install and configure](https://gramax.denvic.ru/extractor_docs/o-programme/vvedenie) the Extractor extension in your 1C version.

To create a connection to [1C Extractor](https://bi.denvic.ru/products/ekstraktor-1s):

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Partner connections**, select the **1C Extractor** connection.
1. Get a token for the connection: in 1C, open **1C Extractor**, select **License key** → **Get token**, and copy the token. For more information, see [this guide](https://gramax.denvic.ru/extractor_docs/ustanovka/licenzirovanie-i-token-dlya-konnektora-1s-k-yande#получите-лицензию).
1. In the **Access token** field, paste the copied token.
1. Click **Create connection**.
1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.

For more information on working with 1C Extractor, see [this {{ yandex-cloud }} blog post](/blog/posts/2024/08/1c-to-datalens).