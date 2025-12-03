
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a cluster connection option:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually.

    Select **Managed Service for Apache Kafka cluster** as the installation type and configure these settings:

    * {% include [Field Managed Kafka cluster](../../fields/kafka/ui/managed-kafka.md) %}
    * {% include [Field Authentication](../../fields/kafka/ui/authentication.md) %}

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Allows connecting to the cluster via [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

    * Select the folder with the {{ mkf-name }} cluster.
    * Select **Managed DB cluster** as the installation type and configure these settings:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}**: Select the cluster to connect to.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}**: Select or create a connection in {{ connection-manager-name }}.

    {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* {% include [Field Topic](../../fields/kafka/ui/topic.md) %}

* {% include [Security groups](../../fields/kafka/ui/security-groups.md) %}

