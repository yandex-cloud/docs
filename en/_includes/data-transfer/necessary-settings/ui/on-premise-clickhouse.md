* {% include [Field Shards](../../fields/clickhouse/ui/shards.md) %}
* {% include [Field HTTP-port](../../fields/clickhouse/ui/http-port.md) %}
* {% include [Field Native Port](../../fields/clickhouse/ui/native-port.md) %}
* {% include [Field SSL connect](../../fields/clickhouse/ui/ssl-connect.md) %}
* {% include [Field CA Certificate](../../fields/clickhouse/ui/ca-certificate.md) %}
* 
   **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseOnPremise.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the desired [availability zone](../../../../overview/concepts/geo-scope.md).


   If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}**: Specify the username that {{ data-transfer-name }} will use to connect to the database.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}**: Enter the user password to the database.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}**: Specify the name of the database in the selected cluster.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

   Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
