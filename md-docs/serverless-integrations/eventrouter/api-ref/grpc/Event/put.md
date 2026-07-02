[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > Справочник API EventRouter > [gRPC (англ.)](../index.md) > [Event](index.md) > Put

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

Required field. Event body.

The maximum string length in characters is 262144. ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#