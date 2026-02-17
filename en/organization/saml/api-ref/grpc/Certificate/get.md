---
editable: false
---

# SAML Federation API, gRPC: CertificateService.Get

Returns the specified certificate.

To get the list of available certificates, make a [List](/docs/organization/saml/api-ref/grpc/Certificate/list#List) request.

## gRPC request

**rpc Get ([GetCertificateRequest](#yandex.cloud.organizationmanager.v1.saml.GetCertificateRequest)) returns ([Certificate](#yandex.cloud.organizationmanager.v1.saml.Certificate))**

## GetCertificateRequest {#yandex.cloud.organizationmanager.v1.saml.GetCertificateRequest}

```json
{
  "certificate_id": "string"
}
```

#|
||Field | Description ||
|| certificate_id | **string**

ID of the certificate to return.
To get the certificate ID, make a [CertificateService.List](/docs/organization/saml/api-ref/grpc/Certificate/list#List) request.

The maximum string length in characters is 50. ||
|#

## Certificate {#yandex.cloud.organizationmanager.v1.saml.Certificate}

```json
{
  "id": "string",
  "federation_id": "string",
  "name": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "data": "string"
}
```

A certificate.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the certificate.

The maximum string length in characters is 50. ||
|| federation_id | **string**

Required field. ID of the federation that the certificate belongs to.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the certificate.

Value must match the regular expression ``` |[a-z][-a-z0-9]{1,61}[a-z0-9] ```. ||
|| description | **string**

Description of the certificate.

The maximum string length in characters is 256. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| data | **string**

Required field. Certificate data in PEM format.

The maximum string length in characters is 32000. ||
|#