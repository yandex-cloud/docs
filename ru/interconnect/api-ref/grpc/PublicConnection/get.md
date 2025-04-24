---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/PublicConnection/get.md
---

# Cloud Interconnect API, gRPC: PublicConnectionService.Get

Returns the specified PublicConnection resource.

To get the list of available PublicConnection resources, make a [List](/docs/interconnect/api-ref/grpc/PublicConnection/list#List) request.

## gRPC request

**rpc Get ([GetPublicConnectionRequest](#yandex.cloud.cic.v1.GetPublicConnectionRequest)) returns ([PublicConnection](#yandex.cloud.cic.v1.PublicConnection))**

## GetPublicConnectionRequest {#yandex.cloud.cic.v1.GetPublicConnectionRequest}

```json
{
  "public_connection_id": "string"
}
```

#|
||Field | Description ||
|| public_connection_id | **string**

Required field. ID of the PublicConnection resource to return.
To get the publicConnection ID use a [PublicConnectionService.List](/docs/interconnect/api-ref/grpc/PublicConnection/list#List) request. ||
|#

## PublicConnection {#yandex.cloud.cic.v1.PublicConnection}

```json
{
  "id": "string",
  "name": "string",
  "description": "string",
  "folder_id": "string",
  "region_id": "string",
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
  "ipv4_allowed_service_types": [
    "CloudServiceType"
  ],
  "ipv4_peer_announced_prefixes": [
    "string"
  ],
  "labels": "map<string, string>",
  "status": "Status",
  "created_at": "google.protobuf.Timestamp"
}
```

A PublicConnection resource.

#|
||Field | Description ||
|| id | **string**

ID of the publicConnection. ||
|| name | **string**

Name of the publicConnection.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the publicConnection. 0-256 characters long. ||
|| folder_id | **string**

ID of the folder that the publicConnection belongs to. ||
|| region_id | **string**

ID of the region that the publicConnection belongs to. ||
|| trunk_connection_id | **string**

ID of the trunk_connection that the publicConnection belongs to. ||
|| vlan_id | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

VLAN_ID that the privateConnection uses in multiplexing.
Not used in connections over partners-II
Value range: [1, 4095] ||
|| ipv4_peering | **[Peering](#yandex.cloud.cic.v1.Peering)**

IPv4 peering config of connection ||
|| ipv4_allowed_service_types[] | enum **CloudServiceType**

Cloud services that the publicConnection connects to.

- `CLOUD_SERVICE_TYPE_UNSPECIFIED`
- `CLOUD_SERVICE_YANDEX`
- `CLOUD_SERVICE_ALL_PUBLIC`
- `CLOUD_SERVICE_S3`
- `CLOUD_SERVICE_ML`
- `CLOUD_SERVICE_APIGW`
- `CLOUD_SERVICE_CONTAINER_REGISTRY`
- `CLOUD_SERVICE_CONSOLE`
- `CLOUD_SERVICE_MONITORING`
- `CLOUD_SERVICE_YANDEX_GPT`
- `CLOUD_SERVICES_ALL_API_ENDPOINT`
- `CLOUD_SERVICE_YMQ` ||
|| ipv4_peer_announced_prefixes[] | **string**

IPv4 Peer Announced Prefixes
It's an list of ip with format ipPrefix/length where address part of ipPrefix is 0 ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| status | enum **Status**

Status of the publicConnection.

- `STATUS_UNSPECIFIED`
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
It's an ip with format ipPrefix/length where address part of ipPrefix is 0. ||
|| peer_ip | **string**

PeerIp.
It's an ip with just an ipAddress format without mask. ||
|| cloud_ip | **string**

CloudIp.
It's an ip with just an ipAddress format without mask. ||
|| peer_bgp_asn | **int64**

PeerBgpAsn.
PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551). ||
|| cloud_bgp_asn | **int64**

CloudBgpAsn. ||
|| peer_bgp_md5_key | **string**

PeerBgpMd5Key.
Optional. ||
|#