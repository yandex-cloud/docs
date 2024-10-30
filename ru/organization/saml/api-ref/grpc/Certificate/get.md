---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Certificate/get.md
---

# Cloud Organization SAML API, gRPC: CertificateService.Get {#Get}

Returns the specified certificate.

To get the list of available certificates, make a [List](/docs/organization/api-ref/grpc/Certificate/list#List) request.

## gRPC request

**rpc Get ([GetCertificateRequest](#yandex.cloud.organizationmanager.v1.saml.GetCertificateRequest)) returns ([Certificate](#yandex.cloud.organizationmanager.v1.saml.Certificate))**

## GetCertificateRequest {#yandex.cloud.organizationmanager.v1.saml.GetCertificateRequest}

```json
{
  "certificateId": "string"
}
```

#|
||Field | Description ||
|| certificateId | **string**

ID of the certificate to return.
To get the certificate ID, make a [CertificateService.List](/docs/organization/api-ref/grpc/Certificate/list#List) request. ||
|#

## Certificate {#yandex.cloud.organizationmanager.v1.saml.Certificate}

```json
{
  "id": "string",
  "federationId": "string",
  "name": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "data": "string"
}
```

A certificate.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the certificate. ||
|| federationId | **string**

Required field. ID of the federation that the certificate belongs to. ||
|| name | **string**

Name of the certificate. ||
|| description | **string**

Description of the certificate. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| data | **string**

Required field. Certificate data in PEM format. ||
|#