---
editable: false
sourcePath: en/_api-ref-grpc/managed-clickhouse/api-ref/grpc/format_schema_service.md
---

# Managed Service for ClickHouse API, gRPC: FormatSchemaService

A set of methods for managing [format schemas](https://clickhouse.com/docs/en/interfaces/formats) for input and output data.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns detailed information about a given format schema. |
| [List](#List) | Returns a list of format schemas in a cluster. |
| [Create](#Create) | Adds a format schema to a cluster. |
| [Update](#Update) | Changes a format schema. |
| [Delete](#Delete) | Deletes a format schema from a cluster. |

## Calls FormatSchemaService {#calls}

## Get {#Get}

Returns detailed information about a given format schema.

**rpc Get ([GetFormatSchemaRequest](#GetFormatSchemaRequest)) returns ([FormatSchema](#FormatSchema))**

### GetFormatSchemaRequest {#GetFormatSchemaRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ClickHouse cluster ID. <br>To get a ClickHouse cluster ID, use the [ClusterService.List](./cluster_service#List) method. The maximum string length in characters is 50.
format_schema_name | **string**<br>Required. Format schema name. <br>To get a format schema name, use the [FormatSchemaService.List](#List) method. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### FormatSchema {#FormatSchema}

Field | Description
--- | ---
name | **string**<br>Format schema name. 
cluster_id | **string**<br>ClickHouse cluster ID. 
type | enum **FormatSchemaType**<br>Schema type. Possible values are the following: <br><ul><li>FORMAT_SCHEMA_TYPE_PROTOBUF - [Protobuf](https://protobuf.dev/) data format (including [ProtobufSingle](https://clickhouse.com/docs/en/interfaces/formats#protobufsingle)). </li><li>FORMAT_SCHEMA_TYPE_CAPNPROTO - [Cap'n Proto](https://capnproto.org/) data format.</li></ul> 
uri | **string**<br>Link to the file of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. 


## List {#List}

Returns a list of format schemas in a cluster.

**rpc List ([ListFormatSchemasRequest](#ListFormatSchemasRequest)) returns ([ListFormatSchemasResponse](#ListFormatSchemasResponse))**

### ListFormatSchemasRequest {#ListFormatSchemasRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ClickHouse cluster ID. <br>To get a ClickHouse cluster ID, use the [ClusterService.List](./cluster_service#List) method. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of the results is larger than `page_size`, the service returns [ListFormatSchemasResponse.next_page_token](#ListFormatSchemasResponse). You can use it to get the next page of the results in subsequent requests of a format schema list. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListFormatSchemasResponse.next_page_token](#ListFormatSchemasResponse) returned by the previous format schema list request. The maximum string length in characters is 100.


### ListFormatSchemasResponse {#ListFormatSchemasResponse}

Field | Description
--- | ---
format_schemas[] | **[FormatSchema](#FormatSchema1)**<br>List of format schemas. 
next_page_token | **string**<br>This token allows you to get the next page of results when requesting the format schema list. If the number of the results is larger than [ListFormatSchemasRequest.page_size](#ListFormatSchemasRequest), use the `next_page_token` as the value for the [ListFormatSchemasRequest.page_token](#ListFormatSchemasRequest) parameter in the next request. Each subsequent request will have its own `next_page_token` to continue paging through the results. 


### FormatSchema {#FormatSchema1}

Field | Description
--- | ---
name | **string**<br>Format schema name. 
cluster_id | **string**<br>ClickHouse cluster ID. 
type | enum **FormatSchemaType**<br>Schema type. Possible values are the following: <br><ul><li>FORMAT_SCHEMA_TYPE_PROTOBUF - [Protobuf](https://protobuf.dev/) data format (including [ProtobufSingle](https://clickhouse.com/docs/en/interfaces/formats#protobufsingle)). </li><li>FORMAT_SCHEMA_TYPE_CAPNPROTO - [Cap'n Proto](https://capnproto.org/) data format.</li></ul> 
uri | **string**<br>Link to the file of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. 


## Create {#Create}

Adds a format schema to a cluster.

**rpc Create ([CreateFormatSchemaRequest](#CreateFormatSchemaRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFormatSchemaMetadata](#CreateFormatSchemaMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[FormatSchema](#FormatSchema2)<br>

### CreateFormatSchemaRequest {#CreateFormatSchemaRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ClickHouse cluster ID. <br>To get a ClickHouse cluster ID, use the [ClusterService.List](./cluster_service#List) method. The maximum string length in characters is 50.
format_schema_name | **string**<br>Required. Format schema name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
type | enum **FormatSchemaType**<br>Required. Schema type. Possible values are the following: <br><ul><li>FORMAT_SCHEMA_TYPE_PROTOBUF - [Protobuf](https://protobuf.dev/) data format (including [ProtobufSingle](https://clickhouse.com/docs/en/interfaces/formats#protobufsingle)). </li><li>FORMAT_SCHEMA_TYPE_CAPNPROTO - [Cap'n Proto](https://capnproto.org/) data format.</li></ul> 
uri | **string**<br>Required. [Link to the file](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/s3-access#get-link-to-object) of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. 


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
cluster_id | **string**<br>ClickHouse cluster ID. 
format_schema_name | **string**<br>Format schema name. 


### FormatSchema {#FormatSchema2}

Field | Description
--- | ---
name | **string**<br>Format schema name. 
cluster_id | **string**<br>ClickHouse cluster ID. 
type | enum **FormatSchemaType**<br>Schema type. Possible values are the following: <br><ul><li>FORMAT_SCHEMA_TYPE_PROTOBUF - [Protobuf](https://protobuf.dev/) data format (including [ProtobufSingle](https://clickhouse.com/docs/en/interfaces/formats#protobufsingle)). </li><li>FORMAT_SCHEMA_TYPE_CAPNPROTO - [Cap'n Proto](https://capnproto.org/) data format.</li></ul> 
uri | **string**<br>Link to the file of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. 


## Update {#Update}

Changes a format schema.

**rpc Update ([UpdateFormatSchemaRequest](#UpdateFormatSchemaRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateFormatSchemaMetadata](#UpdateFormatSchemaMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[FormatSchema](#FormatSchema3)<br>

### UpdateFormatSchemaRequest {#UpdateFormatSchemaRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ClickHouse cluster ID. <br>To get a ClickHouse cluster ID, use the [ClusterService.List](./cluster_service#List) method. The maximum string length in characters is 50.
format_schema_name | **string**<br>Required. Format schema name. <br>To get a format schema name, use the [FormatSchemaService.List](#List) method. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
uri | **string**<br>[Link to the file](https://cloud.yandex.com/en/docs/managed-clickhouse/operations/s3-access#get-link-to-object) of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. 


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
cluster_id | **string**<br>ClickHouse cluster ID. 
format_schema_name | **string**<br>Format schema name. 


### FormatSchema {#FormatSchema3}

Field | Description
--- | ---
name | **string**<br>Format schema name. 
cluster_id | **string**<br>ClickHouse cluster ID. 
type | enum **FormatSchemaType**<br>Schema type. Possible values are the following: <br><ul><li>FORMAT_SCHEMA_TYPE_PROTOBUF - [Protobuf](https://protobuf.dev/) data format (including [ProtobufSingle](https://clickhouse.com/docs/en/interfaces/formats#protobufsingle)). </li><li>FORMAT_SCHEMA_TYPE_CAPNPROTO - [Cap'n Proto](https://capnproto.org/) data format.</li></ul> 
uri | **string**<br>Link to the file of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. 


## Delete {#Delete}

Deletes a format schema from a cluster.

**rpc Delete ([DeleteFormatSchemaRequest](#DeleteFormatSchemaRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFormatSchemaMetadata](#DeleteFormatSchemaMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFormatSchemaRequest {#DeleteFormatSchemaRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ClickHouse cluster ID. <br>To get a ClickHouse cluster ID, use the [ClusterService.List](./cluster_service#List) method. The maximum string length in characters is 50.
format_schema_name | **string**<br>Required. Format schema name. <br>To get a format schema name, use the [FormatSchemaService.List](#List) method. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>ClickHouse cluster ID. 
format_schema_name | **string**<br>Format schema name. 


