* {% include [Field Managed Kafka](../../fields/kafka/ui/managed-kafka.md) %}
* {% include [Field Authentication](../../fields/kafka/ui/authentication.md) %}
* {% include [Field Topic](../../fields/kafka/ui/topic.md) %}
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSourceConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика.

  Это позволит применить к ВМ и кластерам в выбранной сети указанные правила групп безопасности без изменения настроек этих ВМ и кластеров. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).