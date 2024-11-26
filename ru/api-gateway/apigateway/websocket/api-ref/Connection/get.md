---
editable: false
sourcePath: en/_api-ref/serverless/apigateway/websocket/v1/apigateway/websocket/api-ref/Connection/get.md
---

# API Gateway WebSocket Connection Service, REST: Connection.Get

Returns the specified connection info.

## HTTP request

```
GET https://apigateway-connections.{{ api-host }}/apigateways/websocket/v1/connections/{connectionId}
```

## Path parameters

#|
||Field | Description ||
|| connectionId | **string**

Required field. ID of the connection to get. ||
|#

## Response {#yandex.cloud.serverless.apigateway.websocket.v1.Connection}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "gatewayId": "string",
  "identity": {
    "sourceIp": "string",
    "userAgent": "string"
  },
  "connectedAt": "string",
  "lastActiveAt": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the connection. ||
|| gatewayId | **string**

ID of the API Gateway. ||
|| identity | **[Identity](#yandex.cloud.serverless.apigateway.websocket.v1.Identity)**

The information about the caller making the request to API Gateway. ||
|| connectedAt | **string** (date-time)

The timestamp at which connection was established.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastActiveAt | **string** (date-time)

The timestamp at which connection was last accessed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Identity {#yandex.cloud.serverless.apigateway.websocket.v1.Identity}

#|
||Field | Description ||
|| sourceIp | **string**

The source IP address of the caller making the request to API Gateway. ||
|| userAgent | **string**

The User Agent of the caller making the request to API Gateway. ||
|#