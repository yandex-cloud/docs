---
title: How to create a connection to a file in {{ datalens-full-name }}
description: Follow this guide to create a connection to a file.
---

# Creating a connection to a file

To create a connection to a file:

1. Open the [new connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Files and services**, select the **Files** connection.
1. Click **Upload files** and select the file. Information about this file and the data to upload will appear at the center of the screen.

   {% note info %}

   * Currently, you can upload CSV, TXT, and Excel (`xlsx` only) files.
   * The number of files per connection cannot exceed 10. Each Excel sheet is counted as a separate file.
   * The size of each file may not exceed 200 MB.
   * The maximum number of columns per file is 300.
   * After you upload the file, only the first 30 rows are previewed.

   {% endnote %}

1. Select the file upload parameters:

   {% list tabs %}

   - CSV or TXT

     1. Information about this file and the data to upload will appear at the center of the screen. At the top of the screen, select:

        * **Encoding**: Specify the file data encoding. The available values are `utf-8`, `utf-16`, `windows-1251`, and `utf-8-sig`.
        * **Delimiter**: Specify the delimiter used in the file. The available values are `Comma`, `Semicolon`, and `Tabulation character`.
        * **Column header**: Select the header option. If you select **Yes**, {{ datalens-short-name }} will use the first row of data as a header.

     1. Optionally, select the type of data for each column. To do this, click the icon to the left of the column name.

   - Excel

     1. If your file contains multiple sheets, specify the ones you want to upload in the **Add sheets** window. You cannot select empty sheets. Enable the **Sheets** option to select all available sheets. Each sheet is uploaded to a separate table.
     1. Information about this file and the data to upload will appear at the center of the screen. At the top of the screen, select the **Column header** option. If you select **Yes**, {{ datalens-short-name }} will use the first row of data as a header.

   {% endlist %}

1. Repeat steps 3 and 4 to add files.
1. Click **Create connection**.


1. Select the [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.


1. Enter a name for the connection and click **Create**.

You can add, rename, [replace](#file-replace), and delete existing files in the connection.

## Additional settings {#additional-settings}

{% include [datalens-file-connection-export-settings](../../../_includes/datalens/operations/datalens-file-connection-export-settings.md) %}

## File replacement {#file-replace}

To update the connection data, replace a file:

1. In the row with the file name, click ![image](../../../_assets/console-icons/ellipsis.svg) → **Replace** and specify your file. After the file is uploaded, the updated data will be displayed at the center of the screen.
1. Click **Save changes**. This will update the data for all datasets and chats built based on this connection.

{% note tip %}

For dynamic data, you can use other sources, e.g., [{{ CH }}](./create-clickhouse.md).

{% endnote %}


## Use cases {#examples}

* [{#T}](../../tutorials/data-from-csv-visualization.md)
* [{#T}](../../tutorials/data-from-csv-to-public-visualization.md)
* [{#T}](../../tutorials/data-from-ch-visualization.md)


{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}