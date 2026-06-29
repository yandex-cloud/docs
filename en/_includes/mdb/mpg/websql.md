You can use [{{ websql-full-name }}](../../../websql) to send SQL queries to {{ mpg-name }} cluster databases.

{{ websql-name }} is a {{ yandex-cloud }} service that enables you to connect to managed database clusters, work with databases, tables, and schemas, and run queries. This service runs in the browser, requires no extra login, and simplifies work by providing hints for SQL commands.

To connect from {{ websql-name }}, activate the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings. You can enable it when [creating](../../../managed-postgresql/operations/cluster-create.md) or [updating](../../../managed-postgresql/operations/update.md#change-additional-settings) a cluster.

The {{ mpg-name }} cluster automatically creates a [{{ connection-manager-name }}](../../../metadata-hub/concepts/connection-manager.md) connection for each database user, enabling database access from {{ websql-name }}. You can also [create a new connection](../../../websql/operations/create-connection.md#connect-cluster) if needed.

To connect to the database from {{ websql-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
  1. Select the required connection.

      The connection will open in {{ websql-name }}. To open the query editor, select the required database. 
      
      Check [this {{ PG }}](https://www.postgresql.org/docs/current/sql.html) reference for supported queries.

      {% note info %}
      
      You cannot use SQL statements to perform operations requiring superuser privileges.
      
      {% endnote %}
    
{% endlist %}

For more details on working with {{ websql-name }}, see [these guides](../../../websql/operations/index.md).
