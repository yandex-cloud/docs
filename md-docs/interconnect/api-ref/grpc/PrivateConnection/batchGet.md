# Cloud Interconnect API, gRPC: PrivateConnectionService.BatchGet

Get list of PrivateConnections by their IDs

## gRPC request

**rpc BatchGet ([BatchGetPrivateConnectionsRequest](#yandex.cloud.cic.v1.BatchGetPrivateConnectionsRequest)) returns ([BatchGetPrivateConnectionsResponse](#yandex.cloud.cic.v1.BatchGetPrivateConnectionsResponse))**

## BatchGetPrivateConnectionsRequest {#yandex.cloud.cic.v1.BatchGetPrivateConnectionsRequest}

```json
{
  "private_connection_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| private_connection_ids[] | **string**

List of IDs of the PrivateConnection resources to return. ||
|#

## BatchGetPrivateConnectionsResponse {#yandex.cloud.cic.v1.BatchGetPrivateConnectionsResponse}

```json
{
  "private_connections": [
    {
      "id": "string",
      "name": "string",
      "description": "string",
      "folder_id": "string",
      "trunk_connection_id": "string",
      "vlan_id": "google.protobuf.Int64Value",
      "ipv4_peering": {
        "peering_subnet": "string",
        "peer_ip": "string",
        "cloud_ip": "string",
        "peer_bgp_asn": "int64",
        "cloud_bgp_asn": "int64",
        "peer_bgp_md5_key": "string"
      },
      "ipv4_static_routes": [
        {
          "prefix": "string"
        }
      ],
      "labels": "map<string, string>",
      "status": "Status",
      "created_at": "google.protobuf.Timestamp"
    }
  ]
}
```

#|
||Field | Description ||
|| private_connections[] | **[PrivateConnection](#yandex.cloud.cic.v1.PrivateConnection)**

List of PrivateConnections ||
|#

## PrivateConnection {#yandex.cloud.cic.v1.PrivateConnection}

A PrivateConnection resource.

#|
||Field | Description ||
|| id | **string**

ID of the privateConnection. ||
|| name | **string**

Name of the privateConnection.
The name must be unique within the folder.
Value must match the regular expression ```\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?```. ||
|| description | **string**

Description of the privateConnection. 0-256 characters long. ||
|| folder_id | **string**

ID of the folder that the privateConnection belongs to. ||
|| trunk_connection_id | **string**

ID of the trunk_connection that the privateConnection belongs to. ||
|| vlan_id | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

VLAN_ID that the privateConnection uses in multiplexing.
Not used in connections over partners-II
Value range: [1, 4095] ||
|| ipv4_peering | **[Peering](#yandex.cloud.cic.v1.Peering)**

IPv4 peering config of connection ||
|| ipv4_static_routes[] | **[StaticRoute](#yandex.cloud.cic.v1.PrivateConnection.StaticRoute)**

IPv4 StaticRoute config of connection ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| status | enum **Status**

Status of the privateConnection.

- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|#

## Peering {#yandex.cloud.cic.v1.Peering}

#|
||Field | Description ||
|| peering_subnet | **string**

PeeringSubnet.
It's an ip with format ipPrefix/length where address part of ipPrefix is 0.

The maximum string length in characters is 50. ||
|| peer_ip | **string**

PeerIp.
It's an ip with just an ipAddress format without mask.

The maximum string length in characters is 50. ||
|| cloud_ip | **string**

CloudIp.
It's an ip with just an ipAddress format without mask.

The maximum string length in characters is 50. ||
|| peer_bgp_asn | **int64**

PeerBgpAsn.
PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551). ||
|| cloud_bgp_asn | **int64**

CloudBgpAsn. ||
|| peer_bgp_md5_key | **string**

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