---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/publicSubnets
    method: post
    path:
      type: object
      properties:
        cloudId:
          description: |-
            **string**
            ID of the parent cloud.
            To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request.
          type: string
        folderId:
          description: |-
            **string**
            ID of the parent folder.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        publicSubnet:
          description: |-
            **[PublicSubnet](#yandex.cloud.baremetal.v2.PublicSubnet)**
            PublicSubnet resource to create.
          $ref: '#/definitions/PublicSubnet'
      additionalProperties: false
    definitions:
      AutoAllocation:
        type: object
        properties:
          prefixLength:
            description: |-
              **string** (int64)
              Prefix length of the public subnet CIDR block.
              Acceptable values are 1 to 31, inclusive.
            type: string
            format: int64
      ManualAllocation:
        type: object
        properties:
          cidr:
            description: |-
              **string**
              CIDR block of the public subnet. Must be within the public prefix pool CIDR block.
            type: string
          publicPrefixPoolId:
            description: |-
              **string**
              ID of the public prefix pool that the CIDR block belongs to.
              To get a list of available public prefix pools, use the [PublicPrefixPoolService.List] request.
            type: string
      DhcpOptions:
        type: object
        properties:
          startIp:
            description: |-
              **string**
              Start IP address of the DHCP range (inclusive).
            type: string
          endIp:
            description: |-
              **string**
              End IP address of the DHCP range (inclusive).
            type: string
      PublicSubnet:
        type: object
        properties:
          publicSubnetId:
            description: |-
              **string**
              ID of the public subnet.
            type: string
          cloudId:
            description: |-
              **string**
              ID of the cloud that the public subnet belongs to.
            type: string
          folderId:
            description: |-
              **string**
              ID of the folder that the public subnet belongs to.
            type: string
          name:
            description: |-
              **string**
              Name of the public subnet.
              The name is unique within the folder.
              The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `.
            pattern: '[a-z]([-a-z0-9]*[a-z0-9])?'
            type: string
          description:
            description: |-
              **string**
              Optional description of the public subnet.
              The maximum string length in characters is 1024.
            type: string
          hardwarePoolIds:
            description: |-
              **string**
              IDs of the hardware pool that the public subnet belongs to.
            type: array
            items:
              type: string
          type:
            description: |-
              **enum** (Type)
              Type of the public subnet (dedicated or ephemeral).
              Cannot be set on creation. It's DEDICATED by default. EPHEMERAL networks are created only within the server.
              Only EPHEMERAL -> DEDICATED update is possible.
              - `DEDICATED`: Dedicated public subnet.
              - `EPHEMERAL`: Ephemeral public subnet.
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - DEDICATED
              - EPHEMERAL
          autoAllocation:
            description: |-
              **[AutoAllocation](#yandex.cloud.baremetal.v2.PublicSubnet.AutoAllocation)**
              Automatic CIDR allocation from the system public prefix pool.
              Includes only one of the fields `autoAllocation`, `manualAllocation`.
              Method for allocating CIDR block to the public subnet.
            $ref: '#/definitions/AutoAllocation'
          manualAllocation:
            description: |-
              **[ManualAllocation](#yandex.cloud.baremetal.v2.PublicSubnet.ManualAllocation)**
              Manual CIDR allocation with explicit CIDR from user's own public prefix pool (BYOIP).
              Includes only one of the fields `autoAllocation`, `manualAllocation`.
              Method for allocating CIDR block to the public subnet.
            $ref: '#/definitions/ManualAllocation'
          prefixLength:
            description: |-
              **string** (int64)
              Prefix length of the public subnet CIDR block.
            type: string
            format: int64
          cidr:
            description: |-
              **string**
              CIDR block for the public subnet.
            type: string
          dhcpOptions:
            description: |-
              **[DhcpOptions](#yandex.cloud.baremetal.v2.DhcpOptions)**
              DHCP options for the public subnet.
            $ref: '#/definitions/DhcpOptions'
          gatewayIp:
            description: |-
              **string**
              Gateway IP address for the public subnet.
            type: string
          publicPrefixPoolId:
            description: |-
              **string**
              ID of the public prefix pool that the public subnet belongs to.
            type: string
          createTime:
            description: |-
              **string** (date-time)
              Creation timestamp.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          updateTime:
            description: |-
              **string** (date-time)
              Update timestamp.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
          annotations:
            description: |-
              **object** (map<**string**, **string**>)
              Resource annotations as `key:value` pairs.
              The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
            type: object
            additionalProperties:
              type: string
              pattern: '[-_0-9a-z]*'
              maxLength: 63
            propertyNames:
              type: string
              pattern: '[a-z][-_0-9a-z]*'
              maxLength: 63
              minLength: 1
            maxProperties: 64
          deletionUnlockTime:
            description: |-
              **string** (date-time)
              Timestamp when deletion of the public subnet is allowed.
              String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
              `0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.
              To work with values in this field, use the APIs described in the
              [Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
              In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).
            type: string
            format: date-time
        oneOf:
          - required:
              - autoAllocation
          - required:
              - manualAllocation
---

# BareMetal API, REST: PublicSubnet.CreatePublicSubnet

Creates a public subnet in the specified folder.


## HTTP request

```
POST https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/publicSubnets
```

## Path parameters

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request. ||
|| folderId | **string**

Required field. ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|#

## Body parameters {#yandex.cloud.baremetal.v2.CreatePublicSubnetRequest}

```json
{
  "publicSubnet": {
    "publicSubnetId": "string",
    "cloudId": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "hardwarePoolIds": [
      "string"
    ],
    "type": "string",
    // Includes only one of the fields `autoAllocation`, `manualAllocation`
    "autoAllocation": {
      "prefixLength": "string"
    },
    "manualAllocation": {
      "cidr": "string",
      "publicPrefixPoolId": "string"
    },
    // end of the list of possible fields
    "prefixLength": "string",
    "cidr": "string",
    "dhcpOptions": {
      "startIp": "string",
      "endIp": "string"
    },
    "gatewayIp": "string",
    "publicPrefixPoolId": "string",
    "createTime": "string",
    "updateTime": "string",
    "annotations": "object",
    "deletionUnlockTime": "string"
  }
}
```

#|
||Field | Description ||
|| publicSubnet | **[PublicSubnet](#yandex.cloud.baremetal.v2.PublicSubnet)**

PublicSubnet resource to create. ||
|#

## PublicSubnet {#yandex.cloud.baremetal.v2.PublicSubnet}

A PublicSubnet resource.

#|
||Field | Description ||
|| publicSubnetId | **string**

ID of the public subnet. ||
|| cloudId | **string**

ID of the cloud that the public subnet belongs to. ||
|| folderId | **string**

ID of the folder that the public subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the public subnet.

The maximum string length in characters is 1024. ||
|| hardwarePoolIds[] | **string**

IDs of the hardware pool that the public subnet belongs to. ||
|| type | **enum** (Type)

Type of the public subnet (dedicated or ephemeral).

Cannot be set on creation. It's DEDICATED by default. EPHEMERAL networks are created only within the server.
Only EPHEMERAL -> DEDICATED update is possible.

- `DEDICATED`: Dedicated public subnet.
- `EPHEMERAL`: Ephemeral public subnet. ||
|| autoAllocation | **[AutoAllocation](#yandex.cloud.baremetal.v2.PublicSubnet.AutoAllocation)**

Automatic CIDR allocation from the system public prefix pool.

Includes only one of the fields `autoAllocation`, `manualAllocation`.

Method for allocating CIDR block to the public subnet. ||
|| manualAllocation | **[ManualAllocation](#yandex.cloud.baremetal.v2.PublicSubnet.ManualAllocation)**

Manual CIDR allocation with explicit CIDR from user's own public prefix pool (BYOIP).

Includes only one of the fields `autoAllocation`, `manualAllocation`.

Method for allocating CIDR block to the public subnet. ||
|| prefixLength | **string** (int64)

Prefix length of the public subnet CIDR block. ||
|| cidr | **string**

CIDR block for the public subnet. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.baremetal.v2.DhcpOptions)**

DHCP options for the public subnet. ||
|| gatewayIp | **string**

Gateway IP address for the public subnet. ||
|| publicPrefixPoolId | **string**

ID of the public prefix pool that the public subnet belongs to. ||
|| createTime | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updateTime | **string** (date-time)

Update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| deletionUnlockTime | **string** (date-time)

Timestamp when deletion of the public subnet is allowed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## AutoAllocation {#yandex.cloud.baremetal.v2.PublicSubnet.AutoAllocation}

#|
||Field | Description ||
|| prefixLength | **string** (int64)

Prefix length of the public subnet CIDR block.

Acceptable values are 1 to 31, inclusive. ||
|#

## ManualAllocation {#yandex.cloud.baremetal.v2.PublicSubnet.ManualAllocation}

#|
||Field | Description ||
|| cidr | **string**

CIDR block of the public subnet. Must be within the public prefix pool CIDR block. ||
|| publicPrefixPoolId | **string**

ID of the public prefix pool that the CIDR block belongs to.

To get a list of available public prefix pools, use the [PublicPrefixPoolService.List] request. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v2.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| startIp | **string**

Start IP address of the DHCP range (inclusive). ||
|| endIp | **string**

End IP address of the DHCP range (inclusive). ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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