---
editable: false
sourcePath: en/_api-ref/cic/v1/api-ref/PrivateConnection/list.md
---

# Cloud Interconnect API, REST: PrivateConnection.List

Retrieves the list of PrivateConnection resources in the specified folder.

## HTTP request

```
GET https://cic-api.{{ api-host }}/cic/v1/privateConnections
```

## Query parameters {#yandex.cloud.cic.v1.ListPrivateConnectionsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list privateConnections in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListPrivatesConnectionResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListPrivatesConnectionResponse.next_page_token] returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Subnet.name] field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.cic.v1.ListPrivateConnectionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "privateConnections": [
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
          "prefix": "string",
          "nextHop": [
            "string"
          ]
        }
      ],
      "labels": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| privateConnections[] | **[PrivateConnection](#yandex.cloud.cic.v1.PrivateConnection)**

List of PrivateConnection resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListPrivateConnectionsRequest.pageSize](#yandex.cloud.cic.v1.ListPrivateConnectionsRequest), use
the `nextPageToken` as the value
for the [ListPrivateConnectionsRequest.pageToken](#yandex.cloud.cic.v1.ListPrivateConnectionsRequest) query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
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