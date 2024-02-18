# Kafka API
Yandex Data Streams в ограниченном режиме поддерживает работу с потоками данных по протоколу [Apache Kafka®](https://kafka.apache.org/). 
Эндпоинт для доступа по Kafka API отображаются на вкладке Обзор на странице потока данных в [консоли управления]({{ link-console-main }}).

Для аутентификации требуется [создать API-ключ](../../iam/operations/api-key/create).
[Сервисному аккаунту](../../iam/concepts/users/service-accounts) необходимо [назначить роли](../../iam/operations/sa/assign-role-for-sa):
 - ydb.editor
 - ydb.viewer
 - ydb.kafkaApi.client

Аутентификация выполняется через механизмы `SASL_PLAINTEXT/PLAIN` или `SASL_SSL/PLAIN`.
В качестве имени пользователя используется путь базы данных в формате `@<db-path>`.
В качестве пароля используется секретный ключ, полученный при создании API-ключа.

Основную документацию по работе с Data Streams через Kafka API и примеры см. в [документации YDB](https://ydb.tech/ru/docs/reference/kafka-api).
