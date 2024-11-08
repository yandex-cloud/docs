---
editable: false
sourcePath: en/_api-ref/cic/v1/api-ref/PublicConnection/list.md
---

# Cloud Interconnect API, REST: PublicConnection.List {#List}

Retrieves the list of PublicConnection resources in the specified folder.

## HTTP request

```
GET https://cic.{{ api-host }}/cic/v1/publicConnections
```

## Query parameters {#yandex.cloud.cic.v1.ListPublicConnectionsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list publicConnections in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListPublicConnectionsResponse.nextPageToken](#yandex.cloud.cic.v1.ListPublicConnectionsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListPublicConnectionsResponse.nextPageToken](#yandex.cloud.cic.v1.ListPublicConnectionsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Subnet.name] field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.cic.v1.ListPublicConnectionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "publicConnections": [
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
      "ipv4AllowedServiceTypes": [
        "string"
      ],
      "ipv4PeerAnnouncedPrefixes": [
        "string"
      ],
      "labels": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| publicConnections[] | **[PublicConnection](#yandex.cloud.cic.v1.PublicConnection)**

List of PublicConnection resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListPublicConnectionsRequest.pageSize](#yandex.cloud.cic.v1.ListPublicConnectionsRequest), use
the `nextPageToken` as the value
for the [ListPublicConnectionsRequest.pageToken](#yandex.cloud.cic.v1.ListPublicConnectionsRequest) query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
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
|| folderId | **string**

ID of the folder that the publicConnection belongs to. ||
|| regionId | **string**

ID of the region that the publicConnection belongs to. ||
|| trunkConnectionId | **string**

ID of the trunk_connection that the publicConnection belongs to. ||
|| vlanId | **string** (int64)

VLAN_ID that the privateConnection uses in multiplexing.
Not used in connections over partners-II
Value range: [1, 4095] ||
|| ipv4Peering | **[Peering](#yandex.cloud.cic.v1.Peering)**

IPv4 peering config of connection ||
|| ipv4AllowedServiceTypes[] | **enum** (CloudServiceType)

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
|| ipv4PeerAnnouncedPrefixes[] | **string**

IPv4 Peer Announced Prefixes
It's an list of ip with format ipPrefix/length where address part of ipPrefix is 0 ||
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
|| peerBgpAsn | **string** (int64)

PeerBgpAsn.
PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551). ||
|| cloudBgpAsn | **string** (int64)

CloudBgpAsn. ||
|| peerBgpMd5Key | **string**

PeerBgpMd5Key.
Optional. ||
|#