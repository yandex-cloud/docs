---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Subnet/get.md
---

# Virtual Private Cloud API, REST: Subnet.Get

Returns the specified Subnet resource.

To get the list of available Subnet resources, make a [List](/docs/vpc/api-ref/Subnet/list#List) request.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/subnets/{subnetId}
```

## Path parameters

#|
||Field | Description ||
|| subnetId | **string**

Required field. ID of the Subnet resource to return.
To get the subnet ID use a [SubnetService.List](/docs/vpc/api-ref/Subnet/list#List) request. ||
|#

## Response {#yandex.cloud.vpc.v1.Subnet}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "zoneId": "string",
  "v4CidrBlocks": [
    "string"
  ],
  "v6CidrBlocks": [
    "string"
  ],
  "routeTableId": "string",
  "dhcpOptions": {
    "domainNameServers": [
      "string"
    ],
    "domainName": "string",
    "ntpServers": [
      "string"
    ]
  }
}
```

A Subnet resource. For more information, see [Subnets](/docs/vpc/concepts/network#subnet).

#|
||Field | Description ||
|| id | **string**

ID of the subnet. ||
|| folderId | **string**

ID of the folder that the subnet belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the subnet.
The name must be unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the subnet. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| networkId | **string**

ID of the network the subnet belongs to. ||
|| zoneId | **string**

ID of the availability zone where the subnet resides. ||
|| v4CidrBlocks[] | **string**

CIDR block.
The range of internal addresses that are defined for this subnet.
This field can be set only at Subnet resource creation time and cannot be changed.
For example, 10.0.0.0/22 or 192.168.0.0/24.
Minimum subnet size is /28, maximum subnet size is /16. ||
|| v6CidrBlocks[] | **string**

IPv6 not available yet. ||
|| routeTableId | **string**

ID of route table the subnet is linked to. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.vpc.v1.DhcpOptions)**

DHCP options for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.vpc.v1.DhcpOptions}

#|
||Field | Description ||
|| domainNameServers[] | **string**

A list of DHCP servers for this subnet. ||
|| domainName | **string**

A domain name to us as a suffix when resolving host names in this subnet. ||
|| ntpServers[] | **string**

List of NTP servers for this subnet. ||
|#