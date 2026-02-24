* Under **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}**, select the [serialization](../../data-transfer/concepts/serializer.md) type:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}**: Automatic serialization.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}**: Serialization under the Debezium standards:
  
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_yandex_schema_registry_debezium.title }}**:

      * Select a message schema (data format).
      * From the list, select the [namespace](../../metadata-hub/operations/list-name-space.md) of the {{ schema-registry-full-name }} schema registry.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_on_premise_debezium.title }}**:

      * Select the message key schema (matches the `key.converter` Debezium parameter). The default value matches the `key.converter.schemas.enable=true` and `key.converter=org.apache.kafka.connect.json.JsonConverter` Debezium parameters. If you select **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.disabled.title }}**, the `key.converter.schemas.enable` Debezium parameter takes the `false` value.
      * Select the message value schema (matches the `value.converter` Debezium parameter). The default value matches the `value.converter.schemas.enable=true` and `value.converter=org.apache.kafka.connect.json.JsonConverter` Debezium parameters. If you select **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.disabled.title }}**, the `value.converter.schemas.enable` Debezium parameter takes the `false` value.
      * When selecting the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.avro.title }}**, **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**, or **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.protobuf.title }}** value, specify the parameters for access to Confluent Schema Registry for message key and value schemas:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}**: URL.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}**. This is an optional setting.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}**. This is an optional setting.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.ca_cert.title }}**: Upload the SSL certificate for the connection. This is an optional setting. To skip the certificate check, do not provide one.

    * If required, specify [**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**](../../data-transfer/concepts/serializer.md#debezium) in `Parameter`-`Value` format.

If you want to use JSON schemas in {{ schema-registry-full-name }} and preserve their [compatibility when adding and deleting optional fields](../../metadata-hub/concepts/schema-registry-content-model.md#optional-parameters-compatibility-solution), use these settings:

**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_on_premise_debezium.title }}**.

* To use {{ schema-registry-name }} for keys, select **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.key_converter_settings.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. To use {{ schema-registry-name }} for values, select **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.value_converter_settings.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. Set the parameters for access to Schema Registry:
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}**: `https://<namespace_ID>.{{ schema-registry-endpoint }}`.

      {% note warning %}

      The namespace must have **Compatibility check policy for JSON** [set](../../metadata-hub/operations/update-name-space.md) to `optional friendly`.

      {% endnote %}

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}**: `api-key`.

  
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}**: Value of the [API key](../../iam/concepts/authorization/api-key.md) with a limited scope used for connecting to {{ schema-registry-name }}. To get this value:
      1. Create an API key with a limited scope and place it in the `SECRET` local variable:

          ```bash
          yc iam api-key create --folder-id <folder_ID> \
            --service-account-name <name_of_service_account_for_operations_with_Schema_Registry> \
            --scopes yc.schema-registry.schemas.manage \
            --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
          SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
          ```

      1. Print the `SECRET` variable value to the terminal:

          ```bash
          echo $SECRET
          ```


* Under **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**:
    * To generate a closed schema for keys, include the `key.converter.dt.json.generate.closed.content.schema` parameter set to `true`.
    * To generate a closed schema for values, include the `value.converter.dt.json.generate.closed.content.schema` parameter set to `true`.
