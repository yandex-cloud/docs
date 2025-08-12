The `serverless.eventrouter.supplier` enables sending user events to buses and transmitting audit events.

Users with this role can:
* Send user events to [buses](../../../serverless-integrations/concepts/eventrouter/bus.md) using the [EventService/Send](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) gRPC API call.
* Send user events to buses using the [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md) gRPC API call.
* Transmit audit events.