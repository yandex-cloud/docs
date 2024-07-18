You can send SQL queries to databases in a {{ mpg-name }} cluster using [{{ websql-full-name }}](../../../websql).

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with DBs, tables, and schemas, and run queries. It is a web-based tool that does not require additional authorization and simplifies working with SQL queries by suggesting prompts.

To connect from {{ websql-name }} to a {{ mpg-name }} cluster, create a connection:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the cluster name.
1. [Enable](../../../managed-postgresql/operations/update.md#change-additional-settings) the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings if it is not enabled yet.
1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_create-connection }}** and specify the connection parameters:
   * **Connection name**.
   * **Database type**: {{ PG }}.
   * **Cluster**: Defaults to your current {{ PG }} cluster.
   * **Username** you will use to connect to the database in the cluster.
   * User **password**.
   * **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user you specified must have access to them configured.
1. Click **Create**.

To open the SQL editor, click the created connection on the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab. See a reference list of supported queries in the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql.html).

{% note info %}

You cannot use SQL commands to do anything that requires superuser access.

{% endnote %}

For more information about working with {{ websql-name }}, see its [documentation](../../../websql/operations/index.md).
