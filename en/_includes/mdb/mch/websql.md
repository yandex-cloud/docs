You can use [{{ websql-full-name }}](../../../websql) to send SQL queries to {{ mch-name }} cluster databases.

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with databases, tables, and schemas, and run queries. This service runs in the browser, requires no extra login, and simplifies work by providing hints for SQL commands.

To connect to a cluster from {{ websql-name }}, you must enable the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings. You can enable this option when [creating](../../../managed-clickhouse/operations/cluster-create.md) or [updating](../../../managed-clickhouse/operations/update.md#change-additional-settings) a cluster.

The {{ mch-name }} cluster automatically creates a [{{ connection-manager-name }}](../../../metadata-hub/concepts/connection-manager.md) connection for each database user, enabling database access from {{ websql-name }}. You can also [create a new connection](../../../websql/operations/create-connection.md#connect-cluster) if needed.

To connect to the database from {{ websql-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
  1. Select the required connection.

      The connection will open in {{ websql-name }}. To open the query editor, select the required database.
      
      Check [this {{ CH }}]({{ ch.docs }}{{ lang }}/sql-reference/statements/select) reference for supported queries.
    
{% endlist %}

[Learn more](../../../websql/operations/index.md) about working with {{ websql-name }}.
