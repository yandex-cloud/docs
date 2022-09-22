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
| [Pause](#Pause) | Pauses the specified trigger. |
| [Resume](#Resume) | Restarts the specified trigger. |
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
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 
status | enum **Status**<br>Trigger status. 


### Rule {#Rule}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream` or `mail`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage)**<br>Rule for a IoT Core trigger. 
&nbsp;&nbsp;iot_broker_message | **[IoTBrokerMessage](#IoTBrokerMessage)**<br> 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs)**<br> 
&nbsp;&nbsp;logging | **[Logging](#Logging)**<br> 
&nbsp;&nbsp;billing_budget | **[BillingBudget](#BillingBudget)**<br> 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream)**<br> 
&nbsp;&nbsp;mail | **[Mail](#Mail)**<br> 


### Timer {#Timer}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). The maximum string length in characters is 100.
action | **oneof:** `invoke_function`, `invoke_function_with_retry` or `invoke_container_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retry. 
&nbsp;&nbsp;invoke_container_with_retry | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br>Instructions for invoking a container with retry. 


### MessageQueue {#MessageQueue}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerOnce](#InvokeContainerOnce)**<br>Instructions for invoking a container once. 


### IoTMessage {#IoTMessage}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the IoT Core registry. 
device_id | **string**<br>ID of the IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br>Instructions for invoking a container with retries as needed. 


### IoTBrokerMessage {#IoTBrokerMessage}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the IoT Core broker. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br>Instructions for invoking a container with retries as needed. 


### ObjectStorage {#ObjectStorage}

Field | Description
--- | ---
event_type[] | enum **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br>ID of the bucket. 
prefix | **string**<br>Prefix of the object key. Filter, optional. 
suffix | **string**<br>Suffix of the object key. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br>Instructions for invoking a container with retries as needed. 


### ContainerRegistry {#ContainerRegistry}

Field | Description
--- | ---
event_type[] | enum **ContainerRegistryEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
registry_id | **string**<br>ID of the registry. 
image_name | **string**<br>Docker-image name. Filter, optional. 
tag | **string**<br>Docker-image tag. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br>Instructions for invoking a container with retries as needed. 


### CloudLogs {#CloudLogs}

Field | Description
--- | ---
log_group_id[] | **string**<br>Log group identifiers, at least one value is required. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br>Instructions for invoking a container with retries as needed. 


### Logging {#Logging}

Field | Description
--- | ---
log_group_id | **string**<br>Log events filter settings. The maximum string length in characters is 50.
resource_type[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
resource_id[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
levels[] | **`yandex.cloud.logging.v1.LogLevel.Level`**<br> The maximum number of elements is 10.
batch_settings | **[LoggingBatchSettings](#LoggingBatchSettings)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br>Instructions for invoking a container with retries as needed. 


### BillingBudget {#BillingBudget}

Field | Description
--- | ---
billing_account_id | **string**<br>Required.  The maximum string length in characters is 50.
budget_id | **string**<br> The maximum string length in characters is 50.
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br> 


### DataStream {#DataStream}

Field | Description
--- | ---
endpoint | **string**<br>Data stream endpoint. 
database | **string**<br>Data stream database. 
stream | **string**<br>Stream name. 
service_account_id | **string**<br>ID of the service account which has permission to read data stream. 
batch_settings | **[DataStreamBatchSettings](#DataStreamBatchSettings)**<br>Batch settings for processing events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br> 


### DataStreamBatchSettings {#DataStreamBatchSettings}

Field | Description
--- | ---
size | **int64**<br>Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 65536, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


### Mail {#Mail}

Field | Description
--- | ---
email | **string**<br>Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry)**<br> 


### InvokeFunctionOnce {#InvokeFunctionOnce}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account that should be used to invoke the function. 


### InvokeFunctionWithRetry {#InvokeFunctionWithRetry}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the function. 
retry_settings | **[RetrySettings](#RetrySettings)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage)**<br>DLQ policy (no value means discarding a message). 


### RetrySettings {#RetrySettings}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra invokes) before the action is considered failed. Acceptable values are 1 to 5, inclusive.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds to wait between individual retries. 


### PutQueueMessage {#PutQueueMessage}

Field | Description
--- | ---
queue_id | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### InvokeContainerWithRetry {#InvokeContainerWithRetry}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 
retry_settings | **[RetrySettings](#RetrySettings1)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage1)**<br>DLQ policy (no value means discarding a message). 


### BatchSettings {#BatchSettings}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 10, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. 


### InvokeContainerOnce {#InvokeContainerOnce}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 


### CloudLogsBatchSettings {#CloudLogsBatchSettings}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 1s to 1m, inclusive.


### LoggingBatchSettings {#LoggingBatchSettings}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


## List {#List}

Retrieves the list of triggers in the specified folder.

**rpc List ([ListTriggersRequest](#ListTriggersRequest)) returns ([ListTriggersResponse](#ListTriggersResponse))**

### ListTriggersRequest {#ListTriggersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list triggers in. <br>To get a folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListTriggersResponse.next_page_token](#ListTriggersResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListTriggersResponse.next_page_token](#ListTriggersResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters triggers listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Trigger.name](#Trigger1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-trigger`. 


### ListTriggersResponse {#ListTriggersResponse}

Field | Description
--- | ---
triggers[] | **[Trigger](#Trigger1)**<br>List of triggers in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListTriggersRequest.page_size](#ListTriggersRequest), use `nextPageToken` as the value for the [ListTriggersRequest.page_token](#ListTriggersRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Trigger {#Trigger1}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule1)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 
status | enum **Status**<br>Trigger status. 


### Rule {#Rule1}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream` or `mail`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer1)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue1)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage1)**<br>Rule for a IoT Core trigger. 
&nbsp;&nbsp;iot_broker_message | **[IoTBrokerMessage](#IoTBrokerMessage1)**<br> 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage1)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry1)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs1)**<br> 
&nbsp;&nbsp;logging | **[Logging](#Logging1)**<br> 
&nbsp;&nbsp;billing_budget | **[BillingBudget](#BillingBudget1)**<br> 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream1)**<br> 
&nbsp;&nbsp;mail | **[Mail](#Mail1)**<br> 


### Timer {#Timer1}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). The maximum string length in characters is 100.
action | **oneof:** `invoke_function`, `invoke_function_with_retry` or `invoke_container_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce1)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br>Instructions for invoking a function with retry. 
&nbsp;&nbsp;invoke_container_with_retry | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br>Instructions for invoking a container with retry. 


### MessageQueue {#MessageQueue1}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings1)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce1)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerOnce](#InvokeContainerOnce1)**<br>Instructions for invoking a container once. 


### IoTMessage {#IoTMessage1}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the IoT Core registry. 
device_id | **string**<br>ID of the IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br>Instructions for invoking a container with retries as needed. 


### IoTBrokerMessage {#IoTBrokerMessage1}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the IoT Core broker. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br>Instructions for invoking a container with retries as needed. 


### ObjectStorage {#ObjectStorage1}

Field | Description
--- | ---
event_type[] | enum **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br>ID of the bucket. 
prefix | **string**<br>Prefix of the object key. Filter, optional. 
suffix | **string**<br>Suffix of the object key. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br>Instructions for invoking a container with retries as needed. 


### ContainerRegistry {#ContainerRegistry1}

Field | Description
--- | ---
event_type[] | enum **ContainerRegistryEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
registry_id | **string**<br>ID of the registry. 
image_name | **string**<br>Docker-image name. Filter, optional. 
tag | **string**<br>Docker-image tag. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br>Instructions for invoking a container with retries as needed. 


### CloudLogs {#CloudLogs1}

Field | Description
--- | ---
log_group_id[] | **string**<br>Log group identifiers, at least one value is required. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings1)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br>Instructions for invoking a container with retries as needed. 


### Logging {#Logging1}

Field | Description
--- | ---
log_group_id | **string**<br>Log events filter settings. The maximum string length in characters is 50.
resource_type[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
resource_id[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
levels[] | **`yandex.cloud.logging.v1.LogLevel.Level`**<br> The maximum number of elements is 10.
batch_settings | **[LoggingBatchSettings](#LoggingBatchSettings1)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br>Instructions for invoking a container with retries as needed. 


### BillingBudget {#BillingBudget1}

Field | Description
--- | ---
billing_account_id | **string**<br>Required.  The maximum string length in characters is 50.
budget_id | **string**<br> The maximum string length in characters is 50.
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br> 


### DataStream {#DataStream1}

Field | Description
--- | ---
endpoint | **string**<br>Data stream endpoint. 
database | **string**<br>Data stream database. 
stream | **string**<br>Stream name. 
service_account_id | **string**<br>ID of the service account which has permission to read data stream. 
batch_settings | **[DataStreamBatchSettings](#DataStreamBatchSettings1)**<br>Batch settings for processing events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br> 


### DataStreamBatchSettings {#DataStreamBatchSettings1}

Field | Description
--- | ---
size | **int64**<br>Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 65536, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


### Mail {#Mail1}

Field | Description
--- | ---
email | **string**<br>Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry1)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry1)**<br> 


### InvokeFunctionOnce {#InvokeFunctionOnce1}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account that should be used to invoke the function. 


### InvokeFunctionWithRetry {#InvokeFunctionWithRetry1}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the function. 
retry_settings | **[RetrySettings](#RetrySettings1)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage1)**<br>DLQ policy (no value means discarding a message). 


### RetrySettings {#RetrySettings1}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra invokes) before the action is considered failed. Acceptable values are 1 to 5, inclusive.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds to wait between individual retries. 


### PutQueueMessage {#PutQueueMessage1}

Field | Description
--- | ---
queue_id | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### InvokeContainerWithRetry {#InvokeContainerWithRetry1}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 
retry_settings | **[RetrySettings](#RetrySettings2)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage2)**<br>DLQ policy (no value means discarding a message). 


### BatchSettings {#BatchSettings1}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 10, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. 


### InvokeContainerOnce {#InvokeContainerOnce1}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 


### CloudLogsBatchSettings {#CloudLogsBatchSettings1}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 1s to 1m, inclusive.


### LoggingBatchSettings {#LoggingBatchSettings1}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


## Create {#Create}

Creates a trigger in the specified folder.

**rpc Create ([CreateTriggerRequest](#CreateTriggerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTriggerMetadata](#CreateTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trigger](#Trigger2)<br>

### CreateTriggerRequest {#CreateTriggerRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a trigger in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the trigger. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
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


### Trigger {#Trigger2}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule2)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 
status | enum **Status**<br>Trigger status. 


### Rule {#Rule2}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream` or `mail`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer2)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue2)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage2)**<br>Rule for a IoT Core trigger. 
&nbsp;&nbsp;iot_broker_message | **[IoTBrokerMessage](#IoTBrokerMessage2)**<br> 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage2)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry2)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs2)**<br> 
&nbsp;&nbsp;logging | **[Logging](#Logging2)**<br> 
&nbsp;&nbsp;billing_budget | **[BillingBudget](#BillingBudget2)**<br> 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream2)**<br> 
&nbsp;&nbsp;mail | **[Mail](#Mail2)**<br> 


### Timer {#Timer2}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). The maximum string length in characters is 100.
action | **oneof:** `invoke_function`, `invoke_function_with_retry` or `invoke_container_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce2)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br>Instructions for invoking a function with retry. 
&nbsp;&nbsp;invoke_container_with_retry | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br>Instructions for invoking a container with retry. 


### MessageQueue {#MessageQueue2}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings2)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce2)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerOnce](#InvokeContainerOnce2)**<br>Instructions for invoking a container once. 


### IoTMessage {#IoTMessage2}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the IoT Core registry. 
device_id | **string**<br>ID of the IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br>Instructions for invoking a container with retries as needed. 


### IoTBrokerMessage {#IoTBrokerMessage2}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the IoT Core broker. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br>Instructions for invoking a container with retries as needed. 


### ObjectStorage {#ObjectStorage2}

Field | Description
--- | ---
event_type[] | enum **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br>ID of the bucket. 
prefix | **string**<br>Prefix of the object key. Filter, optional. 
suffix | **string**<br>Suffix of the object key. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br>Instructions for invoking a container with retries as needed. 


### ContainerRegistry {#ContainerRegistry2}

Field | Description
--- | ---
event_type[] | enum **ContainerRegistryEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
registry_id | **string**<br>ID of the registry. 
image_name | **string**<br>Docker-image name. Filter, optional. 
tag | **string**<br>Docker-image tag. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br>Instructions for invoking a container with retries as needed. 


### CloudLogs {#CloudLogs2}

Field | Description
--- | ---
log_group_id[] | **string**<br>Log group identifiers, at least one value is required. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings2)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br>Instructions for invoking a container with retries as needed. 


### Logging {#Logging2}

Field | Description
--- | ---
log_group_id | **string**<br>Log events filter settings. The maximum string length in characters is 50.
resource_type[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
resource_id[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
levels[] | **`yandex.cloud.logging.v1.LogLevel.Level`**<br> The maximum number of elements is 10.
batch_settings | **[LoggingBatchSettings](#LoggingBatchSettings2)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br>Instructions for invoking a container with retries as needed. 


### BillingBudget {#BillingBudget2}

Field | Description
--- | ---
billing_account_id | **string**<br>Required.  The maximum string length in characters is 50.
budget_id | **string**<br> The maximum string length in characters is 50.
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br> 


### DataStream {#DataStream2}

Field | Description
--- | ---
endpoint | **string**<br>Data stream endpoint. 
database | **string**<br>Data stream database. 
stream | **string**<br>Stream name. 
service_account_id | **string**<br>ID of the service account which has permission to read data stream. 
batch_settings | **[DataStreamBatchSettings](#DataStreamBatchSettings2)**<br>Batch settings for processing events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br> 


### DataStreamBatchSettings {#DataStreamBatchSettings2}

Field | Description
--- | ---
size | **int64**<br>Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 65536, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


### Mail {#Mail2}

Field | Description
--- | ---
email | **string**<br>Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry2)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry2)**<br> 


### InvokeFunctionOnce {#InvokeFunctionOnce2}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account that should be used to invoke the function. 


### InvokeFunctionWithRetry {#InvokeFunctionWithRetry2}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the function. 
retry_settings | **[RetrySettings](#RetrySettings2)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage2)**<br>DLQ policy (no value means discarding a message). 


### RetrySettings {#RetrySettings2}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra invokes) before the action is considered failed. Acceptable values are 1 to 5, inclusive.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds to wait between individual retries. 


### PutQueueMessage {#PutQueueMessage2}

Field | Description
--- | ---
queue_id | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### InvokeContainerWithRetry {#InvokeContainerWithRetry2}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 
retry_settings | **[RetrySettings](#RetrySettings3)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage3)**<br>DLQ policy (no value means discarding a message). 


### BatchSettings {#BatchSettings2}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 10, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. 


### InvokeContainerOnce {#InvokeContainerOnce2}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 


### CloudLogsBatchSettings {#CloudLogsBatchSettings2}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 1s to 1m, inclusive.


### LoggingBatchSettings {#LoggingBatchSettings2}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


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
name | **string**<br>New name for the trigger. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description of the trigger. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [TriggerService.Get](#Get) request. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

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


### Trigger {#Trigger3}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule3)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 
status | enum **Status**<br>Trigger status. 


### Rule {#Rule3}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream` or `mail`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer3)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue3)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage3)**<br>Rule for a IoT Core trigger. 
&nbsp;&nbsp;iot_broker_message | **[IoTBrokerMessage](#IoTBrokerMessage3)**<br> 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage3)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry3)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs3)**<br> 
&nbsp;&nbsp;logging | **[Logging](#Logging3)**<br> 
&nbsp;&nbsp;billing_budget | **[BillingBudget](#BillingBudget3)**<br> 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream3)**<br> 
&nbsp;&nbsp;mail | **[Mail](#Mail3)**<br> 


### Timer {#Timer3}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). The maximum string length in characters is 100.
action | **oneof:** `invoke_function`, `invoke_function_with_retry` or `invoke_container_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce3)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br>Instructions for invoking a function with retry. 
&nbsp;&nbsp;invoke_container_with_retry | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br>Instructions for invoking a container with retry. 


### MessageQueue {#MessageQueue3}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings3)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce3)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerOnce](#InvokeContainerOnce3)**<br>Instructions for invoking a container once. 


### IoTMessage {#IoTMessage3}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the IoT Core registry. 
device_id | **string**<br>ID of the IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br>Instructions for invoking a container with retries as needed. 


### IoTBrokerMessage {#IoTBrokerMessage3}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the IoT Core broker. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br>Instructions for invoking a container with retries as needed. 


### ObjectStorage {#ObjectStorage3}

Field | Description
--- | ---
event_type[] | enum **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br>ID of the bucket. 
prefix | **string**<br>Prefix of the object key. Filter, optional. 
suffix | **string**<br>Suffix of the object key. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br>Instructions for invoking a container with retries as needed. 


### ContainerRegistry {#ContainerRegistry3}

Field | Description
--- | ---
event_type[] | enum **ContainerRegistryEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
registry_id | **string**<br>ID of the registry. 
image_name | **string**<br>Docker-image name. Filter, optional. 
tag | **string**<br>Docker-image tag. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br>Instructions for invoking a container with retries as needed. 


### CloudLogs {#CloudLogs3}

Field | Description
--- | ---
log_group_id[] | **string**<br>Log group identifiers, at least one value is required. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings3)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br>Instructions for invoking a container with retries as needed. 


### Logging {#Logging3}

Field | Description
--- | ---
log_group_id | **string**<br>Log events filter settings. The maximum string length in characters is 50.
resource_type[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
resource_id[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
levels[] | **`yandex.cloud.logging.v1.LogLevel.Level`**<br> The maximum number of elements is 10.
batch_settings | **[LoggingBatchSettings](#LoggingBatchSettings3)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br>Instructions for invoking a container with retries as needed. 


### BillingBudget {#BillingBudget3}

Field | Description
--- | ---
billing_account_id | **string**<br>Required.  The maximum string length in characters is 50.
budget_id | **string**<br> The maximum string length in characters is 50.
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br> 


### DataStream {#DataStream3}

Field | Description
--- | ---
endpoint | **string**<br>Data stream endpoint. 
database | **string**<br>Data stream database. 
stream | **string**<br>Stream name. 
service_account_id | **string**<br>ID of the service account which has permission to read data stream. 
batch_settings | **[DataStreamBatchSettings](#DataStreamBatchSettings3)**<br>Batch settings for processing events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br> 


### DataStreamBatchSettings {#DataStreamBatchSettings3}

Field | Description
--- | ---
size | **int64**<br>Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 65536, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


### Mail {#Mail3}

Field | Description
--- | ---
email | **string**<br>Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry3)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry3)**<br> 


### InvokeFunctionOnce {#InvokeFunctionOnce3}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account that should be used to invoke the function. 


### InvokeFunctionWithRetry {#InvokeFunctionWithRetry3}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the function. 
retry_settings | **[RetrySettings](#RetrySettings3)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage3)**<br>DLQ policy (no value means discarding a message). 


### RetrySettings {#RetrySettings3}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra invokes) before the action is considered failed. Acceptable values are 1 to 5, inclusive.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds to wait between individual retries. 


### PutQueueMessage {#PutQueueMessage3}

Field | Description
--- | ---
queue_id | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### InvokeContainerWithRetry {#InvokeContainerWithRetry3}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 
retry_settings | **[RetrySettings](#RetrySettings4)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage4)**<br>DLQ policy (no value means discarding a message). 


### BatchSettings {#BatchSettings3}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 10, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. 


### InvokeContainerOnce {#InvokeContainerOnce3}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 


### CloudLogsBatchSettings {#CloudLogsBatchSettings3}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 1s to 1m, inclusive.


### LoggingBatchSettings {#LoggingBatchSettings3}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


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


### Operation {#Operation2}

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


## Pause {#Pause}

Pauses the specified trigger.

**rpc Pause ([PauseTriggerRequest](#PauseTriggerRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PauseTriggerMetadata](#PauseTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trigger](#Trigger4)<br>

### PauseTriggerRequest {#PauseTriggerRequest}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger to pause <br>To get a trigger ID make a [TriggerService.List](#List) request. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PauseTriggerMetadata](#PauseTriggerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Trigger](#Trigger4)>**<br>if operation finished successfully. 


### PauseTriggerMetadata {#PauseTriggerMetadata}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger that is being paused. 


### Trigger {#Trigger4}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule4)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 
status | enum **Status**<br>Trigger status. 


### Rule {#Rule4}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream` or `mail`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer4)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue4)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage4)**<br>Rule for a IoT Core trigger. 
&nbsp;&nbsp;iot_broker_message | **[IoTBrokerMessage](#IoTBrokerMessage4)**<br> 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage4)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry4)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs4)**<br> 
&nbsp;&nbsp;logging | **[Logging](#Logging4)**<br> 
&nbsp;&nbsp;billing_budget | **[BillingBudget](#BillingBudget4)**<br> 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream4)**<br> 
&nbsp;&nbsp;mail | **[Mail](#Mail4)**<br> 


### Timer {#Timer4}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). The maximum string length in characters is 100.
action | **oneof:** `invoke_function`, `invoke_function_with_retry` or `invoke_container_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce4)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br>Instructions for invoking a function with retry. 
&nbsp;&nbsp;invoke_container_with_retry | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br>Instructions for invoking a container with retry. 


### MessageQueue {#MessageQueue4}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings4)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce4)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerOnce](#InvokeContainerOnce4)**<br>Instructions for invoking a container once. 


### IoTMessage {#IoTMessage4}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the IoT Core registry. 
device_id | **string**<br>ID of the IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br>Instructions for invoking a container with retries as needed. 


### IoTBrokerMessage {#IoTBrokerMessage4}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the IoT Core broker. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br>Instructions for invoking a container with retries as needed. 


### ObjectStorage {#ObjectStorage4}

Field | Description
--- | ---
event_type[] | enum **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br>ID of the bucket. 
prefix | **string**<br>Prefix of the object key. Filter, optional. 
suffix | **string**<br>Suffix of the object key. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br>Instructions for invoking a container with retries as needed. 


### ContainerRegistry {#ContainerRegistry4}

Field | Description
--- | ---
event_type[] | enum **ContainerRegistryEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
registry_id | **string**<br>ID of the registry. 
image_name | **string**<br>Docker-image name. Filter, optional. 
tag | **string**<br>Docker-image tag. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br>Instructions for invoking a container with retries as needed. 


### CloudLogs {#CloudLogs4}

Field | Description
--- | ---
log_group_id[] | **string**<br>Log group identifiers, at least one value is required. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings4)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br>Instructions for invoking a container with retries as needed. 


### Logging {#Logging4}

Field | Description
--- | ---
log_group_id | **string**<br>Log events filter settings. The maximum string length in characters is 50.
resource_type[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
resource_id[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
levels[] | **`yandex.cloud.logging.v1.LogLevel.Level`**<br> The maximum number of elements is 10.
batch_settings | **[LoggingBatchSettings](#LoggingBatchSettings4)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br>Instructions for invoking a container with retries as needed. 


### BillingBudget {#BillingBudget4}

Field | Description
--- | ---
billing_account_id | **string**<br>Required.  The maximum string length in characters is 50.
budget_id | **string**<br> The maximum string length in characters is 50.
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br> 


### DataStream {#DataStream4}

Field | Description
--- | ---
endpoint | **string**<br>Data stream endpoint. 
database | **string**<br>Data stream database. 
stream | **string**<br>Stream name. 
service_account_id | **string**<br>ID of the service account which has permission to read data stream. 
batch_settings | **[DataStreamBatchSettings](#DataStreamBatchSettings4)**<br>Batch settings for processing events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br> 


### DataStreamBatchSettings {#DataStreamBatchSettings4}

Field | Description
--- | ---
size | **int64**<br>Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 65536, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


### Mail {#Mail4}

Field | Description
--- | ---
email | **string**<br>Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry4)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry4)**<br> 


### InvokeFunctionOnce {#InvokeFunctionOnce4}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account that should be used to invoke the function. 


### InvokeFunctionWithRetry {#InvokeFunctionWithRetry4}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the function. 
retry_settings | **[RetrySettings](#RetrySettings4)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage4)**<br>DLQ policy (no value means discarding a message). 


### RetrySettings {#RetrySettings4}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra invokes) before the action is considered failed. Acceptable values are 1 to 5, inclusive.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds to wait between individual retries. 


### PutQueueMessage {#PutQueueMessage4}

Field | Description
--- | ---
queue_id | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### InvokeContainerWithRetry {#InvokeContainerWithRetry4}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 
retry_settings | **[RetrySettings](#RetrySettings5)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage5)**<br>DLQ policy (no value means discarding a message). 


### BatchSettings {#BatchSettings4}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 10, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. 


### InvokeContainerOnce {#InvokeContainerOnce4}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 


### CloudLogsBatchSettings {#CloudLogsBatchSettings4}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 1s to 1m, inclusive.


### LoggingBatchSettings {#LoggingBatchSettings4}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


## Resume {#Resume}

Restarts the specified trigger.

**rpc Resume ([ResumeTriggerRequest](#ResumeTriggerRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ResumeTriggerMetadata](#ResumeTriggerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trigger](#Trigger5)<br>

### ResumeTriggerRequest {#ResumeTriggerRequest}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger to pause <br>To get a trigger ID make a [TriggerService.List](#List) request. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ResumeTriggerMetadata](#ResumeTriggerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Trigger](#Trigger5)>**<br>if operation finished successfully. 


### ResumeTriggerMetadata {#ResumeTriggerMetadata}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger that is being paused. 


### Trigger {#Trigger5}

Field | Description
--- | ---
id | **string**<br>ID of the trigger. Generated at creation time. 
folder_id | **string**<br>Required. ID of the folder that the trigger belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the trigger. 
name | **string**<br>Name of the trigger. The string length in characters must be 3-63.
description | **string**<br>Description of the trigger. The string length in characters must be 0-256.
labels | **map<string,string>**<br>Trigger labels as `key:value` pairs. 
rule | **[Rule](#Rule5)**<br>Required. Rule for trigger activation (always consistent with the trigger type). 
status | enum **Status**<br>Trigger status. 


### Rule {#Rule5}

Field | Description
--- | ---
rule | **oneof:** `timer`, `message_queue`, `iot_message`, `iot_broker_message`, `object_storage`, `container_registry`, `cloud_logs`, `logging`, `billing_budget`, `data_stream` or `mail`<br>
&nbsp;&nbsp;timer | **[Timer](#Timer5)**<br>Rule for a timed trigger. 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue5)**<br>Rule for a message queue trigger. 
&nbsp;&nbsp;iot_message | **[IoTMessage](#IoTMessage5)**<br>Rule for a IoT Core trigger. 
&nbsp;&nbsp;iot_broker_message | **[IoTBrokerMessage](#IoTBrokerMessage5)**<br> 
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage5)**<br> 
&nbsp;&nbsp;container_registry | **[ContainerRegistry](#ContainerRegistry5)**<br> 
&nbsp;&nbsp;cloud_logs | **[CloudLogs](#CloudLogs5)**<br> 
&nbsp;&nbsp;logging | **[Logging](#Logging5)**<br> 
&nbsp;&nbsp;billing_budget | **[BillingBudget](#BillingBudget5)**<br> 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream5)**<br> 
&nbsp;&nbsp;mail | **[Mail](#Mail5)**<br> 


### Timer {#Timer5}

Field | Description
--- | ---
cron_expression | **string**<br>Required. Description of a schedule as a [cron expression](/docs/functions/concepts/trigger/timer). The maximum string length in characters is 100.
action | **oneof:** `invoke_function`, `invoke_function_with_retry` or `invoke_container_with_retry`<br>Action to be executed when the current time matches the `cron_expression`.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce5)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_function_with_retry | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br>Instructions for invoking a function with retry. 
&nbsp;&nbsp;invoke_container_with_retry | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br>Instructions for invoking a container with retry. 


### MessageQueue {#MessageQueue5}

Field | Description
--- | ---
queue_id | **string**<br>Required. ID of the message queue in Message Queue. 
service_account_id | **string**<br>Required. ID of the service account which has read access to the message queue. The maximum string length in characters is 50.
batch_settings | **[BatchSettings](#BatchSettings5)**<br>Required. Batch settings for processing messages in the queue. 
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the queue.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionOnce](#InvokeFunctionOnce5)**<br>Instructions for invoking a function once. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerOnce](#InvokeContainerOnce5)**<br>Instructions for invoking a container once. 


### IoTMessage {#IoTMessage5}

Field | Description
--- | ---
registry_id | **string**<br>Required. ID of the IoT Core registry. 
device_id | **string**<br>ID of the IoT Core device in the registry. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br>Instructions for invoking a container with retries as needed. 


### IoTBrokerMessage {#IoTBrokerMessage5}

Field | Description
--- | ---
broker_id | **string**<br>Required. ID of the IoT Core broker. 
mqtt_topic | **string**<br>MQTT topic whose messages activate the trigger. 
action | **oneof:** `invoke_function` or `invoke_container`<br>Action to be executed when the there's a new message in the MQTT topic.
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br>Instructions for invoking a container with retries as needed. 


### ObjectStorage {#ObjectStorage5}

Field | Description
--- | ---
event_type[] | enum **ObjectStorageEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
bucket_id | **string**<br>ID of the bucket. 
prefix | **string**<br>Prefix of the object key. Filter, optional. 
suffix | **string**<br>Suffix of the object key. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br>Instructions for invoking a container with retries as needed. 


### ContainerRegistry {#ContainerRegistry5}

Field | Description
--- | ---
event_type[] | enum **ContainerRegistryEventType**<br>Type (name) of events, at least one value is required. The number of elements must be greater than 0.
registry_id | **string**<br>ID of the registry. 
image_name | **string**<br>Docker-image name. Filter, optional. 
tag | **string**<br>Docker-image tag. Filter, optional. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br>Instructions for invoking a container with retries as needed. 


### CloudLogs {#CloudLogs5}

Field | Description
--- | ---
log_group_id[] | **string**<br>Log group identifiers, at least one value is required. 
batch_settings | **[CloudLogsBatchSettings](#CloudLogsBatchSettings5)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br>Instructions for invoking a container with retries as needed. 


### Logging {#Logging5}

Field | Description
--- | ---
log_group_id | **string**<br>Log events filter settings. The maximum string length in characters is 50.
resource_type[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
resource_id[] | **string**<br> Each value must match the regular expression ` [a-zA-Z][-a-zA-Z0-9_.]{1,62} `. The maximum number of elements is 100.
levels[] | **`yandex.cloud.logging.v1.LogLevel.Level`**<br> The maximum number of elements is 10.
batch_settings | **[LoggingBatchSettings](#LoggingBatchSettings5)**<br>Required. Batch settings for processing log events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br>Instructions for invoking a function with retries as needed. 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br>Instructions for invoking a container with retries as needed. 


### BillingBudget {#BillingBudget5}

Field | Description
--- | ---
billing_account_id | **string**<br>Required.  The maximum string length in characters is 50.
budget_id | **string**<br> The maximum string length in characters is 50.
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br> 


### DataStream {#DataStream5}

Field | Description
--- | ---
endpoint | **string**<br>Data stream endpoint. 
database | **string**<br>Data stream database. 
stream | **string**<br>Stream name. 
service_account_id | **string**<br>ID of the service account which has permission to read data stream. 
batch_settings | **[DataStreamBatchSettings](#DataStreamBatchSettings5)**<br>Batch settings for processing events. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br> 


### DataStreamBatchSettings {#DataStreamBatchSettings5}

Field | Description
--- | ---
size | **int64**<br>Batch size in bytes. Trigger will send the batch of messages to the associated function when size of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 65536, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


### Mail {#Mail5}

Field | Description
--- | ---
email | **string**<br>Address to receive emails for trigger activation. Field is ignored for write requests and populated on trigger creation. 
action | **oneof:** `invoke_function` or `invoke_container`<br>
&nbsp;&nbsp;invoke_function | **[InvokeFunctionWithRetry](#InvokeFunctionWithRetry5)**<br> 
&nbsp;&nbsp;invoke_container | **[InvokeContainerWithRetry](#InvokeContainerWithRetry5)**<br> 


### InvokeFunctionOnce {#InvokeFunctionOnce5}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account that should be used to invoke the function. 


### InvokeFunctionWithRetry {#InvokeFunctionWithRetry5}

Field | Description
--- | ---
function_id | **string**<br>Required. ID of the function to invoke. The maximum string length in characters is 50.
function_tag | **string**<br>Version tag of the function to execute. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the function. 
retry_settings | **[RetrySettings](#RetrySettings5)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage5)**<br>DLQ policy (no value means discarding a message). 


### RetrySettings {#RetrySettings5}

Field | Description
--- | ---
retry_attempts | **int64**<br>Maximum number of retries (extra invokes) before the action is considered failed. Acceptable values are 1 to 5, inclusive.
interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Time in seconds to wait between individual retries. 


### PutQueueMessage {#PutQueueMessage5}

Field | Description
--- | ---
queue_id | **string**<br>ID of the queue. 
service_account_id | **string**<br>Required. Service account which has write permission on the queue. The maximum string length in characters is 50.


### InvokeContainerWithRetry {#InvokeContainerWithRetry5}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 
retry_settings | **[RetrySettings](#RetrySettings6)**<br>Retry policy. If the field is not specified, or the value is empty, no retries will be attempted. 
dead_letter_queue | **[PutQueueMessage](#PutQueueMessage6)**<br>DLQ policy (no value means discarding a message). 


### BatchSettings {#BatchSettings5}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 10, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Required. Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the queue reaches `size`, or the `cutoff` time has passed. 


### InvokeContainerOnce {#InvokeContainerOnce5}

Field | Description
--- | ---
container_id | **string**<br>Required. ID of the container to invoke. The maximum string length in characters is 50.
path | **string**<br>Endpoint HTTP path to invoke. 
service_account_id | **string**<br>ID of the service account which has permission to invoke the container. 


### CloudLogsBatchSettings {#CloudLogsBatchSettings5}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 0 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages to the function when the number of messages in the log group reaches `size`, or the `cutoff` time has passed. Acceptable values are 1s to 1m, inclusive.


### LoggingBatchSettings {#LoggingBatchSettings5}

Field | Description
--- | ---
size | **int64**<br>Batch size. Trigger will send the batch of messages to the associated function when the number of log events reaches this value, or the `cutoff` time has passed. Acceptable values are 1 to 100, inclusive.
cutoff | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Maximum wait time. Trigger will send the batch of messages the time since the last batch exceeds the `cutoff` value, regardless of the amount of log events. Acceptable values are 1s to 1m, inclusive.


## ListOperations {#ListOperations}

Lists operations for the specified trigger.

**rpc ListOperations ([ListTriggerOperationsRequest](#ListTriggerOperationsRequest)) returns ([ListTriggerOperationsResponse](#ListTriggerOperationsResponse))**

### ListTriggerOperationsRequest {#ListTriggerOperationsRequest}

Field | Description
--- | ---
trigger_id | **string**<br>Required. ID of the trigger to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListTriggerOperationsResponse.next_page_token](#ListTriggerOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListTriggerOperationsResponse.next_page_token](#ListTriggerOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Trigger.name](#Trigger6) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-function`. The maximum string length in characters is 1000.


### ListTriggerOperationsResponse {#ListTriggerOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified trigger. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListTriggerOperationsRequest.page_size](#ListTriggerOperationsRequest), use `nextPageToken` as the value for the [ListTriggerOperationsRequest.page_token](#ListTriggerOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Operation {#Operation5}

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


