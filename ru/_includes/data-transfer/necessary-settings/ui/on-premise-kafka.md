* {% include [Field Brokers](../../fields/kafka/ui/brokers.md) %}
* {% include [Field SSL](../../fields/kafka/ui/ssl.md) %}
* {% include [Field CA Certificate](../../fields/kafka/ui/ca-certificate.md) %}
* 
  **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.subnet_id.title }}** — выберите или [создайте](../../../../vpc/operations/subnet-create.md) подсеть в нужной [зоне доступности](../../../../overview/concepts/geo-scope.md).


  Если значение в этом поле задано для обоих эндпоинтов, то обе подсети должны быть размещены в одной зоне доступности.

* {% include [Field Authentication](../../fields/kafka/ui/authentication-on-premise.md) %}
  
* {% include [Field Topic](../../fields/kafka/ui/topic.md) %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

  Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).

