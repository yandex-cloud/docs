# Creating a Google Sheets connection

## Connecting to Google Sheets {#google-sheets-connection}

To create a Google Sheets connection:

1. Go to the [connections page](https://datalens.yandex.com/connections).

1. Click **Create connection**.

1. Select the **Google Sheets** connector.

1. Specify the connection parameters:
    - **Connection name**. Specify a name for the connection. You can set any name.
    - **Link**. Specify a link to the desired sheet in Google Sheets. To do this, in the Google Sheets access settings, select **Anyone with the link** and copy the link to the desired sheet from the browser's address bar.

1. Click **Create**. The connection appears in the list.

{% note info %}

When loading data from Google Sheets, a cache with a lifetime of up to 5 minutes is used, so there might be delays when updating data in {{ datalens-short-name }}.

{% endnote %}

