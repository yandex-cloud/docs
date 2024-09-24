---
editable: false
sourcePath: en/_api-ref-grpc/functions/eventrouter/eventrouter/api-ref/grpc/connector_service.md
---

# EventRouter Service, gRPC: ConnectorService

A set of methods for managing connectors for serverless eventrouter.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified bus. |
| [List](#List) | Retrieves the list of connectors in the specified folder. |
| [Create](#Create) | Creates a connector in the specified folder. |
| [Update](#Update) | Updates the specified connector. |
| [Delete](#Delete) | Deletes the specified connector. |
| [Start](#Start) | Starts the specified connector. |
| [Stop](#Stop) | Stops the specified connector. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified bus. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the connector. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified connector. |
| [ListOperations](#ListOperations) | Lists operations for the specified connector. |

## Calls ConnectorService {#calls}

## Get {#Get}

Returns the specified bus. To get the list of all available connectors, make a [List](#List) request.

**rpc Get ([GetConnectorRequest](#GetConnectorRequest)) returns ([Connector](#Connector))**

### GetConnectorRequest {#GetConnectorRequest}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector to return. 


### Connector {#Connector}

Field | Description
--- | ---
id | **string**<br>ID of the connector. 
bus_id | **string**<br>ID of the bus that the connector belongs to. 
folder_id | **string**<br>ID of the folder that the connector resides in. 
cloud_id | **string**<br>ID of the cloud that the connector resides in. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the connector. 
description | **string**<br>Description of the connector. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
source | **[Source](#Source)**<br>Source of the connector. 
deletion_protection | **bool**<br>Deletion protection. 
status | enum **Status**<br>Status of the connector. <ul><li>`STOPPED`: disabled by user</li><li>`RESOURCE_NOT_FOUND`: source does not exist</li><li>`PERMISSION_DENIED`: service account does not have read permission on source</li><li>`SUBJECT_NOT_FOUND`: service account not found</li></ul>


### Source {#Source}

Field | Description
--- | ---
source | **oneof:** `data_stream` or `message_queue`<br>
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream)**<br> 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue)**<br> 


### DataStream {#DataStream}

Field | Description
--- | ---
database | **string**<br>Required. Stream database. example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6******** 
stream_name | **string**<br>Required. Stream name, absolute or relative. 
consumer | **string**<br>Required. Consumer name. 
service_account_id | **string**<br>Required. Service account which has read permission on the stream. 


### MessageQueue {#MessageQueue}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test 
service_account_id | **string**<br>Required. Service account which has read access to the queue. The maximum string length in characters is 50.
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
batch_size | **int64**<br>Batch size for polling. The maximum value is 10.
polling_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue polling timeout. The maximum value is 20s.


## List {#List}

Retrieves the list of connectors in the specified folder.

**rpc List ([ListConnectorsRequest](#ListConnectorsRequest)) returns ([ListConnectorsResponse](#ListConnectorsResponse))**

### ListConnectorsRequest {#ListConnectorsRequest}

Field | Description
--- | ---
container_id | **oneof:** `bus_id` or `folder_id`<br>ID of the folder or bus to list connectors in.
&nbsp;&nbsp;bus_id | **string**<br>ID of the bus to list connectors in. 
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list connectors in. 
page_size | **int64**<br>The maximum number of results per response. 
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the `next_page_token` returned by a previous list request. 
filter | **string**<br>Supported fields for filter: name created_at 


### ListConnectorsResponse {#ListConnectorsResponse}

Field | Description
--- | ---
connectors[] | **[Connector](#Connector1)**<br>List of connectors. 
next_page_token | **string**<br>Token for getting the next page of the list of results. 


### Connector {#Connector1}

Field | Description
--- | ---
id | **string**<br>ID of the connector. 
bus_id | **string**<br>ID of the bus that the connector belongs to. 
folder_id | **string**<br>ID of the folder that the connector resides in. 
cloud_id | **string**<br>ID of the cloud that the connector resides in. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the connector. 
description | **string**<br>Description of the connector. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
source | **[Source](#Source1)**<br>Source of the connector. 
deletion_protection | **bool**<br>Deletion protection. 
status | enum **Status**<br>Status of the connector. <ul><li>`STOPPED`: disabled by user</li><li>`RESOURCE_NOT_FOUND`: source does not exist</li><li>`PERMISSION_DENIED`: service account does not have read permission on source</li><li>`SUBJECT_NOT_FOUND`: service account not found</li></ul>


### Source {#Source1}

Field | Description
--- | ---
source | **oneof:** `data_stream` or `message_queue`<br>
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream1)**<br> 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue1)**<br> 


### DataStream {#DataStream1}

Field | Description
--- | ---
database | **string**<br>Required. Stream database. example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6******** 
stream_name | **string**<br>Required. Stream name, absolute or relative. 
consumer | **string**<br>Required. Consumer name. 
service_account_id | **string**<br>Required. Service account which has read permission on the stream. 


### MessageQueue {#MessageQueue1}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test 
service_account_id | **string**<br>Required. Service account which has read access to the queue. The maximum string length in characters is 50.
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
batch_size | **int64**<br>Batch size for polling. The maximum value is 10.
polling_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue polling timeout. The maximum value is 20s.


## Create {#Create}

Creates a connector in the specified folder.

**rpc Create ([CreateConnectorRequest](#CreateConnectorRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateConnectorMetadata](#CreateConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector2)<br>

### CreateConnectorRequest {#CreateConnectorRequest}

Field | Description
--- | ---
bus_id | **string**<br>Required. ID of the bus to create a connector in. 
name | **string**<br>Name of the connector. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the connector. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Labels for the connector. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
source | **[Source](#Source2)**<br>Source of the connector. 
deletion_protection | **bool**<br>Flag that disallow deletion of the connector. 


### Source {#Source2}

Field | Description
--- | ---
source | **oneof:** `data_stream` or `message_queue`<br>
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream2)**<br> 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue2)**<br> 


### DataStream {#DataStream2}

Field | Description
--- | ---
database | **string**<br>Required. Stream database. example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6******** 
stream_name | **string**<br>Required. Stream name, absolute or relative. 
consumer | **string**<br>Required. Consumer name. 
service_account_id | **string**<br>Required. Service account which has read permission on the stream. 


### MessageQueue {#MessageQueue2}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test 
service_account_id | **string**<br>Required. Service account which has read access to the queue. The maximum string length in characters is 50.
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
batch_size | **int64**<br>Batch size for polling. The maximum value is 10.
polling_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue polling timeout. The maximum value is 20s.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateConnectorMetadata](#CreateConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Connector](#Connector2)>**<br>if operation finished successfully. 


### CreateConnectorMetadata {#CreateConnectorMetadata}

Field | Description
--- | ---
connector_id | **string**<br>ID of the connector that is being created. 
bus_id | **string**<br>ID of the bus that the connector is created in. 


### Connector {#Connector2}

Field | Description
--- | ---
id | **string**<br>ID of the connector. 
bus_id | **string**<br>ID of the bus that the connector belongs to. 
folder_id | **string**<br>ID of the folder that the connector resides in. 
cloud_id | **string**<br>ID of the cloud that the connector resides in. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the connector. 
description | **string**<br>Description of the connector. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
source | **[Source](#Source3)**<br>Source of the connector. 
deletion_protection | **bool**<br>Deletion protection. 
status | enum **Status**<br>Status of the connector. <ul><li>`STOPPED`: disabled by user</li><li>`RESOURCE_NOT_FOUND`: source does not exist</li><li>`PERMISSION_DENIED`: service account does not have read permission on source</li><li>`SUBJECT_NOT_FOUND`: service account not found</li></ul>


## Update {#Update}

Updates the specified connector.

**rpc Update ([UpdateConnectorRequest](#UpdateConnectorRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateConnectorMetadata](#UpdateConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Connector](#Connector3)<br>

### UpdateConnectorRequest {#UpdateConnectorRequest}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the connector are going to be updated. 
name | **string**<br>New name of the connector. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description of the connector. The maximum string length in characters is 256.
labels | **map<string,string>**<br>New labels of the connector. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
deletion_protection | **bool**<br>New flag that disallow deletion of the connector. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateConnectorMetadata](#UpdateConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Connector](#Connector3)>**<br>if operation finished successfully. 


### UpdateConnectorMetadata {#UpdateConnectorMetadata}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector that is being updated. 


### Connector {#Connector3}

Field | Description
--- | ---
id | **string**<br>ID of the connector. 
bus_id | **string**<br>ID of the bus that the connector belongs to. 
folder_id | **string**<br>ID of the folder that the connector resides in. 
cloud_id | **string**<br>ID of the cloud that the connector resides in. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the connector. 
description | **string**<br>Description of the connector. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
source | **[Source](#Source3)**<br>Source of the connector. 
deletion_protection | **bool**<br>Deletion protection. 
status | enum **Status**<br>Status of the connector. <ul><li>`STOPPED`: disabled by user</li><li>`RESOURCE_NOT_FOUND`: source does not exist</li><li>`PERMISSION_DENIED`: service account does not have read permission on source</li><li>`SUBJECT_NOT_FOUND`: service account not found</li></ul>


### Source {#Source3}

Field | Description
--- | ---
source | **oneof:** `data_stream` or `message_queue`<br>
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream3)**<br> 
&nbsp;&nbsp;message_queue | **[MessageQueue](#MessageQueue3)**<br> 


### DataStream {#DataStream3}

Field | Description
--- | ---
database | **string**<br>Required. Stream database. example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6******** 
stream_name | **string**<br>Required. Stream name, absolute or relative. 
consumer | **string**<br>Required. Consumer name. 
service_account_id | **string**<br>Required. Service account which has read permission on the stream. 


### MessageQueue {#MessageQueue3}

Field | Description
--- | ---
queue_arn | **string**<br>Required. Queue ARN. Example: yrn:yc:ymq:ru-central1:aoe***:test 
service_account_id | **string**<br>Required. Service account which has read access to the queue. The maximum string length in characters is 50.
visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue visibility timeout override. The maximum value is 12h.
batch_size | **int64**<br>Batch size for polling. The maximum value is 10.
polling_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Queue polling timeout. The maximum value is 20s.


## Delete {#Delete}

Deletes the specified connector.

**rpc Delete ([DeleteConnectorRequest](#DeleteConnectorRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteConnectorMetadata](#DeleteConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteConnectorRequest {#DeleteConnectorRequest}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector to delete. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteConnectorMetadata](#DeleteConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteConnectorMetadata {#DeleteConnectorMetadata}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector that is being deleted. 


## Start {#Start}

Starts the specified connector.

**rpc Start ([StartConnectorRequest](#StartConnectorRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartConnectorMetadata](#StartConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StartConnectorRequest {#StartConnectorRequest}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector to start. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartConnectorMetadata](#StartConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StartConnectorMetadata {#StartConnectorMetadata}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector that is being started. 


## Stop {#Stop}

Stops the specified connector.

**rpc Stop ([StopConnectorRequest](#StopConnectorRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopConnectorMetadata](#StopConnectorMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### StopConnectorRequest {#StopConnectorRequest}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector to stop. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopConnectorMetadata](#StopConnectorMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### StopConnectorMetadata {#StopConnectorMetadata}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector that is being stopped. 


## ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified bus.

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

Sets access bindings for the connector.

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

Updates access bindings for the specified connector.

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

Lists operations for the specified connector.

**rpc ListOperations ([ListConnectorOperationsRequest](#ListConnectorOperationsRequest)) returns ([ListConnectorOperationsResponse](#ListConnectorOperationsResponse))**

### ListConnectorOperationsRequest {#ListConnectorOperationsRequest}

Field | Description
--- | ---
connector_id | **string**<br>Required. ID of the connector to list operations for. 
page_size | **int64**<br>The maximum number of results per response. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the `next_page_token` returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>Supported attributes for filter: description created_at modified_at created_by done The maximum string length in characters is 1000.


### ListConnectorOperationsResponse {#ListConnectorOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>List of operations for the specified connector. 
next_page_token | **string**<br>Token for getting the next page of the list of results. 


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


