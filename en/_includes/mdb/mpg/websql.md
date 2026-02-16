You can use [{{ websql-full-name }}](../../../websql) to send SQL queries to {{ mpg-name }} cluster databases.

{{ websql-name }} is a {{ yandex-cloud }} service that enables you to connect to managed database clusters, work with databases, tables, and schemas, and run queries. It is a web-based tool that requires no additional authorization and simplifies working with SQL commands by prompting the user.

To connect from {{ websql-name }}, activate the **{{ ui-key.yacloud.mdb.forms.additional-field-websql-service }}** option in the cluster settings. You can enable it when [creating](../../../managed-postgresql/operations/cluster-create.md) or [updating](../../../managed-postgresql/operations/update.md#change-additional-settings) a cluster.

In the {{ mpg-name }} cluster, a [{{ connection-manager-name }}](../../../metadata-hub/concepts/connection-manager.md) connection is automatically created for each database user, which you can use to connect to the database from {{ websql-name }}. If required, you can also [create a new connection](../../../websql/operations/create-connection.md#connect-cluster).

To connect to the database from {{ websql-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the cluster you need.
  1. [Go to](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.switch_explore-websql }}** tab.
  1. Select the required connection.

      The connection will open in {{ websql-name }}. To go to the query editor, select the required database. 
      
      Check [this {{ PG }}](https://www.postgresql.org/docs/current/sql.html) reference for supported queries.

      {% note info %}
      
      You cannot use SQL statements to perform operations requiring superuser privileges.
      
      {% endnote %}
    
{% endlist %}

For more information on how to work with {{ websql-name }}, see [these guides](../../../websql/operations/index.md).
