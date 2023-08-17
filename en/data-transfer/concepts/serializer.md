# Serialization

Serialization is the conversion of data objects to a bit sequence when transferring data to targets that work with <q>raw</q> data.

These targets include [{{ objstorage-name }}](#serializer-s3) and targets using [message queues](#serializer-message-queue):

* {{ KF }}
* {{ yds-full-name }}

You can set up serialization when [creating](../operations/endpoint/index.md#create) or [updating](../operations/endpoint/index.md#update) a target endpoint.

## {{ objstorage-name }} serialization {#serializer-s3}

For {{ objstorage-name }} serialization, you can select **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`, or `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}`. For `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, complex values can be converted to strings.

## Serialization at data delivery to message queues {#serializer-message-queue}

When delivering data to a message queue, you can use two types of serialization:

* [{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}](#auto)
* [{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}](#debezium)

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }} {#auto}

Automatic selection of serialization settings depending on the source type.

### {{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }} {#debezium}

[Debezium](https://debezium.io/) serialization with configurable parameters:

* **dt.add.original.type.info**: Determines whether to add information about the original types of data to restore the type after the transfer.

   This is with the exception of the `with time zone` {{ PG }} date and time data types, as you cannot restore information about the time zone.

   The default value is `false`.

* **dt.mysql.timezone**: Time zone for {{ MY }} date and time data types in [IANA](https://www.iana.org/time-zones) format.

   The default value is `UTC`.

* **dt.unknown.types.policy**: Policy that determines the behavior for handling user-defined data types.

   Possible values:

   * `skip`: Do not abort the transfer and ignore user-defined data types.
   * `to_string`: Do not abort the transfer and convert user-defined data types to text.
   * `fail`: Abort the transfer and return an error.

   The default value is `skip`.

* **decimal.handling.mode**: Mode for handling real numbers.

   Possible values:

   * `precise`: Precise conversion using the `java.math.BigDecimal` method.
   * `double`: Conversion to the `double` data type. This may result in precision loss.
   * `string`: Conversion to text.

   The default value is `precise`.

* **interval.handling.mode**: Mode for handling time intervals.

   Possible values:

   * `numeric`: Approximate conversion to microseconds.
   * `string`: Precise conversion based on a string template like `P<years>Y<months>M<days>DT<hours>H<minutes>M<seconds>S`.

   The default value is `numeric`.

* **key.converter** and **value.converter**: Key and value converters.

   Possible values:

   * `org.apache.kafka.connect.json.JsonConverter`: JSON, standard for [Debezium](https://debezium.io/documentation/reference/index.html).
   * `io.confluent.connect.json.JsonSchemaConverter`: [Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html).

   The default value is `org.apache.kafka.connect.json.JsonConverter`.

* **key.converter.schemas.enable** and **value.converter.schemas.enable**: Determine whether to add a schema description to each message for keys and values when using `org.apache.kafka.connect.json.JsonConverter`.

   The default value is `true`.

* **key.converter.schema.registry.url** and **value.converter.schema.registry.url**: Determine whether to add a schema description to each message for keys and values when using `io.confluent.connect.json.JsonSchemaConverter`.

   The default value is `true`.

* **key.converter.basic.auth.user.info** and **value.converter.basic.auth.user.info**: Username and password for authorization in the Confluent Schema Registry for keys and values when using `io.confluent.connect.json.JsonSchemaConverter`.

   Value format: `<username>:<password>`.

* **key.converter.ssl.ca** and **value.converter.ssl.ca**: Contents of the Confluent Schema Registry's SSL certificate for keys and values when using `io.confluent.connect.json.JsonSchemaConverter`.

   If the setting value is not specified, the SSL certificate does not get verified.

* **unavailable.value.placeholder**: Value that replaces data if its type is not supported.

   The default value is `__debezium_unavailable_value`.
