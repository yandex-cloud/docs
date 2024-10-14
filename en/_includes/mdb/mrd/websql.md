You can send queries to databases in a {{ mrd-name }} cluster using [{{ websql-full-name }}](../../../websql).

{{ websql-name }} is a {{ yandex-cloud }} service that allows you to connect to managed database clusters, work with DBs, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with {{ RD }} commands by suggesting prompts.

To connect from {{ websql-name }} to a {{ mrd-name }} cluster, create a connection:

1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
1. Click the cluster name.
1. [Enable](../../../managed-redis/operations/update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** in the cluster settings if it is not enabled yet.
1. Select the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_create-connection }}** and specify the connection parameters:
    * **Connection name**.
    * **Database type**: {{ RD }}.
    * **Cluster**: Defaults to your current {{ RD }} cluster.
    * **Username** you will use to connect to the database in the cluster.
    * User **password**.
    * **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user you specified must have access to them configured.
1. Click **Create**.

To open the query editor, click the created connection on the **{{ ui-key.yacloud.postgresql.cluster.switch_explore-websql }}** tab.

For more information about working with {{ websql-name }}, see its [documentation](../../../websql/operations/index.md).
