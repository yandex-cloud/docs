---
editable: false
---

# TestService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns test by test id. |
| [List](#List) | Retrieves the list of tests for the specified folder. |
| [Create](#Create) | Creates a test in the specified folder. |
| [CreateMulti](#CreateMulti) | Creates a multitest in the specified folder. |
| [Update](#Update) | Updates the specified test. |
| [Stop](#Stop) | Stops the specified test. |
| [Delete](#Delete) | Deletes the specified test |
| [ValidateConfig](#ValidateConfig) |  |
| [GetSummary](#GetSummary) |  |
| [GetMonitoringReport](#GetMonitoringReport) |  |
| [GetMonitoringHosts](#GetMonitoringHosts) |  |

## Calls TestService {#calls}

## Get {#Get}

Returns test by test id.

**rpc Get ([GetTestRequest](#GetTestRequest)) returns ([Test](#Test))**

### GetTestRequest {#GetTestRequest}

Field | Description
--- | ---
test_id | **string**<br> The maximum string length in characters is 50.


### Test {#Test}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
agent_instance_id | **string**<br>AgentInstance ID where Test is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
config | **string**<br>Test details 
payload | **oneof:** `payload_urls` or `payload_id`<br>
&nbsp;&nbsp;payload_urls | **string**<br> 
&nbsp;&nbsp;payload_id | **string**<br> 
cases[] | **string**<br> 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
imbalance_comment | **string**<br> 
autostops[] | **[Autostop](#Autostop)**<br> 
user_id | **string**<br> 
test_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 
parts[] | **`yandex.cloud.loadtesting.v2.test.ShortDescription`**<br> 


### Autostop {#Autostop}

Field | Description
--- | ---
autostop_type | enum **AutostopType**<br> 
autostop_criteria | **string**<br> 
autostop_case | **string**<br> 


### ShortDescription {#ShortDescription}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
tank_instance_id | **string**<br>TankInstance ID where TankJob is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
cases[] | **string**<br>Test details 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
job_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 


## List {#List}

Retrieves the list of tests for the specified folder.

**rpc List ([ListTestsRequest](#ListTestsRequest)) returns ([ListTestsResponse](#ListTestsResponse))**

### ListTestsRequest {#ListTestsRequest}

Field | Description
--- | ---
folder_id | **string**<br> The maximum string length in characters is 50.
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 100.
filter | **string**<br> The maximum string length in characters is 1000.


### ListTestsResponse {#ListTestsResponse}

Field | Description
--- | ---
folder_id | **string**<br> 
tests[] | **[Test](#Test1)**<br> 
next_page_token | **string**<br> 


### Test {#Test1}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
agent_instance_id | **string**<br>AgentInstance ID where Test is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
config | **string**<br>Test details 
payload | **oneof:** `payload_urls` or `payload_id`<br>
&nbsp;&nbsp;payload_urls | **string**<br> 
&nbsp;&nbsp;payload_id | **string**<br> 
cases[] | **string**<br> 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
imbalance_comment | **string**<br> 
autostops[] | **[Autostop](#Autostop1)**<br> 
user_id | **string**<br> 
test_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 
parts[] | **`yandex.cloud.loadtesting.v2.test.ShortDescription`**<br> 


### Autostop {#Autostop1}

Field | Description
--- | ---
autostop_type | enum **AutostopType**<br> 
autostop_criteria | **string**<br> 
autostop_case | **string**<br> 


### ShortDescription {#ShortDescription1}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
tank_instance_id | **string**<br>TankInstance ID where TankJob is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
cases[] | **string**<br>Test details 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
job_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 


## Create {#Create}

Creates a test in the specified folder.

**rpc Create ([CreateTestRequest](#CreateTestRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTestMetadata](#CreateTestMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Test](#Test2)<br>

### CreateTestRequest {#CreateTestRequest}

Field | Description
--- | ---
folder_id | **string**<br> The maximum string length in characters is 50.
name | **string**<br> Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each value must be 1-63. Each value must match the regular expression ` [a-z][-_0-9a-z]* `.
agent_instance_id | **string**<br> The maximum string length in characters is 50.
config | **string**<br> 
logging_log_group_id | **string**<br> 
payload_storage_object | **[StorageObject](#StorageObject)**<br> 


### StorageObject {#StorageObject}

Field | Description
--- | ---
object_storage_bucket | **string**<br> 
object_storage_filename | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTestMetadata](#CreateTestMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Test](#Test2)>**<br>if operation finished successfully. 


### CreateTestMetadata {#CreateTestMetadata}

Field | Description
--- | ---
test_id | **string**<br> 


### Test {#Test2}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
agent_instance_id | **string**<br>AgentInstance ID where Test is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
config | **string**<br>Test details 
payload | **oneof:** `payload_urls` or `payload_id`<br>
&nbsp;&nbsp;payload_urls | **string**<br> 
&nbsp;&nbsp;payload_id | **string**<br> 
cases[] | **string**<br> 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
imbalance_comment | **string**<br> 
autostops[] | **[Autostop](#Autostop2)**<br> 
user_id | **string**<br> 
test_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 
parts[] | **`yandex.cloud.loadtesting.v2.test.ShortDescription`**<br> 


### Autostop {#Autostop2}

Field | Description
--- | ---
autostop_type | enum **AutostopType**<br> 
autostop_criteria | **string**<br> 
autostop_case | **string**<br> 


### ShortDescription {#ShortDescription2}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
tank_instance_id | **string**<br>TankInstance ID where TankJob is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
cases[] | **string**<br>Test details 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
job_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 


## CreateMulti {#CreateMulti}

Creates a multitest in the specified folder.

**rpc CreateMulti ([CreateMultiTestRequest](#CreateMultiTestRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTestMetadata](#CreateTestMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Test](#Test3)<br>

### CreateMultiTestRequest {#CreateMultiTestRequest}

Field | Description
--- | ---
folder_id | **string**<br> The maximum string length in characters is 50.
name | **string**<br> Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each value must be 1-63. Each value must match the regular expression ` [a-z][-_0-9a-z]* `.
target_version | **string**<br> The maximum string length in characters is 50.
logging_log_group_id | **string**<br> 
parts[] | **[CreateTestRequest](#CreateTestRequest)**<br> 


### CreateTestRequest {#CreateTestRequest1}

Field | Description
--- | ---
folder_id | **string**<br> The maximum string length in characters is 50.
name | **string**<br> Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each value must be 1-63. Each value must match the regular expression ` [a-z][-_0-9a-z]* `.
agent_instance_id | **string**<br> The maximum string length in characters is 50.
config | **string**<br> 
logging_log_group_id | **string**<br> 
payload_storage_object | **[StorageObject](#StorageObject1)**<br> 


### StorageObject {#StorageObject1}

Field | Description
--- | ---
object_storage_bucket | **string**<br> 
object_storage_filename | **string**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTestMetadata](#CreateTestMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Test](#Test3)>**<br>if operation finished successfully. 


### CreateTestMetadata {#CreateTestMetadata1}

Field | Description
--- | ---
test_id | **string**<br> 


### Test {#Test3}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
agent_instance_id | **string**<br>AgentInstance ID where Test is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
config | **string**<br>Test details 
payload | **oneof:** `payload_urls` or `payload_id`<br>
&nbsp;&nbsp;payload_urls | **string**<br> 
&nbsp;&nbsp;payload_id | **string**<br> 
cases[] | **string**<br> 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
imbalance_comment | **string**<br> 
autostops[] | **[Autostop](#Autostop3)**<br> 
user_id | **string**<br> 
test_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 
parts[] | **`yandex.cloud.loadtesting.v2.test.ShortDescription`**<br> 


### Autostop {#Autostop3}

Field | Description
--- | ---
autostop_type | enum **AutostopType**<br> 
autostop_criteria | **string**<br> 
autostop_case | **string**<br> 


### ShortDescription {#ShortDescription3}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
tank_instance_id | **string**<br>TankInstance ID where TankJob is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
cases[] | **string**<br>Test details 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
job_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 


## Update {#Update}

Updates the specified test.

**rpc Update ([UpdateTestRequest](#UpdateTestRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTestMetadata](#UpdateTestMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Test](#Test4)<br>

### UpdateTestRequest {#UpdateTestRequest}

Field | Description
--- | ---
test_id | **string**<br> The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
name | **string**<br> Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br> The maximum string length in characters is 256.
labels | **map<string,string>**<br> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each value must be 1-63. Each value must match the regular expression ` [a-z][-_0-9a-z]* `.
favorite | **bool**<br> 
target_version | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateTestMetadata](#UpdateTestMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Test](#Test4)>**<br>if operation finished successfully. 


### UpdateTestMetadata {#UpdateTestMetadata}

Field | Description
--- | ---
test_id | **string**<br> 


### Test {#Test4}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
agent_instance_id | **string**<br>AgentInstance ID where Test is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
config | **string**<br>Test details 
payload | **oneof:** `payload_urls` or `payload_id`<br>
&nbsp;&nbsp;payload_urls | **string**<br> 
&nbsp;&nbsp;payload_id | **string**<br> 
cases[] | **string**<br> 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
imbalance_comment | **string**<br> 
autostops[] | **[Autostop](#Autostop4)**<br> 
user_id | **string**<br> 
test_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 
parts[] | **`yandex.cloud.loadtesting.v2.test.ShortDescription`**<br> 


### Autostop {#Autostop4}

Field | Description
--- | ---
autostop_type | enum **AutostopType**<br> 
autostop_criteria | **string**<br> 
autostop_case | **string**<br> 


### ShortDescription {#ShortDescription4}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
tank_instance_id | **string**<br>TankInstance ID where TankJob is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
cases[] | **string**<br>Test details 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
job_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 


## Stop {#Stop}

Stops the specified test.

**rpc Stop ([StopTestRequest](#StopTestRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopTestMetadata](#StopTestMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Test](#Test5)<br>

### StopTestRequest {#StopTestRequest}

Field | Description
--- | ---
test_id | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopTestMetadata](#StopTestMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Test](#Test5)>**<br>if operation finished successfully. 


### StopTestMetadata {#StopTestMetadata}

Field | Description
--- | ---
test_id | **string**<br> 


### Test {#Test5}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
agent_instance_id | **string**<br>AgentInstance ID where Test is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
config | **string**<br>Test details 
payload | **oneof:** `payload_urls` or `payload_id`<br>
&nbsp;&nbsp;payload_urls | **string**<br> 
&nbsp;&nbsp;payload_id | **string**<br> 
cases[] | **string**<br> 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
imbalance_comment | **string**<br> 
autostops[] | **[Autostop](#Autostop5)**<br> 
user_id | **string**<br> 
test_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 
parts[] | **`yandex.cloud.loadtesting.v2.test.ShortDescription`**<br> 


### Autostop {#Autostop5}

Field | Description
--- | ---
autostop_type | enum **AutostopType**<br> 
autostop_criteria | **string**<br> 
autostop_case | **string**<br> 


### ShortDescription {#ShortDescription5}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
tank_instance_id | **string**<br>TankInstance ID where TankJob is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
cases[] | **string**<br>Test details 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
job_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 


## Delete {#Delete}

Deletes the specified test

**rpc Delete ([DeleteTestRequest](#DeleteTestRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTestMetadata](#DeleteTestMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTestRequest {#DeleteTestRequest}

Field | Description
--- | ---
test_id | **string**<br> The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteTestMetadata](#DeleteTestMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteTestMetadata {#DeleteTestMetadata}

Field | Description
--- | ---
test_id | **string**<br> 


## ValidateConfig {#ValidateConfig}



**rpc ValidateConfig ([ValidateConfigRequest](#ValidateConfigRequest)) returns ([ValidateConfigResponse](#ValidateConfigResponse))**

### ValidateConfigRequest {#ValidateConfigRequest}

Field | Description
--- | ---
config | **string**<br> 
folder_id | **string**<br> The maximum string length in characters is 50.


### ValidateConfigResponse {#ValidateConfigResponse}

Field | Description
--- | ---
status | enum **[Status](./test/status#undefined)**<br> 
errors[] | **string**<br> 


## GetSummary {#GetSummary}



**rpc GetSummary ([GetSummaryRequest](#GetSummaryRequest)) returns ([TestSummary](#TestSummary))**

### GetSummaryRequest {#GetSummaryRequest}

Field | Description
--- | ---
folder_id | **string**<br> The maximum string length in characters is 50.
test_id | **string**<br> The maximum string length in characters is 50.
full | **bool**<br> 


### TestSummary {#TestSummary}

Field | Description
--- | ---
test_id | **[Test](#Test6)**<br> 
errors[] | **string**<br> 
results[] | **TestResults**<br> 


### Test {#Test6}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
agent_instance_id | **string**<br>AgentInstance ID where Test is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
config | **string**<br>Test details 
payload | **oneof:** `payload_urls` or `payload_id`<br>
&nbsp;&nbsp;payload_urls | **string**<br> 
&nbsp;&nbsp;payload_id | **string**<br> 
cases[] | **string**<br> 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
imbalance_comment | **string**<br> 
autostops[] | **[Autostop](#Autostop6)**<br> 
user_id | **string**<br> 
test_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 
parts[] | **`yandex.cloud.loadtesting.v2.test.ShortDescription`**<br> 


### Autostop {#Autostop6}

Field | Description
--- | ---
autostop_type | enum **AutostopType**<br> 
autostop_criteria | **string**<br> 
autostop_case | **string**<br> 


### ShortDescription {#ShortDescription6}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
generator | **yandex.cloud.loadtesting.v2.test.Generator**<br> 
tank_instance_id | **string**<br>TankInstance ID where TankJob is running. 
target_address | **string**<br>Target VM ID. 
target_port | **int64**<br> 
target_version | **string**<br>Version of object under test. 
cases[] | **string**<br>Test details 
status | **yandex.cloud.loadtesting.v2.test.Status**<br> 
errors[] | **string**<br> 
favorite | **bool**<br> 
imbalance_point | **int64**<br> 
imbalance_ts | **int64**<br> 
imbalance_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
job_type | **yandex.cloud.loadtesting.v2.test.Type**<br> 
container_id | **string**<br> 


### TestResults {#TestResults}

Field | Description
--- | ---
case_name | **string**<br> 
quantiles | **map<string,double>**<br> 
proto_codes | **map<string,CodeResults>**<br> 
net_codes | **map<string,CodeResults>**<br> 
max_rps | **int64**<br> 
max_instances | **int64**<br> 


### CodeResults {#CodeResults}

Field | Description
--- | ---
amount | **int64**<br> 
percentage | **double**<br> 


## GetMonitoringReport {#GetMonitoringReport}



**rpc GetMonitoringReport ([GetMonitoringReportRequest](#GetMonitoringReportRequest)) returns ([MonitoringReport](#MonitoringReport))**

### GetMonitoringReportRequest {#GetMonitoringReportRequest}

Field | Description
--- | ---
test_id | **string**<br> The maximum string length in characters is 50.
host | **string**<br> The maximum string length in characters is 50.


### MonitoringReport {#MonitoringReport}

Field | Description
--- | ---
test_id | **string**<br> 
charts[] | **[MonitoringChart](#MonitoringChart)**<br> 
finished | **bool**<br> 


### MonitoringChart {#MonitoringChart}

Field | Description
--- | ---
monitored_host | **string**<br> 
test_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
ts[] | **int64**<br> 
responses_per_second[] | **int64**<br> 
threads[] | **int64**<br> 
metric_data[] | **[MetricData](#MetricData)**<br> 
x_axis_label | **string**<br> 
y_axis_label | **string**<br> 


### MetricData {#MetricData}

Field | Description
--- | ---
case_name | **string**<br> 
metric_name | **string**<br> 
metric_value[] | **double**<br> 
disabled | **bool**<br> 


## GetMonitoringHosts {#GetMonitoringHosts}



**rpc GetMonitoringHosts ([GetMonitoringHostsRequest](#GetMonitoringHostsRequest)) returns ([GetMonitoringHostsResponse](#GetMonitoringHostsResponse))**

### GetMonitoringHostsRequest {#GetMonitoringHostsRequest}

Field | Description
--- | ---
test_id | **string**<br> The maximum string length in characters is 50.


### GetMonitoringHostsResponse {#GetMonitoringHostsResponse}

Field | Description
--- | ---
hosts[] | **string**<br> 


