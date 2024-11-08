---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/PrivateConnection/get.md
---

# Cloud Interconnect API, gRPC: PrivateConnectionService.Get {#Get}

Returns the specified PrivateConnection resource.

To get the list of available PrivateConnection resources, make a [List](/docs/cic/workload/api-ref/grpc/PrivateConnection/list#List) request.

## gRPC request

**rpc Get ([GetPrivateConnectionRequest](#yandex.cloud.cic.v1.GetPrivateConnectionRequest)) returns ([PrivateConnection](#yandex.cloud.cic.v1.PrivateConnection))**

## GetPrivateConnectionRequest {#yandex.cloud.cic.v1.GetPrivateConnectionRequest}

```json
{
  "privateConnectionId": "string"
}
```

#|
||Field | Description ||
|| privateConnectionId | **string**

Required field. ID of the PrivateConnection resource to return.
To get the privateConnection ID use a [PrivateConnectionService.List](/docs/cic/workload/api-ref/grpc/PrivateConnection/list#List) request. ||
|#

## PrivateConnection {#yandex.cloud.cic.v1.PrivateConnection}

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folderId": "string",
  "regionId": "string",
  "trunkConnectionId": "string",
  "vlanId": "google.protobuf.Int64Value",
  "ipv4Peering": {
    "peeringSubnet": "string",
    "peerIp": "string",
    "cloudIp": "string",
    "peerBgpAsn": "int64",
    "cloudBgpAsn": "int64",
    "peerBgpMd5Key": "string"
  },
  "ipv4StaticRoutes": [
    {
      "prefix": "string",
      "nextHop": [
        "string"
      ]
    }
  ],
  "labels": "string"
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
|| vlanId | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

VLAN_ID that the privateConnection uses in multiplexing.
Not used in connections over partners-II
Value range: [1, 4095] ||
|| ipv4Peering | **[Peering](#yandex.cloud.cic.v1.Peering)**

IPv4 peering config of connection ||
|| ipv4StaticRoutes[] | **[StaticRoute](#yandex.cloud.cic.v1.PrivateConnection.StaticRoute)**

IPv4 StaticRoute config of connection ||
|| labels | **string**

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
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
|| peerBgpAsn | **int64**

PeerBgpAsn.
PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551). ||
|| cloudBgpAsn | **int64**

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
|| nextHop[] | **string**

PeerIp.
It's an ip with just an ipAddress format without mask. ||
|#