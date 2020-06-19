---
editable: false
---

# TriggerService

A set of methods for managing triggers for serverless functions.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified trigger. |
| [List](#List) | Retrieves the list of triggers in the specified folder. |
| [Create](#Create) | Creates a trigger in the specified folder. |
| [Update](#Update) | Updates the specified trigger. |
| [Delete](#Delete) | Deletes the specified trigger. |
| [ListOperations](#ListOperations) | Lists operations for the specified trigger. |

## Calls TriggerService {#calls}

## Get {#Get}

Returns the specified trigger. <br>To get the list of all available triggers, make a [List](#List) request.

**rpc Get ([GetTriggerRequest](#GetTriggerRequest)) returns ([Trigger](#Trigger))**

### GetTriggerRequest {#GetTriggerRequest}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger to return. <br>To get a trigger ID make a [TriggerService.List](#List) request. 


### Trigger {#Trigger}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to.  The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 


### Rule {#Rule}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message` or `object_storage`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage)**<br>Rule for a Yandex IoT Core trigger. 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage)**<br> 


### Timer {#Timer}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer).  The maximum string length in characters is 100.
action | **oneof:** `invoke_function` or `invoke_function_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Action to be executed when the current time matches the `cron_expression`. 


### MessageQueue {#MessageQueue}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Yandex Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue.  The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 


### IoTMessage {#IoTMessage}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the Yandex IoT Core registry. 
device_id | **string**<br>ID of the Yandex IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 


### ObjectStorage {#ObjectStorage}

Field | Description
--- | ---
event_type[] | **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br> 
prefix | **string**<br>Filter, optional. 
suffix | **string**<br> 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


## List {#List}

Retrieves the list of triggers in the specified folder.

**rpc List ([ListTriggersRequest](#ListTriggersRequest)) returns ([ListTriggersResponse](#ListTriggersResponse))**

### ListTriggersRequest {#ListTriggersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list triggers in. <br>To get a folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListTriggersResponse.next_page_token](#ListTriggersResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListTriggersResponse.next_page_token](#ListTriggersResponse) returned by a previous list request. 
filter | **string**<br><ol><li>The field name. Currently filtering can only be applied to the [Trigger.name](#Trigger1) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> 


### ListTriggersResponse {#ListTriggersResponse}

Field | Description
--- | ---
triggers[] | **[Trigger](#Trigger1)**<br>List of triggers in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListTriggersRequest.page_size](#ListTriggersRequest1), use `nextPageToken` as the value for the [ListTriggersRequest.page_token](#ListTriggersRequest1) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Trigger {#Trigger}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to.  The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule1)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 


### Rule {#Rule}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message` or `object_storage`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer1)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue1)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage1)**<br>Rule for a Yandex IoT Core trigger. 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage1)**<br> 


### Timer {#Timer}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer).  The maximum string length in characters is 100.
action | **oneof:** `invoke_function` or `invoke_function_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Action to be executed when the current time matches the `cron_expression`. 


### MessageQueue {#MessageQueue}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Yandex Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue.  The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 


### IoTMessage {#IoTMessage}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the Yandex IoT Core registry. 
device_id | **string**<br>ID of the Yandex IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 


### ObjectStorage {#ObjectStorage}

Field | Description
--- | ---
event_type[] | **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br> 
prefix | **string**<br>Filter, optional. 
suffix | **string**<br> 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


## Create {#Create}

Creates a trigger in the specified folder.

**rpc Create ([CreateTriggerRequest](#CreateTriggerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTriggerMetadata](#CreateTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trigger](#Trigger2)<br>

### CreateTriggerRequest {#CreateTriggerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a trigger in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. 
name | **string**<br>Name of the trigger. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the trigger. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
rule | **[Trigger.Rule](#Trigger2)**<br>Required. Trigger type. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTriggerMetadata](#CreateTriggerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Trigger](#Trigger2)>**<br>if operation finished successfully. 


### CreateTriggerMetadata {#CreateTriggerMetadata}

Field | Description
--- | ---
trigger_id | **string**<br>ID of the trigger that is being created. 


### Trigger {#Trigger}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to.  The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule2)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 


### Rule {#Rule}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message` or `object_storage`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer2)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue2)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage2)**<br>Rule for a Yandex IoT Core trigger. 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage2)**<br> 


### Timer {#Timer}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer).  The maximum string length in characters is 100.
action | **oneof:** `invoke_function` or `invoke_function_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Action to be executed when the current time matches the `cron_expression`. 


### MessageQueue {#MessageQueue}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Yandex Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue.  The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 


### IoTMessage {#IoTMessage}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the Yandex IoT Core registry. 
device_id | **string**<br>ID of the Yandex IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 


### ObjectStorage {#ObjectStorage}

Field | Description
--- | ---
event_type[] | **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br> 
prefix | **string**<br>Filter, optional. 
suffix | **string**<br> 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


## Update {#Update}

Updates the specified trigger.

**rpc Update ([UpdateTriggerRequest](#UpdateTriggerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTriggerMetadata](#UpdateTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trigger](#Trigger3)<br>

### UpdateTriggerRequest {#UpdateTriggerRequest}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger to update. <br>To get a trigger ID make a [TriggerService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the trigger should be updated. 
name | **string**<br>New name for the trigger. The name must be unique within the folder. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description of the trigger. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [TriggerService.Get](#Get) request. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateTriggerMetadata](#UpdateTriggerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Trigger](#Trigger3)>**<br>if operation finished successfully. 


### UpdateTriggerMetadata {#UpdateTriggerMetadata}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger that is being updated. 


### Trigger {#Trigger}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to.  The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule3)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 


### Rule {#Rule}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message` or `object_storage`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer3)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue3)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage3)**<br>Rule for a Yandex IoT Core trigger. 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage3)**<br> 


### Timer {#Timer}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer).  The maximum string length in characters is 100.
action | **oneof:** `invoke_function` or `invoke_function_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Action to be executed when the current time matches the `cron_expression`. 


### MessageQueue {#MessageQueue}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Yandex Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue.  The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 


### IoTMessage {#IoTMessage}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the Yandex IoT Core registry. 
device_id | **string**<br>ID of the Yandex IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 


### ObjectStorage {#ObjectStorage}

Field | Description
--- | ---
event_type[] | **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br> 
prefix | **string**<br>Filter, optional. 
suffix | **string**<br> 
action | **oneof:** `invoke_function`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 


## Delete {#Delete}

Deletes the specified trigger.

**rpc Delete ([DeleteTriggerRequest](#DeleteTriggerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTriggerMetadata](#DeleteTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTriggerRequest {#DeleteTriggerRequest}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger to delete. <br>To get a trigger ID make a [TriggerService.List](#List) request. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteTriggerMetadata](#DeleteTriggerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteTriggerMetadata {#DeleteTriggerMetadata}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger that is being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified trigger.

**rpc ListOperations ([ListTriggerOperationsRequest](#ListTriggerOperationsRequest)) returns ([ListTriggerOperationsResponse](#ListTriggerOperationsResponse))**

### ListTriggerOperationsRequest {#ListTriggerOperationsRequest}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListTriggerOperationsResponse.next_page_token](#ListTriggerOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListTriggerOperationsResponse.next_page_token](#ListTriggerOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently filtering can only be applied to the [Trigger.name](#Trigger4) field. </li><li>A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> The maximum string length in characters is 1000.


### ListTriggerOperationsResponse {#ListTriggerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified trigger. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListTriggerOperationsRequest.page_size](#ListTriggerOperationsRequest1), use `nextPageToken` as the value for the [ListTriggerOperationsRequest.page_token](#ListTriggerOperationsRequest1) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Operation {#Operation}

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


