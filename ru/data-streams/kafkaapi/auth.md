# Аутентификация и соединение с БД по Kafka API

## Эндпоинт {#endpoint}

Эндпоинт Kafka API отображается в [консоли управления]({{ link-console-main }}), на странице потока данных, на вкладке **Обзор**, в поле **Kafka API эндпоинт**.

Эндпоинт имеет следующий вид: `<FQDN_YDB>:PORT`. Например, `ydb-01.serverless.yandexcloud.net:9093`.

## Предварительные требования {#requirements}

Для аутентификации требуется:

1. [Создать сервисный аккаунт](../../iam/operations/sa/create).
1. [Назначить сервисному аккаунту роли](../../iam/operations/sa/assign-role-for-sa):
   * Для чтения из потока данных: `ydb.kafkaApi.client` и `ydb.viewer`.
   * Для записи в поток данных: `ydb.kafkaApi.client` и `ydb.editor`.
1. [Создать API-ключ](../../iam/operations/api-key/create).


## Аутентификация {#auth}

В Kafka API аутентификация выполняется через механизм [SASL_SSL/PLAIN](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#kafka-sasl-auth-plain).

Для этого необходимы:

* `<database>` — путь базы данных. Путь базы данных отображается в [консоли управления]({{ link-console-main }}), на странице потока данных, на вкладке **Обзор**, в поле **Эндпоинт** после `database=`.

    Например, если эндпоинт — `{{ ydb.ep-serverless }}/?database={{ ydb.path-serverless }}`, то путь базы данных — `{{ ydb.path-serverless }}`.

* `<api-key>` — [API-ключ](../../iam/concepts/authorization/api-key).

Эти параметры будут использоваться для аутентификации при чтении и записи сообщений:

* `<sasl.username>` = `@<database>`
* `<sasl.password>` = `<api-key>`

## Пример записи и чтения сообщения {#example}
В примере используются:
 * `<kafka-api-endpoint>` — [эндпоинт](#endpoint).
 * `<stream-name>` — имя [потока данных](../concepts/glossary.md#stream-concepts).

1. Установите SSL-сертификат:
   ```bash
    mkdir -p /usr/local/share/ca-certificates/Yandex/ && \
    wget "https://crls.yandex.net/YandexInternalRootCA.crt" \
     --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
    chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
   ```
   Сертификат будет сохранен в файле `/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt`.

1. Установите `kcat` — приложение с открытым исходным кодом, которое может работать как универсальный производитель или потребитель данных:

   ```bash
   sudo apt-get install kafkacat
   ```

1. Запустите команду получения сообщений из потока:

    ```ini
    kcat -C \
        -b <kafka-api-endpoint> \
        -t <stream-name> \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanism=PLAIN \
        -X sasl.username="<sasl.username>" \
        -X sasl.password="<sasl.password>" \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z
    ```

    Команда будет непрерывно считывать новые сообщения из потока.

1. В отдельном терминале запустите команду отправки сообщения в поток:

    ```ini
    echo "test message" | kcat -P \
        -b <kafka-api-endpoint> \
        -t <stream-name> \
        -k key \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanism=PLAIN \
        -X sasl.username="<sasl.username>" \
        -X sasl.password="<sasl.password>" \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt -Z
    ```

Основную документацию по работе с {{ yds-name }} через Kafka API и больше примеров см. в [документации YDB](https://ydb.tech/docs/ru/reference/kafka-api).
