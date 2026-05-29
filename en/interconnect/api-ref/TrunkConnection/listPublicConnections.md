---
editable: false
apiPlayground:
  - url: https://cic.{{ api-host }}/cic/v1/trunkConnections/{trunkConnectionId}/publicConnections
    method: get
    path:
      type: object
      properties:
        trunkConnectionId:
          description: |-
            **string**
            Required field. ID of the TrunkConnection resource.
            To get the trunkConnection ID use a [TrunkConnectionService.List](/docs/interconnect/api-ref/TrunkConnection/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - trunkConnectionId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListTrunkConnectionPublicConnectionsResponse.nextPageToken](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse)
            that can be used to get the next page of results in subsequent list requests. Default value: 100.
            The maximum value is 1000.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListTrunkConnectionPublicConnectionsResponse.nextPageToken](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse) returned by a previous list request.
            The maximum string length in characters is 100.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The maximum string length in characters is 1000.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Cloud Interconnect API, REST: TrunkConnection.ListPublicConnections

Retrieves the list of PublicConnection resources associated with the specified TrunkConnection.

## HTTP request

```
GET https://cic.{{ api-host }}/cic/v1/trunkConnections/{trunkConnectionId}/publicConnections
```

## Path parameters

#|
||Field | Description ||
|| trunkConnectionId | **string**

Required field. ID of the TrunkConnection resource.
To get the trunkConnection ID use a [TrunkConnectionService.List](/docs/interconnect/api-ref/TrunkConnection/list#List) request.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListTrunkConnectionPublicConnectionsResponse.nextPageToken](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListTrunkConnectionPublicConnectionsResponse.nextPageToken](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse) returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "publicConnections": [
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
      "ipv4AllowedServiceTypes": [
        "string"
      ],
      "ipv4PeerAnnouncedPrefixes": [
        "string"
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
|| publicConnections[] | **[PublicConnection](#yandex.cloud.cic.v1.PublicConnection)**

List of PublicConnection resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListTrunkConnectionPublicConnectionsRequest.pageSize](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsRequest), use
the `nextPageToken` as the value
for the [ListTrunkConnectionPublicConnectionsRequest.pageToken](#yandex.cloud.cic.v1.ListTrunkConnectionPublicConnectionsRequest) query parameter
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

Description of the publicConnection. 0-256 characters long. ||
|| folderId | **string**

ID of the folder that the publicConnection belongs to. ||
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
|| ipv4PeerAnnouncedPrefixes[] | **string**

IPv4 Peer Announced Prefixes
It's an list of ip with format ipPrefix/length where address part of ipPrefix is 0 ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| status | **enum** (Status)

Status of the publicConnection.

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