---
editable: false
sourcePath: en/_api-ref-grpc/managed-kubernetes/kubernetes-marketplace/kubernetes-marketplace/api-ref/grpc/helm_release_service.md
---

# Kubernetes Marketplace, gRPC: HelmReleaseService

A set of methods for managing Helm release.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves the list of Helm releases in the specified Kubernetes Cluster. |
| [Get](#Get) | Returns the specified Helm release. |
| [Install](#Install) | Installs helm release into specified Kubernetes Cluster. |
| [Update](#Update) | Updates helm release. |
| [Uninstall](#Uninstall) | Uninstalls helm release. |

## Calls HelmReleaseService {#calls}

## List {#List}

Retrieves the list of Helm releases in the specified Kubernetes Cluster.

**rpc List ([ListHelmReleasesRequest](#ListHelmReleasesRequest)) returns ([ListHelmReleasesResponse](#ListHelmReleasesResponse))**

### ListHelmReleasesRequest {#ListHelmReleasesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. The ID of the Kubernetes cluster to list Helm releases from. 
page_size | **int64**<br>The maximum number of results per page that should be returned. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Token for pagination to retrieve the next page of results. The maximum string length in characters is 100.


### ListHelmReleasesResponse {#ListHelmReleasesResponse}

Field | Description
--- | ---
helm_releases[] | **[HelmRelease](#HelmRelease)**<br>List of Helm releases in the Kubernetes cluster. 
next_page_token | **string**<br>Token for retrieving the next page of Helm releases. 


### HelmRelease {#HelmRelease}

Field | Description
--- | ---
id | **string**<br>ID of a helm release. 
cluster_id | **string**<br>ID of the Kubernetes cluster. 
app_name | **string**<br>Name of the application. 
app_namespace | **string**<br>Namespace of the application. 
product_id | **string**<br>Kubernetes marketplace product id. 
product_name | **string**<br>Kubernetes marketplace product name. 
product_version | **string**<br>Kubernetes marketplace product version. 
status | enum **Status**<br>Status of a helm release. <ul><li>`UNKNOWN`: Helm release status is unknown</li><li>`DEPLOYED`: Helm release deployed.</li><li>`UNINSTALLED`: Helm release uninstalled.</li><li>`SUPERSEDED`: Helm release superseded.</li><li>`FAILED`: Helm release installation failed.</li><li>`UNINSTALLING`: Helm release is being uninstalled.</li><li>`PENDING_INSTALL`: Helm release is to be installed.</li><li>`PENDING_UPGRADE`: Helm release is to be updated.</li><li>`PENDING_ROLLBACK`: Helm release is to be rolled back.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Get {#Get}

Returns the specified Helm release.

**rpc Get ([GetHelmReleaseRequest](#GetHelmReleaseRequest)) returns ([HelmRelease](#HelmRelease1))**

### GetHelmReleaseRequest {#GetHelmReleaseRequest}

Field | Description
--- | ---
id | **string**<br>Required. The ID of the Helm release to retrieve. 


### HelmRelease {#HelmRelease1}

Field | Description
--- | ---
id | **string**<br>ID of a helm release. 
cluster_id | **string**<br>ID of the Kubernetes cluster. 
app_name | **string**<br>Name of the application. 
app_namespace | **string**<br>Namespace of the application. 
product_id | **string**<br>Kubernetes marketplace product id. 
product_name | **string**<br>Kubernetes marketplace product name. 
product_version | **string**<br>Kubernetes marketplace product version. 
status | enum **Status**<br>Status of a helm release. <ul><li>`UNKNOWN`: Helm release status is unknown</li><li>`DEPLOYED`: Helm release deployed.</li><li>`UNINSTALLED`: Helm release uninstalled.</li><li>`SUPERSEDED`: Helm release superseded.</li><li>`FAILED`: Helm release installation failed.</li><li>`UNINSTALLING`: Helm release is being uninstalled.</li><li>`PENDING_INSTALL`: Helm release is to be installed.</li><li>`PENDING_UPGRADE`: Helm release is to be updated.</li><li>`PENDING_ROLLBACK`: Helm release is to be rolled back.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Install {#Install}

Installs helm release into specified Kubernetes Cluster.

**rpc Install ([InstallHelmReleaseRequest](#InstallHelmReleaseRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[InstallHelmReleaseMetadata](#InstallHelmReleaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HelmRelease](#HelmRelease2)<br>

### InstallHelmReleaseRequest {#InstallHelmReleaseRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. The ID of the Kubernetes cluster where the Helm release is to be installed. 
product_version_id | **string**<br>The product version ID to install. 
user_values[] | **[ValueWithKey](#ValueWithKey)**<br>User-defined values for the Helm chart during installation. 


### ValueWithKey {#ValueWithKey}

Field | Description
--- | ---
key | **string**<br>Required. The key associated with the value. 
value | **[Value](#Value)**<br>The value associated with the key. 


### Value {#Value}

Field | Description
--- | ---
value | **oneof:** `typed_value`<br>
&nbsp;&nbsp;typed_value | **string**<br>The typed string value. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstallHelmReleaseMetadata](#InstallHelmReleaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HelmRelease](#HelmRelease2)>**<br>if operation finished successfully. 


### InstallHelmReleaseMetadata {#InstallHelmReleaseMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>The ID of the Kubernetes cluster where the Helm release is being installed. 
helm_release_id | **string**<br>The ID of the Helm release being installed. 
product_version_id | **string**<br>The ID of the product version being deployed. 


### HelmRelease {#HelmRelease2}

Field | Description
--- | ---
id | **string**<br>ID of a helm release. 
cluster_id | **string**<br>ID of the Kubernetes cluster. 
app_name | **string**<br>Name of the application. 
app_namespace | **string**<br>Namespace of the application. 
product_id | **string**<br>Kubernetes marketplace product id. 
product_name | **string**<br>Kubernetes marketplace product name. 
product_version | **string**<br>Kubernetes marketplace product version. 
status | enum **Status**<br>Status of a helm release. <ul><li>`UNKNOWN`: Helm release status is unknown</li><li>`DEPLOYED`: Helm release deployed.</li><li>`UNINSTALLED`: Helm release uninstalled.</li><li>`SUPERSEDED`: Helm release superseded.</li><li>`FAILED`: Helm release installation failed.</li><li>`UNINSTALLING`: Helm release is being uninstalled.</li><li>`PENDING_INSTALL`: Helm release is to be installed.</li><li>`PENDING_UPGRADE`: Helm release is to be updated.</li><li>`PENDING_ROLLBACK`: Helm release is to be rolled back.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Update {#Update}

Updates helm release.

**rpc Update ([UpdateHelmReleaseRequest](#UpdateHelmReleaseRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateHelmReleaseMetadata](#UpdateHelmReleaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[HelmRelease](#HelmRelease3)<br>

### UpdateHelmReleaseRequest {#UpdateHelmReleaseRequest}

Field | Description
--- | ---
id | **string**<br>Required. The ID of the Helm release to update. 
product_version_id | **string**<br>The ID of the new product version for the release. 
user_values[] | **[ValueWithKey](#ValueWithKey)**<br>Custom user values to apply during the update. 


### ValueWithKey {#ValueWithKey1}

Field | Description
--- | ---
key | **string**<br>Required. The key associated with the value. 
value | **[Value](#Value)**<br>The value associated with the key. 


### Value {#Value1}

Field | Description
--- | ---
value | **oneof:** `typed_value`<br>
&nbsp;&nbsp;typed_value | **string**<br>The typed string value. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateHelmReleaseMetadata](#UpdateHelmReleaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[HelmRelease](#HelmRelease3)>**<br>if operation finished successfully. 


### UpdateHelmReleaseMetadata {#UpdateHelmReleaseMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>The ID of the Kubernetes cluster where the Helm release is being updated. 
helm_release_id | **string**<br>The ID of the Helm release being updated. 
product_version_id | **string**<br>The ID of the new product version to update the Helm release to. 


### HelmRelease {#HelmRelease3}

Field | Description
--- | ---
id | **string**<br>ID of a helm release. 
cluster_id | **string**<br>ID of the Kubernetes cluster. 
app_name | **string**<br>Name of the application. 
app_namespace | **string**<br>Namespace of the application. 
product_id | **string**<br>Kubernetes marketplace product id. 
product_name | **string**<br>Kubernetes marketplace product name. 
product_version | **string**<br>Kubernetes marketplace product version. 
status | enum **Status**<br>Status of a helm release. <ul><li>`UNKNOWN`: Helm release status is unknown</li><li>`DEPLOYED`: Helm release deployed.</li><li>`UNINSTALLED`: Helm release uninstalled.</li><li>`SUPERSEDED`: Helm release superseded.</li><li>`FAILED`: Helm release installation failed.</li><li>`UNINSTALLING`: Helm release is being uninstalled.</li><li>`PENDING_INSTALL`: Helm release is to be installed.</li><li>`PENDING_UPGRADE`: Helm release is to be updated.</li><li>`PENDING_ROLLBACK`: Helm release is to be rolled back.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Uninstall {#Uninstall}

Uninstalls helm release.

**rpc Uninstall ([UninstallHelmReleaseRequest](#UninstallHelmReleaseRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UninstallHelmReleaseMetadata](#UninstallHelmReleaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UninstallHelmReleaseRequest {#UninstallHelmReleaseRequest}

Field | Description
--- | ---
id | **string**<br>Required. The ID of the Helm release to retrieve. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UninstallHelmReleaseMetadata](#UninstallHelmReleaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UninstallHelmReleaseMetadata {#UninstallHelmReleaseMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required. The ID of the Kubernetes cluster where the release is being uninstalled. 
helm_release_id | **string**<br>Required. The ID of the Helm release being uninstalled. 


