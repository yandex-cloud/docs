Under `serializer`, specify the selected [serialization](../../../data-transfer/concepts/serializer.md) type:

* `serializerAuto`
* `serializerJson`
* `serializerDebezium`

    For this type, you can specify the [Debezium serialization](../../../data-transfer/concepts/serializer.md#debezium) parameters as `key`/`value` pairs in the `serializerDebezium.serializerParameters` field.

If you want to use JSON schemas in {{ schema-registry-full-name }} and need to keep them compatible while adding optional parameters, add the `serializer` object with a description of the serialization settings to the request body. To generate a closed schema for keys, add the `key.converter.dt.json.generate.closed.content.schema` variable set to `true` in `serializer`. To generate a closed schema for values, add the `value.converter.dt.json.generate.closed.content.schema` variable set to `true` in `serializer`.

```json
"serializer": {
  "serializerDebezium": {
    "serializerParameters": [
      {
        "key": "converter.dt.json.generate.closed.content.schema",
        "value": "true"
      },
      {
        "key": "value.converter",
        "value": "io.confluent.connect.json.JsonSchemaConverter"
      },
      {
        "key": "value.converter.schemas.enable",
        "value": "true"
      },
      {
        "key": "value.converter.schema.registry.url",
        "value": "<Schema_Registry_namespace_URL>"
      },
      {
        "key": "value.converter.basic.auth.user.info",
        "value": "api-key:<API_key_value>"
      }
    ]
  }
}
```

Where:

* `Schema_Registry_namespace_URL`: {{ schema-registry-name }} namespace endpoint. You can copy the endpoint from the details for the {{ schema-registry-name }} namespace connection on the **Debezium** tab, in the `value.converter.schema.registry.url` parameter.
* `API_key_value`: Value of the [API key](../../../iam/concepts/authorization/api-key.md) with a limited scope used for connecting to {{ schema-registry-name }}. To get this value:
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

    1. Copy the printed value and paste it into the `value` parameter in the configuration file.
