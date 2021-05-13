# Creating a MySQL connection

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Connecting to MySQL {#mysql-connection}

To create a {{ MY }} connection:


1. Go to the [connections page](https://datalens.yandex.com/connections).

1. Click **Create connection**.

1. Select the **MySQL** connection.

1. Enter a **Connection name**. You can set any name.

1. Select the connection type:

   {% list tabs %}

    - Select in Yandex.Cloud

      Specify the connection parameters for the {{ MY }} DB available in {{ yandex-cloud }}:

      - **Cluster**. Specify a cluster from the list of available {{ MY }} clusters. If you don't have an available cluster, click **Create new**.

        {% note info %}

          The {{ MY }} clusters are shown in the list of clusters:
           - With the permissions for the user that creates the connection.
           - Created in the same folder with the {{ datalens-short-name }} instance.

        {% endnote %}

      - **Hostname**. Select the host name from the list of hosts available in the {{ MY }} cluster.

      - **Port**. Specify the {{ MY }} connection port. The default port is 3306.

      - **Database name**. Specify the name of the database to connect to.

      - **Username**. Specify the username for the {{ MY }} connection.

      - **Password**. Enter the password for the user.

    - Specify manually

      Specify the connection parameters for the external {{ MY }} database:
      - **Hostname**. Specify the {{ MY }} host path or IP address.
      - **Port**. Specify the {{ MY }} connection port. The default port is 3306.
      - **Username**. Specify the username for the {{ MY }} connection.
      - **Database name**. Specify the name of the database to connect to.
      - **Password**. Enter the password for the user.

   {% endlist %}

1. Click **Save**. The connection appears in the list.

{% note info %}

You can check the host connection before creating it. To do this, click **Check connection**.

{% endnote %}