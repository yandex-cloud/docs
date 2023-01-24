# Creating a MySQL connection

{% if product == "yandex-cloud" %}

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

{% endif %}

## Connecting to MySQL {#mysql-connection}

To create a {{ MY }} connection:

{% if product == "yandex-cloud" %}

{% if audience == "internal" %}

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).

{% else %}

1. Go to the [connections page](https://datalens.yandex.ru/connections).

{% endif %}

1. Click **Create connection**.

{% endif %}

{% if product == "cloud-il" %}

1. Go to the workbook page.
1. In the upper-right corner, click **Create**→ **Connection**.

{% endif %}

1. Select **MySQL** as the connection type.
1. Enter a **Connection name**. You can set any name.

{% if product == "yandex-cloud" %}

1. Select the connection type:

   {% list tabs %}

   - Select in a folder

      {% if audience != "internal" %}

      Specify the connection parameters for the {{ MY }} DB available in {{ yandex-cloud }}:

      {% endif %}

      {% if audience == "internal" %}

      Specify the connection parameters for the {{ MY }} database:

      {% endif %}

      - **Cluster**. Specify a cluster from the list of available {{ MY }} clusters. Cluster settings must have the **DataLens access** flag set. If you don't have an available cluster, click **Create new**.

         {% note info %}

         The {{ MY }} clusters are shown in the list of clusters:

         - With the permissions for the user that creates the connection.
         - Created in the same folder with the {{ datalens-short-name }} instance.

         {% endnote %}

      - **Hostname**. Select the host name from the list of hosts available in the {{ MY }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      - **Port**. Specify the {{ MY }} connection port. The default port is 3306.
      - **Database name**. Specify the name of the database to connect to.
      - **Username**. Specify the username for the {{ MY }} connection.
      - **Password**. Enter the password for the user.
      - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
      - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   - Specify manually

      Specify the connection parameters for the external {{ MY }} database:

      - **Hostname**. Specify the path to a master host or a {{ MY }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      - **Port**. Specify the {{ MY }} connection port. The default port is 3306.
      - **Username**. Specify the username for the {{ MY }} connection.
      - **Database name**. Specify the name of the database to connect to.
      - **Password**. Enter the password for the user.
      - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
      - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   {% endlist %}

{% endif %}

{% if product == "cloud-il" %}

1. Specify the connection parameters:
   - **Hostname**. Select the host name from the list of hosts available in the {{ MY }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
   - **Port**. Specify the {{ MY }} connection port. The default port is 3306.
   - **Database name**. Specify the name of the database to connect to.
   - **Username**. Specify the username for the {{ MY }} connection.
   - **Password**. Enter the password for the user.
   - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
   - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

{% endif %}

1. Click **Save**. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
