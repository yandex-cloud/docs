You can use [{{ websql-full-name }}](../../../websql) to run {{ mrd-name }} cluster database operations.

{{ websql-name }} is a {{ yandex-cloud }} service that enables you to connect to managed database clusters, work with databases, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with {{ VLK }} commands by suggesting prompts.

To connect from {{ websql-name }}, you must enable the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings. You can enable this option when [creating](../../../managed-valkey/operations/cluster-create.md) or [updating a cluster](../../../managed-valkey/operations/update.md#change-additional-settings).

In the {{ mrd-name }} cluster, a [connection in {{ connection-manager-name }}](../../../metadata-hub/concepts/connection-manager.md) is automatically created for each database user so they can connect to the database from {{ websql-name }}. You can also [create a new connection](../../../websql/operations/create-connection.md#connect-cluster) if you need one.

To connect to the database from {{ websql-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster of interest.
  1. [Go to](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
  1. Select the connection.

      The connection will open in {{ websql-name }}. To go to the query editor, select the required database.
    
{% endlist %}

For more information on how to work with {{ websql-name }}, see [these guides](../../../websql/operations/index.md).
