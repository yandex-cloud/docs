---
editable: false
sourcePath: en/_api-ref-grpc/load-testing/user/user/api-ref/grpc/test_service.md
---

# Load Testing API, gRPC: TestService

A set of methods for managing tests.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates (runs) a test in the specified folder. |
| [Get](#Get) | Returns the specified test. |
| [Stop](#Stop) | Stops the specified test. |
| [Delete](#Delete) | Deletes specified tests. |
| [List](#List) | Retrieves the list of test in the specified folder. |

## Calls TestService {#calls}

## Create {#Create}

Creates (runs) a test in the specified folder.

**rpc Create ([CreateTestRequest](#CreateTestRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTestMetadata](#CreateTestMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[test.Test](#Test)<br>

### CreateTestRequest {#CreateTestRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a test in. The maximum string length in characters is 50.
configurations[] | **[test.SingleAgentConfiguration](#SingleAgentConfiguration)**<br>Test configuration associated with agents on which they will be executed. In case of multiple configurations, a multitest will be created. 
test_details | **[test.Details](#Details)**<br>Test details. Name, tags etc. 


### SingleAgentConfiguration {#SingleAgentConfiguration}

Field | Description
--- | ---
config_id | **string**<br>ID of the config. 
agent_selector | **[AgentSelector](#AgentSelector)**<br>Agent selection criterion. 
files | **map<string,FilePointer>**<br>Additional files to be used during test execution, represented as `rel_path:file` pairs. <br>`rel_path` can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location. <br>Use cases include: <ul><li>[Test Data files](/docs/load-testing/concepts/payload). </li><li>Custom Pandora executable. </li><li>JMeter executable or ".jmx" scenario. </li><li>etc.</li></ul> 


### AgentSelector {#AgentSelector}

Field | Description
--- | ---
agent | **oneof:** `agent_id`, `match_by_filter` or `anonymous_agent`<br>
&nbsp;&nbsp;agent_id | **string**<br>Selection by agent ID. 
&nbsp;&nbsp;match_by_filter | **string**<br>Selection by filter string. 
&nbsp;&nbsp;anonymous_agent | **bool**<br>Select anonymoud (i.e. not registered) agents. 


### Details {#Details}

Field | Description
--- | ---
name | **string**<br>Name of the test. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the test. The maximum string length in characters is 256.
tags[] | **[common.Tag](#Tag)**<br>Tags assigned to the test. 
logging_log_group_id | **string**<br>ID of the logging group to which test artifacts are uploaded. 
artifact_settings | **[ArtifactSettings](#ArtifactSettings)**<br>Settings which define where to upload test artifacts and which files should be included. 


### Tag {#Tag}

Field | Description
--- | ---
key | **string**<br>Key of the tag. 
value | **string**<br>Value of the tag. 


### ArtifactSettings {#ArtifactSettings}

Field | Description
--- | ---
upload_to | **oneof:** `object_storage_bucket`<br>
&nbsp;&nbsp;object_storage_bucket | **string**<br>Name of output object storage bucket in test's folder. 
is_archive | **bool**<br>Setting which defines whether artifact files should be archived prior to uploading. 
filter_include[] | **string**<br>Filter strings defining which files should be included to artifacts. GLOB format. <br>Example: <ul><li>['*'] - all files will be uploaded. </li><li>['*.log', '*.yaml] - all `.log` and `.yaml` files will be uploaded.</li></ul> 
filter_exclude[] | **string**<br>Filter strings defining which files should be excluded from artifacts. GLOB format. <br>Example: <ul><li>filter_include=['*'], filter_exclude=['phout.log'] - upload all `.log` files excluding `phout.log`.</li></ul> 


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[test.Test](#Test)>**<br>if operation finished successfully. 


### CreateTestMetadata {#CreateTestMetadata}

Field | Description
--- | ---
test_id | **string**<br>ID of the test that is being created. 


### Test {#Test}

Field | Description
--- | ---
id | **string**<br>ID of the test. Generated at creation time. 
configurations[] | **[SingleAgentConfiguration](#SingleAgentConfiguration1)**<br>Configuration of the test. <br>A test can have multiple configurations if it can be executed on multiple agents simultaneously. For more information, see [Load testing using multiple agents](docs/load-testing/tutorials/loadtesting-multiply). 
details | **[Details](#Details1)**<br>Test meta information. Name, description, etc. 
summary | **[Summary](#Summary)**<br>Test execution information. 
folder_id | **string**<br>ID of the folder that the test belongs to. 


### SingleAgentConfiguration {#SingleAgentConfiguration1}

Field | Description
--- | ---
config_id | **string**<br>ID of the config. 
agent_selector | **[AgentSelector](#AgentSelector1)**<br>Agent selection criterion. 
files | **map<string,FilePointer>**<br>Additional files to be used during test execution, represented as `rel_path:file` pairs. <br>`rel_path` can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location. <br>Use cases include: <ul><li>[Test Data files](/docs/load-testing/concepts/payload). </li><li>Custom Pandora executable. </li><li>JMeter executable or ".jmx" scenario. </li><li>etc.</li></ul> 


### Details {#Details1}

Field | Description
--- | ---
name | **string**<br>Name of the test. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the test. The maximum string length in characters is 256.
tags[] | **[common.Tag](#Tag1)**<br>Tags assigned to the test. 
logging_log_group_id | **string**<br>ID of the logging group to which test artifacts are uploaded. 
artifact_settings | **[ArtifactSettings](#ArtifactSettings1)**<br>Settings which define where to upload test artifacts and which files should be included. 


### Summary {#Summary}

Field | Description
--- | ---
status | enum **Status**<br>Status of the test. <ul><li>`STATUS_UNSPECIFIED`: Status is unspecified.</li><li>`CREATED`: Test has been created, but not started by any agent.</li><li>`INITIATED`: Execution stage: initialization.</li><li>`PREPARING`: Execution stage: data preparation and warm-up.</li><li>`RUNNING`: Execution stage: load generation.</li><li>`FINISHING`: Execution stage: termination.</li><li>`DONE`: Test is done.</li><li>`POST_PROCESSING`: Execution stage: results post-processing.</li><li>`FAILED`: Test has failed due to some error.</li><li>`STOPPING`: Test is being stopped.</li><li>`STOPPED`: Test has been stopped.</li><li>`AUTOSTOPPED`: Test has been stopped automatically by satisfying autostop condition.</li><li>`WAITING`: Execution stage: waiting for a trigger to start.</li><li>`DELETING`: Test is being deleted.</li><li>`LOST`: Test status has not been reported in a while during execution stage. <br>Means that either an agent is too busy to send it, got offline, or failed without reporting a final status.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>UA or SA that created the test. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Test start timestamp. <br>Empty if the test has not been started yet. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Test finish timestamp. <br>Empty if the test has not been finished yet. 
is_finished | **bool**<br>Indicates whether the test is finished. 
error | **string**<br>Error message. 
imbalance_point | **[ImbalancePoint](#ImbalancePoint)**<br>Detected imbalance point. <br>Contains information about a state at the moment it has been [auto-stopped](/docs/load-testing/concepts/auto-stop). <br>Empty if no auto-stop occured. 
assigned_agent_id | **string**<br>ID of the agent that executed the test. 
artifacts | **[FilePointer](#FilePointer)**<br>Test output artifacts. <br>Link to the artifacts output target containing `.log` and other files collected during test execution. 


### ImbalancePoint {#ImbalancePoint}

Field | Description
--- | ---
at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Imbalance moment timestamp. 
rps | **int64**<br>Imbalance moment RPS. 
comment | **string**<br>Imbalance reason comment. 


### FilePointer {#FilePointer}

Field | Description
--- | ---
file_pointer | **oneof:** `object_storage`<br>
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage)**<br>Reference to a file in Object Storage. 


### ObjectStorage {#ObjectStorage}

Field | Description
--- | ---
bucket | **string**<br>Bucket name. 
name | **string**<br>File name. 


## Get {#Get}

Returns the specified test. <br>To get the list of all available tests, make a [List](#List) request.

**rpc Get ([GetTestRequest](#GetTestRequest)) returns ([test.Test](#Test1))**

### GetTestRequest {#GetTestRequest}

Field | Description
--- | ---
test_id | **string**<br>Required. ID of the test to return. 


### Test {#Test1}

Field | Description
--- | ---
id | **string**<br>ID of the test. Generated at creation time. 
configurations[] | **[SingleAgentConfiguration](#SingleAgentConfiguration2)**<br>Configuration of the test. <br>A test can have multiple configurations if it can be executed on multiple agents simultaneously. For more information, see [Load testing using multiple agents](docs/load-testing/tutorials/loadtesting-multiply). 
details | **[Details](#Details2)**<br>Test meta information. Name, description, etc. 
summary | **[Summary](#Summary1)**<br>Test execution information. 
folder_id | **string**<br>ID of the folder that the test belongs to. 


### SingleAgentConfiguration {#SingleAgentConfiguration2}

Field | Description
--- | ---
config_id | **string**<br>ID of the config. 
agent_selector | **[AgentSelector](#AgentSelector1)**<br>Agent selection criterion. 
files | **map<string,FilePointer>**<br>Additional files to be used during test execution, represented as `rel_path:file` pairs. <br>`rel_path` can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location. <br>Use cases include: <ul><li>[Test Data files](/docs/load-testing/concepts/payload). </li><li>Custom Pandora executable. </li><li>JMeter executable or ".jmx" scenario. </li><li>etc.</li></ul> 


### AgentSelector {#AgentSelector1}

Field | Description
--- | ---
agent | **oneof:** `agent_id`, `match_by_filter` or `anonymous_agent`<br>
&nbsp;&nbsp;agent_id | **string**<br>Selection by agent ID. 
&nbsp;&nbsp;match_by_filter | **string**<br>Selection by filter string. 
&nbsp;&nbsp;anonymous_agent | **bool**<br>Select anonymoud (i.e. not registered) agents. 


### Details {#Details2}

Field | Description
--- | ---
name | **string**<br>Name of the test. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the test. The maximum string length in characters is 256.
tags[] | **[common.Tag](#Tag1)**<br>Tags assigned to the test. 
logging_log_group_id | **string**<br>ID of the logging group to which test artifacts are uploaded. 
artifact_settings | **[ArtifactSettings](#ArtifactSettings1)**<br>Settings which define where to upload test artifacts and which files should be included. 


### Tag {#Tag1}

Field | Description
--- | ---
key | **string**<br>Key of the tag. 
value | **string**<br>Value of the tag. 


### ArtifactSettings {#ArtifactSettings1}

Field | Description
--- | ---
upload_to | **oneof:** `object_storage_bucket`<br>
&nbsp;&nbsp;object_storage_bucket | **string**<br>Name of output object storage bucket in test's folder. 
is_archive | **bool**<br>Setting which defines whether artifact files should be archived prior to uploading. 
filter_include[] | **string**<br>Filter strings defining which files should be included to artifacts. GLOB format. <br>Example: <ul><li>['*'] - all files will be uploaded. </li><li>['*.log', '*.yaml] - all `.log` and `.yaml` files will be uploaded.</li></ul> 
filter_exclude[] | **string**<br>Filter strings defining which files should be excluded from artifacts. GLOB format. <br>Example: <ul><li>filter_include=['*'], filter_exclude=['phout.log'] - upload all `.log` files excluding `phout.log`.</li></ul> 


### Summary {#Summary1}

Field | Description
--- | ---
status | enum **Status**<br>Status of the test. <ul><li>`STATUS_UNSPECIFIED`: Status is unspecified.</li><li>`CREATED`: Test has been created, but not started by any agent.</li><li>`INITIATED`: Execution stage: initialization.</li><li>`PREPARING`: Execution stage: data preparation and warm-up.</li><li>`RUNNING`: Execution stage: load generation.</li><li>`FINISHING`: Execution stage: termination.</li><li>`DONE`: Test is done.</li><li>`POST_PROCESSING`: Execution stage: results post-processing.</li><li>`FAILED`: Test has failed due to some error.</li><li>`STOPPING`: Test is being stopped.</li><li>`STOPPED`: Test has been stopped.</li><li>`AUTOSTOPPED`: Test has been stopped automatically by satisfying autostop condition.</li><li>`WAITING`: Execution stage: waiting for a trigger to start.</li><li>`DELETING`: Test is being deleted.</li><li>`LOST`: Test status has not been reported in a while during execution stage. <br>Means that either an agent is too busy to send it, got offline, or failed without reporting a final status.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>UA or SA that created the test. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Test start timestamp. <br>Empty if the test has not been started yet. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Test finish timestamp. <br>Empty if the test has not been finished yet. 
is_finished | **bool**<br>Indicates whether the test is finished. 
error | **string**<br>Error message. 
imbalance_point | **[ImbalancePoint](#ImbalancePoint1)**<br>Detected imbalance point. <br>Contains information about a state at the moment it has been [auto-stopped](/docs/load-testing/concepts/auto-stop). <br>Empty if no auto-stop occured. 
assigned_agent_id | **string**<br>ID of the agent that executed the test. 
artifacts | **[FilePointer](#FilePointer1)**<br>Test output artifacts. <br>Link to the artifacts output target containing `.log` and other files collected during test execution. 


### ImbalancePoint {#ImbalancePoint1}

Field | Description
--- | ---
at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Imbalance moment timestamp. 
rps | **int64**<br>Imbalance moment RPS. 
comment | **string**<br>Imbalance reason comment. 


### FilePointer {#FilePointer1}

Field | Description
--- | ---
file_pointer | **oneof:** `object_storage`<br>
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage1)**<br>Reference to a file in Object Storage. 


### ObjectStorage {#ObjectStorage1}

Field | Description
--- | ---
bucket | **string**<br>Bucket name. 
name | **string**<br>File name. 


## Stop {#Stop}

Stops the specified test.

**rpc Stop ([StopTestRequest](#StopTestRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopTestMetadata](#StopTestMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[test.Test](#Test2)<br>

### StopTestRequest {#StopTestRequest}

Field | Description
--- | ---
test_id | **string**<br>ID of the test to stop. 


### Operation {#Operation1}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[test.Test](#Test2)>**<br>if operation finished successfully. 


### StopTestMetadata {#StopTestMetadata}

Field | Description
--- | ---
test_id | **string**<br>ID of the test that is being stopped. 


### Test {#Test2}

Field | Description
--- | ---
id | **string**<br>ID of the test. Generated at creation time. 
configurations[] | **[SingleAgentConfiguration](#SingleAgentConfiguration3)**<br>Configuration of the test. <br>A test can have multiple configurations if it can be executed on multiple agents simultaneously. For more information, see [Load testing using multiple agents](docs/load-testing/tutorials/loadtesting-multiply). 
details | **[Details](#Details3)**<br>Test meta information. Name, description, etc. 
summary | **[Summary](#Summary2)**<br>Test execution information. 
folder_id | **string**<br>ID of the folder that the test belongs to. 


### SingleAgentConfiguration {#SingleAgentConfiguration3}

Field | Description
--- | ---
config_id | **string**<br>ID of the config. 
agent_selector | **[AgentSelector](#AgentSelector2)**<br>Agent selection criterion. 
files | **map<string,FilePointer>**<br>Additional files to be used during test execution, represented as `rel_path:file` pairs. <br>`rel_path` can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location. <br>Use cases include: <ul><li>[Test Data files](/docs/load-testing/concepts/payload). </li><li>Custom Pandora executable. </li><li>JMeter executable or ".jmx" scenario. </li><li>etc.</li></ul> 


### AgentSelector {#AgentSelector2}

Field | Description
--- | ---
agent | **oneof:** `agent_id`, `match_by_filter` or `anonymous_agent`<br>
&nbsp;&nbsp;agent_id | **string**<br>Selection by agent ID. 
&nbsp;&nbsp;match_by_filter | **string**<br>Selection by filter string. 
&nbsp;&nbsp;anonymous_agent | **bool**<br>Select anonymoud (i.e. not registered) agents. 


### Details {#Details3}

Field | Description
--- | ---
name | **string**<br>Name of the test. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the test. The maximum string length in characters is 256.
tags[] | **[common.Tag](#Tag2)**<br>Tags assigned to the test. 
logging_log_group_id | **string**<br>ID of the logging group to which test artifacts are uploaded. 
artifact_settings | **[ArtifactSettings](#ArtifactSettings2)**<br>Settings which define where to upload test artifacts and which files should be included. 


### Tag {#Tag2}

Field | Description
--- | ---
key | **string**<br>Key of the tag. 
value | **string**<br>Value of the tag. 


### ArtifactSettings {#ArtifactSettings2}

Field | Description
--- | ---
upload_to | **oneof:** `object_storage_bucket`<br>
&nbsp;&nbsp;object_storage_bucket | **string**<br>Name of output object storage bucket in test's folder. 
is_archive | **bool**<br>Setting which defines whether artifact files should be archived prior to uploading. 
filter_include[] | **string**<br>Filter strings defining which files should be included to artifacts. GLOB format. <br>Example: <ul><li>['*'] - all files will be uploaded. </li><li>['*.log', '*.yaml] - all `.log` and `.yaml` files will be uploaded.</li></ul> 
filter_exclude[] | **string**<br>Filter strings defining which files should be excluded from artifacts. GLOB format. <br>Example: <ul><li>filter_include=['*'], filter_exclude=['phout.log'] - upload all `.log` files excluding `phout.log`.</li></ul> 


### Summary {#Summary2}

Field | Description
--- | ---
status | enum **Status**<br>Status of the test. <ul><li>`STATUS_UNSPECIFIED`: Status is unspecified.</li><li>`CREATED`: Test has been created, but not started by any agent.</li><li>`INITIATED`: Execution stage: initialization.</li><li>`PREPARING`: Execution stage: data preparation and warm-up.</li><li>`RUNNING`: Execution stage: load generation.</li><li>`FINISHING`: Execution stage: termination.</li><li>`DONE`: Test is done.</li><li>`POST_PROCESSING`: Execution stage: results post-processing.</li><li>`FAILED`: Test has failed due to some error.</li><li>`STOPPING`: Test is being stopped.</li><li>`STOPPED`: Test has been stopped.</li><li>`AUTOSTOPPED`: Test has been stopped automatically by satisfying autostop condition.</li><li>`WAITING`: Execution stage: waiting for a trigger to start.</li><li>`DELETING`: Test is being deleted.</li><li>`LOST`: Test status has not been reported in a while during execution stage. <br>Means that either an agent is too busy to send it, got offline, or failed without reporting a final status.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>UA or SA that created the test. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Test start timestamp. <br>Empty if the test has not been started yet. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Test finish timestamp. <br>Empty if the test has not been finished yet. 
is_finished | **bool**<br>Indicates whether the test is finished. 
error | **string**<br>Error message. 
imbalance_point | **[ImbalancePoint](#ImbalancePoint2)**<br>Detected imbalance point. <br>Contains information about a state at the moment it has been [auto-stopped](/docs/load-testing/concepts/auto-stop). <br>Empty if no auto-stop occured. 
assigned_agent_id | **string**<br>ID of the agent that executed the test. 
artifacts | **[FilePointer](#FilePointer2)**<br>Test output artifacts. <br>Link to the artifacts output target containing `.log` and other files collected during test execution. 


### ImbalancePoint {#ImbalancePoint2}

Field | Description
--- | ---
at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Imbalance moment timestamp. 
rps | **int64**<br>Imbalance moment RPS. 
comment | **string**<br>Imbalance reason comment. 


### FilePointer {#FilePointer2}

Field | Description
--- | ---
file_pointer | **oneof:** `object_storage`<br>
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage2)**<br>Reference to a file in Object Storage. 


### ObjectStorage {#ObjectStorage2}

Field | Description
--- | ---
bucket | **string**<br>Bucket name. 
name | **string**<br>File name. 


## Delete {#Delete}

Deletes specified tests.

**rpc Delete ([DeleteTestRequest](#DeleteTestRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTestMetadata](#DeleteTestMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTestRequest {#DeleteTestRequest}

Field | Description
--- | ---
test_id | **string**<br>ID of the test to delete. 


### Operation {#Operation2}

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
test_id | **string**<br>ID of the test that is being deleted. 


## List {#List}

Retrieves the list of test in the specified folder.

**rpc List ([ListTestsRequest](#ListTestsRequest)) returns ([ListTestsResponse](#ListTestsResponse))**

### ListTestsRequest {#ListTestsRequest}

Field | Description
--- | ---
folder_id | **string**<br>ID of the folder to list tests in. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListTestsResponse.next_page_token](#ListTestsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListTestsResponse.next_page_token](#ListTestsResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters tests listed in the response. <br>The filter expression may contain multiple field expressions joined by `AND`. The field expression must specify: <ol><li>The field name. </li><li>An operator: </li><li>`=`, `!=`, `<`, `<=`, `>`, `>=`, `CONTAINS`, `:` for single values. </li><li>`IN` or `NOT IN` for lists of values. </li><li>The value. String values must be encosed in `"`, boolean values are {`true`, `false`}, timestamp values in ISO-8601. </li></ol><br>Currently supported fields: <ul><li>`id` `yandex.cloud.loadtesting.api.v1.test.Test.id` </li><li>operators: `=`, `!=`, `IN`, `NOT IN` </li><li>`details.name` `yandex.cloud.loadtesting.api.v1.test.Details.name` </li><li>operators: `=`, `!=`, `IN`, `NOT IN`, `CONTAINS` </li><li>`details.tags.<TAG_NAME>` `yandex.cloud.loadtesting.api.v1.test.Details.tags` </li><li>operators: `:` </li><li>`summary.status` `yandex.cloud.loadtesting.api.v1.test.Summary.status` </li><li>operators: `=`, `!=`, `IN`, `NOT IN` </li><li>`summary.is_finished` `yandex.cloud.loadtesting.api.v1.test.Summary.is_finished` </li><li>operators: `=` </li><li>`summary.created_at` `yandex.cloud.loadtesting.api.v1.test.Summary.created_at` </li><li>operators: `<`, `<=`, `>`, `>=` </li><li>`summary.created_by` `yandex.cloud.loadtesting.api.v1.test.Summary.created_by` </li><li>operators: `=`, `!=`, `IN`, `NOT IN` </li></ul><br>Examples: <ul><li>`summary.status IN ("DONE", "ERROR") AND details.tags.author:"yandex"` </li><li>`summary.is_finished = true AND details.name CONTAINS "nightly-test"`</li></ul> 


### ListTestsResponse {#ListTestsResponse}

Field | Description
--- | ---
tests[] | **[test.Test](#Test3)**<br>List of tests in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListTestsRequest.page_size](#ListTestsRequest), use `next_page_token` as the value for the [ListTestsRequest.page_token](#ListTestsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Test {#Test3}

Field | Description
--- | ---
id | **string**<br>ID of the test. Generated at creation time. 
configurations[] | **[SingleAgentConfiguration](#SingleAgentConfiguration4)**<br>Configuration of the test. <br>A test can have multiple configurations if it can be executed on multiple agents simultaneously. For more information, see [Load testing using multiple agents](docs/load-testing/tutorials/loadtesting-multiply). 
details | **[Details](#Details4)**<br>Test meta information. Name, description, etc. 
summary | **[Summary](#Summary3)**<br>Test execution information. 
folder_id | **string**<br>ID of the folder that the test belongs to. 


### SingleAgentConfiguration {#SingleAgentConfiguration4}

Field | Description
--- | ---
config_id | **string**<br>ID of the config. 
agent_selector | **[AgentSelector](#AgentSelector3)**<br>Agent selection criterion. 
files | **map<string,FilePointer>**<br>Additional files to be used during test execution, represented as `rel_path:file` pairs. <br>`rel_path` can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location. <br>Use cases include: <ul><li>[Test Data files](/docs/load-testing/concepts/payload). </li><li>Custom Pandora executable. </li><li>JMeter executable or ".jmx" scenario. </li><li>etc.</li></ul> 


### AgentSelector {#AgentSelector3}

Field | Description
--- | ---
agent | **oneof:** `agent_id`, `match_by_filter` or `anonymous_agent`<br>
&nbsp;&nbsp;agent_id | **string**<br>Selection by agent ID. 
&nbsp;&nbsp;match_by_filter | **string**<br>Selection by filter string. 
&nbsp;&nbsp;anonymous_agent | **bool**<br>Select anonymoud (i.e. not registered) agents. 


### Details {#Details4}

Field | Description
--- | ---
name | **string**<br>Name of the test. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the test. The maximum string length in characters is 256.
tags[] | **[common.Tag](#Tag3)**<br>Tags assigned to the test. 
logging_log_group_id | **string**<br>ID of the logging group to which test artifacts are uploaded. 
artifact_settings | **[ArtifactSettings](#ArtifactSettings3)**<br>Settings which define where to upload test artifacts and which files should be included. 


### Tag {#Tag3}

Field | Description
--- | ---
key | **string**<br>Key of the tag. 
value | **string**<br>Value of the tag. 


### ArtifactSettings {#ArtifactSettings3}

Field | Description
--- | ---
upload_to | **oneof:** `object_storage_bucket`<br>
&nbsp;&nbsp;object_storage_bucket | **string**<br>Name of output object storage bucket in test's folder. 
is_archive | **bool**<br>Setting which defines whether artifact files should be archived prior to uploading. 
filter_include[] | **string**<br>Filter strings defining which files should be included to artifacts. GLOB format. <br>Example: <ul><li>['*'] - all files will be uploaded. </li><li>['*.log', '*.yaml] - all `.log` and `.yaml` files will be uploaded.</li></ul> 
filter_exclude[] | **string**<br>Filter strings defining which files should be excluded from artifacts. GLOB format. <br>Example: <ul><li>filter_include=['*'], filter_exclude=['phout.log'] - upload all `.log` files excluding `phout.log`.</li></ul> 


### Summary {#Summary3}

Field | Description
--- | ---
status | enum **Status**<br>Status of the test. <ul><li>`STATUS_UNSPECIFIED`: Status is unspecified.</li><li>`CREATED`: Test has been created, but not started by any agent.</li><li>`INITIATED`: Execution stage: initialization.</li><li>`PREPARING`: Execution stage: data preparation and warm-up.</li><li>`RUNNING`: Execution stage: load generation.</li><li>`FINISHING`: Execution stage: termination.</li><li>`DONE`: Test is done.</li><li>`POST_PROCESSING`: Execution stage: results post-processing.</li><li>`FAILED`: Test has failed due to some error.</li><li>`STOPPING`: Test is being stopped.</li><li>`STOPPED`: Test has been stopped.</li><li>`AUTOSTOPPED`: Test has been stopped automatically by satisfying autostop condition.</li><li>`WAITING`: Execution stage: waiting for a trigger to start.</li><li>`DELETING`: Test is being deleted.</li><li>`LOST`: Test status has not been reported in a while during execution stage. <br>Means that either an agent is too busy to send it, got offline, or failed without reporting a final status.</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>UA or SA that created the test. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Test start timestamp. <br>Empty if the test has not been started yet. 
finished_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Test finish timestamp. <br>Empty if the test has not been finished yet. 
is_finished | **bool**<br>Indicates whether the test is finished. 
error | **string**<br>Error message. 
imbalance_point | **[ImbalancePoint](#ImbalancePoint3)**<br>Detected imbalance point. <br>Contains information about a state at the moment it has been [auto-stopped](/docs/load-testing/concepts/auto-stop). <br>Empty if no auto-stop occured. 
assigned_agent_id | **string**<br>ID of the agent that executed the test. 
artifacts | **[FilePointer](#FilePointer3)**<br>Test output artifacts. <br>Link to the artifacts output target containing `.log` and other files collected during test execution. 


### ImbalancePoint {#ImbalancePoint3}

Field | Description
--- | ---
at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Imbalance moment timestamp. 
rps | **int64**<br>Imbalance moment RPS. 
comment | **string**<br>Imbalance reason comment. 


### FilePointer {#FilePointer3}

Field | Description
--- | ---
file_pointer | **oneof:** `object_storage`<br>
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage3)**<br>Reference to a file in Object Storage. 


### ObjectStorage {#ObjectStorage3}

Field | Description
--- | ---
bucket | **string**<br>Bucket name. 
name | **string**<br>File name. 


