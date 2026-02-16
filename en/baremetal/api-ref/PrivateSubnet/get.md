---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/privateSubnets/{privateSubnetId}
    method: get
    path:
      type: object
      properties:
        privateSubnetId:
          description: |-
            **string**
            ID of the PrivateSubnet resource to return.
            To get the private subnet ID use a [PrivateSubnetService.List](/docs/baremetal/api-ref/PrivateSubnet/list#List) request.
          pattern: '[a-z][a-z0-9]*'
          type: string
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/PrivateSubnet/get.md
---

# BareMetal API, REST: PrivateSubnet.Get

Returns the specific PrivateSubnet resource.

To get the list of available PrivateSubnet resources, make a [List](/docs/baremetal/api-ref/PrivateSubnet/list#List) request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/privateSubnets/{privateSubnetId}
```

## Path parameters

#|
||Field | Description ||
|| privateSubnetId | **string**

Required field. ID of the PrivateSubnet resource to return.

To get the private subnet ID use a [PrivateSubnetService.List](/docs/baremetal/api-ref/PrivateSubnet/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.PrivateSubnet}

**HTTP Code: 200 - OK**

```json
{
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
```

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