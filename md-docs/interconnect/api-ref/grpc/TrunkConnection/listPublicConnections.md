# Cloud Interconnect API, gRPC: TrunkConnectionService.ListPublicConnections

Retrieves the list of PublicConnection resources associated with the specified TrunkConnection.

## gRPC request

**rpc ListPublicConnections ([ListTrunkConnectionPublicConnectionsRequest](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsRequest)) returns ([ListTrunkConnectionPublicConnectionsResponse](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse))**

## ListTrunkConnectionPublicConnectionsRequest {#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsRequest}

```json
{
  "trunk_connection_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| trunk_connection_id | **string**

Required field. ID of the TrunkConnection resource.
To get the trunkConnection ID use a [TrunkConnectionService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListTrunkConnectionPublicConnectionsResponse.next_page_token](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListTrunkConnectionPublicConnectionsResponse.next_page_token](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse) returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## ListTrunkConnectionPublicConnectionsResponse {#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse}

```json
{
  "public_connections": [
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
is larger than [ListTrunkConnectionPublicConnectionsRequest.page_size](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsRequest), use
the `next_page_token` as the value
for the [ListTrunkConnectionPublicConnectionsRequest.page_token](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsRequest) query parameter
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
Value must match the regular expression ```\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?```. ||
|| description | **string**

Description of the publicConnection. 0-256 characters long. ||
|| folder_id | **string**

ID of the folder that the publicConnection belongs to. ||
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
- `CLOUD_SERVICE_YMQ`
- `CLOUD_SERVICE_SPEECH_SENSE`
- `CLOUD_SERVICE_AI_ASSISTANT` ||
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