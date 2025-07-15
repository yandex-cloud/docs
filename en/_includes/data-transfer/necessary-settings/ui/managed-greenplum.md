
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually.

    Select **Managed Service for Greenplum cluster** as the installation type and configure these settings:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: Select the cluster to connect to.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: Specify the name of the database in the selected cluster.      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the database.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: Enter the user password for access to the database.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Allows connecting to the cluster via [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

    * Select the folder with the {{ mgp-name }} cluster.
    * Select **Managed DB cluster** as the installation type and configure these settings:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}**: Select the cluster to connect to.      
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}**: Select or create a connection in {{ connection-manager-name }}.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: Specify the name of the database in the selected cluster.

    {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

  Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
