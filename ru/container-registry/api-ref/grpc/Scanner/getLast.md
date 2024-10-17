---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Scanner/getLast.md
---

# Container Registry API, gRPC: ScannerService.GetLast {#GetLast}

Returns the last finished ScanResult for the specified Image.

## gRPC request

**rpc GetLast ([GetLastScanResultRequest](#yandex.cloud.containerregistry.v1.GetLastScanResultRequest)) returns ([ScanResult](#yandex.cloud.containerregistry.v1.ScanResult))**

## GetLastScanResultRequest {#yandex.cloud.containerregistry.v1.GetLastScanResultRequest}

```json
{
  "imageId": "string"
}
```

#|
||Field | Description ||
|| imageId | **string**

ID of the Image to get last finished ScanResult. ||
|#

## ScanResult {#yandex.cloud.containerregistry.v1.ScanResult}

```json
{
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
```

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