[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud DNS](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [DnsInboundEndpoint](index.md) > Get

# Cloud DNS API, REST: DnsInboundEndpoint.Get

Returns the specified DNS inbound endpoint.
To get the list of all available DNS inbound endpoints, make a [List](list.md#List) request.

## HTTP request

```
GET https://dns.api.cloud.yandex.net/dns/v1/inboundEndpoints/{dnsInboundEndpointId}
```

## Path parameters

#|
||Field | Description ||
|| dnsInboundEndpointId | **string**

Required field. ID of the DNS inbound endpoint to return.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.dns.v1.DnsInboundEndpoint}

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
  "address": "string",
  "addressId": "string",
  "status": "string",
  "deletionProtection": "boolean"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the DNS inbound endpoint. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the DNS inbound endpoint belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the DNS inbound endpoint.
The name is unique within the folder. ||
|| description | **string**

Description of the DNS inbound endpoint. ||
|| labels | **object** (map<**string**, **string**>)

DNS inbound endpoint labels as `key:value` pairs. ||
|| networkId | **string**

ID of the network that the DNS inbound endpoint belongs to. ||
|| address | **string**

IP address of the DNS inbound endpoint. ||
|| addressId | **string**

ID of the address resource. ||
|| status | **enum** (Status)

Status of the DNS inbound endpoint.

- `PENDING`: Endpoint is being created.
- `AVAILABLE`: Endpoint is ready to use.
- `DELETING`: Endpoint is being deleted. ||
|| deletionProtection | **boolean**

Prevents accidental endpoint removal. ||
|#