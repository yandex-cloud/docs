# Creating an Oracle Database connection

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Connecting to Oracle Database {#oracle-database-connection}

To create an Oracle Database connection:

{% if audience == "internal" %}

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).

{% else %}

1. Go to the [connections page](https://datalens.yandex.com/connections).

{% endif %}

1. Click **Create connection**.

1. Select the **Oracle Database** connection.

1. Specify the connection parameters:
    - **Connection name**. Specify a name for the connection. You can set any name.
    - **Hostname or IP**. Specify the host path or IP address of the Oracle Database host.
    - **Port**. Specify the Oracle Database connection port.
    - **Database name**. Specify the Service Name or SID of the database to connect to.
    - **Username**. Specify the username for the Oracle Database connection.
    - **Password**. Enter the password for the specified user.

1. Click **Create**. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
