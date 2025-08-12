The `serverless.eventrouter.editor` role enables managing buses, connectors, and rules, as well as sending user and audit events to buses.

Users with this role can:
* View info on [buses](../../../serverless-integrations/concepts/eventrouter/bus.md) and [access permissions](../../../iam/concepts/access-control/index.md) granted for them, as well as create, modify, and delete buses.
* View info on [connectors](../../../iam/concepts/access-control/index.md) and access permissions granted for them, as well as create, modify, and delete connectors.
* View info on [rules](../../../iam/concepts/access-control/index.md) and access permissions granted for them, as well as create, modify, and delete rules.
* Send user events to buses using the [EventService/Send](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) gRPC API call.
* Send user events to buses using the [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md) gRPC API call.
* Transmit audit events.

This role includes the `serverless.eventrouter.viewer` and `serverless.eventrouter.supplier` permissions.