The `serverless.eventrouter.admin` role enables managing buses, connectors, rules, and access to them, as well as sending user and audit events to buses.

Users with this role can:
* View info on [buses](../../../serverless-integrations/concepts/eventrouter/bus.md) as well as create, modify, and delete them.
* View info on [access permissions](../../../iam/concepts/access-control/index.md) granted for buses and modify such permissions.
* View info on [connectors](../../../iam/concepts/access-control/index.md) as well as create, modify, and delete them.
* View info on access permissions granted for connectors and modify such permissions.
* View info on [rules](../../../serverless-integrations/concepts/eventrouter/rule.md) as well as create, modify, and delete them.
* View info on access permissions granted for rules and modify such permissions.
* Send user events to buses using the [EventService/Send](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/send.md) gRPC API call.
* Send user events to buses using the [EventService/Put](../../../serverless-integrations/eventrouter/api-ref/grpc/Event/put.md) gRPC API call.
* Transmit audit events.
* View info on the EventRouter [quotes](../../../serverless-integrations/concepts/limits.md#eventrouter).

This role includes the `serverless.eventrouter.editor` permissions.