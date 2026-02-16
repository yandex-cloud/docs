---
title: Authentication and database connection using the Kafka API
description: In this tutorial, you will learn how to authenticate and establish a database connection using the Kafka API.
---

# Authentication and database connection using the Kafka API

## Endpoint {#endpoint}

The Kafka API endpoint appears in the [management console]({{ link-console-main }}) under: **Data Streams** → [Your Stream] → **Overview** → **Kafka API endpoint**.

The endpoint has the following format: `<FQDN_YDB>:PORT`. For example, `ydb-01.serverless.yandexcloud.net:9093`.

## Prerequisites {#requirements}

To authenticate, take these steps:

1. [Create a service account](../../iam/operations/sa/create).
1. [Assign the following roles to the service account](../../iam/operations/sa/assign-role-for-sa):
   * `ydb.kafkaApi.client` and `ydb.viewer`: for reading from a data stream.
   * `ydb.kafkaApi.client` and `ydb.editor`: for writing to a data stream.
1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md) with the `yc.ydb.topics.manage` scope.


## Authentication {#auth}

The Kafka API uses the [SASL_SSL/PLAIN](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#kafka-sasl-auth-plain) authentication mechanism.

The following parameters are required:

* `<database>`: Database path. The database path appears in the [management console]({{ link-console-main }}) under: **Data Streams** → [Your Stream] → **Overview** → **Endpoint** (a substring following `database=`).

    For example, if the **Endpoint** field contains `{{ ydb.ep-serverless }}/?database={{ ydb.path-serverless }}`, the database path is `{{ ydb.path-serverless }}`.

* `<api-key>`: [API key](../../iam/concepts/authorization/api-key).

These parameters will be used for authentication when reading and writing messages:

* `<sasl.username>` = `@<database>` (Note that the database path must be prefixed with the `@` symbol)
* `<sasl.password>` = `<api-key>`

## Example of writing and reading a message {#example}

This example uses the following parameters:

 * `<kafka-api-endpoint>`: [Endpoint](#endpoint).
 * `<stream-name>`: [Data stream](../concepts/glossary.md#stream-concepts) name.

1. If you are using a dedicated database, you need to Install an SSL certificate:

   ```bash
    sudo mkdir -p /usr/local/share/ca-certificates/Yandex/ && \
    wget "{{ crt-web-path }}" \
     --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
    sudo chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
   ```

   The certificate will be saved to the `/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt` file.

1. Install `kcat`, an open-source tool for producing and consuming data:

   ```bash
   sudo apt-get install kafkacat
   ```

1. Run the following command to get messages from the stream:

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

    This command will continuously read new messages from the stream.

1. In a separate terminal, run the following command to send a message to the stream:

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


For details on working with {{ yds-name }} via the Kafka API and more examples, refer to the [YDB documentation]({{ ydb.docs }}/reference/kafka-api).
