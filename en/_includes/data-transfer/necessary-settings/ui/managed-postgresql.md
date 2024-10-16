* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnectionType.mdb_cluster_id.title }}**: Specify ID of the cluster to connect to.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually:

        * {% include [database](../../fields/postgresql/ui/database.md) %}
        * {% include [user](../../fields/postgresql/ui/user.md) %}
        * {% include [password](../../fields/postgresql/ui/password.md) %}

    * {% include [connection-manager](../../fields/postgresql/ui/connection-manager.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

    Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).

