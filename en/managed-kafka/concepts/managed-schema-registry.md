# Managing data schemas

{{ KF }} uses a binary format for storing and transmitting messages. Messages do not contain any information about their structure. As a result, to interpret data in binary format, the consumer needs a _data format schema_ that describes the format of data input or output.

Based on the data format schema, the producer generates and the consumer interprets messages from topics. If data format schemas are different across [producers and consumers](../../managed-kafka/concepts/producers-consumers.md), the application may throw errors because of incorrect message interpretation.

This is why the developers on both the producer and consumer side should:

* Update data format schemas regularly and on time.
* Enable the producer and consumer to support multiple data format schema versions, if required.

To automate handling of data format schemas, a _data format schema registry_ is used. It significantly simplifies working with data, especially when a schema changes over time. The registry automatically checks data version compatibility and ensures the backward compatibility of schema versions.

## How data format schema registry works {#how-sr-works}

1. A producer transmits data format schemas to the registry. The following data schema formats are supported:

   * [Avro](https://avro.apache.org/)
   * [JSON Schema](https://json-schema.org/)
   * [Protobuf](https://protobuf.dev/)

   When a schema is placed in the registry:

   * It is assigned a unique version number.
   * The schema and its version are saved in an {{ KF }} service topic.

1. When sending a message, a producer specifies the version number of the desired schema.
1. Upon receiving a message, a consumer extracts the version number of the data format schema in it.
1. If the required data format schema is missing from the local cache, the consumer looks it up in the registry. After getting the appropriate schema, it correctly interprets the received message.

## {{ mkf-msr }} {#msr}

{{ mkf-name }} clusters already have a built-in {{ mkf-msr }} data format schema registry. The registry is deployed on each cluster broker host and is accessible via HTTPS on port 443.

The [Karapace](https://github.com/Aiven-Open/karapace) open-source tool is used as a {{ mkf-msr }} implementation. API is compatible with the [Confluent Schema Registry API](https://docs.confluent.io/platform/current/schema-registry/develop/api.html) with only minor exceptions. To run API requests, you need [authentication](#msr-auth).

Schema information is posted to a [service topic](./topics.md#service-topics) called `__schema_registry`. You cannot use regular tools to write data to this topic.

To enable management, activate the option when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md#change-additional-settings) a cluster.


To work with {{ mkf-msr }}, you need an advanced [security group configuration](../operations/connect/index.md#configuring-security-groups).


## {{ mkf-msr }} subjects {#subjects}

The schemas use _[subjects](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#subjects)_, i.e., names they are registered under. To write and read schemas, {{ KF }} uses the `<topic_name>-key` or the `<topic_name>-value` subjects, depending on what the schema is being registered for: key or value. The subject specifies the topic to publish messages in.

Subject access depends on permissions [granted](../operations/cluster-accounts.md#grant-permission) to the {{ KF }} user:

* The `ACCESS_ROLE_CONSUMER` or `ACCESS_ROLE_PRODUCER` role for a specific topic allows the user to manage the `<topic_name>-key`, `<topic_name>-value`, and `<topic_name>` subjects.
* The `ACCESS_ROLE_CONSUMER` or `ACCESS_ROLE_PRODUCER` role for a `<prefix>*` topic allows the user to manage subjects of the same `<prefix>*` type. Topic and subject names start with the same prefix.
* The `ACCESS_ROLE_ADMIN` role allows the user to manage all subjects in an {{ mkf-name }} cluster.

## Authorization in {{ mkf-msr }} {#msr-auth}

When working with the {{ mkf-msr }} API over an SSL connection, you need to configure the same client [SSL certificate](../operations/connect#get-ssl-cert) as for broker host connections.

You also need to authorize API server requests using the `Authorization` [HTTP header](https://en.wikipedia.org/wiki/Basic_access_authentication). In this header, specify the [username and password of the {{ KF }} user](../operations/cluster-accounts#create-user).

Access to schemas depends on the selected [topic management method](./topics.md#management) and the configured user roles:

1. If a cluster uses managed topics:

   * A user with the `ACCESS_ROLE_PRODUCER` role for a topic can perform any operations with subjects associated with that topic.
   * A user with the `ACCESS_ROLE_CONSUMER` role for a topic can perform read operations with subjects associated with the topic.

   For more information on available subjects, see [{#T}](#subjects).

1. If a cluster uses unmanaged topics:

   * The above points mentioned for a cluster with managed topics also apply.
   * In addition, a user with the `ACCESS_ROLE_ADMIN` role for a topic has access to any operations with subjects related to the topic. This user can be granted access to any topics.

For more information about roles, see [User management](../operations/cluster-accounts.md).

## Confluent Schema Registry {#confluent-sr}

[Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html) is one of the software solutions that helps resolve the issue of data format schema synchronization between producers and consumers.

Confluent Schema Registry allows you to store data format schemas in the {{ KF }} service topic named `_schemas`.

For more information about the registry, see the [Confluent documentation](https://docs.confluent.io/platform/current/schema-registry/index.html).

## See also {#see-also}

* [Working with the managed schema registry](../tutorials/managed-schema-registry.md)
* [Working with Confluent Schema Registry](../tutorials/confluent-schema-registry.md)
