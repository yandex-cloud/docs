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

A _[subject](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#subjects)_ is a named entity within which a data schema evolves.
The particular subject version contains metainformation about the schema and the schema itself. Schema versions are numbered sequentially incrementing by 1. Each schema version is unique. You can compare different schema versions.

## Schema {#schema}

A _[schema](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#schemas)_ is a definition of a data format used to describe data type and structure.
Schemas are used to check data structure in messages on events, thereby ensuring that producers and consumers send and receive data in the same format. You can define schemas in a schema registry only within a given subject.

## Reference {#reference}

A reference _([schema reference](https://docs.confluent.io/platform/current/schema-registry/fundamentals/serdes-develop/index.html#referenced-schemas))_ is a link to other schemas comprising the following parameters:

* Reference name. For Avro, a reference name is a full schema name; for JSON, it is a URL address; and for Protobuf, a name of another Protobuf file (as stated in the `import` directive).
* Subject name used to register the schema for the reference.
* Version representing the exact version of the registered subject's schema.

{% cut "Example of Protobuf schema's reference" %}

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

To link these schemas, specify the following reference when loading the `msg2.proto` schema into the `test-msg2` subject:
* `msg1.proto`: Reference name.
* `test-msg1`: Subject name used to register the schema for the `msg1.proto` reference.
* `1`: Reference schema version.

{% endcut %}