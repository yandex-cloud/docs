---
editable: false
sourcePath: en/_api-ref-grpc/container-registry/api-ref/grpc/lifecycle_policy_service.md
---

# LifecyclePolicyService

A set of methods for managing Lifecycle policy resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified lifecycle policy. |
| [List](#List) | Retrieves the list of lifecycle policies in the specified repository. |
| [Create](#Create) | Creates a lifecycle policy in the specified repository. |
| [Update](#Update) | Updates the specified lifecycle policy. |
| [Delete](#Delete) | Deletes the specified lifecycle policy. |
| [DryRun](#DryRun) | Creates a request of a dry run of the lifecycle policy. |
| [GetDryRunResult](#GetDryRunResult) | Returns the dry run result of the specified lifecycle policy. |
| [ListDryRunResults](#ListDryRunResults) | Retrieves the list of the dry run results. |
| [ListDryRunResultAffectedImages](#ListDryRunResultAffectedImages) | Retrieves the list of the affected images. |

## Calls LifecyclePolicyService {#calls}

## Get {#Get}

Returns the specified lifecycle policy. <br>To get the list of all available lifecycle policies, make a [List](#List) request.

**rpc Get ([GetLifecyclePolicyRequest](#GetLifecyclePolicyRequest)) returns ([LifecyclePolicy](#LifecyclePolicy))**

### GetLifecyclePolicyRequest {#GetLifecyclePolicyRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required. ID of the lifecycle policy. The maximum string length in characters is 50.


### LifecyclePolicy {#LifecyclePolicy}

Field | Description
--- | ---
id | **string**<br>ID of the lifecycle policy. 
name | **string**<br>Name of the lifecycle policy. 
repository_id | **string**<br>ID of the repository that the lifecycle policy belongs to. Required. The maximum string length in characters is 50. 
description | **string**<br>Description of the lifecycle policy. The maximum string length in characters is 256. 
status | enum **Status**<br>Status of lifecycle policy. <ul><li>`ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.</li><li>`DISABLED`: Policy is disabled and does not delete Docker images in the repository. Policies in this status can be used for preparing and testing rules.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
rules[] | **[LifecycleRule](#LifecycleRule)**<br>The rules of lifecycle policy. 


### LifecycleRule {#LifecycleRule}

Field | Description
--- | ---
description | **string**<br>Description of the lifecycle policy rule. The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Period of time for automatic deletion. Period must be a multiple of 24 hours. The minimum value is 24h.
tag_regexp | **string**<br>Tag for specifying a filter in the form of a regular expression. The maximum string length in characters is 256.
untagged | **bool**<br>Tag for applying the rule to Docker images without tags. 
retained_top | **int64**<br>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired. The minimum value is 0.


## List {#List}

Retrieves the list of lifecycle policies in the specified repository.

**rpc List ([ListLifecyclePoliciesRequest](#ListLifecyclePoliciesRequest)) returns ([ListLifecyclePoliciesResponse](#ListLifecyclePoliciesResponse))**

### ListLifecyclePoliciesRequest {#ListLifecyclePoliciesRequest}

Field | Description
--- | ---
id | **oneof:** `registry_id` or `repository_id`<br>
&nbsp;&nbsp;registry_id | **string**<br>ID of the lifecycle policy. The maximum string length in characters is 50.
&nbsp;&nbsp;repository_id | **string**<br>Repository of the lifecycle policy. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListLifecyclePoliciesResponse.next_page_token](#ListLifecyclePoliciesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListLifecyclePoliciesResponse.next_page_token](#ListLifecyclePoliciesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters lifecycle policy resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [LifecyclePolicy.name](#LifecyclePolicy1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br>Sorting the list by [LifecyclePolicy.name](#LifecyclePolicy1), [LifecyclePolicy.created_at](#LifecyclePolicy1) and [LifecyclePolicy.status](#LifecyclePolicy1) fields. The default sorting order is ascending. The maximum string length in characters is 100.


### ListLifecyclePoliciesResponse {#ListLifecyclePoliciesResponse}

Field | Description
--- | ---
lifecycle_policies[] | **[LifecyclePolicy](#LifecyclePolicy1)**<br>List of lifecycle policies. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListLifecyclePoliciesRequest.page_size](#ListLifecyclePoliciesRequest), use `next_page_token` as the value for the [ListLifecyclePoliciesRequest.page_token](#ListLifecyclePoliciesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### LifecyclePolicy {#LifecyclePolicy1}

Field | Description
--- | ---
id | **string**<br>ID of the lifecycle policy. 
name | **string**<br>Name of the lifecycle policy. 
repository_id | **string**<br>ID of the repository that the lifecycle policy belongs to. Required. The maximum string length in characters is 50. 
description | **string**<br>Description of the lifecycle policy. The maximum string length in characters is 256. 
status | enum **Status**<br>Status of lifecycle policy. <ul><li>`ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.</li><li>`DISABLED`: Policy is disabled and does not delete Docker images in the repository. Policies in this status can be used for preparing and testing rules.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
rules[] | **[LifecycleRule](#LifecycleRule1)**<br>The rules of lifecycle policy. 


### LifecycleRule {#LifecycleRule1}

Field | Description
--- | ---
description | **string**<br>Description of the lifecycle policy rule. The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Period of time for automatic deletion. Period must be a multiple of 24 hours. The minimum value is 24h.
tag_regexp | **string**<br>Tag for specifying a filter in the form of a regular expression. The maximum string length in characters is 256.
untagged | **bool**<br>Tag for applying the rule to Docker images without tags. 
retained_top | **int64**<br>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired. The minimum value is 0.


## Create {#Create}

Creates a lifecycle policy in the specified repository.

**rpc Create ([CreateLifecyclePolicyRequest](#CreateLifecyclePolicyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateLifecyclePolicyMetadata](#CreateLifecyclePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LifecyclePolicy](#LifecyclePolicy2)<br>

### CreateLifecyclePolicyRequest {#CreateLifecyclePolicyRequest}

Field | Description
--- | ---
repository_id | **string**<br>Required. ID of the lifecycle policy repository. The maximum string length in characters is 50.
name | **string**<br>Name of lifecycle policy. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of lifecycle policy. The maximum string length in characters is 256.
status | **[LifecyclePolicy.Status](#LifecyclePolicy2)**<br>Required. Status of the lifecycle policy. 
rules[] | **[LifecycleRule](#LifecycleRule2)**<br>The rules of the lifecycle policy. 


### LifecycleRule {#LifecycleRule2}

Field | Description
--- | ---
description | **string**<br>Description of the lifecycle policy rule. The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Period of time for automatic deletion. Period must be a multiple of 24 hours. The minimum value is 24h.
tag_regexp | **string**<br>Tag for specifying a filter in the form of a regular expression. The maximum string length in characters is 256.
untagged | **bool**<br>Tag for applying the rule to Docker images without tags. 
retained_top | **int64**<br>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired. The minimum value is 0.


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
lifecycle_policy_id | **string**<br>ID of the lifecycle policy resource that is being created. 


### LifecyclePolicy {#LifecyclePolicy2}

Field | Description
--- | ---
id | **string**<br>ID of the lifecycle policy. 
name | **string**<br>Name of the lifecycle policy. 
repository_id | **string**<br>ID of the repository that the lifecycle policy belongs to. Required. The maximum string length in characters is 50. 
description | **string**<br>Description of the lifecycle policy. The maximum string length in characters is 256. 
status | enum **Status**<br>Status of lifecycle policy. <ul><li>`ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.</li><li>`DISABLED`: Policy is disabled and does not delete Docker images in the repository. Policies in this status can be used for preparing and testing rules.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
rules[] | **[LifecycleRule](#LifecycleRule3)**<br>The rules of lifecycle policy. 


## Update {#Update}

Updates the specified lifecycle policy.

**rpc Update ([UpdateLifecyclePolicyRequest](#UpdateLifecyclePolicyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateLifecyclePolicyMetadata](#UpdateLifecyclePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[LifecyclePolicy](#LifecyclePolicy3)<br>

### UpdateLifecyclePolicyRequest {#UpdateLifecyclePolicyRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required. ID of the lifecycle policy. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the lifecycle policy resource are going to be updated. 
name | **string**<br>Name of lifecycle policy. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of lifecycle policy. The maximum string length in characters is 256.
status | **[LifecyclePolicy.Status](#LifecyclePolicy3)**<br>Required. Status of the lifecycle policy. 
rules[] | **[LifecycleRule](#LifecycleRule3)**<br>The rules of the lifecycle policy. 


### LifecycleRule {#LifecycleRule3}

Field | Description
--- | ---
description | **string**<br>Description of the lifecycle policy rule. The maximum string length in characters is 256.
expire_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Period of time for automatic deletion. Period must be a multiple of 24 hours. The minimum value is 24h.
tag_regexp | **string**<br>Tag for specifying a filter in the form of a regular expression. The maximum string length in characters is 256.
untagged | **bool**<br>Tag for applying the rule to Docker images without tags. 
retained_top | **int64**<br>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired. The minimum value is 0.


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
lifecycle_policy_id | **string**<br>ID of the lifecycle policy resource that is being updated. 


### LifecyclePolicy {#LifecyclePolicy3}

Field | Description
--- | ---
id | **string**<br>ID of the lifecycle policy. 
name | **string**<br>Name of the lifecycle policy. 
repository_id | **string**<br>ID of the repository that the lifecycle policy belongs to. Required. The maximum string length in characters is 50. 
description | **string**<br>Description of the lifecycle policy. The maximum string length in characters is 256. 
status | enum **Status**<br>Status of lifecycle policy. <ul><li>`ACTIVE`: Policy is active and regularly deletes Docker images according to the established rules.</li><li>`DISABLED`: Policy is disabled and does not delete Docker images in the repository. Policies in this status can be used for preparing and testing rules.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
rules[] | **[LifecycleRule](#LifecycleRule4)**<br>The rules of lifecycle policy. 


## Delete {#Delete}

Deletes the specified lifecycle policy.

**rpc Delete ([DeleteLifecyclePolicyRequest](#DeleteLifecyclePolicyRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteLifecyclePolicyMetadata](#DeleteLifecyclePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteLifecyclePolicyRequest {#DeleteLifecyclePolicyRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required. ID of the lifecycle policy. The maximum string length in characters is 50.


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
lifecycle_policy_id | **string**<br>ID of the lifecycle policy resource that is being deleted. 


## DryRun {#DryRun}

Creates a request of a dry run of the lifecycle policy.

**rpc DryRun ([DryRunLifecyclePolicyRequest](#DryRunLifecyclePolicyRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DryRunLifecyclePolicyMetadata](#DryRunLifecyclePolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DryRunLifecyclePolicyResult](#DryRunLifecyclePolicyResult)<br>

### DryRunLifecyclePolicyRequest {#DryRunLifecyclePolicyRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required. ID of the lifecycle policy. The maximum string length in characters is 50.


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
dry_run_lifecycle_policy_result_id | **string**<br>ID of the dry run result of the lifecycle policy. 
lifecycle_policy_id | **string**<br>ID of the lifecycle policy. 


### DryRunLifecyclePolicyResult {#DryRunLifecyclePolicyResult}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br>ID of the dry run result of the lifecycle policy. 
lifecycle_policy_id | **string**<br>ID of the lifecycle policy. 
run_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the getting result. 
affected_images_count | **int64**<br>Count of affected images. 


## GetDryRunResult {#GetDryRunResult}

Returns the dry run result of the specified lifecycle policy.

**rpc GetDryRunResult ([GetDryRunLifecyclePolicyResultRequest](#GetDryRunLifecyclePolicyResultRequest)) returns ([DryRunLifecyclePolicyResult](#DryRunLifecyclePolicyResult))**

### GetDryRunLifecyclePolicyResultRequest {#GetDryRunLifecyclePolicyResultRequest}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br>Required. ID of the dry run result of the lifecycle policy. The maximum string length in characters is 50.


### DryRunLifecyclePolicyResult {#DryRunLifecyclePolicyResult1}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br>ID of the dry run result of the lifecycle policy. 
lifecycle_policy_id | **string**<br>ID of the lifecycle policy. 
run_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the getting result. 
affected_images_count | **int64**<br>Count of affected images. 


## ListDryRunResults {#ListDryRunResults}

Retrieves the list of the dry run results.

**rpc ListDryRunResults ([ListDryRunLifecyclePolicyResultsRequest](#ListDryRunLifecyclePolicyResultsRequest)) returns ([ListDryRunLifecyclePolicyResultsResponse](#ListDryRunLifecyclePolicyResultsResponse))**

### ListDryRunLifecyclePolicyResultsRequest {#ListDryRunLifecyclePolicyResultsRequest}

Field | Description
--- | ---
lifecycle_policy_id | **string**<br>Required. ID of the lifecycle policy. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDryRunLifecyclePolicyResultsResponse.next_page_token](#ListDryRunLifecyclePolicyResultsResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDryRunLifecyclePolicyResultsResponse.next_page_token](#ListDryRunLifecyclePolicyResultsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters dry run results listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [LifecyclePolicy.name](#LifecyclePolicy4) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br>Sorting the list by [DryRunLifecyclePolicyResult.run_at](#DryRunLifecyclePolicyResult) and [DryRunLifecyclePolicyResult.affected_images_count](#DryRunLifecyclePolicyResult) fields. The default sorting order is ascending. The maximum string length in characters is 100.


### ListDryRunLifecyclePolicyResultsResponse {#ListDryRunLifecyclePolicyResultsResponse}

Field | Description
--- | ---
dry_run_lifecycle_policy_results[] | **[DryRunLifecyclePolicyResult](#DryRunLifecyclePolicyResult)**<br>List of results of dry runs of a lifecycle policy. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListDryRunLifecyclePolicyResultsRequest.page_size](#ListDryRunLifecyclePolicyResultsRequest) use `next_page_token` as the value for the [ListDryRunLifecyclePolicyResultsRequest.page_token](#ListDryRunLifecyclePolicyResultsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### DryRunLifecyclePolicyResult {#DryRunLifecyclePolicyResult2}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br>ID of the dry run result of the lifecycle policy. 
lifecycle_policy_id | **string**<br>ID of the lifecycle policy. 
run_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the getting result. 
affected_images_count | **int64**<br>Count of affected images. 


## ListDryRunResultAffectedImages {#ListDryRunResultAffectedImages}

Retrieves the list of the affected images.

**rpc ListDryRunResultAffectedImages ([ListDryRunLifecyclePolicyResultAffectedImagesRequest](#ListDryRunLifecyclePolicyResultAffectedImagesRequest)) returns ([ListDryRunLifecyclePolicyResultAffectedImagesResponse](#ListDryRunLifecyclePolicyResultAffectedImagesResponse))**

### ListDryRunLifecyclePolicyResultAffectedImagesRequest {#ListDryRunLifecyclePolicyResultAffectedImagesRequest}

Field | Description
--- | ---
dry_run_lifecycle_policy_result_id | **string**<br>Required. ID of the dry run result of the lifecycle policy The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDryRunLifecyclePolicyResultAffectedImagesResponse.next_page_token](#ListDryRunLifecyclePolicyResultAffectedImagesResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDryRunLifecyclePolicyResultAffectedImagesResponse.next_page_token](#ListDryRunLifecyclePolicyResultAffectedImagesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters affected images listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [LifecyclePolicy.name](#LifecyclePolicy4) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br>Sorting the list by [LifecyclePolicy.name](#LifecyclePolicy4) and [LifecyclePolicy.created_at](#LifecyclePolicy4) fields. The default sorting order is ascending. The maximum string length in characters is 100.


### ListDryRunLifecyclePolicyResultAffectedImagesResponse {#ListDryRunLifecyclePolicyResultAffectedImagesResponse}

Field | Description
--- | ---
affected_images[] | **[Image](#Image)**<br>List of affected images. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListDryRunLifecyclePolicyResultAffectedImagesRequest.page_size](#ListDryRunLifecyclePolicyResultAffectedImagesRequest), use `next_page_token` as the value for the [ListDryRunLifecyclePolicyResultAffectedImagesRequest.page_token](#ListDryRunLifecyclePolicyResultAffectedImagesRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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
urls[] | **string**<br>List of blob urls. 


