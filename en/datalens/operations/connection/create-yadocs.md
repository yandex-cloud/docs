---
title: How to create a connection to Yandex Documents
description: Follow this guide to create a connection to Yandex Documents.
---

# Creating a connection to Yandex Documents


To create a connection to Yandex Documents:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **Yandex Documents** connection.
1. Add files depending on access permissions:

   {% list tabs %}

   - Public

      1. Click **Add file** and navigate to the `Public` tab.
      1. Go to the [service](https://docs.yandex.ru/docs?type=xlsx) page.
      1. Right-click the required file and select **Share**. Click **Copy**.

         {% note info %}

         You can also get a link to the file in Yandex Disk. For more information, see the [documentation](https://yandex.com/support/disk/share/sharing.html#how-to-share).

         {% endnote %}

      1. In {{ datalens-short-name }}, paste the link into the `Link to file in Yandex Documents` field and click **Add**.
      1. If the file you are uploading contains several sheets, specify the ones you want to upload, or select all available. Each sheet is uploaded to a separate table.
      1. Click **Add**. The information about the added file and the uploaded data will be displayed at the center of the screen.

   - Private

      {% note info %}

      Adding password protected private files is not supported.

      {% endnote %}

      1. On the connection page in {{ datalens-short-name }}, click **Add file** and navigate to the `Private` tab.
      1. On the tab, you will see a Yandex Documents authorization message. If authorized, proceed to the next step. If not, complete authorization:
         1. Click **Log in**.
         1. Select a Yandex account to log in to Yandex Documents.
         1. Grant **{{ datalens-short-name }}** a permission to access your Yandex account. Click **Next**.
      1. Specify the **Path to file in Yandex Documents** relative to the root directory. Specify the path without `/disk` at the beginning. You can view the file location in Yandex Documents: open the file and go **File** → **Table details**.
      1. Click **Add**.
      1. If the file you are uploading contains several sheets, specify the ones you want to upload, or select all available. Each sheet is uploaded to a separate table.
      1. Click **Add**. The information about the added file and the uploaded data will be displayed at the center of the screen.

         To log out of your Yandex account, open the connection page and click ![image](../../../_assets/console-icons/arrow-right-from-square.svg) next to the **You are authorized in Yandex Documents** button. Confirm token revocation. The sheets from the files with restricted access will no longer be displayed.

   {% endlist %}

1. Set the **Show column headers** option to **Yes** or **No**.
1. (Optional) Enable automatic updates for the spreadsheet data. To do this, in the top-right corner, select **Update automatically**. The spreadsheet data will be updated once in 30 minutes or less often. To update the data manually, click **Update data**.
1. Click **Create connection**.


1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.


1. Enter a name for the connection and click **Create**.

You can add, rename, and delete files in the connection.

## Limitations {#restrictions}

Consider the following limitations when creating a connection to Yandex Documents:

* Currently, only the `xlsx` file format is available for upload.
* Maximum number of table sheets per connection: 10. All sheets will be loaded when you create a connection, but you can only select 10 of them for concurrent work.
* Maximum size per sheet: 200 MB.
* Maximum number of columns per sheet: 300.
* Minimum number of rows per table: 2. In a table with one row, you cannot specify column types because you cannot tell a header from a data row.
* The link to the file in Yandex Documents must be in the `https://disk.yandex.ru/i/id` format. If the link contains `/d` instead of `/i`, an error will occur. [What to do if the _Invalid link format_ error occurs](../../qa/connections.md#yadocs-error-link)
