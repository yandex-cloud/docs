---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/SecurityGroup/create.md
---

# Virtual Private Cloud API, REST: SecurityGroup.Create

Creates a security group in the specified folder and network.

## HTTP request

```
POST https://vpc.{{ api-host }}/vpc/v1/securityGroups
```

## Body parameters {#yandex.cloud.vpc.v1.CreateSecurityGroupRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "ruleSpecs": [
    {
      "description": "string",
      "labels": "object",
      "direction": "string",
      "ports": {
        "fromPort": "string",
        "toPort": "string"
      },
      // Includes only one of the fields `protocolName`, `protocolNumber`
      "protocolName": "string",
      "protocolNumber": "string",
      // end of the list of possible fields
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
  ]
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder for this request to create a security group in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the security group.
The name must be unique within the folder. ||
|| description | **string**

Description of the security group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. ||
|| networkId | **string**

Required field. ID of the Network to create security group for. ||
|| ruleSpecs[] | **[SecurityGroupRuleSpec](#yandex.cloud.vpc.v1.SecurityGroupRuleSpec)**

Security rules specifications. ||
|#

## SecurityGroupRuleSpec {#yandex.cloud.vpc.v1.SecurityGroupRuleSpec}

#|
||Field | Description ||
|| description | **string**

Description of the security rule. ||
|| labels | **object** (map<**string**, **string**>)

Rule labels as `` key:value `` pairs. ||
|| direction | **enum** (Direction)

Required field. The direction of network traffic allowed by this rule.

- `DIRECTION_UNSPECIFIED`
- `INGRESS`: Allows ingress traffic.
- `EGRESS`: Allows egress traffic. ||
|| ports | **[PortRange](#yandex.cloud.vpc.v1.PortRange)**

The range of ports that allow traffic to pass through. Null value means any port. ||
|| protocolName | **string**

Protocol name.

Includes only one of the fields `protocolName`, `protocolNumber`.

Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
Null value means any protocol. ||
|| protocolNumber | **string** (int64)

Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).

Includes only one of the fields `protocolName`, `protocolNumber`.

Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
Null value means any protocol. ||
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
|| fromPort | **string** (int64)

The lowest port in the range. ||
|| toPort | **string** (int64)

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "securityGroupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "networkId": "string",
    "status": "string",
    "rules": [
      {
        "id": "string",
        "description": "string",
        "labels": "object",
        "direction": "string",
        "ports": {
          "fromPort": "string",
          "toPort": "string"
        },
        "protocolName": "string",
        "protocolNumber": "string",
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
    "defaultForNetwork": "boolean"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateSecurityGroupMetadata](#yandex.cloud.vpc.v1.CreateSecurityGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[SecurityGroup](#yandex.cloud.vpc.v1.SecurityGroup)**

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

## CreateSecurityGroupMetadata {#yandex.cloud.vpc.v1.CreateSecurityGroupMetadata}

#|
||Field | Description ||
|| securityGroupId | **string**

ID of the security group that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## SecurityGroup {#yandex.cloud.vpc.v1.SecurityGroup}

#|
||Field | Description ||
|| id | **string**

ID of the security group. ||
|| folderId | **string**

ID of the folder that the security group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| networkId | **string**

ID of the network that the security group belongs to. ||
|| status | **enum** (Status)

Security group status.

- `STATUS_UNSPECIFIED`
- `CREATING`: Security group is being created.
- `ACTIVE`: Security is active and it's rules are applied to the network interfaces.
- `UPDATING`: Security group is updating. Updating is a long operation because we must update all instances in SG.
- `DELETING`: Instance is being deleted. ||
|| rules[] | **[SecurityGroupRule](#yandex.cloud.vpc.v1.SecurityGroupRule)**

List of the security group rules. ||
|| defaultForNetwork | **boolean**

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
|| direction | **enum** (Direction)

Required field. The direction of network traffic allowed by this rule.

- `DIRECTION_UNSPECIFIED`
- `INGRESS`: Allows ingress traffic.
- `EGRESS`: Allows egress traffic. ||
|| ports | **[PortRange](#yandex.cloud.vpc.v1.PortRange2)**

The range of ports that allow traffic to pass through. Null value means any. ||
|| protocolName | **string**

Protocol name. Null value means any protocol.
Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| protocolNumber | **string** (int64)

Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| cidrBlocks | **[CidrBlocks](#yandex.cloud.vpc.v1.CidrBlocks2)**

CIDR blocks to allow to recieve or send traffic.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|| securityGroupId | **string**

ID of the security group to add rule to.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|| predefinedTarget | **string**

Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information.

Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`. ||
|#

## PortRange {#yandex.cloud.vpc.v1.PortRange2}

#|
||Field | Description ||
|| fromPort | **string** (int64)

The lowest port in the range. ||
|| toPort | **string** (int64)

The highest port in the range. ||
|#

## CidrBlocks {#yandex.cloud.vpc.v1.CidrBlocks2}

#|
||Field | Description ||
|| v4CidrBlocks[] | **string**

IPv4 CIDR blocks to allow traffic to. ||
|| v6CidrBlocks[] | **string**

IPv6 CIDR blocks to allow traffic to. ||
|#