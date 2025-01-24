---
canonical: '{{ link-docs }}/tutorials/dataplatform/schema-registry-overview'
---

# Managing data schemas in {{ mkf-short-name }}

{{ mkf-name }} uses [data format schemas](../concepts/managed-schema-registry.md) to describe the formats of data input and output. Based on the data format schema, the producer generates and the consumer interprets messages from topics.

Such schemas are stored in a schema registry. For {{ mkf-name }}, you can:

* Use an [integrated registry](./managed-schema-registry.md).
* Using an [integrated registry](./managed-schema-registry-rest.md) through the REST API.
* Set up and use the [Confluent registry](./confluent-schema-registry.md).
