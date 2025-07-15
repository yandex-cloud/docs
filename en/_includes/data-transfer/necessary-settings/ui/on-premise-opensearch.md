
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually.

        Select **Custom installation** as the installation type and configure these settings:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.addresses.title }}**: Click ![image](../../../../_assets/console-icons/plus.svg) to add a new data node. For each node, specify:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearchHostPort.host.title }}**: IP address or FQDN of the host with the `DATA` role you need to connect to.
          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearchHostPort.port.title }}**: Port number {{ data-transfer-name }} will use to connect to the host with the `DATA` role.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.ssl_enabled.title }}**: Select this option if a secure SSL connection is used.

        * {% include [Field CA certificate](../../fields/opensearch/ui/ca-certificate.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the database.

          If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.

          If you do not specify a subnet, you may get an [error](../../../../managed-opensearch/qa/index.md#data-transfer-error) when activating the transfer.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}**: Enter the user password for access to the database.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Allows connecting to the database using [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

        * Select the folder the {{ connection-manager-name }} connection was created in.
        * Select **Custom installation** as the installation type and configure these settings:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}**: Select or create a connection in {{ connection-manager-name }}.
          * 
            **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OnPremiseOpenSearch.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the database.


            If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.

            If you do not specify a subnet, you may get an [error](../../../../managed-opensearch/qa/index.md#data-transfer-error) when activating the transfer.

      {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

  This will allow you to apply the specified security group rules to VMs and DBs in the selected network without reconfiguring these VMs and DBs. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
