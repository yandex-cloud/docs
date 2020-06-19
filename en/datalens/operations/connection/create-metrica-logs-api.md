# Creating a Yandex.Metrica Logs API connection

{% note warning %}

Before creating a connection to the Yandex.Metrica Logs API, you need to create a ClickHouse cluster in Yandex.Cloud. {{ datalens-short-name }} saves Logs API data to a dataset in the created cluster.

{% endnote %}

To create a connection to the Logs API:

1. Go to the [connections page](https://datalens.yandex.ru/connections).
1. Click **Create connection**.
1. Select the **Metrica** connector.
1. Specify the connection parameters:
    - **Connection name**. Specify a name for the connection. You can set any name.
    - **OAuth token**. Specify the OAuth token used to access Yandex.Metrica data. If you already have a tag, click **Get token**.
    - **Tag**. Specify the tag to connect to.
    - **Connection**. Select **Logs API** as the connection type.
1. Specify the data export parameters:
    - **Tag source**. Specify the data table to be exported from the Logs API.
    - **Upload from**. Specify the start date for exporting data.
    - **Frequency**. Specify how often data is updated in the connection.
1. Specify information about the target database:
    - **Hostname**. Specify the path to the ClickHouse cluster host in Yandex.Cloud.
    - **Port**. Specify the DB connection port.
    - **Database name**. Specify the name of the DB to connect to.
    - **Cluster**. Specify the DB cluster.
    - **Username**. Specify the username for the DB connection.
    - **Password**. Enter the password for the specified user.
1. Click **Connect**. The connection appears in the list.

Notes:

- Uploading data to the connection may take anywhere from a few minutes to a few hours depending on the amount of data in the tag and the specified start date.
- Changing the **Upload from** parameter fully resets the connection data.
- Changing the **Frequency** value from `Once` to `Regular` fully resets the connection data.

