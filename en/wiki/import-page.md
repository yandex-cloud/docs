# Importing data from a file

## Wiki page {#page}

To convert a TXT or DOC file into a Wiki page:

1. On any Wiki page, click **Create** or choose **Action** → **Create subpage**.

1. Select **Page**.

1. Enter the page header and address in the same way as when [creating regular pages](create-page.md).

1. Click **Upload file** and choose the file you want to convert into a page.

1. Click **Create**.

The contents of the selected file will be uploaded to the new Wiki page:

- If you have uploaded a TXT file, all of the text within the file will be inserted into the Wiki page. If the text contains [markup elements](basic-markup.md), they will be correctly displayed on the page.

- If you have uploaded a DOCX document, the text contained in the document will be converted to the [Wiki page markup](basic-markup.md). If the document contains images, they will be placed at the end of the page in the `<Imported images>` section.

## Dynamic table {#dynamic-table}

You can create dynamic tables from CSV or TXT files:

1. Save your table (for example, a Microsoft Excel file) in the CSV format. You can also create a table from a TXT file. In the file, separate values with a comma, semicolon, or tab.

1. [Create](create-grid.md) a new dynamic table or open an existing one.

1. In the lower-left corner of the table, select ![](../_assets/wiki/table-settings-footer.png) → **Import data**.

1. Select a CSV or TXT file and check the separator settings.

1. Click **Upload**.

1. Select the columns you want to upload from the file.

1. Choose one of the methods for adding the columns you selected:

    - As a new column — columns are added to the right of existing ones.

    - Into existing column — columns added to the end of existing columns.

    You can set up a different column insertion method for different columns in the file.

1. Select the data type for the new columns.

1. Click **Upload file**.

#### See also

- [{#T}](create-grid.md)

- [{#T}](create-page.md)

- [{#T}](add-grid.md)

