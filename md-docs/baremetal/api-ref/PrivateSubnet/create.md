# BareMetal API, REST: PrivateSubnet.Create

Creates a private subnet in the specified folder.

## HTTP request

```
POST https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/privateSubnets
```

## Body parameters {#yandex.cloud.baremetal.v1alpha.CreatePrivateSubnetRequest}

```json
{
  "name": "string",
  "description": "string",
  "hardwarePoolId": "string",
  "vrfOptionsSpec": {
    "vrfId": "string",
    "cidr": "string",
    "dhcpOptions": {
      "startIp": "string",
      "endIp": "string"
    },
    "gatewayIp": "string"
  },
  "folderId": "string",
  "labels": "object"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the private subnet.
The name must be unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the private subnet.

The maximum string length in characters is 1024. ||
|| hardwarePoolId | **string**

ID of the hardware pool where the private subnet resides.
To get a list of available hardware pools, use the [HardwarePoolService.List](../HardwarePool/list.md#List) request.

The maximum string length in characters is 20. ||
|| vrfOptionsSpec | **[VrfOptionsSpec](#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec)**

VRF options. Optional. ||
|| folderId | **string**

ID of the folder to create a private subnet in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.

The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## VrfOptionsSpec {#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec}

#|
||Field | Description ||
|| vrfId | **string**

ID of the VRF to create private subnet in.
To get the VRF ID, use a [VrfService.List](../Vrf/list.md#List) request. ||
|| cidr | **string**

CIDR block.
The range of internal addresses that are defined for this private subnet, as
specified in [RFC1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3).
For example, 10.0.0.0/22 or 192.168.0.0/24. ||
|| dhcpOptions | **[DhcpOptionsSpec](#yandex.cloud.baremetal.v1alpha.DhcpOptionsSpec)**

DHCP options for the subnet.
The absence or null value indicates that DHCP is disabled. ||
|| gatewayIp | **string**

Gateway IP address for the subnet. ||
|#

## DhcpOptionsSpec {#yandex.cloud.baremetal.v1alpha.DhcpOptionsSpec}

DHCP options for the private subnet.

#|
||Field | Description ||
|| startIp | **string**

Start IP address of the DHCP range (inclusive).
The absence or null value indicates that calculation will be performed based on CIDR. ||
|| endIp | **string**

End IP address of the DHCP range (inclusive).
The absence or null value indicates that calculation will be performed based on CIDR. ||
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