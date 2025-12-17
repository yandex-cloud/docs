You can send queries to databases in a {{ mrd-name }} cluster using [{{ websql-full-name }}](../../../websql).

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with database schemas and tables, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with {{ VLK }} commands by suggesting prompts.

To connect to a {{ mrd-name }} cluster from {{ websql-name }}, create a connection:

1. [Go to](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Click the cluster name.
1. [Enable](../../../managed-redis/operations/update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** in the cluster settings if it is not on yet.
1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_create-connection }}** and specify the following connection settings:
    * **Connection name**.
    * **Database type**: {{ VLK }}.
    * **Cluster**: Defaults to your current {{ VLK }} cluster.
    * **Username**: Account you will use to connect to the cluster database.
    * **Password**: User password.
    * **Databases**: List of databases you want to access. You can only connect to the databases within the current cluster. The user account you specified must have permissions to access these databases.
1. Click **Create**.

To open the query editor, click the connection you created on the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab.

For more details on using {{ websql-name }}, see its [official guides](../../../websql/operations/index.md).
