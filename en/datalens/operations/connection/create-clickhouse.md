# Creating a ClickHouse connection

{% note info %}

- {{ CH }} connections only run over the HTTP interface.
- All the data requests are executed with the [join_use_nulls]({{ ch.docs }}/operations/settings/settings/#join_use_nulls) flag enabled. See the [{#T}](#ch-connection-specify), section if you use views or subqueries with a JOIN in {{ datalens-short-name }}.

{% endnote %}


{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}


## Connecting to ClickHouse {#clickhouse-connection}

To create a {{ CH }} connection:



1. Go to the [connections page](https://datalens.yandex.ru/connections).


1. Click **Create connection**.



1. Select the **ClickHouse** connection.
1. Enter a **Connection name**. You can set any name.



1. Select the connection type:

   {% list tabs %}

   - Select in a folder

      Specify the connection parameters for the {{ CH }} DB available in {{ yandex-cloud }}:

      - **Cluster**. Specify a cluster from the list of available {{ CH }} clusters. Cluster settings must have the **DataLens access** flag set. If you don't have an available cluster, click **Create new**.

         {% note info %}

         The {{ CH }} clusters are shown in the list of clusters:

         - With the permissions for the user that creates the connection.
         - Created in the same folder with the {{ datalens-short-name }} instance.

         {% endnote %}

      - **Hostname**. Select the host name from the list of hosts available in the {{ CH }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      - **HTTP interface port**. Specify the {{ CH }} connection port. The default port is 8443.
      - **Username**. Specify the username for the {{ CH }} connection.

         {% include [datalens-db-note](../../../_includes/datalens/datalens-db-note.md) %}

      - **Password**. Enter the password for the user.
      - **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
      - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).
      - **HTTPS**. Be sure that the secure connection option is enabled.

   - Specify manually

      Specify the connection parameters for the external {{ CH }} database:

      {% include [datalens-db-connection-parameters](../../../_includes/datalens/datalens-db-connection-parameters.md) %}

   {% endlist %}




1. Click **Save**. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}

## Specifics for ClickHouse connections {#ch-connection-specify}

You can create datasets on top of views that contain a JOIN in {{ CH }}. To do this, make sure a view is created with the `join_use_nulls` option enabled. We recommend that you set `join_use_nulls = 1` in the `SETTINGS` section:

```sql
CREATE VIEW ... (
    ...
) AS
    SELECT
        ...
    FROM
        ...
    SETTINGS join_use_nulls = 1
```

You should also enable this option for raw-sql subqueries that are used as a data source in your dataset.

To avoid errors when using views with a JOIN in {{ datalens-short-name }}, re-create all views and set `join_use_nulls = 1`. This fills in empty cells with `NULL` values and converts the type of the corresponding fields to [Nullable]({{ ch.docs }}/sql-reference/data-types/nullable/#data_type-nullable).
