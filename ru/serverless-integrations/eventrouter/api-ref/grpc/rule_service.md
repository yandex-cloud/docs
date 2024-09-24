---
editable: false
sourcePath: en/_api-ref-grpc/functions/eventrouter/eventrouter/api-ref/grpc/rule_service.md
---

# EventRouter Service, gRPC: RuleService

A set of methods for managing rules for serverless eventrouter.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified rules. |
| [List](#List) | Retrieves the list of rules in the specified folder. |
| [Create](#Create) | Creates a rule in the specified folder. |
| [Update](#Update) | Updates the specified rule. |
| [Delete](#Delete) | Deletes the specified rule. |
| [Enable](#Enable) | Enables the specified rule. |
| [Disable](#Disable) | Disables the specified rule. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified rule. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the rule. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified rule. |
| [ListOperations](#ListOperations) | Lists operations for the specified rule. |

## Calls RuleService {#calls}

## Get {#Get}

Returns the specified rules. To get the list of all available buses, make a [List](#List) request.

**rpc Get ([GetRuleRequest](#GetRuleRequest)) returns ([Rule](#Rule))**

### GetRuleRequest {#GetRuleRequest}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule to return. 


### Rule {#Rule}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
bus_id | **string**<br>ID of the bus that the rule belongs to. 
folder_id | **string**<br>ID of the folder that the rule resides in. 
cloud_id | **string**<br>ID of the cloud that the rule resides in. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the rule. 
description | **string**<br>Description of the rule. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
filter | **[Filter](#Filter)**<br>Filter for the rule. 
targets[] | **[Target](#Target)**<br>Targets of the rule. The number of elements must be in the range 1-5.
deletion_protection | **bool**<br>Flag that disallow deletion of the rule. 
status | enum **Status**<br>Rule status <ul><li>`CREATING`: Rule creation in progress, rule is not enabled yet</li><li>`ENABLED`: Rule is operating</li><li>`UPDATING`: Rule update in progress, rule is disabled during update</li><li>`DISABLED`: Rule is explicitly disabled by the user</li></ul>


### Filter {#Filter}

Field | Description
--- | ---
condition | **oneof:** `jq_filter`<br>
&nbsp;&nbsp;jq_filter | **string**<br>JQ filter for matching events. The maximum string length in characters is 1024.


### Target {#Target}

Field | Description
--- | ---
target | **oneof:** `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging` or `workflow`<br>Status of the target.
&nbsp;&nbsp;yds | **[YdsTarget](#YdsTarget)**<br>Status of the target. 
&nbsp;&nbsp;ymq | **[YmqTarget](#YmqTarget)**<br>Status of the target. 
&nbsp;&nbsp;function | **[FunctionTarget](#FunctionTarget)**<br>Status of the target. 
&nbsp;&nbsp;container | **[ContainerTarget](#ContainerTarget)**<br>Status of the target. 
&nbsp;&nbsp;gateway_ws_broadcast | **[GatewayWebsocketBroadcastTarget](#GatewayWebsocketBroadcastTarget)**<br>Status of the target. 
&nbsp;&nbsp;logging | **[LoggingTarget](#LoggingTarget)**<br>Status of the target. 
&nbsp;&nbsp;workflow | **[WorkflowTarget](#WorkflowTarget)**<br>Status of the target. 
transformer | **[Transformer](#Transformer)**<br>Transformer of the target. 
retry_settings | **[RetrySettings](#RetrySettings)**<br>Retry settings of the target. 
dead_letter | **oneof:** `dead_letter_queue`<br>Dead letter settings of the target.
&nbsp;&nbsp;dead_letter_queue | **[PutQueueMessage](#PutQueueMessage)**<br>Dead letter queue. 
status | enum **Status**<br>Status of the target. <ul><li>`ENABLED`: Target is enabled.</li><li>`DISABLED`: Target is disabled.</li><li>`RESOURCE_NOT_FOUND`: Target does not exist.</li><li>`PERMISSION_DENIED`: Service account does not have read permission on source.</li><li>`SUBJECT_NOT_FOUND`: Service account not found.</li></ul>


### YdsTarget {#YdsTarget}

Field | Description
--- | ---
database | **string**<br>Required. Stream database. 
stream_name | **string**<br>Required. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. 
service_account_id | **string**<br>Required. Service account, which has write permission on the stream. The maximum string length in characters is 50.


### YmqTarget {#YmqTarget}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test 
service_account_id | **string**<br>Required. Service account which has write access to the queue. The maximum string length in characters is 50.


### FunctionTarget {#FunctionTarget}

Field | Description
--- | ---
function_id | **string**<br>Required. Function ID. The maximum string length in characters is 50.
function_tag | **string**<br>Function tag, optional. 
service_account_id | **string**<br>Service account which has call permission on the function, optional. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Batch settings. 


### BatchSettings {#BatchSettings}

Field | Description
--- | ---
max_count | **int64**<br>Maximum batch size: trigger will send a batch if number of events exceeds this value. Acceptable values are 0 to 1000, inclusive.
max_bytes | **int64**<br>Maximum batch size: trigger will send a batch if total size of events exceeds this value. Acceptable values are 0 to 262144, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. The maximum value is 1m.


### ContainerTarget {#ContainerTarget}

Field | Description
--- | ---
container_id | **string**<br>Required. Container ID. The maximum string length in characters is 50.
container_revision_id | **string**<br>Container revision ID. 
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>Service account which should be used to call a container, optional. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings1)**<br>Batch settings. 


### GatewayWebsocketBroadcastTarget {#GatewayWebsocketBroadcastTarget}

Field | Description
--- | ---
gateway_id | **string**<br>Required. Gateway ID. The maximum string length in characters is 50.
path | **string**<br>Required. Path. 
service_account_id | **string**<br>Required. Service account which has permission for writing to websockets. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings1)**<br>Batch settings. 


### LoggingTarget {#LoggingTarget}

Field | Description
--- | ---
destination | **oneof:** `log_group_id` or `folder_id`<br>Log group ID or folder ID.
&nbsp;&nbsp;log_group_id | **string**<br>Log group ID or folder ID. The maximum string length in characters is 63.
&nbsp;&nbsp;folder_id | **string**<br>Log group ID or folder ID. The maximum string length in characters is 63.
service_account_id | **string**<br>Required. Service account which has permission for writing logs. The maximum string length in characters is 50.


### WorkflowTarget {#WorkflowTarget}

Field | Description
--- | ---
workflow_id | **string**<br>Required. Workflow ID. The maximum string length in characters is 50.
service_account_id | **string**<br>Required. SA which should be used to start workflow. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings1)**<br>Batch settings. 


### Transformer {#Transformer}

Field | Description
--- | ---
transformer | **oneof:** `jq_transformer`<br>
&nbsp;&nbsp;jq_transformer | **string**<br>JQ string inrerpolation expression for changing event format. The maximum string length in characters is 65536.


### RetrySettings {#RetrySettings}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra calls) before an action fails. Acceptable values are 0 to 10, inclusive.
maximum_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Event goes to dlq when its age exceeds this value. Default is 24h. The maximum value is 24h.


### PutQueueMessage {#PutQueueMessage}

Field | Description
--- | ---
queue_arn | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## List {#List}

Retrieves the list of rules in the specified folder.

**rpc List ([ListRulesRequest](#ListRulesRequest)) returns ([ListRulesResponse](#ListRulesResponse))**

### ListRulesRequest {#ListRulesRequest}

Field | Description
--- | ---
container_id | **oneof:** `bus_id` or `folder_id`<br>ID of the folder on bus to list rules in.
&nbsp;&nbsp;bus_id | **string**<br>ID of the bus to list rules in. 
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list rules in. 
page_size | **int64**<br>The maximum number of results per response. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the `next_page_token` returned by a previous list request. 
filter | **string**<br>Supported fields for filter: name created_at 


### ListRulesResponse {#ListRulesResponse}

Field | Description
--- | ---
rules[] | **[Rule](#Rule1)**<br>List of rules. 
next_page_token | **string**<br>Token for getting the next page of the list of rules. 


### Rule {#Rule1}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
bus_id | **string**<br>ID of the bus that the rule belongs to. 
folder_id | **string**<br>ID of the folder that the rule resides in. 
cloud_id | **string**<br>ID of the cloud that the rule resides in. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the rule. 
description | **string**<br>Description of the rule. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
filter | **[Filter](#Filter1)**<br>Filter for the rule. 
targets[] | **[Target](#Target1)**<br>Targets of the rule. The number of elements must be in the range 1-5.
deletion_protection | **bool**<br>Flag that disallow deletion of the rule. 
status | enum **Status**<br>Rule status <ul><li>`CREATING`: Rule creation in progress, rule is not enabled yet</li><li>`ENABLED`: Rule is operating</li><li>`UPDATING`: Rule update in progress, rule is disabled during update</li><li>`DISABLED`: Rule is explicitly disabled by the user</li></ul>


### Filter {#Filter1}

Field | Description
--- | ---
condition | **oneof:** `jq_filter`<br>
&nbsp;&nbsp;jq_filter | **string**<br>JQ filter for matching events. The maximum string length in characters is 1024.


### Target {#Target1}

Field | Description
--- | ---
target | **oneof:** `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging` or `workflow`<br>Status of the target.
&nbsp;&nbsp;yds | **[YdsTarget](#YdsTarget1)**<br>Status of the target. 
&nbsp;&nbsp;ymq | **[YmqTarget](#YmqTarget1)**<br>Status of the target. 
&nbsp;&nbsp;function | **[FunctionTarget](#FunctionTarget1)**<br>Status of the target. 
&nbsp;&nbsp;container | **[ContainerTarget](#ContainerTarget1)**<br>Status of the target. 
&nbsp;&nbsp;gateway_ws_broadcast | **[GatewayWebsocketBroadcastTarget](#GatewayWebsocketBroadcastTarget1)**<br>Status of the target. 
&nbsp;&nbsp;logging | **[LoggingTarget](#LoggingTarget1)**<br>Status of the target. 
&nbsp;&nbsp;workflow | **[WorkflowTarget](#WorkflowTarget1)**<br>Status of the target. 
transformer | **[Transformer](#Transformer1)**<br>Transformer of the target. 
retry_settings | **[RetrySettings](#RetrySettings1)**<br>Retry settings of the target. 
dead_letter | **oneof:** `dead_letter_queue`<br>Dead letter settings of the target.
&nbsp;&nbsp;dead_letter_queue | **[PutQueueMessage](#PutQueueMessage1)**<br>Dead letter queue. 
status | enum **Status**<br>Status of the target. <ul><li>`ENABLED`: Target is enabled.</li><li>`DISABLED`: Target is disabled.</li><li>`RESOURCE_NOT_FOUND`: Target does not exist.</li><li>`PERMISSION_DENIED`: Service account does not have read permission on source.</li><li>`SUBJECT_NOT_FOUND`: Service account not found.</li></ul>


### YdsTarget {#YdsTarget1}

Field | Description
--- | ---
database | **string**<br>Required. Stream database. 
stream_name | **string**<br>Required. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. 
service_account_id | **string**<br>Required. Service account, which has write permission on the stream. The maximum string length in characters is 50.


### YmqTarget {#YmqTarget1}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test 
service_account_id | **string**<br>Required. Service account which has write access to the queue. The maximum string length in characters is 50.


### FunctionTarget {#FunctionTarget1}

Field | Description
--- | ---
function_id | **string**<br>Required. Function ID. The maximum string length in characters is 50.
function_tag | **string**<br>Function tag, optional. 
service_account_id | **string**<br>Service account which has call permission on the function, optional. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings1)**<br>Batch settings. 


### BatchSettings {#BatchSettings1}

Field | Description
--- | ---
max_count | **int64**<br>Maximum batch size: trigger will send a batch if number of events exceeds this value. Acceptable values are 0 to 1000, inclusive.
max_bytes | **int64**<br>Maximum batch size: trigger will send a batch if total size of events exceeds this value. Acceptable values are 0 to 262144, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. The maximum value is 1m.


### ContainerTarget {#ContainerTarget1}

Field | Description
--- | ---
container_id | **string**<br>Required. Container ID. The maximum string length in characters is 50.
container_revision_id | **string**<br>Container revision ID. 
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>Service account which should be used to call a container, optional. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings2)**<br>Batch settings. 


### GatewayWebsocketBroadcastTarget {#GatewayWebsocketBroadcastTarget1}

Field | Description
--- | ---
gateway_id | **string**<br>Required. Gateway ID. The maximum string length in characters is 50.
path | **string**<br>Required. Path. 
service_account_id | **string**<br>Required. Service account which has permission for writing to websockets. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings2)**<br>Batch settings. 


### LoggingTarget {#LoggingTarget1}

Field | Description
--- | ---
destination | **oneof:** `log_group_id` or `folder_id`<br>Log group ID or folder ID.
&nbsp;&nbsp;log_group_id | **string**<br>Log group ID or folder ID. The maximum string length in characters is 63.
&nbsp;&nbsp;folder_id | **string**<br>Log group ID or folder ID. The maximum string length in characters is 63.
service_account_id | **string**<br>Required. Service account which has permission for writing logs. The maximum string length in characters is 50.


### WorkflowTarget {#WorkflowTarget1}

Field | Description
--- | ---
workflow_id | **string**<br>Required. Workflow ID. The maximum string length in characters is 50.
service_account_id | **string**<br>Required. SA which should be used to start workflow. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings2)**<br>Batch settings. 


### Transformer {#Transformer1}

Field | Description
--- | ---
transformer | **oneof:** `jq_transformer`<br>
&nbsp;&nbsp;jq_transformer | **string**<br>JQ string inrerpolation expression for changing event format. The maximum string length in characters is 65536.


### RetrySettings {#RetrySettings1}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra calls) before an action fails. Acceptable values are 0 to 10, inclusive.
maximum_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Event goes to dlq when its age exceeds this value. Default is 24h. The maximum value is 24h.


### PutQueueMessage {#PutQueueMessage1}

Field | Description
--- | ---
queue_arn | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


## Create {#Create}

Creates a rule in the specified folder.

**rpc Create ([CreateRuleRequest](#CreateRuleRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateRuleMetadata](#CreateRuleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Rule](#Rule2)<br>

### CreateRuleRequest {#CreateRuleRequest}

Field | Description
--- | ---
bus_id | **string**<br>Required. ID of the bus to create a rule for. 
name | **string**<br>Name of the rule. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the rule. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Labels for the rule. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
filter | **[Filter](#Filter2)**<br>Filter for the rule. 
targets[] | **[Target](#Target2)**<br>Targets for the rule. The number of elements must be in the range 1-5.
deletion_protection | **bool**<br>Flag that disallow deletion of the rule. 


### Filter {#Filter2}

Field | Description
--- | ---
condition | **oneof:** `jq_filter`<br>
&nbsp;&nbsp;jq_filter | **string**<br>JQ filter for matching events. The maximum string length in characters is 1024.


### Target {#Target2}

Field | Description
--- | ---
target | **oneof:** `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging` or `workflow`<br>Status of the target.
&nbsp;&nbsp;yds | **[YdsTarget](#YdsTarget2)**<br>Status of the target. 
&nbsp;&nbsp;ymq | **[YmqTarget](#YmqTarget2)**<br>Status of the target. 
&nbsp;&nbsp;function | **[FunctionTarget](#FunctionTarget2)**<br>Status of the target. 
&nbsp;&nbsp;container | **[ContainerTarget](#ContainerTarget2)**<br>Status of the target. 
&nbsp;&nbsp;gateway_ws_broadcast | **[GatewayWebsocketBroadcastTarget](#GatewayWebsocketBroadcastTarget2)**<br>Status of the target. 
&nbsp;&nbsp;logging | **[LoggingTarget](#LoggingTarget2)**<br>Status of the target. 
&nbsp;&nbsp;workflow | **[WorkflowTarget](#WorkflowTarget2)**<br>Status of the target. 
transformer | **[Transformer](#Transformer2)**<br>Transformer of the target. 
retry_settings | **[RetrySettings](#RetrySettings2)**<br>Retry settings of the target. 
dead_letter | **oneof:** `dead_letter_queue`<br>Dead letter settings of the target.
&nbsp;&nbsp;dead_letter_queue | **[PutQueueMessage](#PutQueueMessage2)**<br>Dead letter queue. 
status | enum **Status**<br>Status of the target. <ul><li>`ENABLED`: Target is enabled.</li><li>`DISABLED`: Target is disabled.</li><li>`RESOURCE_NOT_FOUND`: Target does not exist.</li><li>`PERMISSION_DENIED`: Service account does not have read permission on source.</li><li>`SUBJECT_NOT_FOUND`: Service account not found.</li></ul>


### YdsTarget {#YdsTarget2}

Field | Description
--- | ---
database | **string**<br>Required. Stream database. 
stream_name | **string**<br>Required. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. 
service_account_id | **string**<br>Required. Service account, which has write permission on the stream. The maximum string length in characters is 50.


### YmqTarget {#YmqTarget2}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test 
service_account_id | **string**<br>Required. Service account which has write access to the queue. The maximum string length in characters is 50.


### FunctionTarget {#FunctionTarget2}

Field | Description
--- | ---
function_id | **string**<br>Required. Function ID. The maximum string length in characters is 50.
function_tag | **string**<br>Function tag, optional. 
service_account_id | **string**<br>Service account which has call permission on the function, optional. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings2)**<br>Batch settings. 


### BatchSettings {#BatchSettings2}

Field | Description
--- | ---
max_count | **int64**<br>Maximum batch size: trigger will send a batch if number of events exceeds this value. Acceptable values are 0 to 1000, inclusive.
max_bytes | **int64**<br>Maximum batch size: trigger will send a batch if total size of events exceeds this value. Acceptable values are 0 to 262144, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. The maximum value is 1m.


### ContainerTarget {#ContainerTarget2}

Field | Description
--- | ---
container_id | **string**<br>Required. Container ID. The maximum string length in characters is 50.
container_revision_id | **string**<br>Container revision ID. 
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>Service account which should be used to call a container, optional. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings3)**<br>Batch settings. 


### GatewayWebsocketBroadcastTarget {#GatewayWebsocketBroadcastTarget2}

Field | Description
--- | ---
gateway_id | **string**<br>Required. Gateway ID. The maximum string length in characters is 50.
path | **string**<br>Required. Path. 
service_account_id | **string**<br>Required. Service account which has permission for writing to websockets. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings3)**<br>Batch settings. 


### LoggingTarget {#LoggingTarget2}

Field | Description
--- | ---
destination | **oneof:** `log_group_id` or `folder_id`<br>Log group ID or folder ID.
&nbsp;&nbsp;log_group_id | **string**<br>Log group ID or folder ID. The maximum string length in characters is 63.
&nbsp;&nbsp;folder_id | **string**<br>Log group ID or folder ID. The maximum string length in characters is 63.
service_account_id | **string**<br>Required. Service account which has permission for writing logs. The maximum string length in characters is 50.


### WorkflowTarget {#WorkflowTarget2}

Field | Description
--- | ---
workflow_id | **string**<br>Required. Workflow ID. The maximum string length in characters is 50.
service_account_id | **string**<br>Required. SA which should be used to start workflow. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings3)**<br>Batch settings. 


### Transformer {#Transformer2}

Field | Description
--- | ---
transformer | **oneof:** `jq_transformer`<br>
&nbsp;&nbsp;jq_transformer | **string**<br>JQ string inrerpolation expression for changing event format. The maximum string length in characters is 65536.


### RetrySettings {#RetrySettings2}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra calls) before an action fails. Acceptable values are 0 to 10, inclusive.
maximum_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Event goes to dlq when its age exceeds this value. Default is 24h. The maximum value is 24h.


### PutQueueMessage {#PutQueueMessage2}

Field | Description
--- | ---
queue_arn | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateRuleMetadata](#CreateRuleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Rule](#Rule2)>**<br>if operation finished successfully. 


### CreateRuleMetadata {#CreateRuleMetadata}

Field | Description
--- | ---
rule_id | **string**<br>ID of the rule that is being created. 
bus_id | **string**<br>ID of the bus that the rule belongs to. 


### Rule {#Rule2}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
bus_id | **string**<br>ID of the bus that the rule belongs to. 
folder_id | **string**<br>ID of the folder that the rule resides in. 
cloud_id | **string**<br>ID of the cloud that the rule resides in. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the rule. 
description | **string**<br>Description of the rule. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
filter | **[Filter](#Filter3)**<br>Filter for the rule. 
targets[] | **[Target](#Target3)**<br>Targets of the rule. The number of elements must be in the range 1-5.
deletion_protection | **bool**<br>Flag that disallow deletion of the rule. 
status | enum **Status**<br>Rule status <ul><li>`CREATING`: Rule creation in progress, rule is not enabled yet</li><li>`ENABLED`: Rule is operating</li><li>`UPDATING`: Rule update in progress, rule is disabled during update</li><li>`DISABLED`: Rule is explicitly disabled by the user</li></ul>


## Update {#Update}

Updates the specified rule.

**rpc Update ([UpdateRuleRequest](#UpdateRuleRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRuleMetadata](#UpdateRuleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Rule](#Rule3)<br>

### UpdateRuleRequest {#UpdateRuleRequest}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the rule are going to be updated. 
name | **string**<br>New name of the rule. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description of the rule. The maximum string length in characters is 256.
labels | **map<string,string>**<br>New labels for the rule. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
filter | **[Filter](#Filter3)**<br>New filter for the rule. 
targets[] | **[Target](#Target3)**<br>New targets for the rule. The number of elements must be in the range 1-5.
deletion_protection | **bool**<br>New flag that disallow deletion of the rule. 


### Filter {#Filter3}

Field | Description
--- | ---
condition | **oneof:** `jq_filter`<br>
&nbsp;&nbsp;jq_filter | **string**<br>JQ filter for matching events. The maximum string length in characters is 1024.


### Target {#Target3}

Field | Description
--- | ---
target | **oneof:** `yds`, `ymq`, `function`, `container`, `gateway_ws_broadcast`, `logging` or `workflow`<br>Status of the target.
&nbsp;&nbsp;yds | **[YdsTarget](#YdsTarget3)**<br>Status of the target. 
&nbsp;&nbsp;ymq | **[YmqTarget](#YmqTarget3)**<br>Status of the target. 
&nbsp;&nbsp;function | **[FunctionTarget](#FunctionTarget3)**<br>Status of the target. 
&nbsp;&nbsp;container | **[ContainerTarget](#ContainerTarget3)**<br>Status of the target. 
&nbsp;&nbsp;gateway_ws_broadcast | **[GatewayWebsocketBroadcastTarget](#GatewayWebsocketBroadcastTarget3)**<br>Status of the target. 
&nbsp;&nbsp;logging | **[LoggingTarget](#LoggingTarget3)**<br>Status of the target. 
&nbsp;&nbsp;workflow | **[WorkflowTarget](#WorkflowTarget3)**<br>Status of the target. 
transformer | **[Transformer](#Transformer3)**<br>Transformer of the target. 
retry_settings | **[RetrySettings](#RetrySettings3)**<br>Retry settings of the target. 
dead_letter | **oneof:** `dead_letter_queue`<br>Dead letter settings of the target.
&nbsp;&nbsp;dead_letter_queue | **[PutQueueMessage](#PutQueueMessage3)**<br>Dead letter queue. 
status | enum **Status**<br>Status of the target. <ul><li>`ENABLED`: Target is enabled.</li><li>`DISABLED`: Target is disabled.</li><li>`RESOURCE_NOT_FOUND`: Target does not exist.</li><li>`PERMISSION_DENIED`: Service account does not have read permission on source.</li><li>`SUBJECT_NOT_FOUND`: Service account not found.</li></ul>


### YdsTarget {#YdsTarget3}

Field | Description
--- | ---
database | **string**<br>Required. Stream database. 
stream_name | **string**<br>Required. Full stream name, like /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6********/test. 
service_account_id | **string**<br>Required. Service account, which has write permission on the stream. The maximum string length in characters is 50.


### YmqTarget {#YmqTarget3}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test 
service_account_id | **string**<br>Required. Service account which has write access to the queue. The maximum string length in characters is 50.


### FunctionTarget {#FunctionTarget3}

Field | Description
--- | ---
function_id | **string**<br>Required. Function ID. The maximum string length in characters is 50.
function_tag | **string**<br>Function tag, optional. 
service_account_id | **string**<br>Service account which has call permission on the function, optional. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings3)**<br>Batch settings. 


### BatchSettings {#BatchSettings3}

Field | Description
--- | ---
max_count | **int64**<br>Maximum batch size: trigger will send a batch if number of events exceeds this value. Acceptable values are 0 to 1000, inclusive.
max_bytes | **int64**<br>Maximum batch size: trigger will send a batch if total size of events exceeds this value. Acceptable values are 0 to 262144, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum batch size: trigger will send a batch if its lifetime exceeds this value. The maximum value is 1m.


### ContainerTarget {#ContainerTarget3}

Field | Description
--- | ---
container_id | **string**<br>Required. Container ID. The maximum string length in characters is 50.
container_revision_id | **string**<br>Container revision ID. 
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>Service account which should be used to call a container, optional. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings4)**<br>Batch settings. 


### GatewayWebsocketBroadcastTarget {#GatewayWebsocketBroadcastTarget3}

Field | Description
--- | ---
gateway_id | **string**<br>Required. Gateway ID. The maximum string length in characters is 50.
path | **string**<br>Required. Path. 
service_account_id | **string**<br>Required. Service account which has permission for writing to websockets. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings4)**<br>Batch settings. 


### LoggingTarget {#LoggingTarget3}

Field | Description
--- | ---
destination | **oneof:** `log_group_id` or `folder_id`<br>Log group ID or folder ID.
&nbsp;&nbsp;log_group_id | **string**<br>Log group ID or folder ID. The maximum string length in characters is 63.
&nbsp;&nbsp;folder_id | **string**<br>Log group ID or folder ID. The maximum string length in characters is 63.
service_account_id | **string**<br>Required. Service account which has permission for writing logs. The maximum string length in characters is 50.


### WorkflowTarget {#WorkflowTarget3}

Field | Description
--- | ---
workflow_id | **string**<br>Required. Workflow ID. The maximum string length in characters is 50.
service_account_id | **string**<br>Required. SA which should be used to start workflow. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings4)**<br>Batch settings. 


### Transformer {#Transformer3}

Field | Description
--- | ---
transformer | **oneof:** `jq_transformer`<br>
&nbsp;&nbsp;jq_transformer | **string**<br>JQ string inrerpolation expression for changing event format. The maximum string length in characters is 65536.


### RetrySettings {#RetrySettings3}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra calls) before an action fails. Acceptable values are 0 to 10, inclusive.
maximum_age | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Event goes to dlq when its age exceeds this value. Default is 24h. The maximum value is 24h.


### PutQueueMessage {#PutQueueMessage3}

Field | Description
--- | ---
queue_arn | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRuleMetadata](#UpdateRuleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Rule](#Rule3)>**<br>if operation finished successfully. 


### UpdateRuleMetadata {#UpdateRuleMetadata}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule that is being updated. 


### Rule {#Rule3}

Field | Description
--- | ---
id | **string**<br>ID of the rule. 
bus_id | **string**<br>ID of the bus that the rule belongs to. 
folder_id | **string**<br>ID of the folder that the rule resides in. 
cloud_id | **string**<br>ID of the cloud that the rule resides in. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the rule. 
description | **string**<br>Description of the rule. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
filter | **[Filter](#Filter4)**<br>Filter for the rule. 
targets[] | **[Target](#Target4)**<br>Targets of the rule. The number of elements must be in the range 1-5.
deletion_protection | **bool**<br>Flag that disallow deletion of the rule. 
status | enum **Status**<br>Rule status <ul><li>`CREATING`: Rule creation in progress, rule is not enabled yet</li><li>`ENABLED`: Rule is operating</li><li>`UPDATING`: Rule update in progress, rule is disabled during update</li><li>`DISABLED`: Rule is explicitly disabled by the user</li></ul>


## Delete {#Delete}

Deletes the specified rule.

**rpc Delete ([DeleteRuleRequest](#DeleteRuleRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRuleMetadata](#DeleteRuleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRuleRequest {#DeleteRuleRequest}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule to delete. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRuleMetadata](#DeleteRuleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteRuleMetadata {#DeleteRuleMetadata}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule that is being deleted. 


## Enable {#Enable}

Enables the specified rule.

**rpc Enable ([EnableRuleRequest](#EnableRuleRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnableRuleMetadata](#EnableRuleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### EnableRuleRequest {#EnableRuleRequest}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule to enable. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[EnableRuleMetadata](#EnableRuleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### EnableRuleMetadata {#EnableRuleMetadata}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule that is being enabled. 


## Disable {#Disable}

Disables the specified rule.

**rpc Disable ([DisableRuleRequest](#DisableRuleRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DisableRuleMetadata](#DisableRuleMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DisableRuleRequest {#DisableRuleRequest}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule to disable. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DisableRuleMetadata](#DisableRuleMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DisableRuleMetadata {#DisableRuleMetadata}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule that is being disabled. 


## ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified rule.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Field | Description
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>List of access bindings for the specified resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), use the `next_page_token` as the value for the [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the rule.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. The maximum string length in characters is 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being set. 


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the specified rule.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. The maximum string length in characters is 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. The number of elements must be greater than 0.


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li></ul>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being updated. 


## ListOperations {#ListOperations}

Lists operations for the specified rule.

**rpc ListOperations ([ListRuleOperationsRequest](#ListRuleOperationsRequest)) returns ([ListRuleOperationsResponse](#ListRuleOperationsResponse))**

### ListRuleOperationsRequest {#ListRuleOperationsRequest}

Field | Description
--- | ---
rule_id | **string**<br>Required. ID of the rule to list operations for. 
page_size | **int64**<br>The maximum number of results per response. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the `next_page_token` returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>Supported attributes for filter: description created_at modified_at created_by done The maximum string length in characters is 1000.


### ListRuleOperationsResponse {#ListRuleOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>List of operations for the specified rule. 
next_page_token | **string**<br>Token for getting the next page of the list of operations. 


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


