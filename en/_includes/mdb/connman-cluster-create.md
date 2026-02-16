Cluster DB connections are managed by {{ connection-manager-name }}. Creating a cluster automatically creates:

* [{{ connection-manager-name }} connection](../../metadata-hub/concepts/connection-manager.md) with information about the database connection.

* [{{ lockbox-name }} secret](../../metadata-hub/concepts/secret.md) that stores the DB owner's user password. Storing passwords in {{ lockbox-name }} ensures their security.

The connection and secret will be created for each new database user. To view all connections, select the **{{ ui-key.yacloud.connection-manager.label_connections }}** tab on the cluster page.

You need the `connection-manager.viewer` role to view connection info. You can [use {{ connection-manager-name }}](../../metadata-hub/operations/connection-access.md) to configure access to connections.

You can use {{ connection-manager-name }} and secrets you create there free of charge.
