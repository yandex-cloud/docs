* **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.addresses.title }}**: Click ![image](../../../../_assets/data-transfer/add-datanode.svg) to add a new data node. For each node, specify:

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearchHostPort.host.title }}**: IP address or FQDN of the host with the `DATA` role you want to connect to.

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearchHostPort.port.title }}**: Port number {{ data-transfer-name }} will use for connections to the `DATA` host.

* {% include [Field CA certificate](../../fields/elasticsearch/ui/ca-certificate.md) %}
* 
   **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.OnPremiseElasticSearch.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the desired [availability zone](../../../../overview/concepts/geo-scope.md).


   If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.user.title }}**: Specify the username {{ data-transfer-name }} will use to connect to the cluster.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.password.title }}**: Enter the user password to the cluster.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.elasticsearch.console.form.elasticsearch.ElasticSearchConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

   This will let you apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).
