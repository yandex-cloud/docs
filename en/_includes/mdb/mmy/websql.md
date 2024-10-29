You can send SQL queries to databases in a {{ mmy-name }} cluster using [{{ websql-full-name }}](../../../websql).

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with DBs, tables, and schemas, and run SQL queries. It is a web-based tool that requires no additional authorization and simplifies working with SQL commands by suggesting prompts.

To connect from {{ websql-name }} to a {{ mmy-name }} cluster, create a connection:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
1. Click the cluster name.
1. [Enable](../../../managed-mysql/operations/update.md#change-additional-settings) the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings if it is not enabled yet.
1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_create-connection }}** and specify the connection parameters:
   * **Connection name**.
   * **Database type**: {{ MY }}.
   * **Cluster**: Defaults to your current {{ MY }} cluster.
   * **Username** you will use to connect to the database in the cluster.
   * User **password**.
   * **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user you specified must have access to them configured.
1. Click **Create**.

To open the SQL editor, click the created connection on the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab.

For more information about working with {{ websql-name }}, see the [service documentation](../../../websql/operations/index.md).
