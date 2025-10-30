---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/signature-certificates
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        applicationId:
          description: |-
            **string**
            Required field. ID of the SAML application to create the certificate for.
          type: string
        name:
          description: |-
            **string**
            Name of the signature certificate.
            The name is unique within the application. 3-63 characters long.
          pattern: ([a-z]([-a-z0-9]{0,61}[a-z0-9])?)?
          type: string
        description:
          description: |-
            **string**
            Description of the signature certificate. 0-256 characters long.
          type: string
      required:
        - applicationId
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/application/saml/api-ref/SignatureCertificate/create.md
---

# SAML Application API, REST: SignatureCertificate.Create

Creates a new signature certificate for the specified SAML application.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/application/saml/signature-certificates
```

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateSignatureCertificateRequest}

```json
{
  "applicationId": "string",
  "name": "string",
  "description": "string"
}
```

Request to create a new signature certificate.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the SAML application to create the certificate for. ||
|| name | **string**

Name of the signature certificate.
The name is unique within the application. 3-63 characters long. ||
|| description | **string**

Description of the signature certificate. 0-256 characters long. ||
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
    "signatureCertificateId": "string"
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
    "applicationId": "string",
    "status": "string",
    "name": "string",
    "description": "string",
    "createdAt": "string",
    "data": "string",
    "fingerprint": "string",
    "notAfter": "string",
    "notBefore": "string"
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
|| metadata | **[CreateSignatureCertificateMetadata](#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateSignatureCertificateMetadata)**

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
|| response | **[SignatureCertificate](#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate)**

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

## CreateSignatureCertificateMetadata {#yandex.cloud.organizationmanager.v1.idp.application.saml.CreateSignatureCertificateMetadata}

Metadata for the [SignatureCertificateService.Create](#Create) operation.

#|
||Field | Description ||
|| signatureCertificateId | **string**

ID of the signature certificate that is being created. ||
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

## SignatureCertificate {#yandex.cloud.organizationmanager.v1.idp.application.saml.SignatureCertificate}

A signature certificate for SAML applications.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the signature certificate. ||
|| applicationId | **string**

ID of the SAML application that the signature certificate belongs to. ||
|| status | **enum** (Status)

Current status of the signature certificate.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `ACTIVE`: The certificate is active and can be used for signing.
- `INACTIVE`: The certificate is inactive and cannot be used for signing. ||
|| name | **string**

Name of the signature certificate. ||
|| description | **string**

Description of the signature certificate. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| data | **string**

Certificate data in PEM format. ||
|| fingerprint | **string**

SHA256-fingerprint of the signature certificate. ||
|| notAfter | **string** (date-time)

Time after which the signature certificate is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| notBefore | **string** (date-time)

Time before which the signature certificate is not valid.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#