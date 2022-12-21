# Creating a Google Sheets connection

{% if audience == "internal" %}

{% note warning %}

When using a connection to Google Sheets, you must follow the NDA and ensure data storage security.

{% endnote %}

{% endif %}

## Connecting to Google Sheets {#google-sheets-connection}

To create a Google Sheets connection:

{% if audience == "internal" %}

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).

{% else %}

1. Go to the [connections page](https://datalens.yandex.com/connections).

{% endif %}

1. Click **Create connection**.
1. Select the **Google Sheets** connection.
1. Specify the connection parameters:
   - **Connection name**. Specify a name for the connection. You can set any name.
   - **Link**. Specify a link to the desired sheet in Google Sheets. To do this, in the Google Sheets access settings, select ``Anyone with the link`` and copy the link to the desired sheet from the browser's address bar. If you copy the link from the Google Sheets sharing window, it will point to the spreadsheet's first sheet.

1. Click **Create**. The connection appears in the list.

{% note info %}

A cache with a 5-minute lifetime is used when loading data from Google Sheets, so there might be delays when updating data in {{ datalens-short-name }}.

{% endnote %}

{% cut "What do I do if a Google Sheets spreadsheet is not working properly?" %}

If a Google Sheets spreadsheet contains empty cells, {{ datalens-short-name }} may display column headers incorrectly and fail to display the first several lines.

To correct this, you need to fill in the empty cells in the Google Sheets spreadsheet with any appropriate values, such as `unavailable`, `none`, and `unknown`.

To complete empty cells in a Google Sheets spreadsheet quickly:

1\. Highlight the entire Google Sheets sheet.
2\. In the spreadsheet menu, select **Data** → **Create a filter**.
3\. In the right-hand corner of the first column's top cell, click the filter icon.
4\. Select **Clear** and then select **(Blanks)**.
5\. In the column's top cell, enter the desired values, such as `0`, `unavailable`, `none`, or any other.
6\. Drag the cell down to fill all the empty cells in the column with the entered value.
7\. Click the filter icon again and click **Select all**.
8\. Repeat all the steps starting with Step 3 for the other columns in the spreadsheet.

{% endcut %}
