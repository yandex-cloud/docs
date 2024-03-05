* {% include [Field Brokers](../../fields/kafka/ui/brokers.md) %}
* {% include [Field SSL](../../fields/kafka/ui/ssl.md) %}
* {% include [Field CA Certificate](../../fields/kafka/ui/ca-certificate.md) %}
* 
   **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the desired [availability zone](../../../../overview/concepts/geo-scope.md).


   If the value in this field is specified for both endpoints, both subnets must be hosted in the same availability zone.

* {% include [Field Authentication](../../fields/kafka/ui/authentication-on-premise.md) %}

* {% include [Field Topic](../../fields/kafka/ui/topic.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.security_groups.title }}**: Select the cloud network to host the endpoint and security groups for network traffic.

   Thus, you will be able to apply the specified security group rules to the VMs and clusters in the selected network without changing the settings of these VMs and clusters. For more information, see [{#T}](../../../../data-transfer/concepts/network.md).

