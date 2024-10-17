---
editable: false
sourcePath: en/_api-ref-grpc/containerregistry/v1/api-ref/grpc/Scanner/list.md
---

# Container Registry API, gRPC: ScannerService.List {#List}

Retrieves the list of ScanResults for specified Image.

## gRPC request

**rpc List ([ListScanResultsRequest](#yandex.cloud.containerregistry.v1.ListScanResultsRequest)) returns ([ListScanResultsResponse](#yandex.cloud.containerregistry.v1.ListScanResultsResponse))**

## ListScanResultsRequest {#yandex.cloud.containerregistry.v1.ListScanResultsRequest}

```json
{
  // Includes only one of the fields `imageId`, `repositoryId`
  "imageId": "string",
  "repositoryId": "string",
  // end of the list of possible fields
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| imageId | **string**

Includes only one of the fields `imageId`, `repositoryId`.

ID of the Image or Repository to list ScanResults for.

To get the image ID use a [yandex.cloud.containerregistry.v1.ImageService.List](/docs/container-registry/api-ref/grpc/Image/list#List) request.
To get the repository ID use a [yandex.cloud.containerregistry.v1.RepositoryService.List](/docs/container-registry/api-ref/grpc/Repository/list#List) request. ||
|| repositoryId | **string**

Includes only one of the fields `imageId`, `repositoryId`.

ID of the Image or Repository to list ScanResults for.

To get the image ID use a [yandex.cloud.containerregistry.v1.ImageService.List](/docs/container-registry/api-ref/grpc/Image/list#List) request.
To get the repository ID use a [yandex.cloud.containerregistry.v1.RepositoryService.List](/docs/container-registry/api-ref/grpc/Repository/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRegistriesResponse.nextPageToken](/docs/container-registry/api-ref/grpc/Registry/list#yandex.cloud.containerregistry.v1.ListRegistriesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListRegistriesResponse.nextPageToken](/docs/container-registry/api-ref/grpc/Registry/list#yandex.cloud.containerregistry.v1.ListRegistriesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [ScanResult.status](#yandex.cloud.containerregistry.v1.ScanResult) field.
2. An `=` operator.
3. The value in double quotes (`"`). ||
|| orderBy | **string**

An order expression that orders resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [ScanResult.status](#yandex.cloud.containerregistry.v1.ScanResult) field.
2. Order selector. Currently you can use ordering only on `ScanResult.status` field (critical first). ||
|#

## ListScanResultsResponse {#yandex.cloud.containerregistry.v1.ListScanResultsResponse}

```json
{
  "scanResults": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| scanResults[] | **[ScanResult](#yandex.cloud.containerregistry.v1.ScanResult)**

List of ScanResult resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListImagesRequest.pageSize](/docs/container-registry/api-ref/grpc/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest), use
the `nextPageToken` as the value
for the [ListImagesRequest.pageToken](/docs/container-registry/api-ref/grpc/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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