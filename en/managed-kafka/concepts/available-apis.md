# APIs in {{ mkf-name }}

A cluster features multiple API types for different operations.

## Cloud APIs {#cloud-api}

Provided by {{ yandex-cloud }}, these APIs include the REST API and gRPC API. You can use any of these APIs to manage the following objects:

* [{{ mkf-name }} clusters](../operations/index.md#clusters) and [cluster logs](../operations/cluster-logs.md).
* Some {{ KF }} entities: [topics](../operations/cluster-topics.md), [accounts](../operations/cluster-accounts.md), and [connectors](../operations/cluster-connector.md).

### Usage {#cloud-api-usage}

You do not need to take any preliminary steps to access these APIs as they are always available. To use these APIs, you need to [authenticate](../api-ref/authentication.md) when sending API requests.

The scope of available operations depends on the [roles of the account](../security/index.md) used to send API requests.

For descriptions of the [REST API methods](../api-ref/index.md) and [gRPC API calls](../api-ref/grpc/index.md), see the API reference. You can find examples of requests in [these step-by-step guides](../operations/index.md).

### Limitations {#cloud-api-limits}

You can use these APIs to manage only some of {{ KF }} entities. For advanced {{ KF }} entity management, use the [{{ mkf-short-name }} REST API](#managed-kafka-api) or [Client API](#client-api).

## {{ mkf-short-name }} REST API {#managed-kafka-api}

Provided by {{ yandex-cloud }}, these REST APIs include the following:

* REST API for {{ mkf-msr }} compatible with Confluent Schema Registry API version {{ mkf.kp-api-version }} (with [some limitations](#managed-kafka-api-limits)).

    You can use this API to work with the [managed schema registry](./managed-schema-registry.md).

* REST API for {{ KF }} compatible with Confluent REST Proxy API version {{ mkf.kp-api-version }} (with [some limitations](#managed-kafka-api-limits)).

    This API enables you to manage producers and consumers using format schemas from the registry as well as view information about brokers, topics, and partitions.

{{ mkf-name }} clusters use [{{ mkf.kp }}](https://www.karapace.io/), an open-source tool which provides access to these REST APIs as well as the basis for the managed schema registry.

### Usage {#managed-kafka-api-usage}

To use any one of these APIs:

1. Get access to the API.

    By default, {{ mkf-msr }} and both of the REST APIs are disabled and not available. To use them, specify the relevant settings when [creating](../operations/cluster-create.md) or [updating](../operations/cluster-update.md) a cluster:

    * **{{ ui-key.yacloud.kafka.field_schema-registry }}**. {{ mkf-msr }} and the respective REST API will become available in the cluster.
    * **{{ ui-key.yacloud.kafka.field_rest-api-config }}**. The REST API for {{ KF }} will become available in the cluster.

    While both of the REST APIs are provided by {{ mkf.kp }}, you can access them independently of each other, e.g., only use {{ mkf-msr }} and its REST API, only use the {{ KF }} REST API, or all of them at once.

1. [Complete all the steps to pre-configure a connection to the cluster](../operations/connect/index.md).

1. Authenticate when sending API requests.

    The APIs use the [HTTP Basic Authentication]https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication#basic_authentication_scheme scheme, where each request must contain an [Authorization](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization) HTTP header with credentials for the [{{ KF }} user](../operations/cluster-accounts.md) sending the request.

The scope of available operations depends on the roles assigned to the [{{ KF }} user](../operations/cluster-accounts.md) sending API requests.

* REST API for {{ mkf-msr }}:

    * `ACCESS_ROLE_CONSUMER` role: User can perform read operations with [subjects](./managed-schema-registry.md#subjects) associated with the topic the role was assigned for.
    * `ACCESS_ROLE_PRODUCER` role: User can perform any operations with subjects associated with the topic the role was assigned for.
    * `ACCESS_ROLE_ADMIN` role: User can perform any operations with subjects associated with any topic (this role applies to all topics).
    * `ACCESS_ROLE_TOPIC_ADMIN` role: User can perform any operations with subjects associated with the topic the role was assigned for.

    Also, a user’s role determines which subjects this user can manage. For more information about the {{ mkf-msr }} role model, see [{#T}](./managed-schema-registry.md).

* REST API for {{ KF }}:

    * `ACCESS_ROLE_CONSUMER` role: User can get information about {{ KF }} objects and work with consumers.
    * `ACCESS_ROLE_TOPIC_ADMIN`, `ACCESS_ROLE_PRODUCER`, or `ACCESS_ROLE_ADMIN` role: User can perform the full range of operations with {{ KF }} objects.

For descriptions of the [REST API methods for {{ mkf-msr }}](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/schema-registry/develop/api.html) and [REST API methods for {{ KF }}](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html), see the Confluent documentation. For examples of working with these APIs, see [{#T}](../tutorials/managed-schema-registry-rest.md).

### Limitations {#managed-kafka-api-limits}

* REST API for {{ mkf-msr }}:

    The following limitations apply to [registry operation mode management methods](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/schema-registry/develop/api.html#mode):

    * To view information on registry operation modes, the user must have the `ACCESS_ROLE_ADMIN` permissions.
    * You cannot change the registry operation mode.

* REST API for {{ KF }}:

    * You cannot manage clusters or other {{ KF }} objects except producers and consumers.
    * Only the [Confluent REST Proxy API](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html) [v2](https://docs.confluent.io/platform/{{ mkf.kp-api-version }}/kafka-rest/api.html#crest-api-v2) methods are available.

## {{ KF }} client APIs {#client-api}

Client APIs is an umbrella name for the following native {{ KF }} APIs:

* [Producer API](https://kafka.apache.org/documentation/#producerapi): For operations with producers.
* [Consumer API](https://kafka.apache.org/documentation/#consumerapi): For operations with consumers.
* [Streams API](https://kafka.apache.org/documentation/#streamsapi): For operations with data streams.
* [Connect API](https://kafka.apache.org/documentation/#connectapi): For operations with connectors.
* [Admin API](https://kafka.apache.org/documentation/#adminapi): For operations with {{ KF }} objects.

You can use these APIs to manage {{ KF }} objects (with [some limitations](#client-api-limits)).

### Usage {#client-api-usage}

To use any one of these APIs:

1. [Pre-configure your connection to the cluster](../operations/connect/index.md).

1. Embed the API into your [{{ KF }} client application](../operations/connect/code-examples.md) code.

    To use the client APIs, you need to invoke the relevant functions from the code of your client apps, as these are not REST APIs.

1. To access the APIs, set up the appropriate authentication method in your client app code. Authentication requires the [{{ KF }} user](../operations/cluster-accounts.md) credentials.

    For the descriptions of authentication methods, see the [Confluent documentation for client applications](https://docs.confluent.io/kafka-client/overview.html). For configuration examples, see [{#T}](../operations/connect/code-examples.md).

The scope of available operations depends on the roles assigned to the [{{ KF }} user](../operations/cluster-accounts.md) sending requests to the client APIs.

For descriptions of the client APIs, see the [{{ KF }} documentation](https://kafka.apache.org/documentation/#api) For examples of working with the Producer API and Consumer API, see [{#T}](../tutorials/managed-schema-registry.md).

### Limitations {#client-api-limits}

* You cannot manage {{ KF }} clusters or accounts.
* You can manage topics via the Admin API with the following limitations:

    {% include [admin-api-limits](../../_includes/mdb/mkf/admin-api-limits.md) %}


## Use cases {#examples}

* [{#T}](../tutorials/managed-schema-registry-rest.md)