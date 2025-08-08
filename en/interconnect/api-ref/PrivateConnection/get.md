---
editable: false
apiPlayground:
  - url: https://cic.{{ api-host }}/cic/v1/privateConnections/{privateConnectionId}
    method: get
    path:
      type: object
      properties:
        privateConnectionId:
          description: |-
            **string**
            Required field. ID of the PrivateConnection resource to return.
            To get the privateConnection ID use a [PrivateConnectionService.List](/docs/interconnect/api-ref/PrivateConnection/list#List) request.
          type: string
      required:
        - privateConnectionId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/cic/v1/api-ref/PrivateConnection/get.md
---

# Cloud Interconnect API, REST: PrivateConnection.Get

Returns the specified PrivateConnection resource.

To get the list of available PrivateConnection resources, make a [List](/docs/interconnect/api-ref/PrivateConnection/list#List) request.

## HTTP request

```
GET https://cic.{{ api-host }}/cic/v1/privateConnections/{privateConnectionId}
```

## Path parameters

#|
||Field | Description ||
|| privateConnectionId | **string**

Required field. ID of the PrivateConnection resource to return.
To get the privateConnection ID use a [PrivateConnectionService.List](/docs/interconnect/api-ref/PrivateConnection/list#List) request. ||
|#

## Response {#yandex.cloud.cic.v1.PrivateConnection}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folderId": "string",
  "regionId": "string",
  "trunkConnectionId": "string",
  "vlanId": "string",
  "ipv4Peering": {
    "peeringSubnet": "string",
    "peerIp": "string",
    "cloudIp": "string",
    "peerBgpAsn": "string",
    "cloudBgpAsn": "string",
    "peerBgpMd5Key": "string"
  },
  "ipv4StaticRoutes": [
    {
      "prefix": "string"
    }
  ],
  "labels": "object",
  "status": "string",
  "createdAt": "string"
}
```

A PrivateConnection resource.

#|
||Field | Description ||
|| id | **string**

ID of the privateConnection. ||
|| name | **string**

Name of the privateConnection.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the privateConnection. 0-256 characters long. ||
|| folderId | **string**

ID of the folder that the privateConnection belongs to. ||
|| regionId | **string**

ID of the region that the privateConnection belongs to. ||
|| trunkConnectionId | **string**

ID of the trunk_connection that the privateConnection belongs to. ||
|| vlanId | **string** (int64)

VLAN_ID that the privateConnection uses in multiplexing.
Not used in connections over partners-II
Value range: [1, 4095] ||
|| ipv4Peering | **[Peering](#yandex.cloud.cic.v1.Peering)**

IPv4 peering config of connection ||
|| ipv4StaticRoutes[] | **[StaticRoute](#yandex.cloud.cic.v1.PrivateConnection.StaticRoute)**

IPv4 StaticRoute config of connection ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| status | **enum** (Status)

Status of the privateConnection.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Peering {#yandex.cloud.cic.v1.Peering}

#|
||Field | Description ||
|| peeringSubnet | **string**

PeeringSubnet.
It's an ip with format ipPrefix/length where address part of ipPrefix is 0. ||
|| peerIp | **string**

PeerIp.
It's an ip with just an ipAddress format without mask. ||
|| cloudIp | **string**

CloudIp.
It's an ip with just an ipAddress format without mask. ||
|| peerBgpAsn | **string** (int64)

PeerBgpAsn.
PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551). ||
|| cloudBgpAsn | **string** (int64)

CloudBgpAsn. ||
|| peerBgpMd5Key | **string**

PeerBgpMd5Key.
Optional. ||
|#

## StaticRoute {#yandex.cloud.cic.v1.PrivateConnection.StaticRoute}

#|
||Field | Description ||
|| prefix | **string**

Prefix.
It's an ip with format ipPrefix/length where address part of ipPrefix is 0. ||
|#