---
title: "How to create a Google Sheets connection"
description: "Follow this guide to create a Google Sheets connection."
---

# Creating a Google Sheets connection

{% note warning %}


Before creating a connection, learn about the [limitations](#restrictions).

{% endnote %}

To create a Google Sheets connection:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}



1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.
1. Select the **Google Sheets** connection.


1. Add files depending on access permissions:

   {% list tabs %}

   - Public spreadsheet

      1. Click **+ Add file** and specify the link to the file. To do this, in the Google Sheets access settings, select `Anyone with the link` and copy the link to the desired sheet from the browser's address bar. If you copy the link from the Google Sheets sharing window, it will lead to the spreadsheet's first sheet.
      1. Click **Add**. If the file contains multiple sheets, specify the ones you want to upload in the **Add sheets** window. You cannot select empty sheets. Enable the **Sheets** option to select all available sheets. Each sheet is uploaded to a separate table. Click **Add**.
      1. The information about the added file and the uploaded data will be displayed at the center of the screen.

   - Spreadsheet with restricted access

      1. At the top of the screen, click **Log in with Google**.
      1. Select the account to switch to the **{{ datalens-short-name }}** application.
      1. Grant **{{ datalens-short-name }}** a permission to access your Google account. Click **Continue**.
      1. Click **+ Add file** and specify the link to the file.
      1. Click **Add**. If the file contains multiple sheets, specify the ones you want to upload in the **Add sheets** window. You cannot select empty sheets. Enable the **Sheets** option to select all available sheets. Each sheet is uploaded to a separate table. Click **Add**.
      1. The information about the added file and the uploaded data will be displayed at the center of the screen.

      To log out of your Google account, click ![image](../../../_assets/datalens/exit.svg). Click **Sign out**. The sheets from the files with restricted access will no longer be displayed.

   {% endlist %}


   {% note info %}

   To properly identify the data types, select **Format** → **Numbers** in the Google Sheets menu and set the column cell format.

   {% endnote %}

1. Set the **Show column headers** option to **Yes** or **No**.
1. (Optional) Enable automatic updates for the spreadsheet data. To do this, in the top right corner, select **Update automatically**. The spreadsheet data will be updated once in 30 minutes or less often. To update the data manually, click **Update data**.
1. Click **Create connection**.
1. Give your connection a name and click **Create**. The connection will appear in the list.

You can add, rename, and delete files in the connection.

{% cut "What do I do if a Google Sheets spreadsheet is not working properly?" %}

If a Google Sheets spreadsheet contains empty cells, {{ datalens-name }} may incorrectly display column headers and miss the first several rows.

To fix this, you need to fill empty cells in your Google Sheets spreadsheet with any appropriate values, such as `unavailable`, `none`, and `unknown`.

To quickly populate empty cells in a Google Sheets spreadsheet:
1\. Highlight the entire Google Sheets sheet.
2\. In the spreadsheet menu, select **Data** → **Create a filter**.
3\. In the right-hand corner of the first column's top cell, click the filter icon.
4\. Select **Clear** and then select **(Blanks)**.
5\. In the column's top cell, enter the desired values, such as `0`, `unavailable`, `none`, or any other.
6\. Drag the cell down to fill all the empty cells in the column with the entered value.
7\. Click the filter icon again and click **Select all**.
8\. Repeat all the steps starting with Step 3 for the other columns in the spreadsheet.

{% endcut %}

{% cut 'Steps to follow in case of the "Document is not supported" error' %}

{% include [err-file-unsupported_document](../../../_includes/datalens/err-file-unsupported_document.md) %}

{% endcut %}

## Constraints {#restrictions}

When creating a connection to Google Sheets, keep in mind the following limitations:
* Maximum number of Google Sheets sheets per connection: 10. All sheets will be loaded when you create a connection, but you can only select 10 of them for concurrent work.
* Maximum size per sheet: 200 MB.
* Maximum number of columns per sheet: 300.
* Minimum number of rows per table: 2. In a table with one row, you cannot specify column types because you cannot tell a header from a data row.