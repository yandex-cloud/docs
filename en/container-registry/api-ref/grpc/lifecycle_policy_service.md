---
editable: false

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# LifecyclePolicyService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [DryRun](#DryRun) |  |
| [GetDryRunResult](#GetDryRunResult) |  |
| [ListDryRunResults](#ListDryRunResults) |  |
| [ListDryRunResultAffectedImages](#ListDryRunResultAffectedImages) |  |

## Calls LifecyclePolicyService {#calls}

## Get {#Get}



**rpc Get ([GetLifecyclePolicyRequest](#GetLifecyclePolicyRequest)) returns ([LifecyclePolicy](#LifecyclePolicy))**

### GetLifecyclePolicyRequest {#GetLifecyclePolicyRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required.  The maximum string length in characters is 50.


### LifecyclePolicy {#LifecyclePolicy}

Field | Description
--- | ---
id | **string**<br> 
name | **string**<br> 
repository_id | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> <ul><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
rules[] | **[LifecycleRule](#LifecycleRule)**<br> 


### LifecycleRule {#LifecycleRule}

Field | Description
--- | ---
description | **string**<br> The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> The minimum value is 24h.
tag_regexp | **string**<br> The maximum string length in characters is 256.
untagged | **bool**<br> 
retained_top | **int64**<br> The minimum value is 0.


## List {#List}



**rpc List ([ListLifecyclePoliciesRequest](#ListLifecyclePoliciesRequest)) returns ([ListLifecyclePoliciesResponse](#ListLifecyclePoliciesResponse))**

### ListLifecyclePoliciesRequest {#ListLifecyclePoliciesRequest}

Field | Description
--- | ---
id | **oneof:** `registry_id` or `repository_id`<br>
&nbsp;&nbsp;registry_id | **string**<br> The maximum string length in characters is 50.
&nbsp;&nbsp;repository_id | **string**<br> The maximum string length in characters is 50.
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.
order_by | **string**<br> The maximum string length in characters is 100.


### ListLifecyclePoliciesResponse {#ListLifecyclePoliciesResponse}

Field | Description
--- | ---
lifecycle_policies[] | **[LifecyclePolicy](#LifecyclePolicy1)**<br> 
next_page_token | **string**<br> 


### LifecyclePolicy {#LifecyclePolicy1}

Field | Description
--- | ---
id | **string**<br> 
name | **string**<br> 
repository_id | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> <ul><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
rules[] | **[LifecycleRule](#LifecycleRule1)**<br> 


### LifecycleRule {#LifecycleRule1}

Field | Description
--- | ---
description | **string**<br> The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> The minimum value is 24h.
tag_regexp | **string**<br> The maximum string length in characters is 256.
untagged | **bool**<br> 
retained_top | **int64**<br> The minimum value is 0.


## Create {#Create}



**rpc Create ([CreateLifecyclePolicyRequest](#CreateLifecyclePolicyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateLifecyclePolicyMetadata](#CreateLifecyclePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LifecyclePolicy](#LifecyclePolicy2)<br>

### CreateLifecyclePolicyRequest {#CreateLifecyclePolicyRequest}

Field | Description
--- | ---
repository_id | **string**<br>Required.  The maximum string length in characters is 50.
name | **string**<br> Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
status | **[LifecyclePolicy.Status](#LifecyclePolicy2)**<br>Required.  
rules[] | **[LifecycleRule](#LifecycleRule2)**<br> 


### LifecycleRule {#LifecycleRule2}

Field | Description
--- | ---
description | **string**<br> The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> The minimum value is 24h.
tag_regexp | **string**<br> The maximum string length in characters is 256.
untagged | **bool**<br> 
retained_top | **int64**<br> The minimum value is 0.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateLifecyclePolicyMetadata](#CreateLifecyclePolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LifecyclePolicy](#LifecyclePolicy2)>**<br>if operation finished successfully. 


### CreateLifecyclePolicyMetadata {#CreateLifecyclePolicyMetadata}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br> 


### LifecyclePolicy {#LifecyclePolicy2}

Field | Description
--- | ---
id | **string**<br> 
name | **string**<br> 
repository_id | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> <ul><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
rules[] | **[LifecycleRule](#LifecycleRule3)**<br> 


### LifecycleRule {#LifecycleRule3}

Field | Description
--- | ---
description | **string**<br> The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> The minimum value is 24h.
tag_regexp | **string**<br> The maximum string length in characters is 256.
untagged | **bool**<br> 
retained_top | **int64**<br> The minimum value is 0.


## Update {#Update}



**rpc Update ([UpdateLifecyclePolicyRequest](#UpdateLifecyclePolicyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateLifecyclePolicyMetadata](#UpdateLifecyclePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LifecyclePolicy](#LifecyclePolicy3)<br>

### UpdateLifecyclePolicyRequest {#UpdateLifecyclePolicyRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required.  The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
status | **[LifecyclePolicy.Status](#LifecyclePolicy3)**<br>Required.  
rules[] | **[LifecycleRule](#LifecycleRule4)**<br> 


### LifecycleRule {#LifecycleRule4}

Field | Description
--- | ---
description | **string**<br> The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> The minimum value is 24h.
tag_regexp | **string**<br> The maximum string length in characters is 256.
untagged | **bool**<br> 
retained_top | **int64**<br> The minimum value is 0.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateLifecyclePolicyMetadata](#UpdateLifecyclePolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[LifecyclePolicy](#LifecyclePolicy3)>**<br>if operation finished successfully. 


### UpdateLifecyclePolicyMetadata {#UpdateLifecyclePolicyMetadata}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br> 


### LifecyclePolicy {#LifecyclePolicy3}

Field | Description
--- | ---
id | **string**<br> 
name | **string**<br> 
repository_id | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> <ul><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
rules[] | **[LifecycleRule](#LifecycleRule5)**<br> 


### LifecycleRule {#LifecycleRule5}

Field | Description
--- | ---
description | **string**<br> The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br> The minimum value is 24h.
tag_regexp | **string**<br> The maximum string length in characters is 256.
untagged | **bool**<br> 
retained_top | **int64**<br> The minimum value is 0.


## Delete {#Delete}



**rpc Delete ([DeleteLifecyclePolicyRequest](#DeleteLifecyclePolicyRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteLifecyclePolicyMetadata](#DeleteLifecyclePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteLifecyclePolicyRequest {#DeleteLifecyclePolicyRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required.  The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteLifecyclePolicyMetadata](#DeleteLifecyclePolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteLifecyclePolicyMetadata {#DeleteLifecyclePolicyMetadata}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br> 


## DryRun {#DryRun}



**rpc DryRun ([DryRunLifecyclePolicyRequest](#DryRunLifecyclePolicyRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DryRunLifecyclePolicyMetadata](#DryRunLifecyclePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DryRunLifecyclePolicyResult](#DryRunLifecyclePolicyResult)<br>

### DryRunLifecyclePolicyRequest {#DryRunLifecyclePolicyRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required.  The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DryRunLifecyclePolicyMetadata](#DryRunLifecyclePolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DryRunLifecyclePolicyResult](#DryRunLifecyclePolicyResult)>**<br>if operation finished successfully. 


### DryRunLifecyclePolicyMetadata {#DryRunLifecyclePolicyMetadata}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br> 
lifecycle_policy_id | **string**<br> 


### DryRunLifecyclePolicyResult {#DryRunLifecyclePolicyResult}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br> 
lifecycle_policy_id | **string**<br> 
run_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
affected_images_count | **int64**<br> 


## GetDryRunResult {#GetDryRunResult}



**rpc GetDryRunResult ([GetDryRunLifecyclePolicyResultRequest](#GetDryRunLifecyclePolicyResultRequest)) returns ([DryRunLifecyclePolicyResult](#DryRunLifecyclePolicyResult))**

### GetDryRunLifecyclePolicyResultRequest {#GetDryRunLifecyclePolicyResultRequest}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br>Required.  The maximum string length in characters is 50.


### DryRunLifecyclePolicyResult {#DryRunLifecyclePolicyResult1}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br> 
lifecycle_policy_id | **string**<br> 
run_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
affected_images_count | **int64**<br> 


## ListDryRunResults {#ListDryRunResults}



**rpc ListDryRunResults ([ListDryRunLifecyclePolicyResultsRequest](#ListDryRunLifecyclePolicyResultsRequest)) returns ([ListDryRunLifecyclePolicyResultsResponse](#ListDryRunLifecyclePolicyResultsResponse))**

### ListDryRunLifecyclePolicyResultsRequest {#ListDryRunLifecyclePolicyResultsRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required.  The maximum string length in characters is 50.
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.
order_by | **string**<br> The maximum string length in characters is 100.


### ListDryRunLifecyclePolicyResultsResponse {#ListDryRunLifecyclePolicyResultsResponse}

Field | Description
--- | ---
dry_run_lifecycle_policy_results[] | **[DryRunLifecyclePolicyResult](#DryRunLifecyclePolicyResult)**<br> 
next_page_token | **string**<br> 


### DryRunLifecyclePolicyResult {#DryRunLifecyclePolicyResult2}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br> 
lifecycle_policy_id | **string**<br> 
run_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
affected_images_count | **int64**<br> 


## ListDryRunResultAffectedImages {#ListDryRunResultAffectedImages}



**rpc ListDryRunResultAffectedImages ([ListDryRunLifecyclePolicyResultAffectedImagesRequest](#ListDryRunLifecyclePolicyResultAffectedImagesRequest)) returns ([ListDryRunLifecyclePolicyResultAffectedImagesResponse](#ListDryRunLifecyclePolicyResultAffectedImagesResponse))**

### ListDryRunLifecyclePolicyResultAffectedImagesRequest {#ListDryRunLifecyclePolicyResultAffectedImagesRequest}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br>Required.  The maximum string length in characters is 50.
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.
order_by | **string**<br> The maximum string length in characters is 100.


### ListDryRunLifecyclePolicyResultAffectedImagesResponse {#ListDryRunLifecyclePolicyResultAffectedImagesResponse}

Field | Description
--- | ---
affected_images[] | **[Image](#Image)**<br> 
next_page_token | **string**<br> 


### Image {#Image}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the Docker image. 
name | **string**<br>Name of the Docker image. The name is unique within the registry. 
digest | **string**<br>Content-addressable identifier of the Docker image. 
compressed_size | **int64**<br>Compressed size of the Docker image, specified in bytes. 
config | **[Blob](#Blob)**<br>Configuration of the Docker image. 
layers[] | **[Blob](#Blob)**<br>Layers of the Docker image. 
tags[] | **string**<br>Tags of the Docker image. <br>Each tag is unique within the repository. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 


### Blob {#Blob}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the blob. 
digest | **string**<br>Content-addressable identifier of the blob. 
size | **int64**<br>Size of the blob, specified in bytes. 
urls[] | **string**<br> 


