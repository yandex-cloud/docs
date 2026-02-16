---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Subnet/get.md
---

# Virtual Private Cloud API, gRPC: SubnetService.Get

Returns the specified Subnet resource.

To get the list of available Subnet resources, make a [List](/docs/vpc/api-ref/grpc/Subnet/list#List) request.

## gRPC request

**rpc Get ([GetSubnetRequest](#yandex.cloud.vpc.v1.GetSubnetRequest)) returns ([Subnet](#yandex.cloud.vpc.v1.Subnet))**

## GetSubnetRequest {#yandex.cloud.vpc.v1.GetSubnetRequest}

```json
{
  "subnet_id": "string"
}
```

#|
||Field | Description ||
|| subnet_id | **string**

Required field. ID of the Subnet resource to return.
To get the subnet ID use a [SubnetService.List](/docs/vpc/api-ref/grpc/Subnet/list#List) request. ||
|#

## Subnet {#yandex.cloud.vpc.v1.Subnet}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "network_id": "string",
  "zone_id": "string",
  "v4_cidr_blocks": [
    "string"
  ],
  "v6_cidr_blocks": [
    "string"
  ],
  "route_table_id": "string",
  "dhcp_options": {
    "domain_name_servers": [
      "string"
    ],
    "domain_name": "string",
    "ntp_servers": [
      "string"
    ]
  }
}
```

A Subnet resource. For more information, see [Subnets](/docs/vpc/concepts/network#subnet).

#|
||Field | Description ||
|| id | **string**

ID of the subnet. ||
|| folder_id | **string**

ID of the folder that the subnet belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
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
|| network_id | **string**

ID of the network the subnet belongs to. ||
|| zone_id | **string**

ID of the availability zone where the subnet resides. ||
|| v4_cidr_blocks[] | **string**

CIDR block.
The range of internal addresses that are defined for this subnet.
This field can be set only at Subnet resource creation time and cannot be changed.
For example, 10.0.0.0/22 or 192.168.0.0/24.
Minimum subnet size is /28, maximum subnet size is /16. ||
|| v6_cidr_blocks[] | **string**

IPv6 not available yet. ||
|| route_table_id | **string**

ID of route table the subnet is linked to. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.vpc.v1.DhcpOptions)**

DHCP options for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.vpc.v1.DhcpOptions}

#|
||Field | Description ||
|| domain_name_servers[] | **string**

A list of DHCP servers for this subnet. ||
|| domain_name | **string**

A domain name to us as a suffix when resolving host names in this subnet. ||
|| ntp_servers[] | **string**

List of NTP servers for this subnet. ||
|#