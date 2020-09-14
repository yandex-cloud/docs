# Creating a ClickHouse connection

{% note info %}

{{ datalens-short-name }} specifics for ClickHouse connections:

  - ClickHouse connections only run over HTTP interface.
  - All the data requests are executed with the [join_use_nulls](https://clickhouse.tech/docs/en/operations/settings/settings/#join_use_nulls) flag enabled.

{% endnote %}

To create a ClickHouse connection:

1. Go to the [connections page](https://datalens.yandex.com/connections).

1. Click **Create connection**.

1. Select the **ClickHouse** connector.

   {% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

1. Specify the connection parameters:

    - **Connection name**. Specify a name for the connection. You can set any name.

    - **Hostname or IP**. Specify the path to the ClickHouse host.

    - **Port**. Specify the ClickHouse connection port.

    - **Username**. Enter the username for the ClickHouse connection.

      The user should have one of the following values set for the parameter [readonly](https://clickhouse.yandex/docs/en/operations/settings/permissions_for_queries/#settings_readonly):
        - `0` — All queries are allowed.
        - `2` — Queries to read data and edit settings are allowed.

    - **Password**. Enter the password for the user.

1. Click **Connect**. The connection appears in the list.

You can check the host connection before creating it. To do this, click **Check connection**.

