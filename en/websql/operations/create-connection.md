# Creating a connection

In {{ websql-full-name }}, you can create a connection to:

* [Managed database clusters](#connect-cluster) in {{ yandex-cloud }}
* [Public database via the internet](#connect-db)

## Connecting to a managed database cluster in {{ yandex-cloud }} {#connect-cluster}

In {{ websql-full-name }}, you can connect to databases in the following clusters:

* [{{ mpg-full-name }}](../../managed-postgresql/operations/cluster-list.md)​
* [{{ mch-full-name }}](../../managed-clickhouse/operations/cluster-list.md)​
* [{{ mmy-full-name }}](../../managed-mysql/operations/cluster-list.md)

{% include notitle [connect-to-cluster](../../_includes/websql/connect-to-cluster.md) %}

You can also [create a connection](../../metadata-hub/operations/create-connection.md) to a cluster in {{ metadata-hub-name }} {{ connection-manager-name }}. This connection will automatically appear in {{ websql-full-name }}. But DB username, password, and name should be entered manually.

If the connection is successful, you will see the cluster structure in the connection tree. Connections to databases within a single managed database cluster are grouped into an expandable list under the name of that cluster.

## Connecting to a public database {#connect-db}

To connect to a public database via the internet:

{% include notitle [connect-to-db](../../_includes/websql/connect-to-db.md) %}

If the connection is successful, you will see the database structure in the connection tree.
