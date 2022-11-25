# Creating a PostgreSQL connection

{% if product == "yandex-cloud" %}

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

{% endif %}

## Connecting to {{ PG }} {#postgresql-connection}

To create a {{ PG }} connection:

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

1. Select **PostgreSQL** as the connection type.
1. Enter a **Connection name**. You can set any name.

{% if product == "yandex-cloud" %}

1. Select the connection type:

   {% list tabs %}

   - Select in Yandex Cloud

      {% if audience != "internal" %}

      Specify the connection parameters for the {{ PG }} DB available in {{ yandex-cloud }}:

      {% endif %}

      {% if audience == "internal" %}

      Specify the connection parameters for the {{ PG }} database:

      {% endif %}

      - **Cluster**. Specify a cluster from the list of available {{ PG }} clusters. Cluster settings must have the **DataLens access** flag set. If you don't have an available cluster, click **Create new**.

         {% note info %}

         The {{ PG }} clusters are shown in the list of clusters:

         - With the permissions for the user that creates the connection.
         - Created in the same folder with the {{ datalens-short-name }} instance.

         {% endnote %}

      - **Hostname**. Select the host name from the list of hosts available in the {{ PG }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      - **Port**. Specify the {{ PG }} connection port. The default port is 6432.
      - **Database name**. Specify the name of the database to connect to.
      - **Username**. Specify the username for the {{ PG }} connection.
      - **Password**. Enter the password for the user.
      - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
      - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   - Specify manually

      Specify the connection parameters for the external {{ PG }} database:

      - **Hostname**. Specify the path to a master host or a {{ PG }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      - **Port**. Specify the {{ PG }} connection port. The default port is 6432.
      - **Database name**. Specify the name of the database to connect to.
      - **Username**. Specify the username for the {{ PG }} connection.
      - **Password**. Enter the password for the user.
      - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
      - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   {% endlist %}

{% endif %}

{% if product == "cloud-il" %}

1. Specify the connection parameters for the external {{ PG }} database:

   - **Hostname**. Specify the path to a master host or a {{ PG }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
   - **Port**. Specify the {{ PG }} connection port. The default port is 6432.
   - **Database name**. Specify the name of the database to connect to.
   - **Username**. Specify the username for the {{ PG }} connection.
   - **Password**. Enter the password for the user.
   - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
   - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

{% endif %}

1. Click **Save**. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}

### Additional settings {#postgresql-additional-settings}

To explicitly define a collation for DB queries, go to **Advanced connection settings**.

Select a mode to configure **Setting collate in a query**:
- **Auto**: The default setting is used, {{ datalens-short-name }} decides whether to enable the `en_US` locale.
- **On**: The {{ datalens-short-name }} setting is used, the `en_US` locale is specified for individual expressions in a query. This makes the server use the appropriate sorting logic, regardless of the server settings and specific tables. Use the {{ datalens-short-name }} setting if the DB locale is incompatible with {{ datalens-short-name }} performance. For more information about the locale and `LC_COLLATE`, see [{#T}](../../../managed-postgresql/operations/cluster-create.md#create-cluster).
- **Off**: The default setting is used, {{ datalens-short-name }} only uses the existing parameters of the DB locale.
