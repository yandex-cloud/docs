---
title: "How to create a connection to a file in {{ datalens-full-name }}"
description: "Follow this guide to create a connection to a file."
---

# Creating a connection to a file

To create a connection to a file:



1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.



1. Select **Files** as the connection type.
1. Click **Upload files** and select the file. The information about the added file and the uploaded data will be displayed in the central area of the screen.

   {% note info %}

   * Currently, you can upload CSV, TXT, and Excel (`xlsx` only) files.
   * The number of files per connection cannot exceed 10. Each Excel sheet is counted as a separate file.
   * The size of each file may not exceed 100 MB.
   * The maximum number of columns per file is 300.
   * After you upload the file, the preview shows only the first 30 rows.

   {% endnote %}

1. Select the file upload parameters:

   {% list tabs %}

   - CSV or TXT

      1. The information about the added file and the uploaded data will be displayed at the center of the screen. At the top of the screen, select:

         * **Encoding**: Specify the file data encoding. You can use `utf-8`, `utf-16`, `windows-1251`, and `utf-8-sig`.
         * **Delimiter**: Specify the delimiter that is used in the file. The available values are `Comma`, `Semicolon`, and `Tabulation character`.
         * **Column header**: Select the title option. If you select **Yes**, {{ datalens-short-name }} will use the first row of data as a heading.

      1. (Optional) Select the type of data for each column. To do this, click the icon to the left of the column.

   - Excel

      1. If the file being uploaded contains multiple sheets, specify the ones you want to upload in the **Add sheets** window. You cannot select empty sheets. Enable the **Sheets** option to select all available sheets. Each sheet is uploaded to a separate table.
      1. The information about the added file and the uploaded data will be displayed at the center of the screen. At the top of the screen, select the **Column header** option. If you select **Yes**, {{ datalens-short-name }} will use the first row of data as heading.

   {% endlist %}

1. Repeat steps 4 and 5 to add files.
1. Click **Create connection**. If you use a new {{ datalens-short-name }} object model with [workbooks and collections](../../../datalens/workbooks-collections/index.md), select or create a workbook to save the connection to.
1. Enter a connection name and click **Create**. The connection will appear in the list.

You can add, rename, and delete files in the connection.
