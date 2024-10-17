---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Scanner/scan.md
---

# Container Registry API, gRPC: ScannerService.Scan {#Scan}

Executes scanning of specified image.

## gRPC request

**rpc Scan ([ScanRequest](#yandex.cloud.containerregistry.v1.ScanRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ScanRequest {#yandex.cloud.containerregistry.v1.ScanRequest}

```json
{
  "imageId": "string"
}
```

#|
||Field | Description ||
|| imageId | **string**

Required field. ID of the Image to be scanned for vulnerabilities. ||
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
    "scanResultId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "imageId": "string",
    "scannedAt": "google.protobuf.Timestamp",
    "status": "Status",
    "vulnerabilities": {
      "critical": "int64",
      "high": "int64",
      "medium": "int64",
      "low": "int64",
      "negligible": "int64",
      "undefined": "int64"
    }
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
|| metadata | **[ScanMetadata](#yandex.cloud.containerregistry.v1.ScanMetadata)**

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
|| response | **[ScanResult](#yandex.cloud.containerregistry.v1.ScanResult)**

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

## ScanMetadata {#yandex.cloud.containerregistry.v1.ScanMetadata}

#|
||Field | Description ||
|| scanResultId | **string**

ID of the ScanResult that is being created. ||
|#

## ScanResult {#yandex.cloud.containerregistry.v1.ScanResult}

A ScanResult resource.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the ScanResult. ||
|| imageId | **string**

Output only. ID of the Image that the ScanResult belongs to. ||
|| scannedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the scan been finished. ||
|| status | enum **Status**

Output only. The status of the ScanResult.

- `STATUS_UNSPECIFIED`
- `RUNNING`: Image scan is in progress.
- `READY`: Image has been scanned and result is ready.
- `ERROR`: Image scan is failed. ||
|| vulnerabilities | **[VulnerabilityStats](#yandex.cloud.containerregistry.v1.VulnerabilityStats)**

Output only. Summary information about vulnerabilities found. ||
|#

## VulnerabilityStats {#yandex.cloud.containerregistry.v1.VulnerabilityStats}

A VulnerabilityStats resource.

#|
||Field | Description ||
|| critical | **int64**

Count of CRITICAL vulnerabilities. ||
|| high | **int64**

Count of HIGH vulnerabilities. ||
|| medium | **int64**

Count of MEDIUM vulnerabilities. ||
|| low | **int64**

Count of LOW vulnerabilities. ||
|| negligible | **int64**

Count of NEGLIGIBLE vulnerabilities. ||
|| undefined | **int64**

Count of other vulnerabilities. ||
|#