---
editable: false
sourcePath: en/_api-ref-grpc/cdn/api-ref/grpc/raw_logs_service.md
---

# Cloud CDN API, gRPC: RawLogsService



| Call | Description |
| --- | --- |
| [Activate](#Activate) |  |
| [Deactivate](#Deactivate) |  |
| [Get](#Get) |  |
| [Update](#Update) |  |

## Calls RawLogsService {#calls}

## Activate {#Activate}



**rpc Activate ([ActivateRawLogsRequest](#ActivateRawLogsRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ActivateRawLogsMetadata](#ActivateRawLogsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ActivateRawLogsResponse](#ActivateRawLogsResponse)<br>

### ActivateRawLogsRequest {#ActivateRawLogsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of CDN resource to switch logs storage for.. The maximum string length in characters is 50.
settings | **[RawLogsSettings](#RawLogsSettings)**<br>Raw logs settings. 


### RawLogsSettings {#RawLogsSettings}

Field | Description
--- | ---
bucket_name | **string**<br>Required. Destination S3 bucket name, note that the suer should be owner of the bucket. The maximum string length in characters is 1024.
bucket_region | **string**<br>Bucket region, unused for now, could be blank. The maximum string length in characters is 50.
file_prefix | **string**<br>file_prefix: prefix each log object name with specified prefix. <br>The prefix makes it simpler for you to locate the log objects. For example, if you specify the prefix value logs/, each log object that S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders could be setup. The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ActivateRawLogsMetadata](#ActivateRawLogsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ActivateRawLogsResponse](#ActivateRawLogsResponse)>**<br>if operation finished successfully. 


### ActivateRawLogsMetadata {#ActivateRawLogsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of resource with activated raw logs. 


### ActivateRawLogsResponse {#ActivateRawLogsResponse}

Field | Description
--- | ---
status | enum **RawLogsStatus**<br>Raw logs status. <ul><li>`RAW_LOGS_STATUS_NOT_ACTIVATED`: Raw logs wasn't activated.</li><li>`RAW_LOGS_STATUS_OK`: Raw logs was activated, and logs storing process works as expected.</li><li>`RAW_LOGS_STATUS_FAILED`: Raw logs was activated, but logs CDN provider has been failed to store logs.</li></ul>
settings | **[RawLogsSettings](#RawLogsSettings1)**<br>Raw logs settings. 


## Deactivate {#Deactivate}



**rpc Deactivate ([DeactivateRawLogsRequest](#DeactivateRawLogsRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeactivateRawLogsMetadata](#DeactivateRawLogsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeactivateRawLogsRequest {#DeactivateRawLogsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of CDN resource to deactivate Raw Logs for. The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeactivateRawLogsMetadata](#DeactivateRawLogsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeactivateRawLogsMetadata {#DeactivateRawLogsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of CDN resource. 


## Get {#Get}



**rpc Get ([GetRawLogsRequest](#GetRawLogsRequest)) returns ([GetRawLogsResponse](#GetRawLogsResponse))**

### GetRawLogsRequest {#GetRawLogsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of CDN resource to request status and settings. The maximum string length in characters is 50.


### GetRawLogsResponse {#GetRawLogsResponse}

Field | Description
--- | ---
status | enum **RawLogsStatus**<br>Raw logs status. <ul><li>`RAW_LOGS_STATUS_NOT_ACTIVATED`: Raw logs wasn't activated.</li><li>`RAW_LOGS_STATUS_OK`: Raw logs was activated, and logs storing process works as expected.</li><li>`RAW_LOGS_STATUS_FAILED`: Raw logs was activated, but logs CDN provider has been failed to store logs.</li></ul>
settings | **[RawLogsSettings](#RawLogsSettings1)**<br>Raw logs settings. 


### RawLogsSettings {#RawLogsSettings1}

Field | Description
--- | ---
bucket_name | **string**<br>Required. Destination S3 bucket name, note that the suer should be owner of the bucket. The maximum string length in characters is 1024.
bucket_region | **string**<br>Bucket region, unused for now, could be blank. The maximum string length in characters is 50.
file_prefix | **string**<br>file_prefix: prefix each log object name with specified prefix. <br>The prefix makes it simpler for you to locate the log objects. For example, if you specify the prefix value logs/, each log object that S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders could be setup. The maximum string length in characters is 50.


## Update {#Update}



**rpc Update ([UpdateRawLogsRequest](#UpdateRawLogsRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRawLogsMetadata](#UpdateRawLogsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[UpdateRawLogsResponse](#UpdateRawLogsResponse)<br>

### UpdateRawLogsRequest {#UpdateRawLogsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of CDN resource. The maximum string length in characters is 50.
settings | **[RawLogsSettings](#RawLogsSettings2)**<br>Raw logs settings. 


### RawLogsSettings {#RawLogsSettings2}

Field | Description
--- | ---
bucket_name | **string**<br>Required. Destination S3 bucket name, note that the suer should be owner of the bucket. The maximum string length in characters is 1024.
bucket_region | **string**<br>Bucket region, unused for now, could be blank. The maximum string length in characters is 50.
file_prefix | **string**<br>file_prefix: prefix each log object name with specified prefix. <br>The prefix makes it simpler for you to locate the log objects. For example, if you specify the prefix value logs/, each log object that S3 creates begins with the logs/ prefix in its key, so pseudo S3 folders could be setup. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRawLogsMetadata](#UpdateRawLogsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRawLogsResponse](#UpdateRawLogsResponse)>**<br>if operation finished successfully. 


### UpdateRawLogsMetadata {#UpdateRawLogsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of CDN resource. 


### UpdateRawLogsResponse {#UpdateRawLogsResponse}

Field | Description
--- | ---
status | enum **RawLogsStatus**<br>Raw logs status. <ul><li>`RAW_LOGS_STATUS_NOT_ACTIVATED`: Raw logs wasn't activated.</li><li>`RAW_LOGS_STATUS_OK`: Raw logs was activated, and logs storing process works as expected.</li><li>`RAW_LOGS_STATUS_FAILED`: Raw logs was activated, but logs CDN provider has been failed to store logs.</li></ul>
settings | **[RawLogsSettings](#RawLogsSettings3)**<br>Raw logs settings. 


