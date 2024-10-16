# Authenticating and connecting to a database using the Kafka API

## Endpoint {#endpoint}

The Kafka API endpoint is displayed in the [management console]({{ link-console-main }}) on the data stream page under the **Overview** tab in the **Kafka API endpoint** field.

The endpoint has the following format: `<FQDN_YDB>:PORT`. For example, `ydb-01.serverless.yandexcloud.net:9093`.

## Prerequisites {#requirements}

To authenticate, take these steps:

1. [Create a service account](../../iam/operations/sa/create).
1. [Assign roles to the service account](../../iam/operations/sa/assign-role-for-sa):
   * For reading from a data stream: `ydb.kafkaApi.client` and `ydb.viewer`.
   * For writing to a data stream: `ydb.kafkaApi.client` and `ydb.editor`.
1. [Create an API key](../../iam/operations/api-key/create).


## Authentication {#auth}

The Kafka API uses the [SASL_SSL/PLAIN](https://docs.confluent.io/platform/current/kafka/authentication_sasl/authentication_sasl_plain.html#kafka-sasl-auth-plain) authentication mechanism.

The following parameters are required:

* `<database>`: Database path. To view the database path, in the [management console]({{ link-console-main }}), go to the data stream page and open the **Overview** tab. The path is specified in the **Endpoint** field after `database=`.

   For example, in the `{{ ydb.ep-serverless }}/?database={{ ydb.path-serverless }}` endpoint, `{{ ydb.path-serverless }}` is the database path.

* `<api-key>`: [API key](../../iam/concepts/authorization/api-key).

Parameters used for authentication when reading and writing messages:

* `<sasl.username>` = `@<database>`
* `<sasl.password>` = `<api-key>`

## Example of writing and reading a message {#example}

The example uses the following parameters:

* `<kafka-api-endpoint>`: [Endpoint](#endpoint)
* `<stream-name>`: [Data stream](../concepts/glossary.md#stream-concepts) name

1. Install an SSL certificate:

   ```bash
    mkdir -p /usr/local/share/ca-certificates/Yandex/ && \
    wget "https://crls.yandex.net/YandexInternalRootCA.crt" \
     --output-document /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt && \
    chmod 0655 /usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt
   ```

   The certificate will be saved to the `/usr/local/share/ca-certificates/Yandex/YandexInternalRootCA.crt` file.

1. Install `kcat`, an open source utility that can function as a generic data producer or consumer:

   ```bash
   sudo apt-get install kafkacat
   ```

1. Run this command to get messages from the stream:

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

   The command will continuously read new messages from the stream.

1. In a separate terminal, run this command to send a message to the stream:

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

For core information on how to work with {{ yds-name }} using the Kafka API, see the [YDB documentation](https://ydb.tech/docs/en/reference/kafka-api).
