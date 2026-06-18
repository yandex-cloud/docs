---
editable: false
---

# Virtual Private Cloud API, gRPC: SecurityGroupService.UpdateRules

Updates the rules of the specified security group.

## gRPC request

**rpc UpdateRules ([UpdateSecurityGroupRulesRequest](#yandex.cloud.vpc.v1.UpdateSecurityGroupRulesRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateSecurityGroupRulesRequest {#yandex.cloud.vpc.v1.UpdateSecurityGroupRulesRequest}

```json
{
  "security_group_id": "string",
  "deletion_rule_ids": [
    "string"
  ],
  "addition_rule_specs": [
    {
      "description": "string",
      "labels": "map<string, string>",
      "direction": "Direction",
      "ports": {
        "from_port": "int64",
        "to_port": "int64"
      },
      // Includes only one of the fields `protocol_name`, `protocol_number`
      "protocol_name": "string",
      "protocol_number": "int64",
      // end of the list of possible fields
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
  ]
}
```

#|
||Field | Description ||
|| security_group_id | **string**

ID of the SecurityGroup that is being updated with new rules.
This field is required. ||
|| deletion_rule_ids[] | **string**

List of rules IDs to delete. ||
|| addition_rule_specs[] | **[SecurityGroupRuleSpec](#yandex.cloud.vpc.v1.SecurityGroupRuleSpec)**

Security rules specifications. ||
|#

## SecurityGroupRuleSpec {#yandex.cloud.vpc.v1.SecurityGroupRuleSpec}

#|
||Field | Description ||
|| description | **string**

Description of the security rule.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Rule labels as `` key:value `` pairs.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| direction | enum **Direction**

The direction of network traffic allowed by this rule.
This field is required.

- `INGRESS`: Allows ingress traffic.
- `EGRESS`: Allows egress traffic. ||
|| ports | **[PortRange](#yandex.cloud.vpc.v1.PortRange)**

The range of ports that allow traffic to pass through. Null value means any port. ||
|| protocol_name | **string**

Protocol name.

Includes only one of the fields `protocol_name`, `protocol_number`.

Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
Null value means any protocol. ||
|| protocol_number | **int64**

Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).

Includes only one of the fields `protocol_name`, `protocol_number`.

Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
Null value means any protocol. ||
|| cidr_blocks | **[CidrBlocks](#yandex.cloud.vpc.v1.CidrBlocks)**

CIDR blocks to allow to recieve or send traffic.

Includes only one of the fields `cidr_blocks`, `security_group_id`, `predefined_target`.

Only one field must be specified. ||
|| security_group_id | **string**

ID of the security group to add rule to.

Includes only one of the fields `cidr_blocks`, `security_group_id`, `predefined_target`.

Only one field must be specified. ||
|| predefined_target | **string**

Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information.

Includes only one of the fields `cidr_blocks`, `security_group_id`, `predefined_target`.

Only one field must be specified. ||
|#

## PortRange {#yandex.cloud.vpc.v1.PortRange}

#|
||Field | Description ||
|| from_port | **int64**

The lowest port in the range.
The value must be between 0 and 65535. ||
|| to_port | **int64**

The highest port in the range.
The value must be between 0 and 65535. ||
|#

## CidrBlocks {#yandex.cloud.vpc.v1.CidrBlocks}

#|
||Field | Description ||
|| v4_cidr_blocks[] | **string**

IPv4 CIDR blocks to allow traffic to. ||
|| v6_cidr_blocks[] | **string**

IPv6 CIDR blocks to allow traffic to. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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