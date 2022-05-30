# Managing data schemas

{{ KF }} uses a binary format for storing and passing messages. Messages don't contain any information about their structure. As a result, to interpret data in binary format, the consumer needs a _data format schema_. It describes the format of data input or output.

Based on the data format schema, the producer generates and the consumer interprets messages from topics. If the data format schemas of [producers and consumers](../../managed-kafka/concepts/producers-consumers.md) differ, the application performs with errors due to incorrect message interpretation.

The developers of the producer and consumer must:

* Update data format schemas regularly and on time.
* Enable the producer and consumer to support several data format schema versions, if necessary.

To automate the handling of data format schemas, a _data format schema registry_ is used. It greatly simplifies working with data, especially when a schema changes over time. The registry automatically checks data version compatibility and ensures the backward compatibility of schema versions.

## Registry of data format schemas {#how-sr-works}

Producers and consumers use the registry as follows:

1. A producer transmits data format schemas to the registry.

    When placed in the registry:
    * A schema is assigned a unique version number.
    * The schema and its version are saved in a {{ KF }} service topic.

1. When sending a message, a producer specifies the version number of the desired schema.

1. Upon receiving a message, a consumer extracts the version number of the data format schema in it.

1. If the required data format schema is missing from the local cache, the consumer looks it up in the registry. After getting the necessary schema, it correctly interprets the received message.

For more information on how the registry works, see the [Confluent documentation](https://docs.confluent.io/platform/current/schema-registry/index.html).

## {{ mkf-msr }} {#msr}

{{ mkf-name }} clusters already have a built-in {{ mkf-msr }} data format schema registry. The registry is deployed on each cluster broker host and is accessible via HTTPS on port 443.

The JSON REST API is available for registry operations and is fully compatible with the [Confluent Schema Registry API](https://docs.confluent.io/platform/current/schema-registry/develop/api.html). To execute requests, [authorization](#msr-auth) is required.

The following data schema formats are supported:

* [Avro](https://avro.apache.org/),
* [JSON Schema](https://json-schema.org/),

Schema information is posted to a [service topic](./topics.md#service-topics) called `_schemas`. You cannot use standard tools to write data to this topic.

To use this registry, enable the relevant option when [creating a cluster](../operations/cluster-create.md).

{% note warning %}

Working with {{ mkf-msr }} requires an advanced [security group configuration](../operations/connect.md#configuring-security-groups).

{% endnote %}

## Authorizing in {{ mkf-msr }} {#msr-auth}

When working with the {{ mkf-msr }} API over an SSL connection, you need to configure the same client [SSL certificate](../operations/connect#get-ssl-cert) as for broker host connections.

You also need to authorize API server requests using the `Authorization` HTTP header. In the header, you need to specify the [{{ KF }} account login and password](../operations/cluster-accounts#create-account).

The ability to work with schemas depends on the selected [topic management method](./topics.md#management) and the configured account roles:

1. If managed topics are used in the cluster:
    * An account with the `ACCESS_ROLE_PRODUCER` role with respect to a topic is able to perform any operations with _subjects_ ([subjects](https://docs.confluent.io/platform/current/schema-registry/develop/api.html#subjects)) related to the topic.
    * An account with the `ACCESS_ROLE_CONSUMER` role with respect to a topic is able to perform read operations with subjects associated with the topic.

1. If a cluster uses unmanaged topics:

    * The same is true for a cluster with managed topics.
    * In addition, an account with the `ACCESS_ROLE_ADMIN` role with respect to a topic has access to any operations with subjects related to the topic. This account can be granted access to any topics.

For more information about roles, see [{#T}](../operations/cluster-accounts.md).

## See also {#see-also}

* [Working with the managed schema registry](../tutorials/managed-schema-registry.md).
* [Working with Confluent Schema Registry](../tutorials/confluent-schema-registry.md).
