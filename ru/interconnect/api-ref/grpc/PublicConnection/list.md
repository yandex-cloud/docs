---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/PublicConnection/list.md
---

# Cloud Interconnect API, gRPC: PublicConnectionService.List

Retrieves the list of PublicConnection resources in the specified folder.

## gRPC request

**rpc List ([ListPublicConnectionsRequest](#yandex.cloud.cic.v1.ListPublicConnectionsRequest)) returns ([ListPublicConnectionsResponse](#yandex.cloud.cic.v1.ListPublicConnectionsResponse))**

## ListPublicConnectionsRequest {#yandex.cloud.cic.v1.ListPublicConnectionsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list publicConnections in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListPublicConnectionsResponse.next_page_token](#yandex.cloud.cic.v1.ListPublicConnectionsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicConnectionsResponse.next_page_token](#yandex.cloud.cic.v1.ListPublicConnectionsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Subnet.name] field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListPublicConnectionsResponse {#yandex.cloud.cic.v1.ListPublicConnectionsResponse}

```json
{
  "public_connections": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| public_connections[] | **[PublicConnection](#yandex.cloud.cic.v1.PublicConnection)**

List of PublicConnection resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListPublicConnectionsRequest.page_size](#yandex.cloud.cic.v1.ListPublicConnectionsRequest), use
the `next_page_token` as the value
for the [ListPublicConnectionsRequest.page_token](#yandex.cloud.cic.v1.ListPublicConnectionsRequest) query parameter
in the next list request. Subsequent list requests will have their own
`next_page_token` to continue paging through the results. ||
|#

## PublicConnection {#yandex.cloud.cic.v1.PublicConnection}

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