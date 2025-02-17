
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually:

        * {% include [Field Host IP or FQDN](../../fields/mysql/ui/host.md) %}
        * {% include [port](../../fields/mysql/ui/port.md) %}
        * {% include [database](../../fields/mysql/ui/database.md) %}
        * {% include [user](../../fields/mysql/ui/user.md) %}
        * {% include [password](../../fields/mysql/ui/password.md) %}
        * {% include [Field CA certificate](../../fields/mysql/ui/ca-certificate.md) %}

    * {% include [connection-manager](../../fields/mysql/ui/connection-manager.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.OnPremiseMysql.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the source.

    If this field's value is specified for both endpoints, both subnets must be hosted in the same availability zone.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

    Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).

