---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Subnet/list.md
---

# Virtual Private Cloud API, gRPC: SubnetService.List {#List}

Retrieves the list of Subnet resources in the specified folder.

## gRPC request

**rpc List ([ListSubnetsRequest](#yandex.cloud.vpc.v1.ListSubnetsRequest)) returns ([ListSubnetsResponse](#yandex.cloud.vpc.v1.ListSubnetsResponse))**

## ListSubnetsRequest {#yandex.cloud.vpc.v1.ListSubnetsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list subnets in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListSubnetsResponse.nextPageToken](#yandex.cloud.vpc.v1.ListSubnetsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListSubnetsResponse.nextPageToken](#yandex.cloud.vpc.v1.ListSubnetsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Subnet.name](#yandex.cloud.vpc.v1.Subnet) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListSubnetsResponse {#yandex.cloud.vpc.v1.ListSubnetsResponse}

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

List of Subnet resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListSubnetsRequest.pageSize](#yandex.cloud.vpc.v1.ListSubnetsRequest), use
the `nextPageToken` as the value
for the [ListSubnetsRequest.pageToken](#yandex.cloud.vpc.v1.ListSubnetsRequest) query parameter
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