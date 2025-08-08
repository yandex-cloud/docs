---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/publicSubnets/{publicSubnetId}
    method: get
    path:
      type: object
      properties:
        publicSubnetId:
          description: |-
            **string**
            Required field. ID of the PublicSubnet resource to return.
            To get the public subnet ID use a [PublicSubnetService.List](/docs/baremetal/api-ref/PublicSubnet/list#List) request.
          type: string
      required:
        - publicSubnetId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/PublicSubnet/get.md
---

# BareMetal API, REST: PublicSubnet.Get

Returns the specific PublicSubnet resource.

To get the list of available PublicSubnet resources, make a [List](/docs/baremetal/api-ref/PublicSubnet/list#List) request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/publicSubnets/{publicSubnetId}
```

## Path parameters

#|
||Field | Description ||
|| publicSubnetId | **string**

Required field. ID of the PublicSubnet resource to return.

To get the public subnet ID use a [PublicSubnetService.List](/docs/baremetal/api-ref/PublicSubnet/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.PublicSubnet}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "cloudId": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "zoneId": "string",
  "hardwarePoolIds": [
    "string"
  ],
  "type": "string",
  "prefixLength": "string",
  "cidr": "string",
  "dhcpOptions": {
    "startIp": "string",
    "endIp": "string"
  },
  "gatewayIp": "string",
  "createdAt": "string",
  "labels": "object"
}
```

A PublicSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the public subnet. ||
|| cloudId | **string**

ID of the cloud that the public subnet belongs to. ||
|| folderId | **string**

ID of the folder that the public subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the public subnet. ||
|| zoneId | **string**

ID of the availability zone where the server resides. ||
|| hardwarePoolIds[] | **string**

IDs of the hardware pool that the public subnet belongs to. ||
|| type | **enum** (PublicSubnetType)

Type of the public subnet (static or ephemeral).

- `PUBLIC_SUBNET_TYPE_UNSPECIFIED`: Unspecified public subnet type.
- `DEDICATED`: Dedicated public subnet.
- `EPHEMERAL`: Ephemeral public subnet. ||
|| prefixLength | **string** (int64)

Prefix length of the public subnet CIDR block. ||
|| cidr | **string**

CIDR block for the public subnet. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the public subnet. ||
|| gatewayIp | **string**

Gateway IP address for the public subnet. ||
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

## DhcpOptions {#yandex.cloud.baremetal.v1alpha.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| startIp | **string**

Start IP address of the DHCP range (inclusive). ||
|| endIp | **string**

End IP address of the DHCP range (inclusive). ||
|#