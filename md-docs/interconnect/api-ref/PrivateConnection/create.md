# Cloud Interconnect API, REST: PrivateConnection.Create

Creates a PrivateConnection resource in the specified folder using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
POST https://cic.api.cloud.yandex.net/cic/v1/privateConnections
```

## Body parameters {#yandex.cloud.cic.v1.CreatePrivateConnectionRequest}

```json
{
  "name": "string",
  "description": "string",
  "folderId": "string",
  "trunkConnectionId": "string",
  "vlanId": "string",
  "ipv4Peering": {
    "peeringSubnet": "string",
    "peerIp": "string",
    "cloudIp": "string",
    "peerBgpAsn": "string",
    "peerBgpMd5Key": "string"
  },
  "ipv4StaticRoutes": [
    {
      "prefix": "string"
    }
  ],
  "labels": "object"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the privateConnection.
The name must be unique within the folder.
Value must match the regular expression ```\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?```.

Value must match the regular expression ``` |[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])? ```. ||
|| description | **string**

Optional description of the privateConnection. 0-256 characters long.

The maximum string length in characters is 256. ||
|| folderId | **string**

ID of the folder that the privateConnection belongs to.

The maximum string length in characters is 50. ||
|| trunkConnectionId | **string**

ID of the trunk_connection that the privateConnection belongs to.

The maximum string length in characters is 50. ||
|| vlanId | **string** (int64)

VLAN_ID that the privateConnection uses in multiplexing.
Not used in connections over partners-II
Value range: [1, 4095] ||
|| ipv4Peering | **[PeeringRequest](#yandex.cloud.cic.v1.PeeringRequest)**

IPv4 peering config of connection ||
|| ipv4StaticRoutes[] | **[StaticRoute](#yandex.cloud.cic.v1.PrivateConnection.StaticRoute)**

IPv4 StaticRoute config of connection ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## PeeringRequest {#yandex.cloud.cic.v1.PeeringRequest}

#|
||Field | Description ||
|| peeringSubnet | **string**

PeeringSubnet.
It's an ip with format ipPrefix/length where address part of ipPrefix is 0.

The maximum string length in characters is 50. ||
|| peerIp | **string**

PeerIp.
It's an ip with just an ipAddress format without mask.

The maximum string length in characters is 50. ||
|| cloudIp | **string**

CloudIp.
It's an ip with just an ipAddress format without mask.

The maximum string length in characters is 50. ||
|| peerBgpAsn | **string** (int64)

PeerBgpAsn.
PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551). ||
|| peerBgpMd5Key | **string**

PeerBgpMd5Key.
Optional.

The maximum string length in characters is 200. ||
|#

## StaticRoute {#yandex.cloud.cic.v1.PrivateConnection.StaticRoute}

#|
||Field | Description ||
|| prefix | **string**

Prefix.
It's an ip with format ipPrefix/length where address part of ipPrefix is 0. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#