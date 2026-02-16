В состав [архивов с бинарными файлами {{ KF }}](https://kafka.apache.org/downloads) включен [набор инструментов](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html), который позволяет управлять кластером {{ KF }} и сущностями в нем. Далее на примере будет показано, как указать реквизиты пользователя для подключения и использовать инструменты с этими реквизитами:

* С помощью [kafka-console-producer](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html#kafka-console-producer-sh) будет отправлено сообщение в топик.
* С помощью [kafka-console-consumer](https://docs.confluent.io/kafka/operations-tools/kafka-tools.html#kafka-console-consumer-sh) будет получено сообщение из топика.
