---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/SecurityGroup/updateRules.md
---

# Virtual Private Cloud API, gRPC: SecurityGroupService.UpdateRules {#UpdateRules}

Updates the rules of the specified security group.

## gRPC request

**rpc UpdateRules ([UpdateSecurityGroupRulesRequest](#yandex.cloud.vpc.v1.UpdateSecurityGroupRulesRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateSecurityGroupRulesRequest {#yandex.cloud.vpc.v1.UpdateSecurityGroupRulesRequest}

```json
{
  "securityGroupId": "string",
  "deletionRuleIds": [
    "string"
  ],
  "additionRuleSpecs": [
    {
      "description": "string",
      "labels": "string",
      "direction": "Direction",
      "ports": {
        "fromPort": "int64",
        "toPort": "int64"
      },
      // Includes only one of the fields `protocolName`, `protocolNumber`
      "protocolName": "string",
      "protocolNumber": "int64",
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
|| securityGroupId | **string**

Required field. ID of the SecurityGroup that is being updated with new rules. ||
|| deletionRuleIds[] | **string**

List of rules IDs to delete. ||
|| additionRuleSpecs[] | **[SecurityGroupRuleSpec](#yandex.cloud.vpc.v1.SecurityGroupRuleSpec)**

Security rules specifications. ||
|#

## SecurityGroupRuleSpec {#yandex.cloud.vpc.v1.SecurityGroupRuleSpec}

#|
||Field | Description ||
|| description | **string**

Description of the security rule. ||
|| labels | **string**

Rule labels as `` key:value `` pairs. ||
|| direction | enum **Direction**

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
|| protocolNumber | **int64**

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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "securityGroupId": "string",
    "addedRuleIds": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateSecurityGroupMetadata](#yandex.cloud.vpc.v1.UpdateSecurityGroupMetadata)**

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

## UpdateSecurityGroupMetadata {#yandex.cloud.vpc.v1.UpdateSecurityGroupMetadata}

#|
||Field | Description ||
|| securityGroupId | **string**

ID of the SecurityGroup that is being updated. ||
|| addedRuleIds[] | **string**

List of added security rules IDs. ||
|#

## SecurityGroup {#yandex.cloud.vpc.v1.SecurityGroup}

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
|| ports | **[PortRange](#yandex.cloud.vpc.v1.PortRange2)**

The range of ports that allow traffic to pass through. Null value means any. ||
|| protocolName | **string**

Protocol name. Null value means any protocol.
Values from [IANA](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). ||
|| protocolNumber | **int64**

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
|| fromPort | **int64**

The lowest port in the range. ||
|| toPort | **int64**

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