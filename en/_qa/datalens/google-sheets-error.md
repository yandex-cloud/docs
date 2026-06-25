### What do I do if a Google Sheets spreadsheet works incorrectly? {#google-sheets-error}

If a Google Sheets spreadsheet contains empty cells, {{ datalens-short-name }} may incorrectly display column headers and miss the first several rows.

To fix this, you need to fill empty cells in your Google Sheets spreadsheet with any appropriate values, e.g., `unavailable`, `none`, `unknown`.

To quickly populate empty cells in a Google Sheets spreadsheet:

1. Select the entire Google Sheets spreadsheet.
1. In the spreadsheet menu, select **Data** → **Create a filter**.
1. In the right-hand corner of the first column's top cell, click the filter icon.
1. Select **Clear** and then select **(Blanks)**.
1. In the column's top cell, enter the appropriate value, e.g., `0`, `unavailable`, `none`, or any other.
1. Drag the cell down to populate all the empty cells in the column with this value.
1. Click the filter icon again and click **Select all**.
1. Repeat all the steps starting with Step 3 for the other columns in the spreadsheet.
