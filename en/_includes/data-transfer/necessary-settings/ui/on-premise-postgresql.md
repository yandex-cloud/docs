* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.host.title }}**: Specify the IP address or FQDN of the master host. If the hosts are on different ports, you can specify multiple host values in the `host:port` format. If you choose this format, the value of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}** field will be disregarded.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}**: Set the number of the port that {{ data-transfer-name }} will use for the connection.

* {% include [Field CA certificate](../../fields/postgresql/ui/ca-certificate.md) %}
* 
   **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md).


   If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.database.title }}**: Specify the name of the database in the selected cluster.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.user.title }}**: Specify the username that {{ data-transfer-name }} will use to connect to the database.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.password.title }}**: Enter the user's password to the database.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

   Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
