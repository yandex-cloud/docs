---
editable: false
sourcePath: en/_api-ref/vpc/v1/privatelink/api-ref/PrivateEndpoint/get.md
---

# Virtual Private Cloud API, REST: PrivateEndpoint.Get {#Get}

Returns the specified Private Endpoint resource.

To get the list of all available PrivateEndpoint resources, make a [List](/docs/vpc/api-ref/PrivateEndpoint/list#List)
request.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/endpoints/{privateEndpointId}
```

## Path parameters

#|
||Field | Description ||
|| privateEndpointId | **string**

Required field. ID of the PrivateEndpoint resource to return.

To get PrivateEndpoint resource ID make a [PrivateEndpointService.List](/docs/vpc/api-ref/PrivateEndpoint/list#List)
request. ||
|#

## Response {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "networkId": "string",
  "status": "string",
  "address": {
    "subnetId": "string",
    "address": "string",
    "addressId": "string"
  },
  "dnsOptions": {
    "privateDnsRecordsEnabled": "boolean"
  },
  // Includes only one of the fields `objectStorage`
  "objectStorage": "object"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| id | **string**

ID of the private endpoint. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the private endpoint belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the private endpoint.
The name is unique within the folder.
Value must match the regular expression
``\\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. ||
|| description | **string**

Description of the private endpoint. 0-256 characters long. ||
|| labels | **string**

Private endpoint labels as `key:value` pairs.
No more than 64 per resource.
The maximum string length in characters for each value is 63.
Each value must match the regular expression `[-_0-9a-z]*`.
The string length in characters for each key must be 1-63.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| networkId | **string**

ID of the network that the private endpoint belongs to. ||
|| status | **enum** (Status)

Status of the private endpoint.

- `STATUS_UNSPECIFIED`
- `PENDING`: Private endpoint is still creating / updating.
- `AVAILABLE`: Private endpoint is available.
- `DELETING`: Private endpoint is deleting. ||
|| address | **[EndpointAddress](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress)**

Private endpoint ip address details. ||
|| dnsOptions | **[DnsOptions](#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions)**

Private endpoint dns options. ||
|| objectStorage | **object**

Yandex Cloud Object Storage.

Includes only one of the fields `objectStorage`.

Service to connect with via private endpoint. ||
|#

## EndpointAddress {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.EndpointAddress}

Private endpoint ip address details.

#|
||Field | Description ||
|| subnetId | **string**

ID of the subnet that the private endpoint address belongs to. ||
|| address | **string**

IP address of the private endpoint. ||
|| addressId | **string**

ID of the private endpoint address. ||
|#

## DnsOptions {#yandex.cloud.vpc.v1.privatelink.PrivateEndpoint.DnsOptions}

#|
||Field | Description ||
|| privateDnsRecordsEnabled | **boolean**

If enabled - vpc will create private dns records for specified service. ||
|#