# Cloud Interconnect API, REST: PointOfPresence.Get

Returns the specified PointOfPresence resource.

To get the list of available PointOfPresence resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://cic.api.cloud.yandex.net/cic/v1/pointOfPresences/{pointOfPresenceId}
```

## Path parameters

#|
||Field | Description ||
|| pointOfPresenceId | **string**

Required field. ID of the PointOfPresence resource to return.
To get the pointOfPresence ID use a [PointOfPresenceService.List](list.md#List) request. ||
|#

## Response {#yandex.cloud.cic.v1.PointOfPresence}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "regionId": "string"
}
```

A PointOfPresence resource.

#|
||Field | Description ||
|| id | **string**

ID of the pointOfPresence. ||
|| regionId | **string**

ID of the region that the pointOfPresence belongs to. ||
|#