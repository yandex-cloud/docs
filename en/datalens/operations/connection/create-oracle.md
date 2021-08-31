# Creating an Oracle Database connection

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Connecting to Oracle Database {#oracle-database-connection}

To create an Oracle Database connection:

1. Go to the [connections page](https://datalens.yandex.com/connections).
1. Click **Create connection**.
1. Select **Oracle Database** as the connection type.
1. Specify the connection parameters:
    - **Connection name**. Specify a name for the connection. You can set any name.
    - **Hostname or IP**. Specify the path to the master host or the IP address of the Oracle Database master host.
    - **Port**. Specify the Oracle Database connection port.
    - **Database name**. Specify the Service Name or SID of the database to connect to.
    - **Username**. Specify the username for the Oracle Database connection.
    - **Password**. Enter the password for the specified user.
    - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
    - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

1. Click **Create**. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
