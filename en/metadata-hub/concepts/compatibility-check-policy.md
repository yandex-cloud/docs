# Compatibility policies


A _compatibility policy_ consists of rules {{ schema-registry-full-name }} uses to check the compatibility of the new schema with earlier versions at the [namespace](schema-registry.md#namespace) level.

You can select a compatibility policy when [creating](../operations/create-name-space.md) or [updating](../operations/update-name-space.md) the namespace. Compatibility policies are available for [Protobuf](https://protobuf.dev/) and [JSON Schema](https://json-schema.org/).

## Protobuf schema compatibility policies {#protobuf-compatibility-policy}

The following policies are available for Protobuf schemas:

* `Confluent`: Based on the best practices for the evolution of Protobuf schemas. For more info on schema evolution, see [this Protobuf guide](https://protobuf.dev/programming-guides/proto3/#updating).

* `buf`: Based on the Buf v1 standards. For more info on the applicable checks, see [this specification](https://github.com/bufbuild/buf/blob/main/private/bufpkg/bufcheck/bufcheckserver/bufcheckserver.go#L156).

## JSON schema compatibility policies {#json-compatibility-policy}

The following policies are available for JSON schemas:

* `Confluent`: Follows the Confluent Schema Registry standards and implements mathematically accurate compatibility checks. This policy does not allow adding or removing optional parameters in `object` fields. In certain cases, such as when working with queues, this limitation may be excessive.

* `Optional Friendly`: Based on a [solution](#optional-parameters-compatibility-solution) using various content models for the producer and the consumer. This option only involves registering the producer schema. The compatibility check involves converting the consumer schema from an open content model to a closed one and comparing it with the registered producer schemas. This enables you to add or remove optional parameters while maintaining full transitive compatibility.
