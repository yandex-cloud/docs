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
To get the pointOfPresence ID use a [PointOfPresenceService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.cic.v1.PointOfPresence}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "locationAddress": "string",
  "connectionPoints": [
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
|| locationAddress | **string**

Location address of the pointOfPresence. ||
|| connectionPoints[] | **string**

Links to info about the connection points. ||
|#