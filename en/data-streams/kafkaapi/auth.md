---
title: Authenticating and connecting to a database using the Kafka API
description: Follow this guide to authenticate and connect to a database using the Kafka API.
---

# Authenticating and connecting to a database using the Kafka API

## Endpoint {#endpoint}

The Kafka API endpoint is displayed in the [management console]({{ link-console-main }}) in the **Kafka API endpoint** field on the **Overview** tab on the data stream page.

The endpoint has the following format: `<FQDN_YDB>:PORT`. For example, `ydb-01.serverless.yandexcloud.net:9093`.

## Prerequisites {#requirements}

To authenticate, take these steps:

1. [Create a service account](../../iam/operations/sa/create).
1. [Assign roles to the service account](../../iam/operations/sa/assign-role-for-sa):
   * For reading from a data stream: `ydb.kafkaApi.client` and `ydb.viewer`.
   * For writing to a data stream: `ydb.kafkaApi.client` and `ydb.editor`.
1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md) with the `yc.ydb.topics.manage` scope.


## Authentication {#auth}

The Kafka API uses the [SASL_SSL/PLAIN](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#kafka-sasl-auth-plain) authentication mechanism.

The following parameters are required:

* `<database>`: Database path. The database path is displayed in the [management console]({{ link-console-main }}) after `database=` in the **Endpoint** field on the **Overview** tab.

    For example, in the `{{ ydb.ep-serverless }}/?database={{ ydb.path-serverless }}` endpoint, `{{ ydb.path-serverless }}` is the database path.

* `<api-key>`: [API key](../../iam/concepts/authorization/api-key).

Parameters used for authentication when reading and writing messages:

* `<sasl.username>` = `@<database>` (Note that you need to put `@` before the path to the database)
* `<sasl.password>` = `<api-key>`

## Example of writing and reading a message {#example}

The example uses the following parameters:

 * `<kafka-api-endpoint>`: [Endpoint](#endpoint).
 * `<stream-name>`: [Stream](../concepts/glossary.md#stream-concepts) name.

1. Install an SSL certificate if you are using a dedicated database:

   ```bash
    sudo mkdir -p /usr/local/share/ca-certificates/Yandex/ && \
    wget "{{ crt-web-path }}" \
     --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
    sudo chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
   ```

   The certificate will be saved to the `/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt` file.

1. Install the `kcat` utility, which is an open source app that can function as a universal data producer or consumer:

   ```bash
   sudo apt-get install kafkacat
   ```

1. Run this command to get messages from the stream:

    {% list tabs %}
    - Serverless database
      ```bash
      kcat -C \
        -b <kafka-api-endpoint> \
        -t <stream-name> \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanism=PLAIN \
        -X sasl.username="<sasl.username>" \
        -X sasl.password="<sasl.password>"
      ```
    - Dedicated database
      ```bash
      kcat -C \
        -b <kafka-api-endpoint> \
        -t <stream-name> \
        -X security.protocol=SASL_SSL \
        -X sasl.mechanism=PLAIN \
        -X sasl.username="<sasl.username>" \
        -X sasl.password="<sasl.password>" \
        -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
      ```
    {% endlist %}

    The command will continuously read new messages from the stream.

1. In a separate terminal, run this command to send a message to the stream:

    {% list tabs %}
    - Serverless database
      ```bash
      echo "test message" | kcat -P \
          -b <kafka-api-endpoint> \
          -t <stream-name> \
          -k key \
          -X security.protocol=SASL_SSL \
          -X sasl.mechanism=PLAIN \
          -X sasl.username="<sasl.username>" \
          -X sasl.password="<sasl.password>"
      ```
    - Dedicated database
      ```bash
      echo "test message" | kcat -P \
          -b <kafka-api-endpoint> \
          -t <stream-name> \
          -k key \
          -X security.protocol=SASL_SSL \
          -X sasl.mechanism=PLAIN \
          -X sasl.username="<sasl.username>" \
          -X sasl.password="<sasl.password>" \
          -X ssl.ca.location=/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
      ```
    {% endlist %}


For core information on how to work with {{ yds-name }} using the Kafka API, see the [YDB documentation]({{ ydb.docs }}/reference/kafka-api).
