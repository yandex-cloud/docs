# Creating a ClickHouse connection

{% note info %}

{{ datalens-short-name }} supports ClickHouse connections via HTTP interface only.

{% endnote %}

To create a ClickHouse connection:

1. Go to the [connections page](https://datalens.yandex.ru/connections).

1. Click **Create connection**.

1. Select the **ClickHouse** connector.

   {% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

1. Specify the connection parameters:
    - **Connection name**. Specify a name for the connection. You can set any name.
    - **Hostname or IP**. Specify the path to the ClickHouse host.
    - **Port**. Specify the ClickHouse connection port.
    - **Username**. Specify the username for the ClickHouse connection.
    - **Password**. Enter the password for the specified user.

1. Click **Connect**. The connection appears in the list.
{% note info %}

You can check the host connection before creating it. To do this, click **Check connection**.

{% endnote %}

