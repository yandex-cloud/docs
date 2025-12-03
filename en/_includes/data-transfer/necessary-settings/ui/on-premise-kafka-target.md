
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually.

        Select **Custom installation** as the installation type and configure these settings:

        * {% include [Field Brokers](../../fields/kafka/ui/brokers.md) %}
        * {% include [Field SSL](../../fields/kafka/ui/ssl.md) %}
        * {% include [Field CA Certificate](../../fields/kafka/ui/ca-certificate.md) %}
        *  **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the target.

            If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.

        * {% include [Field Authentication](../../fields/kafka/ui/authentication-on-premise.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Allows connecting to the database using [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

        * Select the folder where the {{ connection-manager-name }} connection was created.
        * Select **Custom installation** as the installation type and configure these settings:

          * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}**: Select or create a connection in {{ connection-manager-name }}.
          * **Subnet ID**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the database.

            If this field has a value specified for both endpoints, both subnets must be hosted in the same availability zone.

* {% include [Field Topic Target](../../fields/kafka/ui/topic-target.md) %}
* {% include [Security groups](../../fields/kafka/ui/security-groups.md) %}
* {% include [Field Serialization](../../fields/kafka/ui/serialization.md) %}
* {% include [Field Extra Settings Target](../../fields/kafka/ui/extra-settings-target.md) %}

