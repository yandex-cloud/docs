---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Scanner/list.md
---

# Container Registry API, REST: Scanner.List

Retrieves the list of ScanResults for specified Image.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/scans
```

## Query parameters {#yandex.cloud.containerregistry.v1.ListScanResultsRequest}

#|
||Field | Description ||
|| imageId | **string**

Includes only one of the fields `imageId`, `repositoryId`.

ID of the Image or Repository to list ScanResults for.

To get the image ID use a [yandex.cloud.containerregistry.v1.ImageService.List](/docs/container-registry/api-ref/Image/list#List) request.
To get the repository ID use a [yandex.cloud.containerregistry.v1.RepositoryService.List](/docs/container-registry/api-ref/Repository/list#List) request. ||
|| repositoryId | **string**

Includes only one of the fields `imageId`, `repositoryId`.

ID of the Image or Repository to list ScanResults for.

To get the image ID use a [yandex.cloud.containerregistry.v1.ImageService.List](/docs/container-registry/api-ref/Image/list#List) request.
To get the repository ID use a [yandex.cloud.containerregistry.v1.RepositoryService.List](/docs/container-registry/api-ref/Repository/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRegistriesResponse.nextPageToken](/docs/container-registry/api-ref/Registry/list#yandex.cloud.containerregistry.v1.ListRegistriesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListRegistriesResponse.nextPageToken](/docs/container-registry/api-ref/Registry/list#yandex.cloud.containerregistry.v1.ListRegistriesResponse) returned by a previous list request. ||
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

## Response {#yandex.cloud.containerregistry.v1.ListScanResultsResponse}

**HTTP Code: 200 - OK**

```json
{
  "scanResults": [
    {
      "id": "string",
      "imageId": "string",
      "scannedAt": "string",
      "status": "string",
      "vulnerabilities": {
        "critical": "string",
        "high": "string",
        "medium": "string",
        "low": "string",
        "negligible": "string",
        "undefined": "string"
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
is larger than [ListImagesRequest.pageSize](/docs/container-registry/api-ref/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest), use
the `nextPageToken` as the value
for the [ListImagesRequest.pageToken](/docs/container-registry/api-ref/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest) query parameter
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
|| scannedAt | **string** (date-time)

Output only. The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the scan been finished.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

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
|| critical | **string** (int64)

Count of CRITICAL vulnerabilities. ||
|| high | **string** (int64)

Count of HIGH vulnerabilities. ||
|| medium | **string** (int64)

Count of MEDIUM vulnerabilities. ||
|| low | **string** (int64)

Count of LOW vulnerabilities. ||
|| negligible | **string** (int64)

Count of NEGLIGIBLE vulnerabilities. ||
|| undefined | **string** (int64)

Count of other vulnerabilities. ||
|#