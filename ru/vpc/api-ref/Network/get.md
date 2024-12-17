---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Network/get.md
---

# Virtual Private Cloud API, REST: Network.Get

Returns the specified Network resource.

Get the list of available Network resources by making a [List](/docs/vpc/api-ref/Network/list#List) request.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/networks/{networkId}
```

## Path parameters

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the Network resource to return.
To get the network ID, use a [NetworkService.List](/docs/vpc/api-ref/Network/list#List) request. ||
|#

## Response {#yandex.cloud.vpc.v1.Network}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "defaultSecurityGroupId": "string"
}
```

A Network resource. For more information, see [Networks](/docs/vpc/concepts/network).

#|
||Field | Description ||
|| id | **string**

ID of the network. ||
|| folderId | **string**

ID of the folder that the network belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the network.
The name is unique within the folder.
Value must match the regular expression ``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Optional description of the network. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| defaultSecurityGroupId | **string**

ID of default security group for network. ||
|#