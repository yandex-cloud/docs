1. In the left-hand panel, select ![image](../../_assets/console-icons/branches-down.svg) **{{ ui-key.yacloud.schema-registry.label_schemas }}**.
1. Click **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.
1. Select the method for schema uploading into the new subject and specify the following parameters:
    * **Name**: Unique subject name.
    * Optionally, specify the **Compatibility check level** if you need to change the level inherited from the namespace:
        * `BACKWARD`: (Default) Consumers using the new schema can read data written by producers using the latest registered schema.
        * `BACKWARD_TRANSITIVE`: Consumers using the new schema can read data written by producers using all previously registered schemas.
        * `FORWARD`: Consumers using the latest registered schema can read data written by producers using the new schema.
        * `FORWARD_TRANSITIVE`: Consumers using all previously registered schemas can read data written by producers using the new schema.
        * `FULL`: New schema is forward and backward compatible with the latest registered schema.
        * `FULL_TRANSITIVE`: New schema is forward and backward compatible with all previously registered schemas.
        * `NONE`: Schema compatibility checks are disabled.
          For more information about schema compatibility types, see the [Confluent documentation](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).
1. Set the data format to [Protobuf](https://protobuf.dev/), [Avro](https://avro.apache.org/), or [JSON Schema](https://json-schema.org/) and attach the file.
1. If a schema references another schema, in the **References** section, click ![add](../../_assets/console-icons/plus.svg) and enter the [reference](../../metadata-hub/concepts/schema-registry.md#reference) name, the subject name the schema for is registered under for linking, and the registered subject's schema version.
1. To apply [data schema normalization](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#schema-normalization), enable the **Normalization** setting.
1. If you want to skip the schema compatibility check, enable the relevant option.
1. Click **{{ ui-key.yacloud.schema-registry.label_upload-schema-action }}**.