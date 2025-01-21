* {% include [Field Host IP or FQDN](../../fields/mysql/ui/host.md) %}
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.port.title }}**: Set the number of the port that {{ data-transfer-name }} will use for the connection.

* {% include [Field CA certificate](../../fields/mysql/ui/ca-certificate.md) %}
* 
  **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the target.


  If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.

* {% include [Field Database Name](../../fields/mysql/ui/database-name-source.md) %}
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.user.title }}**: Specify the username that {{ data-transfer-name }} will use to connect to the database.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.password.title }}**: Enter the user's password to the database.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

  Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
