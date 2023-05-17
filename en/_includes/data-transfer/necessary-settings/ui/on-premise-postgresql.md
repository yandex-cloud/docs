* {% include [Field IP FQDN](../../fields/postgresql/ui/host.md) %}
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.port.title }}**: Set the number of the port that {{ data-transfer-name }} will use for the connection.

* {% include [Field CA certificate](../../fields/postgresql/ui/ca-certificate.md) %}
* 
   **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.OnPremisePostgres.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the desired [availability zone](../../../../overview/concepts/geo-scope.md).


   If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.database.title }}**: Specify the name of the database in the selected cluster.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.user.title }}**: Specify the username that {{ data-transfer-name }} will use to connect to the database.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.password.title }}**: Enter the user's password to the database.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.postgres.console.form.postgres.PostgresConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

   This will let you apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
