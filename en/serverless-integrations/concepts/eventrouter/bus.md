# Bus

A _bus_ is a logical entity that groups events and links [connectors](connector.md) sending events to the bus from external sources to [rules](rule.md) that process events and deliver them to targets.

An event is a JSON object delivered to the bus in one of these ways:
* Via a connector.
* Using the [put](../../eventrouter/api-ref/Event/put.md) REST API method for the [Event](../../eventrouter/api-ref/Event/index.md) resource or the [EventService/Put](../../eventrouter/api-ref/grpc/Event/put.md) gRPC API call. You can use the API to deliver user events.

An event is considered processed when all targets of all triggered rules return a successful response, or when the event is moved to a dead-letter queue.
