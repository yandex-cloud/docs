---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/PrivateConnection/create.md
---

# Cloud Interconnect API, gRPC: PrivateConnectionService.Create

Creates a PrivateConnection resource in the specified folder using the data specified in the request.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc Create ([CreatePrivateConnectionRequest](#yandex.cloud.cic.v1.CreatePrivateConnectionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreatePrivateConnectionRequest {#yandex.cloud.cic.v1.CreatePrivateConnectionRequest}

```json
{
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
  "ipv4_static_routes": [
    {
      "prefix": "string"
    }
  ],
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the privateConnection.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the privateConnection. 0-256 characters long. ||
|| folder_id | **string**

ID of the folder that the privateConnection belongs to. ||
|| region_id | **string**

ID of the region that the privateConnection belongs to. ||
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

## StaticRoute {#yandex.cloud.cic.v1.PrivateConnection.StaticRoute}

#|
||Field | Description ||
|| prefix | **string**

Prefix.
It's an ip with format ipPrefix/length where address part of ipPrefix is 0. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "private_connection_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
    "ipv4_static_routes": [
      {
        "prefix": "string"
      }
    ],
    "labels": "map<string, string>",
    "status": "Status",
    "created_at": "google.protobuf.Timestamp"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreatePrivateConnectionMetadata](#yandex.cloud.cic.v1.CreatePrivateConnectionMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[PrivateConnection](#yandex.cloud.cic.v1.PrivateConnection)**

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

## CreatePrivateConnectionMetadata {#yandex.cloud.cic.v1.CreatePrivateConnectionMetadata}

#|
||Field | Description ||
|| private_connection_id | **string**

ID of the PrivateConnection resource. ||
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
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the privateConnection. 0-256 characters long. ||
|| folder_id | **string**

ID of the folder that the privateConnection belongs to. ||
|| region_id | **string**

ID of the region that the privateConnection belongs to. ||
|| trunk_connection_id | **string**

ID of the trunk_connection that the privateConnection belongs to. ||
|| vlan_id | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

VLAN_ID that the privateConnection uses in multiplexing.
Not used in connections over partners-II
Value range: [1, 4095] ||
|| ipv4_peering | **[Peering](#yandex.cloud.cic.v1.Peering2)**

IPv4 peering config of connection ||
|| ipv4_static_routes[] | **[StaticRoute](#yandex.cloud.cic.v1.PrivateConnection.StaticRoute2)**

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

- `STATUS_UNSPECIFIED`
- `CREATING`
- `UPDATING`
- `DELETING`
- `ACTIVE` ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|#

## Peering {#yandex.cloud.cic.v1.Peering2}

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

## StaticRoute {#yandex.cloud.cic.v1.PrivateConnection.StaticRoute2}

#|
||Field | Description ||
|| prefix | **string**

Prefix.
It's an ip with format ipPrefix/length where address part of ipPrefix is 0. ||
|#