---
editable: false
---

# TransferService



| Call | Description |
| --- | --- |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [Get](#Get) |  |
| [Deactivate](#Deactivate) |  |
| [Activate](#Activate) |  |

## Calls TransferService {#calls}

## Create {#Create}



**rpc Create ([CreateTransferRequest](#CreateTransferRequest)) returns ([operation.Operation](#Operation))**

### CreateTransferRequest {#CreateTransferRequest}

Field | Description
--- | ---
source_id | **string**<br> 
target_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
folder_id | **string**<br> 
type | enum **TransferType**<br> <ul><ul/>


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


## Update {#Update}



**rpc Update ([UpdateTransferRequest](#UpdateTransferRequest)) returns ([operation.Operation](#Operation1))**

### UpdateTransferRequest {#UpdateTransferRequest}

Field | Description
--- | ---
transfer_id | **string**<br> 
description | **string**<br> 
name | **string**<br> 


### Operation {#Operation1}

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


## Delete {#Delete}



**rpc Delete ([DeleteTransferRequest](#DeleteTransferRequest)) returns ([operation.Operation](#Operation2))**

### DeleteTransferRequest {#DeleteTransferRequest}

Field | Description
--- | ---
transfer_id | **string**<br> 


### Operation {#Operation2}

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


## Get {#Get}



**rpc Get ([GetTransferRequest](#GetTransferRequest)) returns ([Transfer](#Transfer))**

### GetTransferRequest {#GetTransferRequest}

Field | Description
--- | ---
transfer_id | **string**<br> 


### Transfer {#Transfer}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
source | **[Endpoint](#Endpoint)**<br> 
target | **[Endpoint](#Endpoint)**<br> 
status | enum **TransferStatus**<br> <ul><ul/>
type | enum **TransferType**<br> <ul><ul/>
warning | **string**<br> 


### Endpoint {#Endpoint}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
settings | **[EndpointSettings](#EndpointSettings)**<br> 


### EndpointSettings {#EndpointSettings}

Field | Description
--- | ---
settings | **oneof:** `mysql_source`, `postgres_source`, `mysql_target` or `postgres_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./endpoint/common#MysqlSource)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./endpoint/common#PostgresSource)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./endpoint/common#MysqlTarget)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./endpoint/common#PostgresTarget)**<br> 


### MysqlSource {#MysqlSource}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret)**<br> 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br> 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings)**<br> 


### MysqlConnection {#MysqlConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql)**<br> 


### OnPremiseMysql {#OnPremiseMysql}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig)**<br> 


### TLSConfig {#TLSConfig}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br> <ul><ul/>
routine | enum **ObjectTransferStage**<br> <ul><ul/>
trigger | enum **ObjectTransferStage**<br> <ul><ul/>


### PostgresSource {#PostgresSource}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret1)**<br> 
include_tables[] | **string**<br> 
exclude_tables[] | **string**<br> 
slot_byte_lag_limit | **int64**<br> 
service_schema | **string**<br> 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings)**<br> 


### PostgresConnection {#PostgresConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres)**<br> 


### OnPremisePostgres {#OnPremisePostgres}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode1)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode1}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig1)**<br> 


### TLSConfig {#TLSConfig1}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret1}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br> <ul><ul/>
sequence_owned_by | enum **ObjectTransferStage**<br> <ul><ul/>
table | enum **ObjectTransferStage**<br> <ul><ul/>
primary_key | enum **ObjectTransferStage**<br> <ul><ul/>
fk_constraint | enum **ObjectTransferStage**<br> <ul><ul/>
default_values | enum **ObjectTransferStage**<br> <ul><ul/>
constraint | enum **ObjectTransferStage**<br> <ul><ul/>
index | enum **ObjectTransferStage**<br> <ul><ul/>
view | enum **ObjectTransferStage**<br> <ul><ul/>
function | enum **ObjectTransferStage**<br> <ul><ul/>
trigger | enum **ObjectTransferStage**<br> <ul><ul/>
type | enum **ObjectTransferStage**<br> <ul><ul/>
rule | enum **ObjectTransferStage**<br> <ul><ul/>
collation | enum **ObjectTransferStage**<br> <ul><ul/>
policy | enum **ObjectTransferStage**<br> <ul><ul/>
cast | enum **ObjectTransferStage**<br> <ul><ul/>


### MysqlTarget {#MysqlTarget}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection1)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret2)**<br> 
sql_mode | **string**<br> 
skip_constraint_checks | **bool**<br> 
timezone | **string**<br> 


### MysqlConnection {#MysqlConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql1)**<br> 


### OnPremiseMysql {#OnPremiseMysql1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode2)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode2}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig2)**<br> 


### TLSConfig {#TLSConfig2}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret2}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### PostgresTarget {#PostgresTarget}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection1)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret3)**<br> 


### PostgresConnection {#PostgresConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres1)**<br> 


### OnPremisePostgres {#OnPremisePostgres1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode3)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode3}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig3)**<br> 


### TLSConfig {#TLSConfig3}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret3}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


## Deactivate {#Deactivate}



**rpc Deactivate ([DeactivateTransferRequest](#DeactivateTransferRequest)) returns ([operation.Operation](#Operation3))**

### DeactivateTransferRequest {#DeactivateTransferRequest}

Field | Description
--- | ---
transfer_id | **string**<br> 


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


## Activate {#Activate}



**rpc Activate ([ActivateTransferRequest](#ActivateTransferRequest)) returns ([operation.Operation](#Operation4))**

### ActivateTransferRequest {#ActivateTransferRequest}

Field | Description
--- | ---
transfer_id | **string**<br> 


### Operation {#Operation4}

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


