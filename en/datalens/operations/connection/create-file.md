# Creating a connection to a file

To create a connection to a file:



1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.



1. Select **Files** as the connection type.
1. Click **Upload files** and select the file. The information about the added file and the uploaded data will be displayed in the central area of the screen.

   {% note info %}

   * Currently, you can upload CSV and TXT files.
   * The number of files per connection cannot exceed 10. 
   * The size of each file may not exceed 100 MB.
   * The maximum number of columns per file is 300.
   * After you upload the file, the preview shows only the first 30 rows.

   {% endnote %}


1. In the top part of the screen, select the file upload parameters:

   * **Encoding**. Specify the data encoding of the file. The values you can use are `utf-8`, `utf-16`, `windows-1251`, and `utf-8-sig`.
   * **Delimiter**. Specify the delimiter that is used in the file. Available values: `Comma`, `Semicolon`, and `Tabulation character`.
   * **Column header**. Select the title option. If you choose **Yes**, then {{ datalens-short-name }} uses the first row of data as the heading.

1. (optional) Select the type of data for each column. To do this, click the icon to the left of the column.


1. Repeat steps 4 and 5 to add files.
1. Click **Create connection**.
1. Enter the connection name and click **Create**. The connection will appear in the list.

You can add, rename, and delete files in the connection.
