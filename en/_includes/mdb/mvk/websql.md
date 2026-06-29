You can use [{{ websql-full-name }}](../../../websql) to run {{ mrd-name }} cluster database operations.

{{ websql-name }} is a {{ yandex-cloud }} service that enables you to connect to managed database clusters, work with databases, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with {{ VLK }} commands by prompting the user.

To connect to a cluster from {{ websql-name }}, you must enable the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings. You can enable this option when [creating](../../../managed-valkey/operations/cluster-create.md) or [updating a cluster](../../../managed-valkey/operations/update.md#change-additional-settings).

The {{ mrd-name }} cluster automatically creates a [{{ connection-manager-name }}](../../../metadata-hub/concepts/connection-manager.md) connection for each database user, enabling database access from {{ websql-name }}. You can also [create a new connection](../../../websql/operations/create-connection.md#connect-cluster) if you need one.

To connect to the database from {{ websql-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your cluster.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
  1. Select the required connection.

      The connection will open in {{ websql-name }}. To go to the query editor, select the required database.
    
{% endlist %}

For more details on working with {{ websql-name }}, see [these guides](../../../websql/operations/index.md).
