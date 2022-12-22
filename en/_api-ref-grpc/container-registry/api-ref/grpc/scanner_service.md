---
editable: false
---

# Container Registry API, gRPC: ScannerService

A set of methods for scanning Docker images.

| Call | Description |
| --- | --- |
| [Scan](#Scan) | Executes scanning of specified image. |
| [Get](#Get) | Returns the specified ScanResult resource. |
| [GetLast](#GetLast) | Returns the last finished ScanResult for the specified Image. |
| [List](#List) | Retrieves the list of ScanResults for specified Image. |
| [ListVulnerabilities](#ListVulnerabilities) | Retrieves the list of vulnerabilities found in particular scan. |

## Calls ScannerService {#calls}

## Scan {#Scan}

Executes scanning of specified image.

**rpc Scan ([ScanRequest](#ScanRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ScanMetadata](#ScanMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ScanResult](#ScanResult)<br>

### ScanRequest {#ScanRequest}

Field | Description
--- | ---
image_id | **string**<br>Required. ID of the Image to be scanned for vulnerabilities. The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScanMetadata](#ScanMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScanResult](#ScanResult)>**<br>if operation finished successfully. 


### ScanMetadata {#ScanMetadata}

Field | Description
--- | ---
scan_result_id | **string**<br>ID of the ScanResult that is being created. 


### ScanResult {#ScanResult}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the ScanResult. 
image_id | **string**<br>Output only. ID of the Image that the ScanResult belongs to. 
scanned_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the scan been finished. 
status | enum **Status**<br>Output only. The status of the ScanResult. <ul><li>`RUNNING`: Image scan is in progress.</li><li>`READY`: Image has been scanned and result is ready.</li><li>`ERROR`: Image scan is failed.</li></ul>
vulnerabilities | **[VulnerabilityStats](#VulnerabilityStats)**<br>Output only. Summary information about vulnerabilities found. 


### VulnerabilityStats {#VulnerabilityStats}

Field | Description
--- | ---
critical | **int64**<br>Count of CRITICAL vulnerabilities. 
high | **int64**<br>Count of HIGH vulnerabilities. 
medium | **int64**<br>Count of MEDIUM vulnerabilities. 
low | **int64**<br>Count of LOW vulnerabilities. 
negligible | **int64**<br>Count of NEGLIGIBLE vulnerabilities. 
undefined | **int64**<br>Count of other vulnerabilities. 


## Get {#Get}

Returns the specified ScanResult resource. <br>To get the list of ScanResults for specified Image, make a [List](#List) request.

**rpc Get ([GetScanResultRequest](#GetScanResultRequest)) returns ([ScanResult](#ScanResult1))**

### GetScanResultRequest {#GetScanResultRequest}

Field | Description
--- | ---
scan_result_id | **string**<br>Required. ID of the ScanResult to return. The maximum string length in characters is 50.


### ScanResult {#ScanResult1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the ScanResult. 
image_id | **string**<br>Output only. ID of the Image that the ScanResult belongs to. 
scanned_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the scan been finished. 
status | enum **Status**<br>Output only. The status of the ScanResult. <ul><li>`RUNNING`: Image scan is in progress.</li><li>`READY`: Image has been scanned and result is ready.</li><li>`ERROR`: Image scan is failed.</li></ul>
vulnerabilities | **[VulnerabilityStats](#VulnerabilityStats1)**<br>Output only. Summary information about vulnerabilities found. 


### VulnerabilityStats {#VulnerabilityStats1}

Field | Description
--- | ---
critical | **int64**<br>Count of CRITICAL vulnerabilities. 
high | **int64**<br>Count of HIGH vulnerabilities. 
medium | **int64**<br>Count of MEDIUM vulnerabilities. 
low | **int64**<br>Count of LOW vulnerabilities. 
negligible | **int64**<br>Count of NEGLIGIBLE vulnerabilities. 
undefined | **int64**<br>Count of other vulnerabilities. 


## GetLast {#GetLast}

Returns the last finished ScanResult for the specified Image.

**rpc GetLast ([GetLastScanResultRequest](#GetLastScanResultRequest)) returns ([ScanResult](#ScanResult2))**

### GetLastScanResultRequest {#GetLastScanResultRequest}

Field | Description
--- | ---
image_id | **string**<br>ID of the Image to get last finished ScanResult. The maximum string length in characters is 50.


### ScanResult {#ScanResult2}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the ScanResult. 
image_id | **string**<br>Output only. ID of the Image that the ScanResult belongs to. 
scanned_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the scan been finished. 
status | enum **Status**<br>Output only. The status of the ScanResult. <ul><li>`RUNNING`: Image scan is in progress.</li><li>`READY`: Image has been scanned and result is ready.</li><li>`ERROR`: Image scan is failed.</li></ul>
vulnerabilities | **[VulnerabilityStats](#VulnerabilityStats2)**<br>Output only. Summary information about vulnerabilities found. 


### VulnerabilityStats {#VulnerabilityStats2}

Field | Description
--- | ---
critical | **int64**<br>Count of CRITICAL vulnerabilities. 
high | **int64**<br>Count of HIGH vulnerabilities. 
medium | **int64**<br>Count of MEDIUM vulnerabilities. 
low | **int64**<br>Count of LOW vulnerabilities. 
negligible | **int64**<br>Count of NEGLIGIBLE vulnerabilities. 
undefined | **int64**<br>Count of other vulnerabilities. 


## List {#List}

Retrieves the list of ScanResults for specified Image.

**rpc List ([ListScanResultsRequest](#ListScanResultsRequest)) returns ([ListScanResultsResponse](#ListScanResultsResponse))**

### ListScanResultsRequest {#ListScanResultsRequest}

Field | Description
--- | ---
id | **oneof:** `image_id` or `repository_id`<br>ID of the Image or Repository to list ScanResults for. <br>To get the image ID use a [yandex.cloud.containerregistry.v1.ImageService.List](/docs/container-registry/api-ref/grpc/image_service#List) request. To get the repository ID use a [yandex.cloud.containerregistry.v1.RepositoryService.List](/docs/container-registry/api-ref/grpc/repository_service#List) request.
&nbsp;&nbsp;image_id | **string**<br>ID of the Image or Repository to list ScanResults for. <br>To get the image ID use a [yandex.cloud.containerregistry.v1.ImageService.List](/docs/container-registry/api-ref/grpc/image_service#List) request. To get the repository ID use a [yandex.cloud.containerregistry.v1.RepositoryService.List](/docs/container-registry/api-ref/grpc/repository_service#List) request. The maximum string length in characters is 50.
&nbsp;&nbsp;repository_id | **string**<br>ID of the Image or Repository to list ScanResults for. <br>To get the image ID use a [yandex.cloud.containerregistry.v1.ImageService.List](/docs/container-registry/api-ref/grpc/image_service#List) request. To get the repository ID use a [yandex.cloud.containerregistry.v1.RepositoryService.List](/docs/container-registry/api-ref/grpc/repository_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListRegistriesResponse.next_page_token](#ListRegistriesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRegistriesResponse.next_page_token](#ListRegistriesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [ScanResult.status](#ScanResult3) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`).</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br>An order expression that orders resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [ScanResult.status](#ScanResult3) field. </li><li>Order selector. Currently you can use ordering only on `ScanResult.status` field (critical first).</li></ol> The maximum string length in characters is 100.


### ListScanResultsResponse {#ListScanResultsResponse}

Field | Description
--- | ---
scan_results[] | **[ScanResult](#ScanResult3)**<br>List of ScanResult resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListImagesRequest.page_size](#ListImagesRequest), use the `next_page_token` as the value for the [ListImagesRequest.page_token](#ListImagesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### ScanResult {#ScanResult3}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the ScanResult. 
image_id | **string**<br>Output only. ID of the Image that the ScanResult belongs to. 
scanned_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the scan been finished. 
status | enum **Status**<br>Output only. The status of the ScanResult. <ul><li>`RUNNING`: Image scan is in progress.</li><li>`READY`: Image has been scanned and result is ready.</li><li>`ERROR`: Image scan is failed.</li></ul>
vulnerabilities | **[VulnerabilityStats](#VulnerabilityStats3)**<br>Output only. Summary information about vulnerabilities found. 


### VulnerabilityStats {#VulnerabilityStats3}

Field | Description
--- | ---
critical | **int64**<br>Count of CRITICAL vulnerabilities. 
high | **int64**<br>Count of HIGH vulnerabilities. 
medium | **int64**<br>Count of MEDIUM vulnerabilities. 
low | **int64**<br>Count of LOW vulnerabilities. 
negligible | **int64**<br>Count of NEGLIGIBLE vulnerabilities. 
undefined | **int64**<br>Count of other vulnerabilities. 


## ListVulnerabilities {#ListVulnerabilities}

Retrieves the list of vulnerabilities found in particular scan.

**rpc ListVulnerabilities ([ListVulnerabilitiesRequest](#ListVulnerabilitiesRequest)) returns ([ListVulnerabilitiesResponse](#ListVulnerabilitiesResponse))**

### ListVulnerabilitiesRequest {#ListVulnerabilitiesRequest}

Field | Description
--- | ---
scan_result_id | **string**<br>Required. ID of the ScanResult to get list of vulnerabilities for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListRegistriesResponse.next_page_token](#ListRegistriesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRegistriesResponse.next_page_token](#ListRegistriesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Vulnerability.severity](#Vulnerability) and [PackageVulnerability.name](#PackageVulnerability) fields. </li><li>An `=` operator. </li><li>The value in double quotes (`"`).</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br>An order expression that orders resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Vulnerability.severity](#Vulnerability) and [PackageVulnerability.name](#PackageVulnerability) fields. </li><li>Order selector. Currently you can use ordering only on `Vulnerability.severity` field (recent first).</li></ol> The maximum string length in characters is 100.


### ListVulnerabilitiesResponse {#ListVulnerabilitiesResponse}

Field | Description
--- | ---
vulnerabilities[] | **[Vulnerability](#Vulnerability)**<br>List of Vulnerability resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListImagesRequest.page_size](#ListImagesRequest), use the `next_page_token` as the value for the [ListImagesRequest.page_token](#ListImagesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Vulnerability {#Vulnerability}

Field | Description
--- | ---
severity | enum **Severity**<br>Output only. Severity of the Vulnerability. <ul><li>`CRITICAL`: Critical severity is a world-burning problem, exploitable for nearly all users. Includes remote root privilege escalations, or massive data loss.</li><li>`HIGH`: High severity is a real problem, exploitable for many users in a default installation. Includes serious remote denial of services, local root privilege escalations, or data loss.</li><li>`MEDIUM`: Medium severity is a real security problem, and is exploitable for many users. Includes network daemon denial of service attacks, cross-site scripting, and gaining user privileges. Updates should be made soon for this priority of issue.</li><li>`LOW`: Low severity is a security problem, but is hard to exploit due to environment, requires a user-assisted attack, a small install base, or does very little damage. These tend to be included in security updates only when higher priority issues require an update, or if many low priority issues have built up.</li><li>`NEGLIGIBLE`: Negligible severity is technically a security problem, but is only theoretical in nature, requires a very special situation, has almost no install base, or does no real damage. These tend not to get backport from upstream, and will likely not be included in security updates unless there is an easy fix and some other issue causes an update.</li><li>`UNDEFINED`: Unknown severity is either a security problem that has not been assigned to a priority yet or a priority that our system did not recognize.</li></ul>
vulnerability | **oneof:** `package`<br>Details of vulnerability depending on type. Only `package` vulnerability is supported at the moment.
&nbsp;&nbsp;package | **[PackageVulnerability](#PackageVulnerability)**<br>Details of vulnerability depending on type. Only `package` vulnerability is supported at the moment. 


### PackageVulnerability {#PackageVulnerability}

Field | Description
--- | ---
name | **string**<br>Name of vulnerability in CVE database. 
link | **string**<br>URL to the page with description of vulnerability. 
package | **string**<br>The package name where vulnerability has been found. 
source | **string**<br>The package manager name. Ex.: yum, rpm, dpkg. 
version | **string**<br>The version of the package where vulnerability has been found. 
fixed_by | **string**<br>The version of the package where vulnerability has been fixed. 


