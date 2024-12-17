---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Subnet/create.md
---

# Virtual Private Cloud API, gRPC: SubnetService.Create

Creates a subnet in the specified folder and network.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc Create ([CreateSubnetRequest](#yandex.cloud.vpc.v1.CreateSubnetRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateSubnetRequest {#yandex.cloud.vpc.v1.CreateSubnetRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "network_id": "string",
  "zone_id": "string",
  "v4_cidr_blocks": [
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

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create a subnet in.
To get folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the subnet.
The name must be unique within the folder. ||
|| description | **string**

Description of the subnet. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `` key:value `` pairs. ||
|| network_id | **string**

Required field. ID of the network to create subnet in. ||
|| zone_id | **string**

Required field. ID of the availability zone where the subnet resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| v4_cidr_blocks[] | **string**

Required field. CIDR block.
The range of internal addresses that are defined for this subnet.
For example, 10.0.0.0/22 or 192.168.0.0/24.
Minimum subnet size is /28, maximum subnet size is /16. ||
|| route_table_id | **string**

ID of route table the subnet is linked to. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.vpc.v1.DhcpOptions)** ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "subnet_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSubnetMetadata](#yandex.cloud.vpc.v1.CreateSubnetMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Subnet](#yandex.cloud.vpc.v1.Subnet)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreateSubnetMetadata {#yandex.cloud.vpc.v1.CreateSubnetMetadata}

#|
||Field | Description ||
|| subnet_id | **string**

ID of the subnet that is being created. ||
|#

## Subnet {#yandex.cloud.vpc.v1.Subnet}

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
|| dhcp_options | **[DhcpOptions](#yandex.cloud.vpc.v1.DhcpOptions2)**

DHCP options for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.vpc.v1.DhcpOptions2}

#|
||Field | Description ||
|| domain_name_servers[] | **string**

A list of DHCP servers for this subnet. ||
|| domain_name | **string**

A domain name to us as a suffix when resolving host names in this subnet. ||
|| ntp_servers[] | **string**

List of NTP servers for this subnet. ||
|#