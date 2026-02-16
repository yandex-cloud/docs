# Schema compatibility

_Schema compatibility_ defines whether applications with a newer schema can read data written with an older schema, and vice versa.

{{ schema-registry-name }} uses the Confluent Schema Registry standard, which supports these compatibility types:

* `BACKWARD_COMPATIBILITY`: Applications with a newer schema can read data written in the previous schema version.
* `BACKWARD_TRANSITIVE_COMPATIBILITY`: Applications with a newer schema can read data written in any earlier schema version.
* `FORWARD_COMPATIBILITY`: Applications with an older schema can read data written in the new schema.
* `FORWARD_TRANSITIVE_COMPATIBILITY`: Applications with any older schema can read data written in the new schema.
* `FULL_COMPATIBILITY`: Both backward and forward compatibility apply.
* `FULL_TRANSITIVE_COMPATIBILITY`: Both transitive backward and transitive forward compatibility apply.
* `NONE`: No compatibility check is performed.

For more information about compatibility types, see [this Confluent Schema Registry article](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).

{{ schema-registry-name }} supports schema compatibility checks. You can specify the compatibility type for schema checks in the **Compatibility check level** parameter and set the check rules in the **Compatibility check policy for JSON** parameter. The compatibility type also affects how [data schemas evolve](schema-registry-content-model.md#schema-evolution-considerations). 

## See also {#see-also}

[Understanding JSON Schema Compatibility by Robert Yokota](https://yokota.blog/2021/03/29/understanding-json-schema-compatibility/)
