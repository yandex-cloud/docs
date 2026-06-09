# Cloud Interconnect API, REST: TrunkConnection.ListPrivateConnections

Retrieves the list of PrivateConnection resources associated with the specified TrunkConnection.

## HTTP request

```
GET https://cic.{{ api-host }}/cic/v1/trunkConnections/{trunkConnectionId}/privateConnections
```

## Path parameters

#|
||Field | Description ||
|| trunkConnectionId | **string**

Required field. ID of the TrunkConnection resource.
To get the trunkConnection ID use a [TrunkConnectionService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.cic.v1.ListTrunkConnectionPrivateConnectionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListTrunkConnectionPrivateConnectionsResponse.nextPageToken](#yandex.cloud.cic.v1.ListTrunkConnectionPrivateConnectionsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListTrunkConnectionPrivateConnectionsResponse.nextPageToken](#yandex.cloud.cic.v1.ListTrunkConnectionPrivateConnectionsResponse) returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.cic.v1.ListTrunkConnectionPrivateConnectionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "privateConnections": [
    {
      "id": "string",
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
is larger than [ListTrunkConnectionPrivateConnectionsRequest.pageSize](#yandex.cloud.cic.v1.ListTrunkConnectionPrivateConnectionsRequest), use
the `nextPageToken` as the value
for the [ListTrunkConnectionPrivateConnectionsRequest.pageToken](#yandex.cloud.cic.v1.ListTrunkConnectionPrivateConnectionsRequest) query parameter
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

Description of the privateConnection. 0-256 characters long. ||
|| folderId | **string**

ID of the folder that the privateConnection belongs to. ||
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
|| cloudBgpAsn | **string** (int64)

CloudBgpAsn. ||
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