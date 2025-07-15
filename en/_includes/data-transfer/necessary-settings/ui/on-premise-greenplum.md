
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually:

      * {% include [Field Primary IP FQDN](../../fields/greenplum/ui/primary-host.md) %}
      * {% include [Field Primary port](../../fields/greenplum/ui/primary-port.md) %}
      * {% include [Field Mirror IP FQDN](../../fields/greenplum/ui/mirror-host.md) %}
      * {% include [Field Mirror port](../../fields/greenplum/ui/mirror-port.md) %}
      * {% include [Field Segments](../../fields/greenplum/ui/segments.md) %}
      * {% include [Field CA certificate](../../fields/greenplum/ui/ca-certificate.md) %}
      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the database.

        If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: Enter the database name.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: Enter the user password for access to the database.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Allows connecting to the database using [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

      * Select the folder the {{ connection-manager-name }} connection was created in.
      * Select **Custom installation** as the installation type and configure these settings:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}**: Select or create a connection in {{ connection-manager-name }}.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: Specify the database name in the custom installation.
        *  **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.OnPremiseGreenplum.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the database.

            If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.

        {% include [connection-manager-access](../../notes/connection-manager-access.md) %}        

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

  This will allow you to apply the specified security group rules to VMs and DBs in the selected network without reconfiguring these VMs and DBs. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
  