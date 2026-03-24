# Asynchronous operations

In asynchronous communication via message queues (Kafka, RabbitMQ, etc.), span relationships are not modeled as _parent–child_; instead, [span links](../concepts.md#span-links) are used. They connect spans from different traces, e.g., when multiple producers send messages and a consumer processes them in a single batch.

## Naming convention {#naming}

The span name has the `{messaging.operation.name} {destination}` format, e.g., `send orders` or `process orders`. For a topic name with high cardinality, use a template (`messaging.destination.template`). If the topic is unknown, use `unknown`. For more information, see the [messaging span naming specification](https://opentelemetry.io/docs/specs/semconv/messaging/messaging-spans/#span-name).

## Attributes {#attributes}

#|
|| Attribute | Description ||
|| `messaging.system` | Messaging system: `kafka`, `rabbitmq`, etc. ||
|| `messaging.destination.name` | Topic or queue name: `orders` ||
|| `messaging.operation.name` | System operation name: `send`, `poll`, or `process` ||
|| `messaging.operation.type` | Standardized type: `send`, `receive`, `process`, `create`, or `settle` ||
|| `messaging.message.id` | Message ID ||
|| `messaging.batch.message_count` | Number of messages in the batch ||
|#

For a full list of attributes, see the [OpenTelemetry specification for messaging spans](https://opentelemetry.io/docs/specs/semconv/messaging/messaging-spans/).

## Examples {#examples}

### Multiple producers, one consumer {#many-to-one}

Producer A and Producer B each send a message to the `orders` Kafka topic. The consumer receives both messages in a single batch (`poll orders` span) and then creates an individual `process orders` span for each message. Span links are attached to the `process` spans, connecting each message back to its producer:

#|
|| Attribute | Producer A | Producer B | Consumer: receive | Consumer: process A | Consumer: process B ||
|| Name | `send orders` | `send orders` | `poll orders` | `process orders` | `process orders` ||
|| Kind | `PRODUCER` | `PRODUCER` | `CLIENT` | `CONSUMER` | `CONSUMER` ||
|| Status | `OK` | `OK` | `OK` | `OK` | `OK` ||
|| Links | — | — | — | → `send orders` (Producer A) | → `send orders` (Producer B) ||
|| `messaging.system` | `kafka` | `kafka` | `kafka` | `kafka` | `kafka` ||
|| `messaging.destination.name` | `orders` | `orders` | `orders` | `orders` | `orders` ||
|| `messaging.operation.name` | `send` | `send` | `poll` | `process` | `process` ||
|| `messaging.operation.type` | `send` | `send` | `receive` | `process` | `process` ||
|| `messaging.message.id` | `a1` | `a2` | — | `a1` | `a2` ||
|| `messaging.batch.message_count` | — | — | `2` | — | — ||
|#

### One producer, multiple consumers {#one-to-many}

A producer sends a message to the `orders` topic. Consumer X and Consumer Y from different consumer groups independently process this message. Each `process` span is connected to the producer's span via a span link:

#|
|| Attribute | Producer | Consumer X | Consumer Y ||
|| Name | `send orders` | `process orders` | `process orders` ||
|| Kind | `PRODUCER` | `CONSUMER` | `CONSUMER` ||
|| Status | `OK` | `OK` | `OK` ||
|| Links | — | → `send orders` (Producer) | → `send orders` (Producer) ||
|| `messaging.system` | `kafka` | `kafka` | `kafka` ||
|| `messaging.destination.name` | `orders` | `orders` | `orders` ||
|| `messaging.operation.name` | `send` | `process` | `process` ||
|| `messaging.operation.type` | `send` | `process` | `process` ||
|| `messaging.message.id` | `a1` | `a1` | `a1` ||
|#
