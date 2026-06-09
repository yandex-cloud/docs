# Yandex Cloud Registry API, gRPC: ScannerService.List

Retrieves the list of ScanResults for specified artifact.

## gRPC request

**rpc List ([ListScanResultsRequest](#yandex.cloud.cloudregistry.v1.ListScanResultsRequest)) returns ([ListScanResultsResponse](#yandex.cloud.cloudregistry.v1.ListScanResultsResponse))**

## ListScanResultsRequest {#yandex.cloud.cloudregistry.v1.ListScanResultsRequest}

```json
{
  "artifact_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": {
    "status": "Status"
  },
  "order_by": "string"
}
```

#|
||Field | Description ||
|| artifact_id | **string**

ID of the artifact to list ScanResults for.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListScanResultsResponse.next_page_token](#yandex.cloud.cloudregistry.v1.ListScanResultsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 10.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListScanResultsResponse.next_page_token](#yandex.cloud.cloudregistry.v1.ListScanResultsResponse) returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **[ListScanResultsFilter](#yandex.cloud.cloudregistry.v1.ListScanResultsFilter)**

Filter the list by [ScanResult.status](#yandex.cloud.cloudregistry.v1.ScanResult). ||
|| order_by | **string**

An order expression that orders resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [ScanResult.status](#yandex.cloud.cloudregistry.v1.ScanResult) field.
2. Order selector. Currently you can use ordering only on `ScanResult.status` field (critical first).

The maximum string length in characters is 100. ||
|#

## ListScanResultsFilter {#yandex.cloud.cloudregistry.v1.ListScanResultsFilter}

#|
||Field | Description ||
|| status | enum **Status**

Filter by the `ScanResult.status` value.

- `RUNNING`: Image scan is in progress.
- `READY`: Image has been scanned and result is ready.
- `ERROR`: Image scan is failed.
- `QUEUED`: Image scan is waiting in queue to be processed.
- `CANCELLED`: Image scan was cancelled by user. ||
|#

## ListScanResultsResponse {#yandex.cloud.cloudregistry.v1.ListScanResultsResponse}

```json
{
  "scan_results": [
    {
      "id": "string",
      "artifact_id": "string",
      "scanned_at": "google.protobuf.Timestamp",
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| scan_results[] | **[ScanResult](#yandex.cloud.cloudregistry.v1.ScanResult)**

List of ScanResult resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListScanResultsRequest.page_size](#yandex.cloud.cloudregistry.v1.ListScanResultsRequest), use
the `next_page_token` as the value
for the [ListScanResultsRequest.page_token](#yandex.cloud.cloudregistry.v1.ListScanResultsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## ScanResult {#yandex.cloud.cloudregistry.v1.ScanResult}

A ScanResult resource.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the ScanResult. ||
|| artifact_id | **string**

Output only. ID of the artifact that the ScanResult belongs to. ||
|| scanned_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Output only. The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the scan been finished. ||
|| status | enum **Status**

Output only. The status of the ScanResult.

- `RUNNING`: Image scan is in progress.
- `READY`: Image has been scanned and result is ready.
- `ERROR`: Image scan is failed.
- `QUEUED`: Image scan is waiting in queue to be processed.
- `CANCELLED`: Image scan was cancelled by user. ||
|| vulnerabilities | **[VulnerabilityStats](#yandex.cloud.cloudregistry.v1.VulnerabilityStats)**

Output only. Summary information about vulnerabilities found. ||
|#

## VulnerabilityStats {#yandex.cloud.cloudregistry.v1.VulnerabilityStats}

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