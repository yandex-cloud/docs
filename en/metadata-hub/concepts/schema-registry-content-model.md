# Content models and JSON schema evolution issues

{{ schema-registry-full-name }} supports the [Avro](https://avro.apache.org/), [Protobuf](https://protobuf.dev/), and [JSON Schema](https://json-schema.org/) formats. Avro and Protobuf schemas rely on a preset structure that is strictly enforced and defines any schema evolution. In contrast, a JSON schema does not require a preset structure, so it has no formally defined rules for schema evolution. As a result, when handling optional properties, a JSON Schema behaves differently from Avro or Protobuf ones. 

> For example, adding an optional property to an Avro or Protobuf schema is considered a backward-compatible change, while in a JSON schema, the same action may either break or preserve compatibility depending on the employed [content model](#content-models).

To maintain compatibility during JSON schema evolution, compatibility checks are employed, with their rules defined by [special policies](compatibility-check-policy.md). {{ schema-registry-name }} supports the following policies for JSON schemas:

* _Confluent_ does not allow adding or removing optional properties in `object` fields. In certain cases, e.g., when working with queues, this limitation may be excessive.

* _Optional friendly_ allows adding or removing optional properties in `object` fields while maintaining full transitive compatibility.

This article covers the theory behind the `Optional-friendly` policy and how this policy works.

{% note tip %}

To use a JSON schema with the `Optional-friendly` compatibility check policy in [{{ data-transfer-name }}](../../data-transfer/concepts/index.md):

1. [Set](../operations/update-name-space.md) the `Optional-friendly` compatibility check policy in your name space.
1. In the {{ mkf-full-name }} target endpoint [serialization settings](../../data-transfer/operations/endpoint/target/kafka.md#serializer), configure Debezium as follows:

    * Schema key: Set `key.converter.dt.json.generate.closed.content.schema` to `true`.
    * Schema value: Set `value.converter.dt.json.generate.closed.content.schema` to `true`.

{% endnote %}

## JSON schema content models {#content-models}

_Content models_ define the rules for how an `object` field in a schema can be modified. Each field in a schema can use a different content model. 

JSON Schema supports three content models:

* [Open content model](#open-model).
* [Closed content model](#closed-model).
* [Partially open content model](#partially-open-model).

### Open content model {#open-model}

An open content model supports both using properties defined in the schema and adding new ones of any type. This is the default model.

In the open content model, the schema description is as follows:

```json
{
  "type": "object",
  "properties": {
    "name": {"type": "string"},
    "age": {"type": "integer"}
  },
  "additionalProperties": true
}
```

Where `additionalProperties` controls whether you can add properties with `true` or `false` values. The default value is `true`, so it is often omitted when describing schemas in the open content model.

### Closed content model {#closed-model}

In a closed content model, you can only use the properties defined in the schema. You cannot add new properties.

In the closed content model, the schema description is as follows:

```json
{
  "type": "object",
  "properties": {
    "name": {"type": "string"},
    "age": {"type": "integer"}
  },
  "additionalProperties": false
}
```

### Partially open content model {#partially-open-model}

The partially open content model allows adding new properties if they match certain constraints. You can set the constraints in the following ways:

* Use `additionalProperties` to [only allow adding properties of certain types](#property-type-limitation) by specifying the property type.
* Use the `patternProperties` object to [allow adding properties of certain types with specific naming requirements](#pattern-based-limitation) by listing the regular expressions for naming and their matching property types.

##### **Property type limitation** {#property-type-limitation}

   Supported types for new properties are described in `additionalProperties`. You cannot add properties of any other type. 

   The schema description is as follows:

   ```json
   {
     "type": "object",
     "properties": {
       "name": {"type": "string"},
       "age": {"type": "integer"}
     },
     "additionalProperties": {"type": "string"}
   }
   ```

   This schema allows adding only new `string` properties.

##### **Property type limitation based on the property name prefix** {#pattern-based-limitation}

   Similarly to the closed schema, `additionalProperties` is set to `false`. The `patternProperties` object describes the allowed new properties, where each property name gets a prefix indicating the property type. The schema describes property names using regular expressions. You cannot add any properties different from those described in `patternProperties`.

   The schema description is as follows:

   ```json
   {
     "type": "object",
     "properties": {
       "s_name": {"type": "string"},
       "i_age": {"type": "integer"}
     },
     "patternProperties": {
       "^s_": {"type": "string"},
       "^i_": {"type": "integer"}
     },
     "additionalProperties": false
   }
   ```

   This schema restricts new properties to:

   * `string` properties with names starting with `s_`.
   * `integer` properties with names starting with `i_`.

## JSON schema evolution specifics in content models {#schema-evolution-considerations}

_Schema evolution_ is an update of one or multiple schema properties or their attributes. You can update a JSON schema in one of the following ways:

* Add a new required property.
* Add a new optional property.
* Remove a required property.
* Remove an optional property.
* Change a property type from optional to required.
* Change a property type from required to optional.

Open and closed content models each have their own limitations on schema evolution while maintaining compatibility with previous versions. Limitations and constraints are model-specific.

### Open content model {#open-model-compatibility-chart}

   | Schema change                                   | Forward compatibility | Backward compatibility | Full compatibility |
   | ------------------------------------------------- | :------------------: | :--------------------: | :------------------: |
   | Adding required property                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
   | Adding optional property                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
   | Removing required property                  | ![image](../../_assets/common/no.svg) |  ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
   | Removing optional property                  | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
   | Changing optional property to required | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
   | Changing required property to optional | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |

### Closed content model {#closed-model-compatibility-chart}

   | Schema change                                   | Forward compatibility | Backward compatibility | Full compatibility |
   | ------------------------------------------------- | :------------------: | :--------------------: | :------------------: |
   | Adding required property                | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
   | Adding optional property                | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |
   | Removing required property                  | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
   | Removing optional property                  | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
   | Changing optional property to required | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/no.svg) |
   | Changing required property to optional | ![image](../../_assets/common/no.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/no.svg) |

### Partially open content model {#partially-open-model-compatibility-issues}

In the partially open content model, you can add new properties while maintaining compatibility by defining the property type in `additionalProperties`. However, this method can only add properties of one type.

To add properties of several types at once, list their types in `patternProperties`, appropriately prefixing the property names. Remember to describe all possible properties, including `object` and `array` types.

However, this solution has drawbacks:

* The schema becomes bulky and hard to maintain.
* Any errors in `patternProperties` cannot be fixed without losing compatibility.
* You cannot use new property types that may be added to the JSON specification as they are not described in `patternProperties`.
* The schema works only if all property names exactly match the described patterns, which is only possible if you control the data producer.

## Maintaining compatibility with evolving optional properties {#optional-parameters-compatibility-solution}

With open and closed content models in JSON schemas, you cannot ensure [full compatibility](#open-model-compatibility-chart) when adding or removing optional properties. This causes the `PROPERTY_ADDED_TO_OPEN_CONTENT_MODEL` and `PROPERTY_REMOVED_FROM_CLOSED_CONTENT_MODEL` errors during operations with optional properties. While ensuring compatibility in these cases, the partially open content model, however, [has significant drawbacks](#partially-open-model-compatibility-issues).

Instead of using a specific model, you can employ different content models for data producers and consumers:

* Use the closed content model for producers as they always know the exact list of properties.
* Use the open content model for consumers as they only get properties from incoming data and ignore any unknown ones.

In this scenario, only the producer data schema is registered. The consumer schema is generated based on the producer schema, if required, but is not registered. The only difference between producer and consumer schemas is that they use different content models. As a result, schema compatibility checks only involve converting the consumer schema from the open content model to the closed one and verifying that the producer registry includes such a schema. If the registry includes a similar producer schema, the compatibility check is passed. At the same time, the consumer schema may contain additional properties from other registered producer schemas. To support full transitive compatibility, the consumer schema must be compatible with at least one registered producer schema. Lead more about the [theory](https://www.creekservice.org/articles/2024/01/08/json-schema-evolution-part-1.html) behind this solution and [its applications](https://www.creekservice.org/articles/2024/01/09/json-schema-evolution-part-2.html).

{{ schema-registry-name }} supports schema compatibility checks by converting an open consumer schema to a closed one. To enable this, in the JSON schema [namespace](schema-registry.md#namespace), set the `Optional-friendly` [compatibility check policy](compatibility-check-policy.md). You can [set a policy](../operations/create-name-space.md) for a new namespace or [modify it](../operations/update-name-space.md) for an existing one. For the `Optional-friendly` policy to work correctly, the namespace schemas must use the [closed content model](#closed-model).

You can also use this solution to maintain JSON schema compatibility when delivering data to [{{ mkf-full-name }}](../../managed-kafka) via [{{ data-transfer-full-name }}](../../data-transfer/) [{{ yds-full-name}}](../../data-streams/). For more information about the required {{ data-transfer-name }} endpoint settings, see [this guide](../../data-transfer/operations/endpoint/target/kafka.md#serializer).

## See also {#see-also}

* [Understanding JSON Schema Compatibility by Robert Yokota](https://yokota.blog/2021/03/29/understanding-json-schema-compatibility/)
* [Evolving JSON Schemas - Part I by Andy Coates](https://www.creekservice.org/articles/2024/01/08/json-schema-evolution-part-1.html)
* [Evolving JSON Schemas - Part II by Andy Coates](https://www.creekservice.org/articles/2024/01/09/json-schema-evolution-part-2.html)
