With {{ connection-manager-full-name }}, you can manage database [connection](../../metadata-hub/concepts/connection-manager.md) parameters. Connections are created automatically when you create a new managed database cluster in {{ yandex-cloud }}, if support for {{ connection-manager-full-name }} is configured at cloud level. To configure the integration, contact [support]({{ link-console-support }}).
You cannot edit or delete any connection or secret created automatically together with a new cluster: they are updated automatically when editing user settings in a managed database cluster.

A connection contains the whole information about database connection parameters. The sensitive part of this information, such as the user password for database access, is stored in [{{ lockbox-full-name }}](../../lockbox/index.yaml) as a [secret](../../metadata-hub/concepts/secret.md).

