---
editable: false
sourcePath: en/_api-ref-grpc/storage/v1/api-ref/grpc/Bucket/setHTTPSConfig.md
---

# Object Storage API, gRPC: BucketService.SetHTTPSConfig {#SetHTTPSConfig}

Updates the HTTPS configuration for the specified bucket.

The updated configuration could take up to 30 minutes to apply to the bucket.

## gRPC request

**rpc SetHTTPSConfig ([SetBucketHTTPSConfigRequest](#yandex.cloud.storage.v1.SetBucketHTTPSConfigRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## SetBucketHTTPSConfigRequest {#yandex.cloud.storage.v1.SetBucketHTTPSConfigRequest}

```json
{
  "name": "string",
  // Includes only one of the fields `selfManaged`, `certificateManager`
  "selfManaged": {
    "certificatePem": "string",
    "privateKeyPem": "string"
  },
  "certificateManager": {
    "certificateId": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the bucket to update the HTTPS configuration for. ||
|| selfManaged | **[SelfManagedHTTPSConfigParams](#yandex.cloud.storage.v1.SelfManagedHTTPSConfigParams)**

Your TLS certificate, uploaded directly.

Object Storage only supports [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificates.

Includes only one of the fields `selfManaged`, `certificateManager`.

HTTPS configuration parameters. ||
|| certificateManager | **[CertificateManagerHTTPSConfigParams](#yandex.cloud.storage.v1.CertificateManagerHTTPSConfigParams)**

TLS certificate from Certificate Manager.

To create a certificate in Certificate Manager, make a
[yandex.cloud.certificatemanager.v1.CertificateService.Create](/docs/certificate-manager/api-ref/grpc/Certificate/create#Create) request.

Includes only one of the fields `selfManaged`, `certificateManager`.

HTTPS configuration parameters. ||
|#

## SelfManagedHTTPSConfigParams {#yandex.cloud.storage.v1.SelfManagedHTTPSConfigParams}

#|
||Field | Description ||
|| certificatePem | **string**

[PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded certificate. ||
|| privateKeyPem | **string**

[PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail)-encoded private key for the certificate. ||
|#

## CertificateManagerHTTPSConfigParams {#yandex.cloud.storage.v1.CertificateManagerHTTPSConfigParams}

A resource for a TLS certificate from Certificate Manager.

#|
||Field | Description ||
|| certificateId | **string**

ID of the certificate.

To get the list of all available certificates, make a [yandex.cloud.certificatemanager.v1.CertificateService.List](/docs/certificate-manager/api-ref/grpc/Certificate/list#List)
request. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "sourceType": "SourceType",
    "issuer": "google.protobuf.StringValue",
    "subject": "google.protobuf.StringValue",
    "dnsNames": [
      "string"
    ],
    "notBefore": "google.protobuf.Timestamp",
    "notAfter": "google.protobuf.Timestamp",
    "certificateId": "string"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[SetBucketHTTPSConfigMetadata](#yandex.cloud.storage.v1.SetBucketHTTPSConfigMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[HTTPSConfig](#yandex.cloud.storage.v1.HTTPSConfig)**

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

## SetBucketHTTPSConfigMetadata {#yandex.cloud.storage.v1.SetBucketHTTPSConfigMetadata}

#|
||Field | Description ||
|| name | **string**

Name of the bucket the HTTPS configuration is being updated for. ||
|#

## HTTPSConfig {#yandex.cloud.storage.v1.HTTPSConfig}

A resource for HTTPS configuration of a bucket.

#|
||Field | Description ||
|| name | **string**

Name of the bucket. ||
|| sourceType | enum **SourceType**

Type of TLS certificate source.

- `SOURCE_TYPE_UNSPECIFIED`
- `SOURCE_TYPE_SELF_MANAGED`: Your certificate, uploaded directly.
- `SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER`: Certificate managed by Certificate Manager. ||
|| issuer | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Issuer of the TLS certificate. ||
|| subject | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Subject of the TLS certificate. ||
|| dnsNames[] | **string**

List of DNS names of the TLS certificate (Subject Alternative Name field). ||
|| notBefore | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start of the TLS certificate validity period (Not Before field). ||
|| notAfter | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End of the TLS certificate validity period (Not After field) ||
|| certificateId | **string**

ID of the TLS certificate in Certificate Manager.

To get information about the certificate from Certificate Manager, make a
[yandex.cloud.certificatemanager.v1.CertificateService.Get](/docs/certificate-manager/api-ref/grpc/Certificate/get#Get) request. ||
|#