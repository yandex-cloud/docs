# Аутентификация и соединение с БД по Kafka API
## Эндпоинт
Эндпоинт для доступа по Kafka API отображаются на вкладке Обзор на странице потока данных в [консоли управления]({{ link-console-main }}).

## Предварительные требования

Для аутентификации требуется предварительно: 
1. [Создать сервисный аккаунт](../../iam/operations/sa/create).
1. [Назначить сервисному акканту роли](../../iam/operations/sa/assign-role-for-sa):
   - для чтения из топика `ydb.kafkaApi.client` и `ydb.viewer`.
   - для записи в топик `ydb.kafkaApi.client` и `ydb.editor`.
1. [Создать API-ключ](../../iam/operations/api-key/create).


## Аутентификация
В Kafka API аутентификация выполняется через механизм `SASL_SSL/PLAIN`.

Для этого необходимы:
* `<database>` — путь базы данных. Путь базы данных отображается на вкладке Обзор на странице потока данных в [консоли управления]({{ link-console-main }}).
* `<api-key>` — [API-ключ](../../iam/concepts/authorization/api-key).

Из этих параметров формируются:
* `<sasl.username>` = `@<database>`
* `<sasl.password>` = `<api-key>`

Которые позже используются для аутентификации.

## Пример записи в топик

{% list tabs %}

- kcat
  ```ini
  echo "test message" | kcat -P \
    -b <ydb-endpoint> \
    -t <topic-name> \
    -k key \
    -X security.protocol=SASL_SSL \
    -X sasl.mechanism=PLAIN \
    -X sasl.username="<sasl.username>" \
    -X sasl.password="<sasl.password>" \
  ```
{% endlist %}

Основную документацию по работе с Data Streams через Kafka API и больше примеров см. в [документации YDB](https://ydb.tech/ru/docs/reference/kafka-api).
