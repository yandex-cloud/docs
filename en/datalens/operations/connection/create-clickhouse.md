# Creating a ClickHouse connection

{% note info %}

{{ datalens-short-name }} specifics for {{ CH }} connections:

  - {{ CH }} connections only run over the HTTP interface.
  - All the data requests are executed with the [join_use_nulls](https://clickhouse.tech/docs/en/operations/settings/settings/#join_use_nulls) flag enabled.

{% endnote %}

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Connecting to ClickHouse {#clickhouse-connection}

To create a {{ CH }} connection:

1. Go to the [connections page](https://datalens.yandex.com/connections).

1. Click **Create connection**.

1. Select the **ClickHouse** connector.

1. Enter a **Connection name**. You can set any name.

1. Select the connection type:

   {% list tabs %}

    - Select in Yandex.Cloud

      Specify the connection parameters for the {{ CH }} DB available in {{ yandex-cloud }}:

      - **Cluster**. Specify a cluster from the list of available {{ CH }} clusters. If you don't have an available cluster, click **Create new**.

        {% note info %}

          The {{ CH }} clusters are shown in the list of clusters:
           - With the permissions for the user that creates the connection.
           - Created in the same folder with the {{ datalens-short-name }} instance.

        {% endnote %}

      - **Hostname**. Select the host name from the list of hosts available in the {{ CH }} cluster.

      - **HTTP interface port**. Specify the {{ CH }} connection port. The default port is 8443.

      - **Username**. Specify the username for the {{ CH }} connection.

           {% include [datalens-db-note](../../../_includes/datalens/datalens-db-note.md) %}

      - **Password**. Enter the password for the user.

      - **HTTPS**. Be sure that the secure connection option is enabled.

    - Specify manually

      Specify the connection parameters for the external {{ CH }} database:

      - **Hostname**. Specify the {{ CH }} host path or IP address.

      - **HTTP interface port**. Specify the {{ CH }} connection port. The default port is 8443.

      - **Username**. Specify the username for the {{ CH }} connection.

         {% include [datalens-db-note](../../../_includes/datalens/datalens-db-note.md) %}

      - **Password**. Enter the password for the user.

      - **HTTPS**. Enable the secure connection option if your server supports HTTPS.

   {% endlist %}

1. Click **Save**. The connection appears in the list.

{% note info %}

You can check the host connection before creating it. To do this, click **Check connection**.

{% endnote %}

