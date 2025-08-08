---
editable: false
apiPlayground:
  - url: https://vpc.{{ api-host }}/vpc/v1/networks/{networkId}/subnets
    method: get
    path:
      type: object
      properties:
        networkId:
          description: |-
            **string**
            Required field. ID of the Network resource to list subnets for.
          type: string
      required:
        - networkId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListNetworkSubnetsResponse.nextPageToken](/docs/vpc/api-ref/Network/listSubnets#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse)
            that can be used to get the next page of results in subsequent list requests. Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `pageToken`
            to the [ListNetworkSubnetsResponse.nextPageToken](/docs/vpc/api-ref/Network/listSubnets#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse)
            returned by a previous list request to get the next page of results.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/vpc/v1/api-ref/Network/listSubnets.md
---

# Virtual Private Cloud API, REST: Network.ListSubnets

Lists subnets from the specified network.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/networks/{networkId}/subnets
```

## Path parameters

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the Network resource to list subnets for. ||
|#

## Query parameters {#yandex.cloud.vpc.v1.ListNetworkSubnetsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`,
the service returns a [ListNetworkSubnetsResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListNetworkSubnetsResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse)
returned by a previous list request to get the next page of results. ||
|#

## Response {#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse}

**HTTP Code: 200 - OK**

```json
{
  "subnets": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "networkId": "string",
      "zoneId": "string",
      "v4CidrBlocks": [
        "string"
      ],
      "v6CidrBlocks": [
        "string"
      ],
      "routeTableId": "string",
      "dhcpOptions": {
        "domainNameServers": [
          "string"
        ],
        "domainName": "string",
        "ntpServers": [
          "string"
        ]
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| subnets[] | **[Subnet](#yandex.cloud.vpc.v1.Subnet)**

List of subnets that belong to the network which is specified in the request. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListNetworkSubnetsRequest.pageSize](#yandex.cloud.vpc.v1.ListNetworkSubnetsRequest), use
the `nextPageToken` as the value
for the [ListNetworkSubnetsRequest.pageToken](#yandex.cloud.vpc.v1.ListNetworkSubnetsRequest) query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
|#

## Subnet {#yandex.cloud.vpc.v1.Subnet}

A Subnet resource. For more information, see [Subnets](/docs/vpc/concepts/network#subnet).

#|
||Field | Description ||
|| id | **string**

ID of the subnet. ||
|| folderId | **string**

ID of the folder that the subnet belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the subnet.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the subnet. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| networkId | **string**

ID of the network the subnet belongs to. ||
|| zoneId | **string**

ID of the availability zone where the subnet resides. ||
|| v4CidrBlocks[] | **string**

CIDR block.
The range of internal addresses that are defined for this subnet.
This field can be set only at Subnet resource creation time and cannot be changed.
For example, 10.0.0.0/22 or 192.168.0.0/24.
Minimum subnet size is /28, maximum subnet size is /16. ||
|| v6CidrBlocks[] | **string**

IPv6 not available yet. ||
|| routeTableId | **string**

ID of route table the subnet is linked to. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.vpc.v1.DhcpOptions)**

DHCP options for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.vpc.v1.DhcpOptions}

#|
||Field | Description ||
|| domainNameServers[] | **string**

A list of DHCP servers for this subnet. ||
|| domainName | **string**

A domain name to us as a suffix when resolving host names in this subnet. ||
|| ntpServers[] | **string**

List of NTP servers for this subnet. ||
|#