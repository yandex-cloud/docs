---
editable: false
apiPlayground:
  - url: https://vpc.{{ api-host }}/vpc/v1/securityGroups/{securityGroupId}
    method: patch
    path:
      type: object
      properties:
        securityGroupId:
          description: |-
            **string**
            Required field. ID of the security group to update.
            To get the security group ID make a [SecurityGroupService.List](/docs/vpc/api-ref/SecurityGroup/list#List) request.
          type: string
      required:
        - securityGroupId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            New name for the security group.
            The name must be unique within the folder.
          pattern: '|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?'
          type: string
        description:
          description: |-
            **string**
            New description of the security group.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Security group labels as `key:value` pairs.
            Existing set of labels is completely replaced by the provided set, so if you just want
            to add or remove a label:
            1. Get the current set of labels with a [SecurityGroupService.Get](/docs/vpc/api-ref/SecurityGroup/get#Get) request.
            2. Add or remove a label in this set.
            3. Send the new set in this field.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_./\@0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_./\@0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        ruleSpecs:
          description: |-
            **[SecurityGroupRuleSpec](#yandex.cloud.vpc.v1.SecurityGroupRuleSpec)**
            Updated rule list. All existing rules will be replaced with given list.
          type: array
          items:
            $ref: '#/definitions/SecurityGroupRuleSpec'
      additionalProperties: false
    definitions:
      PortRange:
        type: object
        properties:
          fromPort:
            description: |-
              **string** (int64)
              The lowest port in the range.
            type: string
            format: int64
          toPort:
            description: |-
              **string** (int64)
              The highest port in the range.
            type: string
            format: int64
      CidrBlocks:
        type: object
        properties:
          v4CidrBlocks:
            description: |-
              **string**
              IPv4 CIDR blocks to allow traffic to.
            type: array
            items:
              type: string
          v6CidrBlocks:
            description: |-
              **string**
              IPv6 CIDR blocks to allow traffic to.
            type: array
            items:
              type: string
      SecurityGroupRuleSpec:
        type: object
        properties:
          description:
            description: |-
              **string**
              Description of the security rule.
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Rule labels as `` key:value `` pairs.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_./\@0-9a-z]*'
              maxLength: 63
            propertyNames:
              type: string
              pattern: '[a-z][-_./\@0-9a-z]*'
              maxLength: 63
              minLength: 1
            maxProperties: 64
          direction:
            description: |-
              **enum** (Direction)
              Required field. The direction of network traffic allowed by this rule.
              - `DIRECTION_UNSPECIFIED`
              - `INGRESS`: Allows ingress traffic.
              - `EGRESS`: Allows egress traffic.
            type: string
            enum:
              - DIRECTION_UNSPECIFIED
              - INGRESS
              - EGRESS
          ports:
            description: |-
              **[PortRange](#yandex.cloud.vpc.v1.PortRange)**
              The range of ports that allow traffic to pass through. Null value means any port.
            $ref: '#/definitions/PortRange'
          protocolName:
            description: |-
              **string**
              Protocol name.
              Includes only one of the fields `protocolName`, `protocolNumber`.
              Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
              Null value means any protocol.
            type: string
          protocolNumber:
            description: |-
              **string** (int64)
              Protocol number from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
              Includes only one of the fields `protocolName`, `protocolNumber`.
              Values from [IANA protocol numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml).
              Null value means any protocol.
            type: string
            format: int64
          cidrBlocks:
            description: |-
              **[CidrBlocks](#yandex.cloud.vpc.v1.CidrBlocks)**
              CIDR blocks to allow to recieve or send traffic.
              Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`.
            $ref: '#/definitions/CidrBlocks'
          securityGroupId:
            description: |-
              **string**
              ID of the security group to add rule to.
              Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`.
            type: string
          predefinedTarget:
            description: |-
              **string**
              Predefined target. See [security groups rules](/docs/vpc/concepts/security-groups#security-groups-rules) for more information.
              Includes only one of the fields `cidrBlocks`, `securityGroupId`, `predefinedTarget`.
            type: string
        required:
          - direction
        allOf:
          - oneOf:
              - required:
                  - protocolName
              - required:
                  - protocolNumber
          - oneOf:
              - required:
                  - cidrBlocks
              - required:
                  - securityGroupId
              - required:
                  - predefinedTarget
sourcePath: en/_api-ref/vpc/v1/api-ref/SecurityGroup/update.md
---

# Virtual Private Cloud API, REST: SecurityGroup.Update

Updates the specified security group.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
PATCH https://vpc.{{ api-host }}/vpc/v1/securityGroups/{securityGroupId}
```

## Path parameters

#|
||Field | Description ||
|| securityGroupId | **string**

Required field. ID of the security group to update.

To get the security group ID make a [SecurityGroupService.List](/docs/vpc/api-ref/SecurityGroup/list#List) request. ||
|#

## Body parameters {#yandex.cloud.vpc.v1.UpdateSecurityGroupRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name for the security group.
The name must be unique within the folder. ||
|| description | **string**

New description of the security group. ||
|| labels | **object** (map<**string**, **string**>)

Security group labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [SecurityGroupService.Get](/docs/vpc/api-ref/SecurityGroup/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| ruleSpecs[] | **[SecurityGroupRuleSpec](#yandex.cloud.vpc.v1.SecurityGroupRuleSpec)**

Updated rule list. All existing rules will be replaced with given list. ||
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
    "securityGroupId": "string",
    "addedRuleIds": [
      "string"
    ]
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
|| metadata | **[UpdateSecurityGroupMetadata](#yandex.cloud.vpc.v1.UpdateSecurityGroupMetadata)**

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

## UpdateSecurityGroupMetadata {#yandex.cloud.vpc.v1.UpdateSecurityGroupMetadata}

#|
||Field | Description ||
|| securityGroupId | **string**

ID of the SecurityGroup that is being updated. ||
|| addedRuleIds[] | **string**

List of added security rules IDs. ||
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