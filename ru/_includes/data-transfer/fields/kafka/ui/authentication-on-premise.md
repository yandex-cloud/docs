**{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafka.auth.title }}** — выберите тип: `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.sasl.title }}` или `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.no_auth.title }}`.

При выборе значения `{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.OnPremiseKafkaAuth.sasl.title }}`:

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.user.title }}** — укажите имя учетной записи, от имени которой сервис {{ data-transfer-name }} будет подключаться к топику.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.password.title }}** — укажите пароль учетной записи.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaSaslSecurity.mechanism.title }}** — выберите механизм хеширования: {{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaAuthMechanism.KAFKA_AUTH_MECHANISM_SHA256.title }} или {{ ui-key.yc-data-transfer.data-transfer.console.form.kafka.console.form.kafka.KafkaAuthMechanism.KAFKA_AUTH_MECHANISM_SHA512.title }}.
