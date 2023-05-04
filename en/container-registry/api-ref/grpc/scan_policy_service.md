---
editable: false
sourcePath: en/_api-ref-grpc/container-registry/api-ref/grpc/scan_policy_service.md
---

# Container Registry API, gRPC: ScanPolicyService

A set of methods for managing scan policy resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified scan policy. |
| [GetByRegistry](#GetByRegistry) | Returns scan policy for the registry if any exists. |
| [Create](#Create) | Creates a scan policy for the specified registry. |
| [Update](#Update) | Updates the specified scan policy. |
| [Delete](#Delete) | Deletes the specified scan policy. |

## Calls ScanPolicyService {#calls}

## Get {#Get}

Returns the specified scan policy.

**rpc Get ([GetScanPolicyRequest](#GetScanPolicyRequest)) returns ([ScanPolicy](#ScanPolicy))**

### GetScanPolicyRequest {#GetScanPolicyRequest}

Field | Description
--- | ---
scan_policy_id | **string**<br>Required. ID of the scan policy. The maximum string length in characters is 50.


### ScanPolicy {#ScanPolicy}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the scan policy. 
registry_id | **string**<br>ID of the registry that the scan policy belongs to. Required. The maximum string length in characters is 50. 
name | **string**<br>Name of the scan policy. 
description | **string**<br>Description of the scan policy. The maximum string length in characters is 256. 
rules | **[ScanRules](#ScanRules)**<br>The rules of scan policy. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp. 
disabled | **bool**<br>Turns off scan policy. 


### ScanRules {#ScanRules}

Field | Description
--- | ---
push_rule | **[PushRule](#PushRule)**<br>Description of on-push scan rule. 
schedule_rules[] | **[ScheduledRule](#ScheduledRule)**<br>Description of time based rescan rule. 


### PushRule {#PushRule}

Field | Description
--- | ---
repository_prefixes[] | **string**<br>List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry The number of elements must be greater than 0. Each value must match the regular expression ` \\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
disabled | **bool**<br>Turns off scan rule. 


### ScheduledRule {#ScheduledRule}

Field | Description
--- | ---
repository_prefixes[] | **string**<br>List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry The number of elements must be greater than 0. Each value must match the regular expression ` \\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
rescan_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Period of time since last scan to trigger automatic rescan. 
disabled | **bool**<br>Turns off scan rule. 


## GetByRegistry {#GetByRegistry}

Returns scan policy for the registry if any exists.

**rpc GetByRegistry ([GetScanPolicyByRegistryRequest](#GetScanPolicyByRegistryRequest)) returns ([ScanPolicy](#ScanPolicy1))**

### GetScanPolicyByRegistryRequest {#GetScanPolicyByRegistryRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the registry with scan policy. The maximum string length in characters is 50.


### ScanPolicy {#ScanPolicy1}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the scan policy. 
registry_id | **string**<br>ID of the registry that the scan policy belongs to. Required. The maximum string length in characters is 50. 
name | **string**<br>Name of the scan policy. 
description | **string**<br>Description of the scan policy. The maximum string length in characters is 256. 
rules | **[ScanRules](#ScanRules1)**<br>The rules of scan policy. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp. 
disabled | **bool**<br>Turns off scan policy. 


### ScanRules {#ScanRules1}

Field | Description
--- | ---
push_rule | **[PushRule](#PushRule1)**<br>Description of on-push scan rule. 
schedule_rules[] | **[ScheduledRule](#ScheduledRule1)**<br>Description of time based rescan rule. 


### PushRule {#PushRule1}

Field | Description
--- | ---
repository_prefixes[] | **string**<br>List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry The number of elements must be greater than 0. Each value must match the regular expression ` \\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
disabled | **bool**<br>Turns off scan rule. 


### ScheduledRule {#ScheduledRule1}

Field | Description
--- | ---
repository_prefixes[] | **string**<br>List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry The number of elements must be greater than 0. Each value must match the regular expression ` \\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
rescan_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Period of time since last scan to trigger automatic rescan. 
disabled | **bool**<br>Turns off scan rule. 


## Create {#Create}

Creates a scan policy for the specified registry.

**rpc Create ([CreateScanPolicyRequest](#CreateScanPolicyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateScanPolicyMetadata](#CreateScanPolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ScanPolicy](#ScanPolicy2)<br>

### CreateScanPolicyRequest {#CreateScanPolicyRequest}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the scan policy registry. The maximum string length in characters is 50.
name | **string**<br>Name of the scan policy. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the scan policy. The maximum string length in characters is 256.
rules | **[ScanRules](#ScanRules2)**<br>Rules of the scan policy. 


### ScanRules {#ScanRules2}

Field | Description
--- | ---
push_rule | **[PushRule](#PushRule2)**<br>Description of on-push scan rule. 
schedule_rules[] | **[ScheduledRule](#ScheduledRule2)**<br>Description of time based rescan rule. 


### PushRule {#PushRule2}

Field | Description
--- | ---
repository_prefixes[] | **string**<br>List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry The number of elements must be greater than 0. Each value must match the regular expression ` \\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
disabled | **bool**<br>Turns off scan rule. 


### ScheduledRule {#ScheduledRule2}

Field | Description
--- | ---
repository_prefixes[] | **string**<br>List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry The number of elements must be greater than 0. Each value must match the regular expression ` \\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
rescan_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Period of time since last scan to trigger automatic rescan. 
disabled | **bool**<br>Turns off scan rule. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateScanPolicyMetadata](#CreateScanPolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScanPolicy](#ScanPolicy2)>**<br>if operation finished successfully. 


### CreateScanPolicyMetadata {#CreateScanPolicyMetadata}

Field | Description
--- | ---
scan_policy_id | **string**<br>ID of created scan policy resource. 


### ScanPolicy {#ScanPolicy2}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the scan policy. 
registry_id | **string**<br>ID of the registry that the scan policy belongs to. Required. The maximum string length in characters is 50. 
name | **string**<br>Name of the scan policy. 
description | **string**<br>Description of the scan policy. The maximum string length in characters is 256. 
rules | **[ScanRules](#ScanRules3)**<br>The rules of scan policy. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp. 
disabled | **bool**<br>Turns off scan policy. 


## Update {#Update}

Updates the specified scan policy.

**rpc Update ([UpdateScanPolicyRequest](#UpdateScanPolicyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateScanPolicyMetadata](#UpdateScanPolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ScanPolicy](#ScanPolicy3)<br>

### UpdateScanPolicyRequest {#UpdateScanPolicyRequest}

Field | Description
--- | ---
scan_policy_id | **string**<br>Required. ID of the scan policy. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the scan policy resource are going to be updated. 
name | **string**<br>Name of the scan policy. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the scan policy. The maximum string length in characters is 256.
rules | **[ScanRules](#ScanRules3)**<br>Rules of the scan policy. 


### ScanRules {#ScanRules3}

Field | Description
--- | ---
push_rule | **[PushRule](#PushRule3)**<br>Description of on-push scan rule. 
schedule_rules[] | **[ScheduledRule](#ScheduledRule3)**<br>Description of time based rescan rule. 


### PushRule {#PushRule3}

Field | Description
--- | ---
repository_prefixes[] | **string**<br>List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry The number of elements must be greater than 0. Each value must match the regular expression ` \\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
disabled | **bool**<br>Turns off scan rule. 


### ScheduledRule {#ScheduledRule3}

Field | Description
--- | ---
repository_prefixes[] | **string**<br>List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry The number of elements must be greater than 0. Each value must match the regular expression ` \\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
rescan_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Period of time since last scan to trigger automatic rescan. 
disabled | **bool**<br>Turns off scan rule. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateScanPolicyMetadata](#UpdateScanPolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScanPolicy](#ScanPolicy3)>**<br>if operation finished successfully. 


### UpdateScanPolicyMetadata {#UpdateScanPolicyMetadata}

Field | Description
--- | ---
scan_policy_id | **string**<br>ID of the scan policy resource that is updated. 


### ScanPolicy {#ScanPolicy3}

Field | Description
--- | ---
id | **string**<br>Output only. ID of the scan policy. 
registry_id | **string**<br>ID of the registry that the scan policy belongs to. Required. The maximum string length in characters is 50. 
name | **string**<br>Name of the scan policy. 
description | **string**<br>Description of the scan policy. The maximum string length in characters is 256. 
rules | **[ScanRules](#ScanRules4)**<br>The rules of scan policy. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Output only. Creation timestamp. 
disabled | **bool**<br>Turns off scan policy. 


## Delete {#Delete}

Deletes the specified scan policy.

**rpc Delete ([DeleteScanPolicyRequest](#DeleteScanPolicyRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteScanPolicyMetadata](#DeleteScanPolicyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteScanPolicyRequest {#DeleteScanPolicyRequest}

Field | Description
--- | ---
scan_policy_id | **string**<br>Required. ID of the scan policy. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteScanPolicyMetadata](#DeleteScanPolicyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteScanPolicyMetadata {#DeleteScanPolicyMetadata}

Field | Description
--- | ---
scan_policy_id | **string**<br>ID of the scan policy resource that is deleted. 


