# Content models and JSON schema evolution issues

{{ schema-registry-full-name }} supports the [Avro](https://avro.apache.org/), [Protobuf](https://protobuf.dev/), and [JSON Schema](https://json-schema.org/) formats. Avro and Protobuf are based on grammar rules, so their constraints are strictly defined. JSON Schemas combine grammar and production rules, making their constraints more flexible. This can cause compatibility issues as schemas evolve, especially if they have optional parameters. To address this, you can use the closed content model with the `Optional-friendly` [compatibility check policy](compatibility-check-policy.md). {{ schema-registry-name }} implements a JSON schema compatibility check policy, which ensures JSON Schema stays compatible when you add or remove optional parameters.

This article covers:

* [Schema compatibility basics](#compatibility).
* [JSON schema content models](#content-models).
* [Schema evolution issues in content models](#schema-evolution-problems).
* [Maintaining compatibility as optional parameters evolve](#optional-parameters-compatibility-solution).

To use JSON Schema with backward compatibility checks in [{{ data-transfer-name }}](../../data-transfer/concepts/index.md) and allow adding or removing optional parameters:

1. [Set](../operations/update-name-space.md) the `Optional-friendly` compatibility check policy in your name space.
1. In the {{ mkf-full-name }} target endpoint [serialization settings](../../data-transfer/operations/endpoint/target/kafka.md#serializer), configure Debezium as follows:

    * Schema key: Set `key.converter.dt.json.generate.closed.content.schema` to `true`.
    * Schema value: Set `value.converter.dt.json.generate.closed.content.schema` to `true`.

## Schema compatibility {#compatibility}

_Schema compatibility_ defines how a new version of a schema works with its previous version or versions. It is set with the **Compatibility check level** and **JSON compatibility check policy** parameters. 
Depending on the type of compatibility, applications can read data written in older schemas, and vice versa. The compatibility type also affects how schemas evolve. [Learn more about schema compatibility](https://yokota.blog/2021/03/29/understanding-json-schema-compatibility/).

{{ schema-registry-name }} uses the Confluent Schema Registry standard, which supports these compatibility types:

* `BACKWARD_COMPATIBILITY`: Applications with a newer schema can read data written in the previous schema version.
* `BACKWARD_TRANSITIVE_COMPATIBILITY`: Applications with a newer schema can read data written in any earlier schema version.
* `FORWARD_COMPATIBILITY`: Applications with an older schema can read data written in the new schema.
* `FORWARD_TRANSITIVE_COMPATIBILITY`: Applications with any older schema can read data written in the new schema.
* `FULL_COMPATIBILITY`: Both backward and forward compatibility apply.
* `FULL_TRANSITIVE_COMPATIBILITY`: Both transitive backward and transitive forward compatibility apply.
* `NONE`: No compatibility check is performed.

For more information about compatibility types, see [this Confluent Schema Registry article](https://docs.confluent.io/platform/current/schema-registry/fundamentals/schema-evolution.html#compatibility-types).

## JSON schema content models {#content-models}

_Content models_ define the rules for how an `object` field in a schema can be modified. Each field in a schema can use a different content model. 

JSON Schema supports three content models:

* [Open content model](#open-model).
* [Closed content model](#closed-model).
* [Partially open content model](#partially-open-model).

Depending on the model type, you can:

* Add a new required property.
* Add a new optional property.
* Remove a required property.
* Remove an optional property.
* Change a property type from optional to required.
* Change a property type from required to optional.

### Open content model {#open-model}

The open content model allows properties defined in the schema as well as other properties of any type. This is the default model.

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

The closed content model only allows properties defined in the schema. You cannot add new properties.

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

The partially open content model allows adding new properties if they match certain constraints. You can implement the constraints in the following ways:

* Use `additionalProperties` to [allow only properties of certain types](#property-type-limitation).
* Use the `patternProperties` object to [allow properties of certain types with a given prefix added to their names](#pattern-based-limitation) by listing the prefixes mapped to property types.

##### **Property type limitation** {#property-type-limitation}

   This schema allows adding property types described in `additionalProperties`. You cannot add a property of any other type. 

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

   Similarly to the closed schema, here, `additionalProperties` is set to `false`. The `patternProperties` object describes the allowed new properties, where each property name gets a prefix indicating the property type. The schema describes property names using regular expressions. You cannot add a property not described in `patternProperties`. The schema description is as follows:

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

## JSON schema evolution issues in content models {#schema-evolution-problems}

Open and closed content models each have their own limitations on schema evolution while maintaining compatibility with previous versions. The tables below describe constraints for each model type.

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

In the partially open content model, you can add new properties while maintaining compatibility. However, if you use `additionalProperties` to define the type of new properties, you can only add properties of one type. This means you can use the solution in limited scenarios.

A more versatile approach is to list the possible property types adding appropriate prefixes to property names. However, in this case, you must describe all possible properties in `patternProperties`, including `object` and `array` types. 

Such a schema may look as follows:

```json
{
  ...
  "$ref": "#/definitions/obj",
  "definitions": {
    "obj": {
      "type": "object",
      "additionalProperties": false,
      "patternProperties": {
       "^i_": { "type": "integer" },
       "^n_": { "type": "number" },
       "^s_": { "type": "string" },
       "^b_": { "type": "boolean" },
       "^o_": { "$ref": "#/definitions/obj"},
       "^ai_": { "type": "array", "items": {"type": "integer"} },
       "^an_": { "type": "array", "items": {"type": "number" } },
       "^as_": { "type": "array", "items": {"type": "string" } },
       "^ab_": { "type": "array", "items": {"type": "boolean" } },
       "^ao_": { "type": "array", "items": {"$ref": "#/definitions/obj"} }
      }
    }
  }
}
```

The above example does not define any properties but simply provides a general list of possible parameters in `patternProperties`. However, this solution has drawbacks:

* The schema becomes bulky and hard to maintain.
* Any errors in `patternProperties` cannot be fixed without losing compatibility.
* You cannot use new property types that may be added to the JSON specification as they are not described in `patternProperties`.
* To use such a schema in practice, all property names must strictly match the described patterns, which is only possible if you control the data producer.

## Maintaining compatibility with evolving optional properties {#optional-parameters-compatibility-solution}

As you can see from the above [description](#schema-evolution-problems) of content model behavior during schema evolution, the open and closed models do not provide full compatibility when optional properties are added or removed. This causes the `PROPERTY_ADDED_TO_OPEN_CONTENT_MODEL` and `PROPERTY_REMOVED_FROM_CLOSED_CONTENT_MODEL` errors during operations with optional properties. The partially open content model supports compatibility in these cases, but has significant drawbacks that limit its use.

A better approach is to create different schemas for data producers and consumers. Here is why:

* Producers never consume data, so their schemas do not have to be compatibile with each other.
* Consumers never produce data, so their schemas do not have to be compatibile with each other either.
* The main requirement is compatibility between the producer's and consumer's schemas.

To implement this solution, producers and consumers should use different content models:

* Use the closed content model for producers as they always know the exact list of properties.
* Use the open content model for consumers as they only get properties from incoming data and ignore any unknown ones.

In this scenario, only the producer’s data schema is registered. The consumer’s schema is generated based on the producer schema, if required, but is not registered. The only difference between producer and consumer schemas is that they use different content models. As a result, schema compatibility checks only involve converting the consumer schema from the open content model to the closed one and verifying that such a schema is registered for the producer. If such a schema is registered, the compatibility check is passed. At the same time, the consumer schema may contain additional properties from other registered producer schemas. To support full transitive compatibility, the consumer schema must be compatible with at least one registered producer schema. Lead more about the [theory](https://www.creekservice.org/articles/2024/01/08/json-schema-evolution-part-1.html) behind this solution and [its applications](https://www.creekservice.org/articles/2024/01/09/json-schema-evolution-part-2.html).

{{ schema-registry-name }} supports schema compatibility checks by converting an open consumer schema to a closed one. To enable this, in the JSON schema [namespace](schema-registry.md#namespace), set the `Optional-friendly` [compatibility check policy](compatibility-check-policy.md). You can [set a policy](../operations/create-name-space.md) for a new namespace or [modify it](../operations/update-name-space.md) for an existing one. For the `Optional-friendly` policy to work correctly, the namespace schemas must use the [closed content model](#closed-model).
