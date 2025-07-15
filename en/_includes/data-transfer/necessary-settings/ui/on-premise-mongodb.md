
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually.

        Select **Custom installation** as the installation type and configure these settings:

        * {% include [Field Hosts list](../../fields/mongodb/ui/hosts-list.md) %}
        * {% include [Field Replica Set](../../fields/mongodb/ui/replica-set.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.port.title }}**: Set the number of the port that {{ data-transfer-name }} will use for the connection.

        * {% include [Field CA certificate](../../fields/mongodb/ui/ca-certificate.md) %}

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the database.

          If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: Specify the database name in the custom installation.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.raw_password.title }}**: Enter the user password for access to the database.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Allows connecting to the database via [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

        * Select the folder the {{ connection-manager-name }} connection was created in.
        * Select **Custom installation** as the installation type and configure these settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}**: Select or create a {{ connection-manager-name }} connection.

            * {% include [Field Replica Set](../../fields/mongodb/ui/replica-set.md) %}

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.auth_source.title }}**: Specify the database name in the custom installation.

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.OnPremiseMongo.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the database.

              If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.

        {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.mongo.console.form.mongo.MongoConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

  This will allow you to apply the specified security group rules to VMs and DBs in the selected network without reconfiguring these VMs and DBs. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).

