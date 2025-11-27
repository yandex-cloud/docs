---
editable: false
---

# Cloud CDN Audit Trails Events: ResourceDelete

## Event JSON schema {#yandex.cloud.audit.cdn.gcore.ResourceDelete2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    "subjectType": "string",
    "subjectId": "string",
    "subjectName": "string",
    "federationId": "string",
    "federationName": "string",
    "federationType": "string",
    "tokenInfo": {
      "maskedIamToken": "string",
      "iamTokenId": "string",
      "impersonatorId": "string",
      "impersonatorType": "string",
      "impersonatorName": "string",
      "impersonatorFederationId": "string",
      "impersonatorFederationName": "string",
      "impersonatorFederationType": "string"
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        "resourceName": "string"
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    "remotePort": "string"
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "resourceId": "string",
    "cname": "string",
    "options": "string",
    "active": "boolean",
    "secondaryHostnames": {
      "values": [
        "string"
      ]
    },
    "originGroupId": "string",
    "originGroupName": "string",
    "originProtocol": "string",
    "sslCertificate": {
      "type": "string",
      "data": {
        // Includes only one of the fields `cm`
        "cm": {
          "id": "string"
        }
        // end of the list of possible fields
      }
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.cdn.gcore.ResourceDelete2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[Authentication](#yandex.cloud.audit.Authentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `EVENT_STATUS_UNSPECIFIED`
- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[EventDetails](#yandex.cloud.audit.cdn.gcore.ResourceDelete.EventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## Authentication {#yandex.cloud.audit.Authentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (SubjectType)

- `SUBJECT_TYPE_UNSPECIFIED`
- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| subjectId | **string** ||
|| subjectName | **string** ||
|| federationId | **string**

Federation block will be filled only when subject_type = FEDERATED_USER_ACCOUNT ||
|| federationName | **string** ||
|| federationType | **enum** (FederationType)

- `FEDERATION_TYPE_UNSPECIFIED`
- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.Authentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.Authentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string** ||
|| impersonatorId | **string** ||
|| impersonatorType | **enum** (SubjectType)

- `SUBJECT_TYPE_UNSPECIFIED`
- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| impersonatorName | **string** ||
|| impersonatorFederationId | **string** ||
|| impersonatorFederationName | **string** ||
|| impersonatorFederationType | **enum** (FederationType)

- `FEDERATION_TYPE_UNSPECIFIED`
- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string** ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64) ||
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

## EventDetails {#yandex.cloud.audit.cdn.gcore.ResourceDelete.EventDetails}

#|
||Field | Description ||
|| resourceId | **string** ||
|| cname | **string** ||
|| options | **string** ||
|| active | **boolean** ||
|| secondaryHostnames | **[SecondaryHostnames](#yandex.cloud.cdn.v1.SecondaryHostnames)** ||
|| originGroupId | **string** (int64) ||
|| originGroupName | **string** ||
|| originProtocol | **enum** (OriginProtocol)

- `ORIGIN_PROTOCOL_UNSPECIFIED`
- `HTTP`: CDN servers will connect to your origin via HTTP.
- `HTTPS`: CDN servers will connect to your origin via HTTPS.
- `MATCH`: Connection protocol will be chosen automatically (content on the
origin source should be available for the CDN both through HTTP and HTTPS). ||
|| sslCertificate | **[SSLTargetCertificate](#yandex.cloud.cdn.v1.SSLTargetCertificate)** ||
|#

## SecondaryHostnames {#yandex.cloud.cdn.v1.SecondaryHostnames}

List of secondary (alternative) CNAMEs.

#|
||Field | Description ||
|| values[] | **string**

List of secondary hostname values. ||
|#

## SSLTargetCertificate {#yandex.cloud.cdn.v1.SSLTargetCertificate}

A set of the personal SSL certificate parameters.

#|
||Field | Description ||
|| type | **enum** (SSLCertificateType)

Type of the certificate.

- `SSL_CERTIFICATE_TYPE_UNSPECIFIED`: SSL certificate is unspecified.
- `DONT_USE`: No SSL certificate is added, the requests are sent via HTTP.
- `LETS_ENCRYPT_GCORE`: The option is deprecated. Works only if you have already pointed your domain name to the protected IP address in your DNS.
- `CM`: Add your SSL certificate by uploading the certificate in PEM format and your private key. ||
|| data | **[SSLCertificateData](#yandex.cloud.cdn.v1.SSLCertificateData)**

Certificate data. ||
|#

## SSLCertificateData {#yandex.cloud.cdn.v1.SSLCertificateData}

A certificate data parameters.

#|
||Field | Description ||
|| cm | **[SSLCertificateCMData](#yandex.cloud.cdn.v1.SSLCertificateCMData)**

Custom (add your SSL certificate by uploading the certificate
in PEM format and your private key).

Includes only one of the fields `cm`. ||
|#

## SSLCertificateCMData {#yandex.cloud.cdn.v1.SSLCertificateCMData}

A certificate data custom parameters.

#|
||Field | Description ||
|| id | **string**

ID of the custom certificate. ||
|#