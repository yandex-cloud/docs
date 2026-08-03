[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [PublicSubnet](index.md) > UpdatePublicSubnet

# BareMetal API, REST: PublicSubnet.UpdatePublicSubnet

Updates the specified public subnet.

https://google.aip.dev/130 --)

## HTTP request

```
PATCH https://baremetal.api.cloud.yandex.net/baremetal/v2/clouds/{public_subnet.cloud_id}/folders/{public_subnet.folder_id}/publicSubnets/{public_subnet.public_subnet_id}
```

## Body parameters {#yandex.cloud.baremetal.v2.UpdatePublicSubnetRequest}

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
  },
  "updateMask": "string"
}
```

#|
||Field | Description ||
|| publicSubnet | **[PublicSubnet](#yandex.cloud.baremetal.v2.PublicSubnet)**

The PublicSubnet object to be updated. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
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

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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