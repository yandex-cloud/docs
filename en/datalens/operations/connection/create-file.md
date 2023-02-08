# Creating a connection to a CSV file

To create a connection to a file:



1. Go to the [connections page](https://datalens.yandex.com/connections).


1. Click **Create connection**.



1. Select a **File** connection.
1. Click **Upload files** and select the file. The information about the added file and the uploaded data will be displayed in the central area of the screen.

   {% note info %}

   * Uploading of CSV files is only supported at the moment.
   * The number of files per connection can't exceed ten.
   * The size of each file may not exceed 100 MB.
   * The CSV file can include a maximum of 300 files.
   * After you upload the file, the preview shows only the first 30 rows.

   {% endnote %}

1. In the top part of the screen, select the file upload parameters:

   * **Encoding**. Specify the data encoding of the file. Available values: `utf-8`, `utf-16`, `windows-1251`, and `utf-8-sig`.
   * **Delimiter**. Specify the delimiter that is used in the CSV file. Available values: `Comma`, `Semicolon`, and `Tabulation character`.
   * **Column header**. Select the title option. If you choose **Yes**, then {{ datalens-short-name }} uses the first row of data as the heading.

1. (optional) Select the type of data for each column. To do this, click the icon to the left of the column.

1. Repeat steps 4 and 5 to add files.
1. Click **Create connection**.
1. Enter the connection name and click **Create**. The connection appears in the list.

You can add, rename, and delete files in the connection.
