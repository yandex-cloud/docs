# Managing data schemas in {{ mkf-short-name }}

{{ mkf-full-name }} uses [data format schemas](../../managed-kafka/concepts/managed-schema-registry.md) to describe the formats of data input and output. Based on the data format schema, the producer generates and the consumer interprets messages from topics.

Such schemas are stored in a schema registry. For {{ mkf-full-name }}, you can:

* Use an [integrated registry](./managed-schema-registry.md).
* Use an [integrated registry](./managed-schema-registry-rest.md) via the REST API.
* Set up and use the [Confluent registry](./confluent-schema-registry.md).
