---
title: How to create a Google Sheets connection
description: Follow this guide to create a Google Sheets connection.
---

# Creating a Google Sheets connection

{% note warning %}


Before creating a connection, check out [these limitations](#restrictions).

{% endnote %}

To create a Google Sheets connection:

1. Open the [connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **Google Sheets** connection.


1. Add files depending on access permissions:

   {% list tabs %}

   - Public spreadsheet

     1. Click **+ Add file** and specify the link to the file. To do this, in the Google Sheets access settings, select `Anyone with the link` and copy the link to the sheet you need from your browser's address bar. If you copy the link from the Google Sheets sharing window, it will lead to the first sheet of the spreadsheet.
     1. Click **Add**. If your file contains multiple sheets, specify the ones you want to upload in the **Add sheets** window. You cannot select empty sheets. Enable the **Sheets** option to select all available sheets. Each sheet is uploaded to a separate table. Click **Add**.
     1. Information about this file and the data to upload will appear at the center of the screen.

   - Spreadsheet with restricted access

     1. At the top of the screen, click **Log in with Google**.
     1. Select the account to go to the **{{ datalens-short-name }}** application.
     1. Allow **{{ datalens-short-name }}** to access your Google account. Click **Continue**.
     1. Click **+ Add file** and specify the link to the file.
     1. Click **Add**. If your file contains multiple sheets, specify the ones you want to upload in the **Add sheets** window. You cannot select empty sheets. Enable the **Sheets** option to select all available sheets. Each sheet is uploaded to a separate table. Click **Add**.
     1. Information about this file and the data to upload will appear at the center of the screen.

     To sign out of your Google account, click ![image](../../../_assets/console-icons/arrow-right-from-square.svg). Click **Sign out**. The sheets from the files with restricted access will no longer be displayed.

   {% endlist %}

   {% note info %}

   * To properly identify the data types, select **Format** → **Numbers** in the Google Sheets menu and set the column cell format.
   * If a filter is enabled in your Google Sheets table, only data matching the filter criteria will be displayed in connections and datasets based on it.

   {% endnote %}

1. Set the **Show column headers** option to **Yes** or **No**.
1. Optionally, enable automatic updates for spreadsheet data. To do this, in the top-right corner, select **Update automatically**. Spreadsheet data will be updated every 30 minutes or less often. To update your data manually, click **Update data**.
1. Click **Create connection**.
1. Select the [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.

You can add, rename, and delete files in the connection.



## Additional settings {#additional-settings}

{% include [datalens-file-connection-export-settings](../../../_includes/datalens/operations/datalens-file-connection-export-settings.md) %}

## Limitations {#restrictions}

When creating a connection to Google Sheets, consider the following limitations:

* The maximum number of Google Sheets per connection is 10. When creating a connection, all sheets will be loaded, but you can only select ten of them to work with at the same time.
* Maximum size per sheet: 200 MB.
  
  {% note info %}
  
  Technically, you cannot check the size of an individual sheet in the connection. If the limit is exceeded, you will get a message saying the data could not be loaded.

  {% endnote %}

* Maximum number of columns per sheet: 300.
* Minimum number of rows per spreadsheet: 2. In a spreadsheet with one row, you cannot identify column types as you cannot tell a header from a data row.

## FAQ {#qa}


See [how to replace a legacy Google Sheets connection with a new one](../../qa/connections.md#google-sheets-v2).


{% cut "What do I do if a Google Sheets spreadsheet works incorrectly?" %}

If a Google Sheets spreadsheet contains empty cells, {{ datalens-name }} may incorrectly display column headers and miss the first several rows.

To fix this, you need to fill empty cells in your Google Sheets spreadsheet with any appropriate values, e.g., `unavailable`, `none`, `unknown`.

To quickly populate empty cells in a Google Sheets spreadsheet:
1. Select the entire Google Sheets spreadsheet.
1. In the spreadsheet menu, select **Data** → **Create filter**.
1. In the right-hand corner of the first column's top cell, click the filter icon.
1. Select **Clear** and then select **(Blanks)**.
1. In the column's top cell, enter the appropriate value, e.g., `0`, `unavailable`, `none`, or any other.
1. Drag the cell down to populate all the empty cells in the column with this value.
1. Click the filter icon again and click **Select all**.
1. Repeat all the steps starting with Step 3 for the other columns in the spreadsheet.

{% endcut %}

{% cut 'What to do if you get the "Document not supported" error?' %}

{% include [err-file-unsupported_document](../../../_includes/datalens/err-file-unsupported_document.md) %}

{% endcut %}
