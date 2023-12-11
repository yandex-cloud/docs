---
title: "How to import a page from a file in {{ wiki-full-name }}"
description: "In this tutorial, you will learn about importing a page from a file in {{ wiki-name }}."
---

# Importing a page from a file

## Pages created in the old editor {#page}

To convert a .txt file or a .docx document to a page created in the old editor:

1. On any page created in the old editor, click ![](../_assets/wiki/svg/create-page.svg) **Create page** in the left-hand panel or select ![](../_assets/wiki/svg/actions-icon.svg) **Actions** → **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-page-more-panel.create_page }}** in the top-right corner.

1. Select **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-page.page }}**.

1. Set the page title and address in the same way as when [creating a regular Wiki page](create-page.md).

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-attachments.upload-btn-text }}** and open the file you want to convert to a page.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-head.create }}**.

The contents of the selected file will be uploaded to a new page:

- If you uploaded a .txt file, the complete text of the file is copied to the page. If the text contains [markup elements](basic-markup.md), they will be displayed correctly on the page.

- If you uploaded a .docx document, its text will be converted to [page markup](basic-markup.md). If the document contains images, they will be placed at the end of the page in the `<<Imported images>>` section.


## Dynamic table {#dynamic-table}

You can create dynamic tables from CSV or TXT files:

1. Save your spreadsheet (for instance, an MS Excel file) in CSV format. Alternatively, you can create a TXT file in which the cell values are separated by a comma, semicolon, or tab character.

1. [Create](create-grid.md) a new dynamic table or open an existing one.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_w-comment.edit }}**.

1. In the bottom-left corner of the table, select ![](../_assets/wiki/table-settings-footer.png) → **Import data**.

1. Select a CSV or TXT file and check the delimiter settings.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-widget.load }}**.

1. Select the table columns that you want to upload from the file.

1. Specify how you want to add the selected columns:

   * To a new column: These columns are placed to the right of the existing columns.

   * To an existing column: These columns are appended to the end of the existing columns.

   You can set up column insertion behavior for each column after you import them from the file.

1. Select the data type for the new columns.

1. Click **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-file2.icon_upload }}**.


#### See also

- [{#T}](create-grid.md)

- [{#T}](create-page.md)

- [{#T}](add-grid.md)
