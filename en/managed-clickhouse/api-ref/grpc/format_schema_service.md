---
editable: false
sourcePath: en/_api-ref-grpc/managed-clickhouse/api-ref/grpc/format_schema_service.md
---

# Managed Service for ClickHouse API, gRPC: FormatSchemaService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |

## Calls FormatSchemaService {#calls}

## Get {#Get}



**rpc Get ([GetFormatSchemaRequest](#GetFormatSchemaRequest)) returns ([FormatSchema](#FormatSchema))**

### GetFormatSchemaRequest {#GetFormatSchemaRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
format_schema_name | **string**<br>Required.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### FormatSchema {#FormatSchema}

Field | Description
--- | ---
name | **string**<br> 
cluster_id | **string**<br> 
type | enum **FormatSchemaType**<br> 
uri | **string**<br> 


## List {#List}



**rpc List ([ListFormatSchemasRequest](#ListFormatSchemasRequest)) returns ([ListFormatSchemasResponse](#ListFormatSchemasResponse))**

### ListFormatSchemasRequest {#ListFormatSchemasRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
page_size | **int64**<br> The maximum value is 1000.
page_token | **string**<br> The maximum string length in characters is 100.


### ListFormatSchemasResponse {#ListFormatSchemasResponse}

Field | Description
--- | ---
format_schemas[] | **[FormatSchema](#FormatSchema1)**<br> 
next_page_token | **string**<br> 


### FormatSchema {#FormatSchema1}

Field | Description
--- | ---
name | **string**<br> 
cluster_id | **string**<br> 
type | enum **FormatSchemaType**<br> 
uri | **string**<br> 


## Create {#Create}



**rpc Create ([CreateFormatSchemaRequest](#CreateFormatSchemaRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFormatSchemaMetadata](#CreateFormatSchemaMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[FormatSchema](#FormatSchema2)<br>

### CreateFormatSchemaRequest {#CreateFormatSchemaRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
format_schema_name | **string**<br>Required.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
type | enum **FormatSchemaType**<br>Required.  
uri | **string**<br>Required.  


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFormatSchemaMetadata](#CreateFormatSchemaMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[FormatSchema](#FormatSchema2)>**<br>if operation finished successfully. 


### CreateFormatSchemaMetadata {#CreateFormatSchemaMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 
format_schema_name | **string**<br> 


### FormatSchema {#FormatSchema2}

Field | Description
--- | ---
name | **string**<br> 
cluster_id | **string**<br> 
type | enum **FormatSchemaType**<br> 
uri | **string**<br> 


## Update {#Update}



**rpc Update ([UpdateFormatSchemaRequest](#UpdateFormatSchemaRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateFormatSchemaMetadata](#UpdateFormatSchemaMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[FormatSchema](#FormatSchema3)<br>

### UpdateFormatSchemaRequest {#UpdateFormatSchemaRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
format_schema_name | **string**<br>Required.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
uri | **string**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateFormatSchemaMetadata](#UpdateFormatSchemaMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[FormatSchema](#FormatSchema3)>**<br>if operation finished successfully. 


### UpdateFormatSchemaMetadata {#UpdateFormatSchemaMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 
format_schema_name | **string**<br> 


### FormatSchema {#FormatSchema3}

Field | Description
--- | ---
name | **string**<br> 
cluster_id | **string**<br> 
type | enum **FormatSchemaType**<br> 
uri | **string**<br> 


## Delete {#Delete}



**rpc Delete ([DeleteFormatSchemaRequest](#DeleteFormatSchemaRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFormatSchemaMetadata](#DeleteFormatSchemaMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFormatSchemaRequest {#DeleteFormatSchemaRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
format_schema_name | **string**<br>Required.  The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteFormatSchemaMetadata](#DeleteFormatSchemaMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteFormatSchemaMetadata {#DeleteFormatSchemaMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 
format_schema_name | **string**<br> 


