---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Certificate/get.md
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
To get the certificate ID, make a [CertificateService.List](/docs/organization/saml/api-ref/grpc/Certificate/list#List) request. ||
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

Required field. ID of the certificate. ||
|| federation_id | **string**

Required field. ID of the federation that the certificate belongs to. ||
|| name | **string**

Name of the certificate. ||
|| description | **string**

Description of the certificate. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| data | **string**

Required field. Certificate data in PEM format. ||
|#