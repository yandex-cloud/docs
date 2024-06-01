---
editable: false
sourcePath: en/_api-ref-grpc/managed-kubernetes/api-ref/grpc/version_service.md
---

# Managed Services for Kubernetes API, gRPC: VersionService

A set of methods for managing Kubernetes versions.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves the list of versions in the specified release channel. |

## Calls VersionService {#calls}

## List {#List}

Retrieves the list of versions in the specified release channel.

**rpc List ([ListVersionsRequest](#ListVersionsRequest)) returns ([ListVersionsResponse](#ListVersionsResponse))**

### ListVersionsRequest {#ListVersionsRequest}

Empty.

### ListVersionsResponse {#ListVersionsResponse}

Field | Description
--- | ---
available_versions[] | **[AvailableVersions](#AvailableVersions)**<br>Versions available in the specified release channel. 


### AvailableVersions {#AvailableVersions}

Field | Description
--- | ---
release_channel | enum **ReleaseChannel**<br>Release channel: `RAPID`, `REGULAR` or `STABLE`. For more details see [documentation](/docs/managed-kubernetes/concepts/release-channels-and-updates). <ul><li>`RAPID`: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li><li>`REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li><li>`STABLE`: Only updates related to bug fixes or security improvements are added.</li></ul>
versions[] | **string**<br>Version of Kubernetes components. 


