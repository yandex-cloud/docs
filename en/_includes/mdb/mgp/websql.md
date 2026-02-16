You can use [{{ websql-full-name }}](../../../websql) to run {{ mgp-name }} cluster database operations.

{{ websql-name }} is a {{ yandex-cloud }} service that enables you to connect to managed database clusters, work with databases, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with {{ VLK }} commands by prompting the user.

To connect to a {{ mgp-name }} cluster from {{ websql-name }}, create a connection:

1. Open the [folder dashboard]({{ link-console-main }}).
1. [Navigate to](../../../console/operations/select-service.md#select-service) the **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}** service.
1. Click the name of your cluster.
1. [Enable](../../../managed-greenplum/operations/update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** in the cluster settings if it is not enabled yet.
1. Select the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.websql-connections.action_create-connection }}** and specify the following connection settings:
    * **Database type**: {{ GP }}.
    * **Cluster folder**: Defaults to your current folder.
    * **Cluster**: Defaults to your current {{ GP }} cluster.
    * **Username**: Account you will use to connect to the cluster database.
    * User **password**.
    * **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user account you specified must have access to them.
1. Click **Create**.

To open the query editor, click the connection you created on the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.

For more information on how to work with {{ websql-name }}, see [these guides](../../../websql/operations/index.md).
