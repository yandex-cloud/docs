**{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.auth.title }}**: Select the connection type (`{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.sasl.title }}` or `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.no_auth.title }}`).

If you select `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.sasl.title }}`:

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.user.title }}**: Specify the name of the account, under which {{ data-transfer-name }} will connect to the topic.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.password.title }}**: Enter the account password.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.mechanism.title }}**: Select the hashing mechanism ({{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaAuthMechanism.KAFKA_AUTH_MECHANISM_SHA256.title }} or {{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaAuthMechanism.KAFKA_AUTH_MECHANISM_SHA512.title }}).
