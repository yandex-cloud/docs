---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a Yandex.Metrica Logs API connection

{% note warning %}

Before creating a connection to the Yandex.Metrica Logs API, you need to create a ClickHouse cluster in {{ yandex-cloud }}. {{ datalens-short-name }} saves Logs API data to a dataset in the created cluster.

{% endnote %}

## Connecting to the Yandex.Metrica Logs API {#metrica-logs-api-connection}

To create a connection to the Logs API:


1. Go to the [connections page](https://datalens.yandex.com/connections).

1. Click **Create connection**.

1. Select the **Metrica** connection.

1. Specify the connection parameters:

    - **Connection name**. Specify a name for the connection. You can set any name.

    - **OAuth token**. Click **Get token** or enter the [OAuth token](#get-oauth-token) manually to access the Yandex.Metrica data.

    - **Tag**. Specify the tag to connect to.

    - **Connection**. Select **Logs API** as the connection type.

      {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}

1. Specify the data export parameters:
    - **Tag source**. Specify the data table to be exported from the Logs API.
    - **Upload from**. Specify the start date for exporting data.
    - **Frequency**. Specify how often data is updated in the connection.

1. Specify information about the target database:
    - **Hostname**. Specify the path to the ClickHouse cluster host in {{ yandex-cloud }}.
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

{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}

