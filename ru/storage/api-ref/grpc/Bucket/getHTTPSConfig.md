---
editable: false
sourcePath: en/_api-ref-grpc/storage/v1/api-ref/grpc/Bucket/getHTTPSConfig.md
---

# Object Storage API, gRPC: BucketService.GetHTTPSConfig

Returns the HTTPS configuration for the specified bucket.

## gRPC request

**rpc GetHTTPSConfig ([GetBucketHTTPSConfigRequest](#yandex.cloud.storage.v1.GetBucketHTTPSConfigRequest)) returns ([HTTPSConfig](#yandex.cloud.storage.v1.HTTPSConfig))**

## GetBucketHTTPSConfigRequest {#yandex.cloud.storage.v1.GetBucketHTTPSConfigRequest}

```json
{
  "name": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Required field. Name of the bucket to return the HTTPS configuration for. ||
|#

## HTTPSConfig {#yandex.cloud.storage.v1.HTTPSConfig}

```json
{
  "name": "string",
  "source_type": "SourceType",
  "issuer": "google.protobuf.StringValue",
  "subject": "google.protobuf.StringValue",
  "dns_names": [
    "string"
  ],
  "not_before": "google.protobuf.Timestamp",
  "not_after": "google.protobuf.Timestamp",
  "certificate_id": "string"
}
```

A resource for HTTPS configuration of a bucket.

#|
||Field | Description ||
|| name | **string**

Name of the bucket. ||
|| source_type | enum **SourceType**

Type of TLS certificate source.

- `SOURCE_TYPE_UNSPECIFIED`
- `SOURCE_TYPE_SELF_MANAGED`: Your certificate, uploaded directly.
- `SOURCE_TYPE_MANAGED_BY_CERTIFICATE_MANAGER`: Certificate managed by Certificate Manager. ||
|| issuer | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Issuer of the TLS certificate. ||
|| subject | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Subject of the TLS certificate. ||
|| dns_names[] | **string**

List of DNS names of the TLS certificate (Subject Alternative Name field). ||
|| not_before | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start of the TLS certificate validity period (Not Before field). ||
|| not_after | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

End of the TLS certificate validity period (Not After field) ||
|| certificate_id | **string**

ID of the TLS certificate in Certificate Manager.

To get information about the certificate from Certificate Manager, make a
[yandex.cloud.certificatemanager.v1.CertificateService.Get](/docs/certificate-manager/api-ref/grpc/Certificate/get#Get) request. ||
|#