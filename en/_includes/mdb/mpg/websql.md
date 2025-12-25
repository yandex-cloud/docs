You can use [{{ websql-full-name }}](../../../websql) to send SQL queries to {{ mpg-name }} cluster databases.

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with database schemas and tables, and run queries. This service runs in your browser, requires no additional authentication, and simplifies working with SQL queries by providing hints.

To connect to a {{ mpg-name }} cluster from {{ websql-name }}, create a connection:

1. Navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
1. Click the name of your cluster.
1. [Enable](../../../managed-postgresql/operations/update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** in the cluster settings if it is not on yet.
1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_create-connection }}** and specify the following connection settings:
    * **Connection name**.
    * **Database type**: {{ PG }}.
    * **Cluster**: Defaults to your current {{ PG }} cluster.
    * **Username**: Account you will use to connect to the cluster database.
    * **Password**: User password.
    * **Databases**: List of databases you want to access. You can only connect to the databases within the current cluster. The user account you specified must have permissions to access these databases.
1. Click **Create**.

To open the SQL editor, click the connection you created on the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab. See the [{{ PG }} reference](https://www.postgresql.org/docs/current/sql.html) for supported queries.

{% note info %}

You cannot use SQL statements to perform operations requiring superuser privileges.

{% endnote %}

For more details on using {{ websql-name }}, see its [official guides](../../../websql/operations/index.md).
