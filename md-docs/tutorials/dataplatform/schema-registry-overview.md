# Управление схемами данных в Managed Service for Apache Kafka®

Сервис Yandex Managed Service for Apache Kafka® использует [схемы форматов данных](../../managed-kafka/concepts/managed-schema-registry.md) для описания форматов ввода и вывода данных. На основе схемы формата данных производитель формирует, а потребитель интерпретирует сообщения из топиков.

Такие схемы хранятся в реестре схем формата данных. Для Yandex Managed Service for Apache Kafka® вы можете:

* Использовать [интегрированный реестр](managed-schema-registry.md).
* Использовать [интегрированный реестр](managed-schema-registry-rest.md) с помощью REST API.
* Настроить и использовать [реестр от Confluent](confluent-schema-registry.md).