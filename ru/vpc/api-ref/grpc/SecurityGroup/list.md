---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/SecurityGroup/list.md
---

# Virtual Private Cloud API, gRPC: SecurityGroupService.List

Retrieves the list of SecurityGroup resources in the specified folder.

## gRPC request

**rpc List ([ListSecurityGroupsRequest](#yandex.cloud.vpc.v1.ListSecurityGroupsRequest)) returns ([ListSecurityGroupsResponse](#yandex.cloud.vpc.v1.ListSecurityGroupsResponse))**

## ListSecurityGroupsRequest {#yandex.cloud.vpc.v1.ListSecurityGroupsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list security groups in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListSecurityGroupsResponse.next_page_token](#yandex.cloud.vpc.v1.ListSecurityGroupsResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListSecurityGroupsResponse.next_page_token](#yandex.cloud.vpc.v1.ListSecurityGroupsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [SecurityGroup.name](#yandex.cloud.vpc.v1.SecurityGroup) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListSecurityGroupsResponse {#yandex.cloud.vpc.v1.ListSecurityGroupsResponse}

```json
{
  "security_groups": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "network_id": "string",
      "status": "Status",
      "rules": [
        {
          "id": "string",
          "description": "string",
          "labels": "map<string, string>",
          "direction": "Direction",
          "ports": {
            "from_port": "int64",
            "to_port": "int64"
          },
          "protocol_name": "string",
          "protocol_number": "int64",
          // Includes only one of the fields `cidr_blocks`, `security_group_id`, `predefined_target`
          "cidr_blocks": {
            "v4_cidr_blocks": [
              "string"
            ],
            "v6_cidr_blocks": [
              "string"
            ]
          },
          "security_group_id": "string",
          "predefined_target": "string"
          // end of the list of possible fields
        }
      ],
      "default_for_network": "bool"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| security_groups[] | **[SecurityGroup](#yandex.cloud.vpc.v1.SecurityGroup)**

List of SecurityGroup resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListNetworksRequest.page_size](/docs/vpc/api-ref/grpc/Network/list#yandex.cloud.vpc.v1.ListNetworksRequest), use
the `next_page_token` as the value
for the [ListNetworksRequest.page_token](/docs/vpc/api-ref/grpc/Network/list#yandex.cloud.vpc.v1.ListNetworksRequest) query parameter
in the next list request. Subsequent list requests will have their own
`next_page_token` to continue paging through the results. ||
|#

## SecurityGroup {#yandex.cloud.vpc.v1.SecurityGroup}

#|
||Field | Description ||
|| id | **string**

ID of the security group. ||
|| folder_id | **string**

ID of the folder that the security group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the security group.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Description of the security group. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_./\\@0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_./\\@0-9a-z]*`. ||
|| network_id | **string**

ID of the network that the security group belongs to. ||
|| status | enum **Status**

Security group status.

- `STATUS_UNSPECIFIED`
- `CREATING`: Security group is being created.
- `ACTIVE`: Security is active and it's rules are applied to the network interfaces.
- `UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.
- `DELETING`: Instance is being deleted. ||
|| rules[] | **[SecurityGroupRule](#yandex.cloud.vpc.v1.SecurityGroupRule)**

List of the security group rules. ||
|| default_for_network | **bool**

Flag that indicates that the security group is the default for the network. ||
|#

## SecurityGroupRule {#yandex.cloud.vpc.v1.SecurityGroupRule}

#|
||Field | Description ||
|| id | **string**

ID of the rule. ||
|| description | **string**

Description of the rule. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| direction | enum **Direction**

Required field. The direction of network traffic allowed by this rule.

- `DIRECTION_UNSPECIFIED`
- `INGRESS`: Allows ingress traffic.
- `EGRESS`: Allows egress traffic. ||
|| ports | **[PortRange](#yandex.cloud.vpc.v1.PortRange)**

The range of ports that allow traffic to pass through. Null value means any. ||
|| protocol_name | **string**

Protocol name. Null value means any protocol.
Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| protocol_number | **int64**

Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| cidr_blocks | **[CidrBlocks](#yandex.cloud.vpc.v1.CidrBlocks)**

CIDR blocks to allow to recieve or send traffic.

Includes only one of the fields `cidr_blocks`, `security_group_id`, `predefined_target`. ||
|| security_group_id | **string**

ID of the security group to add rule to.

Includes only one of the fields `cidr_blocks`, `security_group_id`, `predefined_target`. ||
|| predefined_target | **string**

Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information.

Includes only one of the fields `cidr_blocks`, `security_group_id`, `predefined_target`. ||
|#

## PortRange {#yandex.cloud.vpc.v1.PortRange}

#|
||Field | Description ||
|| from_port | **int64**

The lowest port in the range. ||
|| to_port | **int64**

The highest port in the range. ||
|#

## CidrBlocks {#yandex.cloud.vpc.v1.CidrBlocks}

#|
||Field | Description ||
|| v4_cidr_blocks[] | **string**

IPv4 CIDR blocks to allow traffic to. ||
|| v6_cidr_blocks[] | **string**

IPv6 CIDR blocks to allow traffic to. ||
|#