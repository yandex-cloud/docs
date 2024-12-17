---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/Gateway/get.md
---

# Virtual Private Cloud API, REST: Gateway.Get

Returns the specified Gateway resource.

To get the list of all available Gateway resources, make a [List](/docs/vpc/api-ref/Gateway/list#List) request.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/gateways/{gatewayId}
```

## Path parameters

#|
||Field | Description ||
|| gatewayId | **string**

Required field. ID of the Gateway resource to return.

To get Gateway resource ID make a [GatewayService.List](/docs/vpc/api-ref/Gateway/list#List) request. ||
|#

## Response {#yandex.cloud.vpc.v1.Gateway}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  // Includes only one of the fields `sharedEgressGateway`
  "sharedEgressGateway": "object"
  // end of the list of possible fields
}
```

A Gateway resource. For more information, see [Gateway](/docs/vpc/concepts/gateways).

#|
||Field | Description ||
|| id | **string**

ID of the gateway. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the gateway belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the gateway.
The name is unique within the folder.
Value must match the regular expression ``\\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``. ||
|| description | **string**

Description of the gateway. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Gateway labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_./\\@0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_./\\@0-9a-z]*`. ||
|| sharedEgressGateway | **object**

Includes only one of the fields `sharedEgressGateway`.

Gateway specification ||
|#