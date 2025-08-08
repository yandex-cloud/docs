---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/privateSubnets/{privateSubnetId}
    method: patch
    path:
      type: object
      properties:
        privateSubnetId:
          description: |-
            **string**
            ID of the PrivateSubnet resource to update.
            To get the private subnet ID, use a [PrivateSubnetService.List](/docs/baremetal/api-ref/PrivateSubnet/list#List) request.
          pattern: '[a-z][a-z0-9]*'
          type: string
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
            Name of the private subnet.
            The name must be unique within the folder.
          pattern: '[a-z]([-a-z0-9]*[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the private subnet.
          type: string
        vrfOptionsSpec:
          description: |-
            **[VrfOptionsSpec](/docs/baremetal/api-ref/PrivateSubnet/create#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec)**
            VRF options. Optional.
          $ref: '#/definitions/VrfOptionsSpec'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            Existing set of `labels` is completely replaced by the provided set.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
      additionalProperties: false
    definitions:
      DhcpOptionsSpec:
        type: object
        properties:
          startIp:
            description: |-
              **string**
              Start IP address of the DHCP range (inclusive).
              The absence or null value indicates that calculation will be performed based on CIDR.
            type: string
          endIp:
            description: |-
              **string**
              End IP address of the DHCP range (inclusive).
              The absence or null value indicates that calculation will be performed based on CIDR.
            type: string
      VrfOptionsSpec:
        type: object
        properties:
          vrfId:
            description: |-
              **string**
              ID of the VRF to create private subnet in.
              To get the VRF ID, use a [VrfService.List](/docs/baremetal/api-ref/Vrf/list#List) request.
            type: string
          cidr:
            description: "**string**\nCIDR block.\nThe range of internal addresses that are defined for this private subnet, as\nspecified in [RFC1918](https://datatracker.ietf.org/doc/html/rfc1918#section-3).\nFor example,\_10.0.0.0/22\_or\_192.168.0.0/24."
            type: string
          dhcpOptions:
            description: |-
              **[DhcpOptionsSpec](/docs/baremetal/api-ref/PrivateSubnet/create#yandex.cloud.baremetal.v1alpha.DhcpOptionsSpec)**
              DHCP options for the subnet.
              The absence or null value indicates that DHCP is disabled.
            $ref: '#/definitions/DhcpOptionsSpec'
          gatewayIp:
            description: |-
              **string**
              Gateway IP address for the subnet.
            type: string
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/PrivateSubnet/update.md
---

# BareMetal API, REST: PrivateSubnet.Update

Updates the specified private subnet.

## HTTP request

```
PATCH https://baremetal.{{ api-host }}/baremetal/v1alpha/privateSubnets/{privateSubnetId}
```

## Path parameters

#|
||Field | Description ||
|| privateSubnetId | **string**

Required field. ID of the PrivateSubnet resource to update.

To get the private subnet ID, use a [PrivateSubnetService.List](/docs/baremetal/api-ref/PrivateSubnet/list#List) request. ||
|#

## Body parameters {#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "vrfOptionsSpec": {
    "vrfId": "string",
    "cidr": "string",
    "dhcpOptions": {
      "startIp": "string",
      "endIp": "string"
    },
    "gatewayIp": "string"
  },
  "labels": "object"
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

Name of the private subnet.
The name must be unique within the folder. ||
|| description | **string**

Description of the private subnet. ||
|| vrfOptionsSpec | **[VrfOptionsSpec](#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec)**

VRF options. Optional. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
|#

## VrfOptionsSpec {#yandex.cloud.baremetal.v1alpha.VrfOptionsSpec}

#|
||Field | Description ||
|| vrfId | **string**

ID of the VRF to create private subnet in.

To get the VRF ID, use a [VrfService.List](/docs/baremetal/api-ref/Vrf/list#List) request. ||
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
  "metadata": {
    "privateSubnetId": "string"
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
    "cloudId": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "status": "string",
    "zoneId": "string",
    "hardwarePoolId": "string",
    "vrfOptions": {
      "vrfId": "string",
      "cidr": "string",
      "dhcpOptions": {
        "startIp": "string",
        "endIp": "string"
      },
      "gatewayIp": "string"
    },
    "createdAt": "string",
    "labels": "object"
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
|| metadata | **[UpdatePrivateSubnetMetadata](#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetMetadata)**

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
|| response | **[PrivateSubnet](#yandex.cloud.baremetal.v1alpha.PrivateSubnet)**

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

## UpdatePrivateSubnetMetadata {#yandex.cloud.baremetal.v1alpha.UpdatePrivateSubnetMetadata}

#|
||Field | Description ||
|| privateSubnetId | **string**

ID of the PrivateSubnet resource that is being updated. ||
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

## PrivateSubnet {#yandex.cloud.baremetal.v1alpha.PrivateSubnet}

A PrivateSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the private subnet. ||
|| cloudId | **string**

ID of the cloud that the private subnet belongs to. ||
|| folderId | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the private subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the private subnet. ||
|| status | **enum** (Status)

Status of the private subnet.

- `STATUS_UNSPECIFIED`: Unspecified private subnet status.
- `CREATING`: Private subnet is being created.
- `READY`: Private subnet is ready to use.
- `UPDATING`: Private subnet is being updated.
- `DELETING`: Private subnet is being deleted.
- `ERROR`: Private subnet encountered a problem and cannot operate. ||
|| zoneId | **string**

ID of the availability zone where the server resides. ||
|| hardwarePoolId | **string**

ID of the hardware pool that the private subnet belongs to. ||
|| vrfOptions | **[VrfOptions](#yandex.cloud.baremetal.v1alpha.PrivateSubnet.VrfOptions)**

Optional VRF options for the private subnet. If missing, the private subnet will be unrouted,
i.e. it will lack a DHCP server and routing capabilities between this subnet and other private
subnets. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## VrfOptions {#yandex.cloud.baremetal.v1alpha.PrivateSubnet.VrfOptions}

VRF options for the private subnet.

#|
||Field | Description ||
|| vrfId | **string**

ID of the VRF. ||
|| cidr | **string**

CIDR block for the subnet. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the subnet. ||
|| gatewayIp | **string**

Gateway IP address for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v1alpha.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| startIp | **string**

Start IP address of the DHCP range (inclusive). ||
|| endIp | **string**

End IP address of the DHCP range (inclusive). ||
|#