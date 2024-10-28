---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/SecurityGroup/get.md
---

# Virtual Private Cloud API, gRPC: SecurityGroupService.Get {#Get}

Returns the specified SecurityGroup resource.

To get the list of all available SecurityGroup resources, make a [List](/docs/vpc/api-ref/grpc/SecurityGroup/list#List) request.

## gRPC request

**rpc Get ([GetSecurityGroupRequest](#yandex.cloud.vpc.v1.GetSecurityGroupRequest)) returns ([SecurityGroup](#yandex.cloud.vpc.v1.SecurityGroup))**

## GetSecurityGroupRequest {#yandex.cloud.vpc.v1.GetSecurityGroupRequest}

```json
{
  "securityGroupId": "string"
}
```

#|
||Field | Description ||
|| securityGroupId | **string**

Required field. ID of the Security Group resource to return.
To get the security group ID, use a [SecurityGroup.List] request. ||
|#

## SecurityGroup {#yandex.cloud.vpc.v1.SecurityGroup}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "networkId": "string",
  "status": "Status",
  "rules": [
    {
      "id": "string",
      "description": "string",
      "labels": "string",
      "direction": "Direction",
      "ports": {
        "fromPort": "int64",
        "toPort": "int64"
      },
      "protocolName": "string",
      "protocolNumber": "int64",
      // Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`
      "cidrBlocks": {
        "v4CidrBlocks": [
          "string"
        ],
        "v6CidrBlocks": [
          "string"
        ]
      },
      "securityGroupId": "string",
      "predefinedTarget": "string"
      // end of the list of possible fields
    }
  ],
  "defaultForNetwork": "bool"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the security group. ||
|| folderId | **string**

ID of the folder that the security group belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the security group.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Description of the security group. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_./\\@0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_./\\@0-9a-z]*`. ||
|| networkId | **string**

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
|| defaultForNetwork | **bool**

Flag that indicates that the security group is the default for the network. ||
|#

## SecurityGroupRule {#yandex.cloud.vpc.v1.SecurityGroupRule}

#|
||Field | Description ||
|| id | **string**

ID of the rule. ||
|| description | **string**

Description of the rule. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| direction | enum **Direction**

Required field. The direction of network traffic allowed by this rule.

- `DIRECTION_UNSPECIFIED`
- `INGRESS`: Allows ingress traffic.
- `EGRESS`: Allows egress traffic. ||
|| ports | **[PortRange](#yandex.cloud.vpc.v1.PortRange)**

The range of ports that allow traffic to pass through. Null value means any. ||
|| protocolName | **string**

Protocol name. Null value means any protocol.
Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| protocolNumber | **int64**

Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| cidrBlocks | **[CidrBlocks](#yandex.cloud.vpc.v1.CidrBlocks)**

CIDR blocks to allow to recieve or send traffic.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|| securityGroupId | **string**

ID of the security group to add rule to.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|| predefinedTarget | **string**

Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|#

## PortRange {#yandex.cloud.vpc.v1.PortRange}

#|
||Field | Description ||
|| fromPort | **int64**

The lowest port in the range. ||
|| toPort | **int64**

The highest port in the range. ||
|#

## CidrBlocks {#yandex.cloud.vpc.v1.CidrBlocks}

#|
||Field | Description ||
|| v4CidrBlocks[] | **string**

IPv4 CIDR blocks to allow traffic to. ||
|| v6CidrBlocks[] | **string**

IPv6 CIDR blocks to allow traffic to. ||
|#