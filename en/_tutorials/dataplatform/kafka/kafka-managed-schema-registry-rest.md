In {{ mkf-name }} clusters, you can work with [{{ mkf-msr }}](../../../managed-kafka/concepts/managed-schema-registry.md#msr) either [using {{ KF }} clients](../../../managed-kafka/tutorials/managed-schema-registry.md) for various programming languages or the [REST API](../../../managed-kafka/concepts/available-apis.md#managed-kafka-api).

{{ mkf-name }} also provides the [REST API for {{ KF }}](../../../managed-kafka/concepts/available-apis.md#managed-kafka-api). Among other things, this API allows you to send and receive messages without using third-party producers and consumers. These features will also be demonstrated in this tutorial.

To get to know the REST API for {{ mkf-msr }} and {{ KF }}:

1. [Create data format schemas](#create-schemas).
1. [Send messages to a topic](#send-messages).
1. [Get messages from a topic](#receive-messages).
1. [Delete the resources you created](#clear-out).

## Getting started {#before-you-begin}

### Prepare the infrastructure {#deploy-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mkf-name }}](../../../managed-kafka/operations/cluster-create.md) cluster with any suitable configuration.

        When creating a cluster, enable the following options:

        * **{{ ui-key.yacloud.kafka.field_schema-registry }}**.

            The cluster will deploy a {{ mkf-msr }} schema registry, and the REST API for {{ mkf-msr }} will become available.

        * **{{ ui-key.yacloud.kafka.field_rest-api-config }}**.

            The REST API for {{ KF }} will become available in the cluster.

        * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

            Broker hosts will become available from the internet.

    1. [Create a topic](../../../managed-kafka/operations/cluster-topics.md#create-topic) named `messages` for exchanging messages between the producer and the consumer.

    1. [Create a user](../../../managed-kafka/operations/cluster-accounts.md#create-account) named `user1` and [grant them permissions](../../../managed-kafka/operations/cluster-accounts.md#grant-permission) for the `messages` topic:

        * `ACCESS_ROLE_CONSUMER`
        * `ACCESS_ROLE_PRODUCER`

        This user will be able to send and receive messages within the topic, as well as [perform any operations on subjects in {{ mkf-msr }}](../../../managed-kafka/concepts/managed-schema-registry.md#msr-auth) that are associated with the topic.

    1. [Complete all pre-configuration steps to connect to the cluster](../../../managed-kafka/operations/connect/index.md).

{% endlist %}

### Install utilities {#install-utilities}

1. Install [cURL](https://curl.se/):

    ```bash
    sudo apt install curl -y
    ```

    It will be used to make requests to the API.

    For convenience, this tutorial will use the [--user](https://curl.se/docs/manpage.html#-u) cURL option when making requests to the API. If this option is used, cURL will automatically add to the request the [Authorization](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization) HTTP header with the value required for [authorization](../../../managed-kafka/concepts/available-apis.md#managed-kafka-api-usage).

    {% note tip %}

    You can build the `Authorization` header yourself, e.g., if not using cURL.

    {% endnote %}

1. Install the [jq](https://github.com/jqlang/jq) utility:

    ```bash
    sudo apt install jq -y
    ```

    You can use it to convert schema descriptions to the required format.

    When using the REST API for {{ mkf-msr }}, you need to provide schema descriptions as an escaped character string, e.g.:

    ```json
    "schema": "{\"type\": \"record\", \"name\": \"Obj\", \"fields\":[...]}"
    ```

    For convenience, in this tutorial, schemas are presented as JSON documents with indentations and line breaks; and when making requests to the API, schemas are converted to the required format using `jq`.

    {% note tip %}

    After you request the REST API using cURL, you get the server response as a single JSON string.

    You can additionally process the output of the commands featured in this tutorial with the help of `jq` to make the server's response more readable.

    {% endnote %}

## Create data format schemas {#create-schemas}

{% note info %}

This tutorial uses the [Avro](https://avro.apache.org/docs/1.12.0/specification/) type schemas.

You can use other types of schemas supported in {{ mkf-msr }}.

{% endnote %}

Let's assume an {{ KF }} message in the `messages` topic must consist of a key and a value in the following format:

#|
|| **Key** | **Value** ||
||

```json
{
  "id": <int>,
  "sid": "<string>"
}
```

|

```json
{
  "name": "<string>",
  "city": "<string>",
  "age": <int>
}
```

||
|#

Create the relevant data format schemas:

1. Create a file named `schema-key.json` containing the data format schema for the {{ KF }} message key.

    {% cut "schema-key.json" %}

    ```json
    {
      "type": "record",
      "name": "my_key",
      "fields": [
        {
          "name": "id",
          "type": "int"
        },
        {
          "name": "sid",
          "type": "string"
        }
      ]
    }
    ```

    {% endcut %}

1. Create a data format schema for the {{ KF }} message key.

    The [subject name for the schema](../../../managed-kafka/concepts/managed-schema-registry#subjects) must consist of the name of the topic the schema will be used in (`messages`) and the `-key` suffix.

    Use the [POST /subjects/(subject)/versions](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/schema-registry/develop/api.html#post--subjects-(string-%20subject)-versions) REST API method for {{ mkf-msr }} and send the following request:

    ```bash
    jq \
        -n --slurpfile data schema-key.json \
        '{
           "schemaType": "AVRO",
           "schema": "\($data)"
        }' \
    | curl \
          --request POST \
          --url 'https://<broker_host_FQDN>:{{ port-https }}/subjects/messages-key/versions' \
          --user user1:<user_password> \
          --header 'Content-Type: application/vnd.schemaregistry.v1+json' \
          --data "@-"
    ```

    The response to the request will return the new schema ID, e.g., `{"id":1}`.

1. Create a `schema-value.json` file containing the data format schema for the {{ KF }} message value.

    {% cut "schema-value.json" %}

    ```json
    {
      "type": "record",
      "name": "my_value",
      "fields": [
        {
          "name": "name",
          "type": "string"
        },
        {
          "name": "city",
          "type": "string"
        },
        {
          "name": "age",
          "type": "int"
        }
      ]
    }
    ```

    {% endcut %}

1. Create a data format schema for the {{ KF }} message value.

    The [subject name for the schema](../../../managed-kafka/concepts/managed-schema-registry#subjects) must consist of the name of the topic the schema will be used in (`messages`) and the `-value` suffix.

    Use the [POST /subjects/(subject)/versions](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/schema-registry/develop/api.html#post--subjects-(string-%20subject)-versions) REST API method for {{ mkf-msr }} and send the following request:

    ```bash
    jq \
        -n --slurpfile data schema-value.json \
        '{
           "schemaType": "AVRO",
           "schema": "\($data)"
        }' \
    | curl \
          --request POST \
          --url 'https://<broker_host_FQDN>:{{ port-https }}/subjects/messages-value/versions' \
          --user user1:<user_password> \
          --header 'Content-Type: application/vnd.schemaregistry.v1+json' \
          --data "@-"
    ```

    The response to the request will return the new schema ID, e.g., `{"id":2}`.

## Send messages to a topic {#send-messages}

1. Get the data format schema IDs for the key and the value.

    Use the `GET /schemas` REST API method for {{ mkf-msr }} and send the following request:

    ```bash
    curl \
        --request GET \
        --url 'https://<broker_host_FQDN>:{{ port-https }}/schemas' \
        --user user1:<user_password> \
        --header 'Accept: application/vnd.schemaregistry.v1+json'
    ```

    The response to the request contains data format schema IDs (`id`). These IDs will be used later.

    {% cut "Example of response to query" %}

     For brevity, the data format schema named `schema` in the form of JSON strings is not provided.

    ```json
    [
      {
        "id": 1,
        "schema": "<data_format_schema>",
        "schemaType": "AVRO",
        "subject": "messages-key",
        "version": 1
      },
      {
        "id": 2,
        "schema": "<data_format_schema>",
        "schemaType": "AVRO",
        "subject": "messages-value",
        "version": 1
      }
    ]
    ```

    {% endcut %}

1. Create a file named `message-list.json` containing two messages. For each message, the key and the value are specified according to the data format schemas created earlier.

    {% cut "message-list.json" %}

    ```json
    [
      {
        "key": {
          "id": 1111,
          "sid": "AAAAA-BBBBB-CCCCC"
        },
        "value": {
          "name": "Anna",
          "city": "Moscow",
          "age": 44
        }
      },
      {
        "key": {
          "id": 2222,
          "sid": "DDDDD-EEEEE-FFFFF"
        },
        "value": {
          "name": "Alex",
          "city": "London",
          "age": 32
        }
      }
    ]
    ```

    {% endcut %}

1. Send messages to the `messages` topic.

    Use the [POST /topics/(topic)](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#post--topics-(string-topic_name)) REST API method for {{ KF }} and send the following request:

    ```bash
    jq \
        -n --slurpfile data message-list.json \
        '{
          "key_schema_id": <messages-key_schema_ID>,
          "value_schema_id": <messages-value_schema_ID>,
          "records": $data.[]
        }' \
    | curl \
          --request POST \
          --url 'https://<broker_host_FQDN>:{{ port-https }}/topics/messages' \
          --user user1:<user_password> \
          --header 'Content-Type: application/vnd.kafka.avro.v2+json' \
          --header 'Accept: application/vnd.kafka.v2+json' \
          --data "@-"
    ```

    The schema ID values ​​were obtained earlier by requesting the `GET /schemas` endpoint.

    {% cut "Example of response to query" %}

    ```json
    {
      "key_schema_id": 1,
      "offsets": [
        {
          "offset": 0,
          "partition": 0
        },
        {
          "offset": 0,
          "partition": 1
        }
      ],
      "value_schema_id": 2
    }
    ```

    {% endcut %}

## Get messages from a topic {#receive-messages}

1. Create a consumer named `my-consumer` in the consumer group named `my-group`.

    Use the [POST /consumers/(group)](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#post--consumers-(string-group_name)) REST API method for {{ KF }} and send the following request:

    ```bash
    curl \
        --request POST \
        --url 'https://<broker_host_FQDN>:{{ port-https }}/consumers/my-group' \
        --user user1:<user_password> \
        --header 'Content-Type: application/vnd.kafka.v2+json' \
        --header 'Accept: application/vnd.kafka.v2+json' \
        --data '{
                  "name": "my-consumer",
                  "format": "avro",
                  "auto.offset.reset": "earliest"
                }'
    ```

    {% cut "Example of response to query" %}

    ```json
    {
      "base_uri": "https://<broker_host_FQDN>:{{ port-https }}/consumers/my-group/instances/my-consumer",
      "instance_id": "my-consumer"
    }
    ```

    {% endcut %}

1. Subscribe to the `messages` topic for the consumer named `my-consumer` from the consumer group named `my-group`.

    Use the [POST /consumers/(group)/instances/(instance)/subscription](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#post--consumers-(string-group_name)-instances-(string-instance)-subscription) REST API method for {{ KF }} and send the following request:

    ```bash
    curl \
        --request POST \
        --url 'https://<broker_host_FQDN>:{{ port-https }}/consumers/my-group/instances/my-consumer/subscription' \
        --user user1:<user_password> \
        --header 'Content-Type: application/vnd.kafka.v2+json' \
        --header 'Accept: application/vnd.kafka.v2+json' \
        --data '{"topics": ["messages"]}'
    ```

    The API server does not return a response to this request, only an HTTP status.

1. Get all messages from the `messages` topic for the consumer named `my-consumer` from the consumer group named `my-group`.

    Use the [GET /consumers/(group)/instances/(instance)/records](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#get--consumers-(string-group_name)-instances-(string-instance)-records) REST API method for {{ KF }} and send the following request:

    ```bash
    curl \
        --request GET \
        --url 'https://<broker_host_FQDN>:{{ port-https }}/consumers/my-group/instances/my-consumer/records' \
        --user user1:<user_password> \
        --header 'Accept: application/vnd.kafka.avro.v2+json'
    ```

    If the response to the request contains messages that were sent earlier, this means the producer and consumer are successfully interpreting the messages in accordance with the specified data format schemas.

    {% cut "Example of response to query" %}

    ```json
    [
      {
        "key": {
          "id": 2222,
          "sid": "DDDDD-EEEEE-FFFFF"
        },
        "offset": 0,
        "partition": 1,
        "timestamp": 1726031054186,
        "topic": "messages",
        "value": {
          "age": 32,
          "city": "London",
          "name": "Alex"
        }
      },
      {
        "key": {
          "id": 1111,
          "sid": "AAAAA-BBBBB-CCCCC"
        },
        "offset": 0,
        "partition": 0,
        "timestamp": 1726031054186,
        "topic": "messages",
        "value": {
          "age": 44,
          "city": "Moscow",
          "name": "Anna"
        }
      }
    ]
    ```

    {% endcut %}

## Delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete the {{ mkf-name }}](../../../managed-kafka/operations/cluster-delete.md) cluster.
* If you reserved public static IP addresses, release and [delete them](../../../vpc/operations/address-delete.md).
