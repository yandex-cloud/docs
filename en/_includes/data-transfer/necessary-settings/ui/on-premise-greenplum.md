* {% include [Field Primary IP FQDN](../../fields/greenplum/ui/primary-host.md) %}
* {% include [Field Primary port](../../fields/greenplum/ui/primary-port.md) %}
* {% include [Field Mirror IP FQDN](../../fields/greenplum/ui/mirror-host.md) %}
* {% include [Field Mirror port](../../fields/greenplum/ui/mirror-port.md) %}
* {% include [Field Segments](../../fields/greenplum/ui/segments.md) %}
* {% include [Field CA certificate](../../fields/greenplum/ui/ca-certificate.md) %}
* 
  **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the cluster.


  If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: Specify the name of the database in the selected cluster.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: Specify the username that {{ data-transfer-name }} will use to connect to the database.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: Enter the user's password to the database.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

  Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
