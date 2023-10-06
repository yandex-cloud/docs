# Creating a {{ CH }} connection

{% note info %}

All data requests are executed with the [join_use_nulls]({{ ch.docs }}/operations/settings/settings/#join_use_nulls) flag enabled. See the [{#T}](#ch-connection-specify) section if you use views or subqueries with a JOIN in {{ datalens-short-name }}.

{% endnote %}


{% include [connection-note](../../../_includes/datalens/datalens-connection-note-ip.md) %}

To create a {{ CH }} connection:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}



1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.
1. Select a **{{ CH }}** connection.


1. Select the connection type:

   {% list tabs %}

   - Select in a folder

      Specify the connection parameters for the {{ CH }} DB available in {{ yandex-cloud }}:

      * **Cluster**: Specify a cluster from the list of available {{ CH }} clusters. Cluster settings must have the **{{ datalens-short-name }} access** option enabled. If you do not have an available cluster, click **Create new**.

         {% note info %}

         The {{ CH }} clusters are shown in the list of clusters:

         * With the permissions for the user that creates the connection.
         * Created in the same folder with the {{ datalens-short-name }} instance.

         {% endnote %}

      * **Hostname**: Select the host name from the list of hosts available in the {{ CH }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      * **HTTP interface port**: Specify the {{ CH }} connection port. The default port is 8443.
      * **Username**: Specify the username for the {{ CH }} connection.

         {% include [datalens-db-note](../../../_includes/datalens/datalens-db-note.md) %}

      * **Password**: Enter the password for the user.
      * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
      * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   - Specify manually

      Specify the connection parameters for the external {{ CH }} database:

      {% include [datalens-db-connection-parameters](../../../_includes/datalens/datalens-db-connection-parameters.md) %}

   {% endlist %}


1. Click **Create connection**.
1. Enter a name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}



## Additional settings {#clickhouse-additional-settings}

You can specify additional connection settings in the **Advanced connection settings** section:

* **TLS**: If this option is enabled, the DB is accessed via `HTTPS`; if not, via `HTTP`.

* **CA Certificate**: To upload a certificate , click **Attach file** and specify the certificate file. When the certificate is uploaded, the field shows the file name.

* {% include [datalens-db-connection-export-settings-item](../../../_includes/datalens/operations/datalens-db-connection-export-settings-item.md) %}

## Specifics for {{ CH }} connections {#ch-connection-specify}

In {{ CH }}, you can create a dataset on top of a `VIEW` that contains a `JOIN`. To do this, make sure a view is created with the `join_use_nulls` option enabled. We recommend that you set `join_use_nulls = 1` in the `SETTINGS` section:

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
