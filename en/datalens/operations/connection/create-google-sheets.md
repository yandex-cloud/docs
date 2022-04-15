# Creating a Google Sheets connection

## Connecting to Google Sheets {#google-sheets-connection}

To create a Google Sheets connection:

1. Go to the [connections page](https://datalens.yandex.com/connections).

1. Click **Create connection**.

1. Select the **Google Sheets** connection.

1. Specify the connection parameters:

    - **Connection name**. Specify a name for the connection. You can set any name.
    - **Link**. Specify a link to the desired sheet in Google Sheets. To do this, in the Google Sheets share settings, select `Anyone with the link`, select the desired sheet, and copy the link from the browser's address bar. If you copy the link from the Google Sheets share dialog box, it will point to the spreadsheet's first sheet.

1. Click **Create**. The connection appears in the list.

{% note info %}

A cache with a 5-minute lifetime is used when loading data from Google Sheets, so there might be delays when updating data in {{ datalens-short-name }}.

{% endnote %}

{% cut "What to do if a table from Google Sheets does not work correctly?" %}

{% include [google-sheets-error](../../../_includes/datalens/qa/google-sheets-error.md) %}

{% endcut %}

