[Документация Yandex Cloud](../../../index.md) > [Yandex Virtual Private Cloud](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Address](index.md) > Create

# Virtual Private Cloud API, REST: Address.Create

Creates an address in the specified folder and network.

## HTTP request

```
POST https://vpc.api.cloud.yandex.net/vpc/v1/addresses
```

## Body parameters {#yandex.cloud.vpc.v1.CreateAddressRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  // Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`
  "externalIpv4AddressSpec": {
    "address": "string",
    "zoneId": "string",
    "requirements": {
      "ddosProtectionProvider": "string",
      "outgoingSmtpCapability": "string"
    }
  },
  "internalIpv4AddressSpec": {
    "address": "string",
    // Includes only one of the fields `subnetId`
    "subnetId": "string"
    // end of the list of possible fields
  },
  // end of the list of possible fields
  "deletionProtection": "boolean",
  "dnsRecordSpecs": [
    {
      "fqdn": "string",
      "dnsZoneId": "string",
      "ttl": "string",
      "ptr": "boolean"
    }
  ]
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create a address in.
To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the address.
The name must be unique within the folder.
The value must match the regular expression: ```|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?```. ||
|| description | **string**

Description of the address.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Address labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_0-9a-z]*`.
Each map value must match the regular expression: `[-_0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| externalIpv4AddressSpec | **[ExternalIpv4AddressSpec](#yandex.cloud.vpc.v1.ExternalIpv4AddressSpec)**

External ipv4 address specification.

Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`.

Only one field must be specified. ||
|| internalIpv4AddressSpec | **[InternalIpv4AddressSpec](#yandex.cloud.vpc.v1.InternalIpv4AddressSpec)**

Internal ipv4 address specification.

Includes only one of the fields `externalIpv4AddressSpec`, `internalIpv4AddressSpec`.

Only one field must be specified. ||
|| deletionProtection | **boolean**

Specifies if address protected from deletion. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.vpc.v1.DnsRecordSpec)**

Optional DNS record specifications ||
|#

## ExternalIpv4AddressSpec {#yandex.cloud.vpc.v1.ExternalIpv4AddressSpec}

#|
||Field | Description ||
|| address | **string**

Value of address. ||
|| zoneId | **string**

Availability zone from which the address will be allocated. ||
|| requirements | **[AddressRequirements](#yandex.cloud.vpc.v1.AddressRequirements)**

Parameters of the allocated address, for example DDoS Protection. ||
|#

## AddressRequirements {#yandex.cloud.vpc.v1.AddressRequirements}

#|
||Field | Description ||
|| ddosProtectionProvider | **string**

DDoS protection provider ID. ||
|| outgoingSmtpCapability | **string**

Capability to send SMTP traffic. ||
|#

## InternalIpv4AddressSpec {#yandex.cloud.vpc.v1.InternalIpv4AddressSpec}

#|
||Field | Description ||
|| address | **string**

Value of address.
The length must be less than or equal to 16. ||
|| subnetId | **string**

Subnet from which the address will be allocated.
The length must be less than or equal to 50.

Includes only one of the fields `subnetId`.

Only one field must be specified. ||
|#

## DnsRecordSpec {#yandex.cloud.vpc.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

Required. DNS record name (absolute or relative to the DNS zone in use).
This field is required. ||
|| dnsZoneId | **string**

Required. ID of the public DNS zone. The maximum string length in characters is 20.
The length must be exactly 20.
This field is required. ||
|| ttl | **string** (int64)

TTL of record. Acceptable values are 0 to 86400, inclusive.
The value must be between 0 and 86400. ||
|| ptr | **boolean**

Optional. If the PTR record is required, this parameter must be set to "true". ||
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