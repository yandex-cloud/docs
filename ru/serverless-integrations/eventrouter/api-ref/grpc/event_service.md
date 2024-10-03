---
editable: false
sourcePath: en/_api-ref-grpc/functions/eventrouter/eventrouter/api-ref/grpc/event_service.md
---

# EventRouter Service, gRPC: EventService

Service for put events to bus for serverless eventrouter.

| Call | Description |
| --- | --- |
| [Put](#Put) | Puts event to bus. |

## Calls EventService {#calls}

## Put {#Put}

Puts event to bus.

**rpc Put ([PutEventRequest](#PutEventRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

### PutEventRequest {#PutEventRequest}

Field | Description
--- | ---
bus_id | **string**<br>Required. ID of the bus to put event. 
body | **string**<br>Required. Event body. The maximum string length in characters is 262144.


