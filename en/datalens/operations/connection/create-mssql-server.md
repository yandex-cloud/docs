# Creating an MS SQL Server connection

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Connecting to MS SQL Server {#ms-sql-server-connection}

To create an MS SQL Server connection:





1. Go to the [connections page](https://datalens.yandex.ru/connections).


1. Click **Create connection**.




1. Select **MS SQL Server** as the connection type.
1. Specify the connection parameters:
   - **Connection name**. Specify a name for the connection. You can set any name.
   - **Hostname or IP**. Specify the path to the master host or the IP address of the MS SQL Server master host. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
   - **Port**. Specify the MS SQL Server connection port.
   - **Database name**. Specify the name of the database to connect to.
   - **Username**. Specify the username for the MS SQL Server connection.
   - **Password**. Enter the password for the specified user.
   - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
   - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).
1. Click **Connect**. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
