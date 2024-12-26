---
canonical: '{{ link-docs }}/tutorials/dataplatform/schema-registry-overview'
---

# Управление схемами данных в {{ mkf-short-name }}

Сервис {{ mkf-name }} использует [схемы форматов данных](../concepts/managed-schema-registry.md) для описания форматов ввода и вывода данных. На основе схемы формата данных производитель формирует, а потребитель интерпретирует сообщения из топиков.

Такие схемы хранятся в реестре схем формата данных. Для {{ mkf-name }} вы можете:

* Использовать [интегрированный реестр](./managed-schema-registry.md).
* Использовать [интегрированный реестр](./managed-schema-registry-rest.md) с помощью REST API.
* Настроить и использовать [реестр от Confluent](./confluent-schema-registry.md).
