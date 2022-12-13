---
editable: false
---

# MDB Proxy Service, gRPC: ProxyService

A set of methods for managing serverless MDB proxy.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified proxy. |
| [List](#List) | Retrieves the list of proxies in the specified folder. |
| [Create](#Create) | Creates a proxy in the specified folder. |
| [Update](#Update) | Updates the specified proxy. |
| [Delete](#Delete) | Deletes the specified proxy. |
| [ListOperations](#ListOperations) | Lists operations for the specified proxy. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified proxy. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the proxy. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified proxy. |

## Calls ProxyService {#calls}

## Get {#Get}

Returns the specified proxy. <br>To get the list of all available proxies, make a [List](#List) request.

**rpc Get ([GetProxyRequest](#GetProxyRequest)) returns ([Proxy](#Proxy))**

### GetProxyRequest {#GetProxyRequest}

Field | Description
--- | ---
proxy_id | **string**<br>Required. ID of the proxy to return. <br>To get a proxy ID make a [ProxyService.List](#List) request. The maximum string length in characters is 50.


### Proxy {#Proxy}

Field | Description
--- | ---
id | **string**<br>ID of the proxy. 
folder_id | **string**<br>Required. ID of the folder that the proxy belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the proxy. 
name | **string**<br>Required. Name of the proxy. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the proxy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
target | **[Target](#Target)**<br>MDB specific settings. 


### Target {#Target}

Field | Description
--- | ---
mdb | **oneof:** `clickhouse` or `postgresql`<br>
&nbsp;&nbsp;clickhouse | **[ClickHouse](#ClickHouse)**<br>Clickhouse settings for proxy. 
&nbsp;&nbsp;postgresql | **[PostgreSQL](#PostgreSQL)**<br>PostgreSQL settings for proxy. 


### PostgreSQL {#PostgreSQL}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Cluster identifier for postgresql. The maximum string length in characters is 50.
user | **string**<br>Required. PostgreSQL user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
password | **string**<br>PostgreSQL password, input only field. 
db | **string**<br>Required. PostgreSQL database name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
endpoint | **string**<br>PostgreSQL proxy-host for connection, output only field. 


### ClickHouse {#ClickHouse}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Cluster identifier for clickhouse. The maximum string length in characters is 50.
user | **string**<br>Required. Clickhouse user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Clickhouse password, input only field. 
db | **string**<br>Required. Clickhouse database name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
endpoint | **string**<br>Clickhouse proxy-host for connection, output only field. 


## List {#List}

Retrieves the list of proxies in the specified folder.

**rpc List ([ListProxyRequest](#ListProxyRequest)) returns ([ListProxyResponse](#ListProxyResponse))**

### ListProxyRequest {#ListProxyRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list proxies in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListProxyResponse.next_page_token](#ListProxyResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListProxyResponse.next_page_token](#ListProxyResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters proxies listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [Proxy.name](#Proxy1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-proxy`. The maximum string length in characters is 1000.


### ListProxyResponse {#ListProxyResponse}

Field | Description
--- | ---
proxies[] | **[Proxy](#Proxy1)**<br>List of proxies in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListProxyRequest.page_size](#ListProxyRequest), use `nextPageToken` as the value for the [ListProxyRequest.page_token](#ListProxyRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. The maximum string length in characters is 100.


### Proxy {#Proxy1}

Field | Description
--- | ---
id | **string**<br>ID of the proxy. 
folder_id | **string**<br>Required. ID of the folder that the proxy belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the proxy. 
name | **string**<br>Required. Name of the proxy. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the proxy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
target | **[Target](#Target1)**<br>MDB specific settings. 


### Target {#Target1}

Field | Description
--- | ---
mdb | **oneof:** `clickhouse` or `postgresql`<br>
&nbsp;&nbsp;clickhouse | **[ClickHouse](#ClickHouse1)**<br>Clickhouse settings for proxy. 
&nbsp;&nbsp;postgresql | **[PostgreSQL](#PostgreSQL1)**<br>PostgreSQL settings for proxy. 


### PostgreSQL {#PostgreSQL1}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Cluster identifier for postgresql. The maximum string length in characters is 50.
user | **string**<br>Required. PostgreSQL user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
password | **string**<br>PostgreSQL password, input only field. 
db | **string**<br>Required. PostgreSQL database name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
endpoint | **string**<br>PostgreSQL proxy-host for connection, output only field. 


### ClickHouse {#ClickHouse1}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Cluster identifier for clickhouse. The maximum string length in characters is 50.
user | **string**<br>Required. Clickhouse user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Clickhouse password, input only field. 
db | **string**<br>Required. Clickhouse database name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
endpoint | **string**<br>Clickhouse proxy-host for connection, output only field. 


## Create {#Create}

Creates a proxy in the specified folder.

**rpc Create ([CreateProxyRequest](#CreateProxyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateProxyMetadata](#CreateProxyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Proxy](#Proxy2)<br>

### CreateProxyRequest {#CreateProxyRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a proxy in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the proxy. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the proxy. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
target | **[Target](#Target2)**<br>Required. Proxy target. 


### Target {#Target2}

Field | Description
--- | ---
mdb | **oneof:** `clickhouse` or `postgresql`<br>
&nbsp;&nbsp;clickhouse | **[ClickHouse](#ClickHouse2)**<br>Clickhouse settings for proxy. 
&nbsp;&nbsp;postgresql | **[PostgreSQL](#PostgreSQL2)**<br>PostgreSQL settings for proxy. 


### PostgreSQL {#PostgreSQL2}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Cluster identifier for postgresql. The maximum string length in characters is 50.
user | **string**<br>Required. PostgreSQL user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
password | **string**<br>PostgreSQL password, input only field. 
db | **string**<br>Required. PostgreSQL database name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
endpoint | **string**<br>PostgreSQL proxy-host for connection, output only field. 


### ClickHouse {#ClickHouse2}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Cluster identifier for clickhouse. The maximum string length in characters is 50.
user | **string**<br>Required. Clickhouse user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Clickhouse password, input only field. 
db | **string**<br>Required. Clickhouse database name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
endpoint | **string**<br>Clickhouse proxy-host for connection, output only field. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateProxyMetadata](#CreateProxyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Proxy](#Proxy2)>**<br>if operation finished successfully. 


### CreateProxyMetadata {#CreateProxyMetadata}

Field | Description
--- | ---
proxy_id | **string**<br>ID of the proxy. The maximum string length in characters is 50.


### Proxy {#Proxy2}

Field | Description
--- | ---
id | **string**<br>ID of the proxy. 
folder_id | **string**<br>Required. ID of the folder that the proxy belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the proxy. 
name | **string**<br>Required. Name of the proxy. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the proxy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
target | **[Target](#Target3)**<br>MDB specific settings. 


## Update {#Update}

Updates the specified proxy.

**rpc Update ([UpdateProxyRequest](#UpdateProxyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateProxyMetadata](#UpdateProxyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Proxy](#Proxy3)<br>

### UpdateProxyRequest {#UpdateProxyRequest}

Field | Description
--- | ---
proxy_id | **string**<br>Required. ID of the proxy to update. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the proxy should be updated. 
name | **string**<br>New name for the proxy. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>New description for the proxy. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Proxy labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
target | **[Target](#Target3)**<br>Proxy target. 


### Target {#Target3}

Field | Description
--- | ---
mdb | **oneof:** `clickhouse` or `postgresql`<br>
&nbsp;&nbsp;clickhouse | **[ClickHouse](#ClickHouse3)**<br>Clickhouse settings for proxy. 
&nbsp;&nbsp;postgresql | **[PostgreSQL](#PostgreSQL3)**<br>PostgreSQL settings for proxy. 


### PostgreSQL {#PostgreSQL3}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Cluster identifier for postgresql. The maximum string length in characters is 50.
user | **string**<br>Required. PostgreSQL user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
password | **string**<br>PostgreSQL password, input only field. 
db | **string**<br>Required. PostgreSQL database name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
endpoint | **string**<br>PostgreSQL proxy-host for connection, output only field. 


### ClickHouse {#ClickHouse3}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Cluster identifier for clickhouse. The maximum string length in characters is 50.
user | **string**<br>Required. Clickhouse user. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Clickhouse password, input only field. 
db | **string**<br>Required. Clickhouse database name. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
endpoint | **string**<br>Clickhouse proxy-host for connection, output only field. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateProxyMetadata](#UpdateProxyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Proxy](#Proxy3)>**<br>if operation finished successfully. 


### UpdateProxyMetadata {#UpdateProxyMetadata}

Field | Description
--- | ---
proxy_id | **string**<br>Required. ID of the proxy. The maximum string length in characters is 50.


### Proxy {#Proxy3}

Field | Description
--- | ---
id | **string**<br>ID of the proxy. 
folder_id | **string**<br>Required. ID of the folder that the proxy belongs to. The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the proxy. 
name | **string**<br>Required. Name of the proxy. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the proxy. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
target | **[Target](#Target4)**<br>MDB specific settings. 


## Delete {#Delete}

Deletes the specified proxy.

**rpc Delete ([DeleteProxyRequest](#DeleteProxyRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteProxyMetadata](#DeleteProxyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteProxyRequest {#DeleteProxyRequest}

Field | Description
--- | ---
proxy_id | **string**<br>Required. ID of the proxy. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteProxyMetadata](#DeleteProxyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteProxyMetadata {#DeleteProxyMetadata}

Field | Description
--- | ---
proxy_id | **string**<br>Required. ID of the proxy. The maximum string length in characters is 50.


## ListOperations {#ListOperations}

Lists operations for the specified proxy.

**rpc ListOperations ([ListProxyOperationsRequest](#ListProxyOperationsRequest)) returns ([ListProxyOperationsResponse](#ListProxyOperationsResponse))**

### ListProxyOperationsRequest {#ListProxyOperationsRequest}

Field | Description
--- | ---
proxy_id | **string**<br>Required. ID of the proxy to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListProxyOperationsResponse.next_page_token](#ListProxyOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListProxyOperationsResponse.next_page_token](#ListProxyOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [operation.Operation.done](#Operation3), [operation.Operation.created_by](#Operation3) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `done=false`, `created_by='John.Doe'`. The maximum string length in characters is 1000.


### ListProxyOperationsResponse {#ListProxyOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified proxy. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListProxyOperationsRequest.page_size](#ListProxyOperationsRequest), use `nextPageToken` as the value for the [ListProxyOperationsRequest.page_token](#ListProxyOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Operation {#Operation3}

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


## ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified proxy.

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

Sets access bindings for the proxy.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation4))**

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


### Operation {#Operation4}

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

Updates access bindings for the specified proxy.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

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


### Operation {#Operation5}

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


