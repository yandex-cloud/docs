[Документация Yandex Cloud](../../../../index.md) > [Yandex Certificate Manager](../../../index.md) > Справочник API > REST (англ.) > [Certificate Manager Private CA API](../index.md) > [PrivateCa](index.md) > GenerateCertificateAuthorityByCsr

# Certificate Manager Private CA API, REST: PrivateCa.GenerateCertificateAuthorityByCsr

Generates a Certificate Authority (CA) by using a Certificate Signing Request (CSR).
This allows using an externally provided CSR to finalize CA creation.

## HTTP request

```
POST https://private-ca.certificate-manager.api.cloud.yandex.net/privateca/v1/certificateAuthorities:generateByCsr
```

## Body parameters {#yandex.cloud.certificatemanager.v1.privateca.GenerateCertificateAuthorityByCsrRequest}

```json
{
  "folderId": "string",
  "parentCertificateAuthorityId": "string",
  "name": "string",
  "description": "string",
  "csr": "string",
  "privateKey": "string",
  "ttlDays": "string",
  "endEntitiesTtlLimitDays": "string",
  "templateId": "string",
  "enableCrl": "boolean",
  "enableOcsp": "boolean",
  "deletionProtection": "boolean"
}
```

Request to generate a Certificate Authority (CA) from a Certificate Signing Request (CSR).

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID where the CA is being created.

The maximum string length in characters is 50. ||
|| parentCertificateAuthorityId | **string**

Optional. If set intermediate CA would be generated and signed on parent CA

The maximum string length in characters is 50. ||
|| name | **string**

Required field. The name of the Certificate Authority.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

An optional description of the Certificate Authority.

The maximum string length in characters is 1024. ||
|| csr | **string**

Required field. The PEM-encoded Certificate Signing Request (CSR) content. ||
|| privateKey | **string**

Optional. The PEM-encoded private key linked to the certificate. If absent CA would be issued with server side generated key pair ||
|| ttlDays | **string** (int64)

The Time-To-Live (TTL) in days for the CA.

Acceptable values are 1 to 20000, inclusive. ||
|| endEntitiesTtlLimitDays | **string** (int64)

TTL limit in days for end-entities signed by the CA.

The maximum value is 20000. ||
|| templateId | **string**

Optional template ID to fill certificate fields with template data. Explicitly defined parameters is preferred

The maximum string length in characters is 50. ||
|| enableCrl | **boolean**

Enable Certificate Revocation List (CRL) support. ||
|| enableOcsp | **boolean**

Enable Online Certificate Status Protocol (OCSP) support. ||
|| deletionProtection | **boolean**

Protect the CA from accidental deletion. ||
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

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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