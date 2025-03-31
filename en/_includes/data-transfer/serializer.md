* Under **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}**, select the [serialization](../../data-transfer/concepts/serializer.md) type:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}**: Automatic serialization.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}**: Serialization under the Debezium standards:

      * Select the message key schema (matches the `key.converter` Debezium parameter).
      * Select the message value schema (matches the `value.converter` Debezium parameter).
      * If required, specify [**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**](../../data-transfer/concepts/serializer.md#debezium) in `Parameter`-`Value` format.

If you want to use JSON schemas in {{ schema-registry-full-name }} and need to keep them compatible while adding optional parameters, specify these settings:

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_debezium.title }}**.
* To use {{ schema-registry-name }} for keys, select **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.key_converter_settings.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**. To use {{ schema-registry-name }} for values, select **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.value_converter_settings.title }}**: **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.converter_settings.json.title }}**.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.url.title }}**: {{ schema-registry-name }} namespace endpoint. You can copy the endpoint from the details for the {{ schema-registry-name }} namespace connection on the **Debezium** tab, in the `value.converter.schema.registry.url` parameter.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.username.title }}**: `api-key`.
  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}**: Value of the [API key](../../iam/concepts/authorization/api-key.md) with a limited scope used for connecting to {{ schema-registry-name }}. To get this value:
      1. Create an API key with a limited scope and place it in the `SECRET` local variable:

          ```bash
          yc iam api-key create --folder-id <folder_ID> \
            --service-account-name <name_of_service_account_for_operations_with_Schema_Registry> \
            --scope yc.schema-registry.schemas.manage \
            --expires-at '2030-01-01T00:00:00Z' >./api-key.yaml && \
          SECRET=`cat ./api-key.yaml | grep 'secret:' | awk '{print $2}'`
          ```

      1. Print the `SECRET` variable value to the terminal:

          ```bash
          echo $SECRET
          ```

      1. Copy the printed value and paste it into the **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.confluent_sr.password.title }}** field in the endpoint creation window.

* Under **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.Debezium.parameters.title }}**:
    * To generate a closed schema for keys, include the `key.converter.dt.json.generate.closed.content.schema` parameter set to `true`.
    * To generate a closed schema for values, include the `value.converter.dt.json.generate.closed.content.schema` parameter set to `true`.
