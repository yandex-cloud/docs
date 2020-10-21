# Creating a PostgreSQL connection

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Connecting to PostgreSQL {#postgresql-connection}

To create a PostgreSQL connection:

1. Go to the [connections page](https://datalens.yandex.com/connections).
1. Click **Create connection**.
1. Select the **PostgreSQL** connector.
1. Specify the connection parameters:
    - **Connection name**. Specify a name for the connection. You can set any name.
    - **Hostname or IP**. Specify the path to the PostgreSQL host.
    - **Port**. Specify the PostgreSQL connection port.
    - **Database name**. Specify the name of the database to connect to.
    - **Username**. Specify the username for the PostgreSQL connection.
    - **Password**. Enter the password for the specified user.
1. Click **Connect**. The connection appears in the list.

{% note info %}

You can check the host connection before creating it. To do this, click **Check connection**.

{% endnote %}