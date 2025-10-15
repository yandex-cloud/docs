With {{ connection-manager-full-name }}, you can manage database [connection](../../metadata-hub/concepts/connection-manager.md) parameters. Connections are created automatically when you create a new managed database cluster in {{ yandex-cloud }} for {{ PG }}, {{ CH }}, and {{ MY }} clusters. For other types of clusters, you can [create a connection](../../metadata-hub/operations/create-connection.md) manually.
Clusters created before the {{ connection-manager-name }} integration was implemented, will operate as they used to. For such clusters, you can enable integration manually in [additional cluster settings](../../metadata-hub/quickstart/connection-manager.md#mdb-integration).
You cannot edit or delete any connection or secret created automatically together with a new cluster: they are updated automatically when editing user settings in a managed database cluster.

A connection contains all the information about database connection parameters. The sensitive part of this information, such as the user password for database access, is stored in [{{ lockbox-full-name }}](../../lockbox/index.yaml) as a [secret](../../metadata-hub/concepts/secret.md).

