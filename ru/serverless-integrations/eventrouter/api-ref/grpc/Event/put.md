---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Event/put.md
---

# EventRouter Service, gRPC: EventService.Put

Puts event to bus.

## gRPC request

**rpc Put ([PutEventRequest](#yandex.cloud.serverless.eventrouter.v1.PutEventRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## PutEventRequest {#yandex.cloud.serverless.eventrouter.v1.PutEventRequest}

```json
{
  "bus_id": "string",
  "body": "string"
}
```

#|
||Field | Description ||
|| bus_id | **string**

Required field. ID of the bus to put event. ||
|| body | **string**

Required field. Event body. ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#