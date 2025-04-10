* {% include [Field Brokers](../../fields/kafka/ui/brokers.md) %}
* {% include [Field SSL](../../fields/kafka/ui/ssl.md) %}
* {% include [Field CA Certificate](../../fields/kafka/ui/ca-certificate.md) %}

*  **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.subnet_id.title }}**: Select or [create](../../../../vpc/operations/subnet-create.md) a subnet in the required [availability zone](../../../../overview/concepts/geo-scope.md). The transfer will use this subnet to access the target.


  If this field's value is specified for both endpoints, both subnets must be hosted in the same availability zone.

* {% include [Field Authentication](../../fields/kafka/ui/authentication-on-premise.md) %}


{% include [Security groups](../../fields/kafka/ui/security-groups.md) %}
