---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Network/listSubnets.md
---

# Virtual Private Cloud API, gRPC: NetworkService.ListSubnets {#ListSubnets}

Lists subnets from the specified network.

## gRPC request

**rpc ListSubnets ([ListNetworkSubnetsRequest](#yandex.cloud.vpc.v1.ListNetworkSubnetsRequest)) returns ([ListNetworkSubnetsResponse](#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse))**

## ListNetworkSubnetsRequest {#yandex.cloud.vpc.v1.ListNetworkSubnetsRequest}

```json
{
  "networkId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the Network resource to list subnets for. ||
|| pageSize | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`,
the service returns a [ListNetworkSubnetsResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListNetworkSubnetsResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse)
returned by a previous list request to get the next page of results. ||
|#

## ListNetworkSubnetsResponse {#yandex.cloud.vpc.v1.ListNetworkSubnetsResponse}

```json
{
  "subnets": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the subnet.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the subnet. 0-256 characters long. ||
|| labels | **string**

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