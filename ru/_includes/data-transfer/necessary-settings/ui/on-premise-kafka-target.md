* {% include [Field Brokers](../../fields/kafka/ui/brokers.md) %}
* {% include [Field SSL](../../fields/kafka/ui/ssl.md) %}
* {% include [Field CA Certificate](../../fields/kafka/ui/ca-certificate.md) %}

  **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md). Трансфер будет использовать эту подсеть для доступа к приемнику.


  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

* {% include [Field Authentication](../../fields/kafka/ui/authentication-on-premise.md) %}


{% include [Security groups](../../fields/kafka/ui/security-groups.md) %}
