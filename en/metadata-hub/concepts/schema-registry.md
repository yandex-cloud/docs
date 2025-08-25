---
title: Data schema registry
description: 'This article explains the following concepts: namespace, subject, schema, and reference.'
---

# Data schema registry


{% include notitle [preview](../../_includes/note-preview.md) %}

{% include [connection](../../_includes/metadata-hub/schema-registry-definition.md) %}

## Namespace {#namespace}

A _namespace_ is a certain number of schemas. Schemas and subjects of different namespaces are completely isolated from one another. It is up to the user to decide how many namespaces to create and what principle to follow for placing schemas in them. You cannot create references between schemas from different namespaces.

## Subject {#subject}

A _[subject](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#subjects)_ is a named entity within which a [data schema](#schema) evolves.
The particular subject version contains metainformation about the schema and the schema itself. Subject versions are numbered sequentially incrementing by 1. Each subject version is unique and contains only one schema. You can [compare schemas](../operations/compare-schemas.md) in different versions of a subject.

## Schema {#schema}

A _[schema_](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#schemas) is a definition of a data format used to describe data type and structure.
Schemas are used to check data structure in messages on events, thereby ensuring that producers and consumers send and receive data in the same format. You can define schemas in a schema registry only within a given [subject](#subject).
You can edit a data schema. To do this, [upload an updated schema to a subject](../operations/add-schema.md). The new schema will appear in the new subject version:

## Reference {#reference}

A reference _([schema reference](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#referenced-schemas))_ is a link to other schemas comprising the following parameters:

* Reference name. For Avro, a reference name is a full schema name; for JSON, it is a URL address; and for Protobuf, a name of a Protobuf file with a schema (as stated in the `import` directive).
* Subject name used to register the referenced schema.
* Subject version containing the referenced schema.

{% cut "Example of a Protobuf schema reference" %}

Let's take a look at the `msg2.proto` schema in the `test-msg2` subject that refers to the `msg1.proto` schema in the `test-msg1` subject.

`msg1.proto` file contents:

```bash
message msg1 {
    int8 my_field = 1
}
```

`msg2.proto` contents:

```bash
import "msg1.proto"

message msg2 {
    msg1 my_field = 1
}
```

To link these schemas, add a reference with the following parameters when loading the `msg2.proto` schema into the `test-msg2` subject:
* `msg1.proto`: Reference name.
* `test-msg1`: Subject name used to register the referenced schema, `msg1.proto`.
* `1`: `test-msg1` subject version containing the referenced schema.

{% endcut %}

## Use cases {#examples}

* [{#T}](../tutorials/schema-registry-cdc-debezium-kafka.md)