You can use [{{ websql-full-name }}](../../../websql) to send SQL queries to {{ mch-name }} cluster databases.

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with databases, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with SQL commands by providing hints.

To access a {{ mch-name }} cluster from {{ websql-name }}, create a connection:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Click the cluster name.
1. [Enable](../../../managed-clickhouse/operations/update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** in the cluster settings if it is not enabled yet.
1. Select the **{{ ui-key.yacloud.clickhouse.cluster.switch_explore-websql }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_create-connection }}** and specify the following connection settings:
    * **Connection name**.
    * **Database type**: {{ CH }}.
    * **Cluster**: Defaults to your current {{ CH }} cluster.
    * **Username**: Account you will use to connect to the cluster database.
    * User **password**.
    * **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user account you specified must have access to them.
1. Click **Create**.

To open the SQL editor, click the created connection on the **{{ ui-key.yacloud.clickhouse.cluster.switch_explore-websql }}** tab. Check the [{{ CH }} reference]({{ ch.docs }}/sql-reference/statements/select/) for supported queries.

For more information on how to work with {{ websql-name }}, see [these guides](../../../websql/operations/index.md).
