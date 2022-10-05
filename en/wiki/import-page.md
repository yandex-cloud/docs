# Importing a page from a file

## Wiki page {#page}

To convert a .txt text file or a .docx document to a Wiki page:

1. On any wiki page, click ![](../_assets/wiki/svg/create-page.svg) **Create a page** in the left panel or select ![](../_assets/wiki/svg/actions-icon.svg) **Actions** → **Create subpage** in the upper-right corner.

1. Select **Page**.

1. Set the page title and address in the same way as with [normal page creation](create-page.md).

1. Click **Select a file** and open the file you want to convert to a page.

1. Click **Create**.

The contents of the selected file will be uploaded to a new Wiki page:

- If you uploaded a .txt file, the complete text of the file is copied to the Wiki page. If the text contains [markup elements](basic-markup.md), they will be displayed correctly on the page.

- If you uploaded a .docx document, the text of the document is converted to [Wiki page markup](basic-markup.md). If the document contains images, they are placed at the end of the page in the `<Imported images>` section.

## Dynamic table {#dynamic-table}

You can create dynamic tables from CSV or TXT files:

1. Save your table (for instance, an MS Excel file) in CSV format. Alternatively, create a TXT file in which the cell values are separated by a comma, semicolon, or tab character.

1. [Create](create-grid.md) a new dynamic table or open an existing one.

1. Click **Edit**.

1. In the lower-left corner of the table, select ![](../_assets/wiki/table-settings-footer.png) → **Import data**.

1. Select a CSV or TXT file and check the delimiter settings.

1. Click **Upload**.

1. Select the table columns that you want to upload from the file.

1. Specify how you want to add the selected columns:

    * To a new column: Such columns will be placed to the right of the existing columns.

    * To an existing column: Such columns will be appended to the end of the existing columns.

    Column insertion behavior can be set up for each individual column after you import them from the file.

1. Select the data type for the new columns.

1. Click **Upload**.

#### See also

- [{#T}](create-grid.md)

- [{#T}](create-page.md)

- [{#T}](add-grid.md)

