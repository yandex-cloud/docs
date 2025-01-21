* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually:

        * {% include [host](../../fields/postgresql/ui/host.md) %}
        * {% include [port](../../fields/postgresql/ui/port.md) %}
        * {% include [database](../../fields/postgresql/ui/database.md) %}
        * {% include [user](../../fields/postgresql/ui/user.md) %}
        * {% include [password](../../fields/postgresql/ui/password.md) %}
        * {% include [ca-certificate](../../fields/postgresql/ui/ca-certificate.md) %}

    * {% include [connection-manager](../../fields/postgresql/ui/connection-manager.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the cluster.

    If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

    Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).

