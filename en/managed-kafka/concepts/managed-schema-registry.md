# Managing data schemas

{{ KF }} uses a binary format for storing and passing messages. Messages don't contain any information about their structure. As a result, to interpret data in binary format, the consumer needs a _data format schema_. It describes the format of data input or output.

Based on the data format schema, the producer generates and the consumer interprets messages from topics. If data format schemas differ between [producers and consumers](../../managed-kafka/concepts/producers-consumers.md), the application may throw errors because of incorrect message interpretation.

The developers of the producer and consumer must:

* Update data format schemas regularly and on time.
* Enable the producer and consumer to support several data format schema versions, if necessary.

To automate the handling of data format schemas, a _data format schema registry_ is used. It greatly simplifies working with data, especially when a schema changes over time. The registry automatically checks data version compatibility and ensures the backward compatibility of schema versions.

## Registry of data format schemas {#how-sr-works}

1. A producer transmits data format schemas to the registry. The following data schema formats are supported:

   * [Avro](https://avro.apache.org/)
   * [JSON Schema](https://json-schema.org/)
   * [Protobuf](https://protobuf.dev/)

   When placed in the registry:

   * A schema is assigned a unique version number.
   * The schema and its version are saved in a {{ KF }} service topic.

1. When sending a message, a producer specifies the version number of the desired schema.
1. Upon receiving a message, a consumer extracts the version number of the data format schema in it.
1. If the required data format schema is missing from the local cache, the consumer looks it up in the registry. After getting the necessary schema, it correctly interprets the received message.

## {{ mkf-msr }} {#msr}

{{ mkf-name }} clusters already have a built-in {{ mkf-msr }} data format schema registry. The registry is deployed on each cluster broker host and is accessible via HTTPS on port 443.

The registry provides a JSON REST API that is fully compatible with the [Confluent Schema Registry API](https://docs.confluent.io/platform/current/schema-registry/develop/api.html). Queries require [authentication](#msr-auth).

Schema information is posted to a [service topic](./topics.md#service-topics) called `__schema_registry`. You cannot use standard tools to write data to this topic.

To use this registry, enable the relevant option when [creating a cluster](../operations/cluster-create.md).


Working with {{ mkf-msr }} requires an advanced [security group configuration](../operations/connect.md#configuring-security-groups).


## Authorizing in {{ mkf-msr }} {#msr-auth}

When working with the {{ mkf-msr }} API over an SSL connection, you need to configure the same client [SSL certificate](../operations/connect#get-ssl-cert) as for broker host connections.

You also need to authorize API server requests using the `Authorization` [HTTP header](https://en.wikipedia.org/wiki/Basic_access_authentication). In the header, specify the [username and password of the {{ KF }} user](../operations/cluster-accounts#create-user).

Access to schemas depends on the selected [topic management method](./topics.md#management) and the configured user roles:

1. If managed topics are used in the cluster:

   * A user with the `ACCESS_ROLE_CONSUMER` role for a topic can perform any operations with [_subjects_](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#subjects) associated with the topic.
   * A user with the `ACCESS_ROLE_CONSUMER` role for a topic can perform read operations with subjects associated with the topic.

1. If a cluster uses unmanaged topics:

   * The same is true for a cluster with managed topics.
   * In addition, a user with the `ACCESS_ROLE_ADMIN` role for a topic has access to any operations with subjects related to the topic. This user can be granted access to any topics.

For more information about roles, see [{#T}](../operations/cluster-accounts.md).

## Confluent Schema Registry {#confluent-sr}

[Confluent Schema Registry](https://docs.confluent.io/platform/current/schema-registry/index.html) is one of the software solutions that helps avoid the problem of data format schema synchronization between producers and consumers.

Confluent Schema Registry allows you to store data format schemas in the {{ KF }} service topic named `_schemas`.

For more information about the registry, see the [Confluent documentation](https://docs.confluent.io/platform/current/schema-registry/index.html).

## See also {#see-also}

* [Working with the managed schema registry](../tutorials/managed-schema-registry.md).
* [Working with Confluent Schema Registry](../tutorials/confluent-schema-registry.md).
