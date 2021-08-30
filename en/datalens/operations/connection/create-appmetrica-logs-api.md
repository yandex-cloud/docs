# Creating an AppMetrica Logs API connection

{% note warning %}

Before creating a connection to the AppMetrica Logs API, you need to create a ClickHouse cluster in {{ yandex-cloud }}. {{ datalens-short-name }} will automatically upload AppMetrica data via the Logs API to the specified cluster.

{% endnote %}

## Connecting to the AppMetrica Logs API {#appmetrica-logs-api-connection}

To create an AppMetrica Logs API connection:

1. Go to the [connections page](https://datalens.yandex.com/connections).

1. Click **Create connection**.

1. Select **AppMetrica** as the connection type.

1. Specify the connection parameters:

    * In the field next to the folder name, enter the connection name. You can set any name.

    * **OAuth token**. Click **Get token** or enter the [OAuth token](#get-oauth-token) manually to access the AppMetrica data.

    * **App**. Specify one or more applications to connect to. You can select them from the list or enter them manually separated by commas.

    * **Connection**. Select **Logs API** as the connection type.

      {% note info %}

      If you want to get access for a username other than your current Yandex account or the required application isn't on the list, see [Getting an OAuth token](#get-oauth-token).

      {% endnote %}

1. Specify the parameters for exporting data from source applications:
    * **Tag source**. Select the type of data to upload from the list.
    * **Upload from**. Specify the start date for exporting data.
    * **Frequency**. Specify how often data is updated in the connection.

1. Specify information about the target database:
    * **Hostname**. Specify the path to the {{ CH }} cluster host in {{ yandex-cloud }}.
    * **Port**. Specify the DB connection port.
    * **Database name**. Specify the name of the DB to connect to.
    * **Username**. Specify the username for the DB connection.
    * **Password**. Enter the password for the specified user.

1. Click **Create**.

Notes:

* Uploading data to the connection may take anywhere from a few minutes to a few hours depending on the amount of data in the tag and the specified start date.
* Changing the **Upload from** parameter fully resets the connection data.
* Changing the **Frequency** value from `Once` to `Regular` fully resets the connection data.

## Getting an OAuth token {#get-oauth-token}

To get access to an AppMetrica app for a username other than your current Yandex account, follow these steps:

1. Switch to an account that has access to AppMetrica.
1. Use the [link](https://oauth.yandex.com/authorize?response_type=token&client_id=4f802221a95340dd9417c04bc30606b5) to get a token. If necessary, allow access to the application, then copy the token.
1. Switch to an account that has access to {{ datalens-full-name }}.
1. Create a new connection to Yandex.Metrica and paste the obtained token from the clipboard to the OAuth token field.

