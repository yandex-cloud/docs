[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud Interconnect](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [PointOfPresence](index.md) > Get

# Cloud Interconnect API, gRPC: PointOfPresenceService.Get

Returns the specified PointOfPresence resource.
To get the list of available PointOfPresence resources, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetPointOfPresenceRequest](#yandex.cloud.cic.v1.GetPointOfPresenceRequest)) returns ([PointOfPresence](#yandex.cloud.cic.v1.PointOfPresence))**

## GetPointOfPresenceRequest {#yandex.cloud.cic.v1.GetPointOfPresenceRequest}

```json
{
  "point_of_presence_id": "string"
}
```

#|
||Field | Description ||
|| point_of_presence_id | **string**

Required field. ID of the PointOfPresence resource to return.
To get the pointOfPresence ID use a [PointOfPresenceService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## PointOfPresence {#yandex.cloud.cic.v1.PointOfPresence}

```json
{
  "id": "string",
  "name": "string",
  "location_address": "string",
  "connection_points": [
    "string"
  ]
}
```

A PointOfPresence resource.

#|
||Field | Description ||
|| id | **string**

ID of the pointOfPresence. ||
|| name | **string**

Name of the pointOfPresence. ||
|| location_address | **string**

Location address of the pointOfPresence. ||
|| connection_points[] | **string**

Links to info about the connection points. ||
|#