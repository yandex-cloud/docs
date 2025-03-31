---
title: Serialization in {{ data-transfer-full-name }}
description: In this article, you will learn what serialization is and what types of serialization you can use depending on delivery.
---

# Serialization

Serialization is the conversion of data objects to a bit sequence when transferring data to targets that work with <q>raw</q> data. These targets include:

* [{{ objstorage-name }}](#serializer-s3)
* [{{ KF }}, and {{ yds-full-name }} message queues](#serializer-message-queue)

You can set up serialization when [creating](../operations/endpoint/index.md#create) or [updating](../operations/endpoint/index.md#update) a target endpoint.

## Serialization on delivery to {{ objstorage-name }} {#serializer-s3}

When delivering to {{ objstorage-name }}, you can select **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`, `PARQUET`, or `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}`. For `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, the **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.any_as_string.title }}** setting is available.

The output data format depends both on the **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** setting selection and the type and settings of source endpoint conversion rules.

See below how output data differs if no conversion rules are set for the source endpoint.

{% note info %}

There are no examples for `PARQUET` output data, since this format is binary.

{% endnote %}

### {{ yds-full-name }} {#yds}

Input data: Two messages:

```text
Text string
{"device_id":"iv9,"speed":"5"}
```

Output data:

{% list tabs %}

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}

    ```text
    <stream_name>,<segment_key>,<message_sequence_number>,<data_recording_date_and_time>,Text string
    <stream_name>,<segment_key>,<message_sequence_number>,<data_recording_date_and_time>,"{""device_id"":""iv9"",""speed"":5}"
    ```

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}

    ```text
    {"data":"Text string","partition":<segment_key>,"seq_no":<message_sequence_number>,"topic":"<stream_name>","write_time":"<data_recording_date_and_time>"}
    {"data":"{\"device_id\":\"iv9\",\"speed\":5}","partition":<segment_key>,"seq_no":<message_sequence_number>,"topic":"<stream_name>","write_time":"<data_recording_date_and_time>"}
    ```

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}

    ```text
    Text string
    {"device_id":"iv9,"speed":"5"}
    ```

{% endlist %}

### {{ mpg-name }} {#pg}

Input data: Table:

| device_id | speed |
| --------- | ----- |
| iv9       | 5     |
| rhi       | 10    |

Output data:

{% list tabs %}

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}

    ```text
    {"device_id":"iv9","speed":5}
    {"device_id":"rhi","speed":10}
    ```

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}

    ```text
    iv9,5,
    rhi,10,
    ````

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}

    This is not supported.

{% endlist %}

## Serialization at data delivery to message queues {#serializer-message-queue}

When delivering data to a message queue, you can use two types of serialization:

* [{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}](#auto)
* [{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}](#debezium)

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }} {#auto}

Automatic selection of serialization settings depending on the source type.

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }} {#debezium}

[Debezium](https://debezium.io/) serialization with configurable parameters:

* **dt.add.original.type.info**: Determines whether to add information about the original types of data to restore the type after the transfer.

    Exception: {{ PG }} `with time zone` date and time data types. Time zone information cannot be restored.

    The default value is `false`.

* **dt.batching.max.size**: Maximum message size in bytes.

    The default value is `0` bytes (batching is disabled). The recommended value is `1048576` bytes (1 MB). A non-empty value enables batching.

    The setting is relevant if you use JSON serialization with {{ schema-registry-name }} (see the **key.converter** and **value.converter** parameters). If using {{ schema-registry-name }}, the enqueued messages may become very small. In such a case, batching increases the throughput of queues.

    When batching is enabled, a single queue message will comprise a sequence of logical messages in [Confluent wire format](https://docs.confluent.io/cloud/current/sr/fundamentals/serdes-develop/index.html#wire-format). Data serialized in this way can be easily decoded.

    When batching is enabled, messages are aggregated in a buffer. If a new message leads to exceeding the `dt.batching.max.size` value, the current buffer is retained and the new message is added to an empty buffer. If one logical message from the source exceeds the `dt.batching.max.size` value, a batch consisting of this single message will be created. Batching takes place before compression in the queue client.

    Enabling batching can be useful to optimize heavy delivery to a queue where messages are read by a transfer.

    {% note warning %}

    Only a transfer can decode batched messages.

    {% endnote %}

* **dt.mysql.timezone**: Time zone for {{ MY }} date and time data types in [IANA](https://www.iana.org/time-zones) format.

    The default value is `UTC`.

* **dt.unknown.types.policy**: Policy that determines the behavior for handling user-defined data types.

    The possible values are as follows:

    * `skip`: Do not abort the transfer and ignore user-defined data types.
    * `to_string`: Do not abort the transfer and convert user-defined data types to text.
    * `fail`: Abort the transfer and return an error.

    The default value is `skip`.

* **decimal.handling.mode**: Mode for handling real numbers.

    The possible values are as follows:

    * `precise`: Precise conversion using the `java.math.BigDecimal` method.
    * `double`: Conversion to a `double` data type. This may result in precision loss.
    * `string`: Conversion to text.

    The default value is `precise`.

* **interval.handling.mode**: Mode for handling time intervals.

    The possible values are as follows:

    * `numeric`: Approximate conversion to microseconds.
    * `string`: Precise conversion based on the string template: `P<years>Y<months>M<days>DT<hours>H<minutes>M<seconds>S`.

    The default value is `numeric`.

* **key.converter** and **value.converter**: Key and value converters.

    The possible values are as follows:

    * `org.apache.kafka.connect.json.JsonConverter`: JSON, standard for [Debezium](https://debezium.io/documentation/reference/index.html).
    * `io.confluent.connect.json.JsonSchemaConverter`: [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html).

    The default value is `org.apache.kafka.connect.json.JsonConverter`.

* **key.converter.schemas.enable** and **value.converter.schemas.enable**: Whether to add a schema description to each message for keys and values when using `org.apache.kafka.connect.json.JsonConverter`.

    The default value is `true`.

* **key.converter.schema.registry.url** and **value.converter.schema.registry.url**: Whether to add a schema description to each message for keys and values when using `io.confluent.connect.json.JsonSchemaConverter`.

    The possible values are as follows: 

    * Empty string (default): Do not add a schema description.
    * URL string value defining the path to the schema registry service. 

* **key.converter.dt.json.generate.closed.content.schema** and **value.converter.dt.json.generate.closed.content.schema**: Determine whether to use the closed content model to generate the data producer schema for the key and value. This enables performing compatibility checks by converting the consumer open model to the closed one and searching for a similar schema among those registered for the producer. 

    The default value is `true` if the appropriate **key.converter.schema.schema.registry.url** and **value.converter.schema.registry.url** settings are enabled.

    If you select the `Optional-friendly` compatibility check policy in the {{ schema-registry-name }} namespace and enable the following setting:

    * **key.converter.dt.json.generate.closed.content.schema**: Adding or removing optional fields in the key schema will not violate full transitive schema compatibility.
    * **value.converter.dt.json.generate.closed.content.schema**: Adding or removing optional fields in the value schema will not violate full transitive schema compatibility.

* **key.converter.basic.auth.user.info** and **value.converter.basic.auth.user.info**: Username and password for authorization in Confluent Schema Registry for keys and values when using `io.confluent.connect.json.JsonSchemaConverter`.

    Value format: `<username>:<password>`.

* **key.converter.ssl.ca** and **value.converter.ssl.ca**: Contents of Confluent Schema Registry's SSL certificate for keys and values when using `io.confluent.connect.json.JsonSchemaConverter`.

    If the setting value is not specified, the SSL certificate does not get verified.

* **unavailable.value.placeholder**: Value that replaces data if its type is not supported.

    The default value is `__debezium_unavailable_value`.
