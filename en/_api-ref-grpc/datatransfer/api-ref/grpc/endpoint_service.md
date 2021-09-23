---
editable: false
---

# EndpointService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |

## Calls EndpointService {#calls}

## Get {#Get}



**rpc Get ([GetEndpointRequest](#GetEndpointRequest)) returns ([Endpoint](#Endpoint))**

### GetEndpointRequest {#GetEndpointRequest}

Field | Description
--- | ---
endpoint_id | **string**<br> 


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
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./#endpoint)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./#endpoint)**<br> 


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


## Create {#Create}



**rpc Create ([CreateEndpointRequest](#CreateEndpointRequest)) returns ([operation.Operation](#Operation))**

### CreateEndpointRequest {#CreateEndpointRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
settings | **[EndpointSettings](#EndpointSettings1)**<br> 


### EndpointSettings {#EndpointSettings1}

Field | Description
--- | ---
settings | **oneof:** `mysql_source`, `postgres_source`, `mysql_target` or `postgres_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./#endpoint)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./#endpoint)**<br> 


### MysqlSource {#MysqlSource1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection2)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret4)**<br> 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br> 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings1)**<br> 


### MysqlConnection {#MysqlConnection2}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql2)**<br> 


### OnPremiseMysql {#OnPremiseMysql2}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode4)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode4}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig4)**<br> 


### TLSConfig {#TLSConfig4}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret4}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings1}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br> <ul><ul/>
routine | enum **ObjectTransferStage**<br> <ul><ul/>
trigger | enum **ObjectTransferStage**<br> <ul><ul/>


### PostgresSource {#PostgresSource1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection2)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret5)**<br> 
include_tables[] | **string**<br> 
exclude_tables[] | **string**<br> 
slot_byte_lag_limit | **int64**<br> 
service_schema | **string**<br> 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings1)**<br> 


### PostgresConnection {#PostgresConnection2}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres2)**<br> 


### OnPremisePostgres {#OnPremisePostgres2}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode5)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode5}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig5)**<br> 


### TLSConfig {#TLSConfig5}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret5}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings1}

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


### MysqlTarget {#MysqlTarget1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection3)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret6)**<br> 
sql_mode | **string**<br> 
skip_constraint_checks | **bool**<br> 
timezone | **string**<br> 


### MysqlConnection {#MysqlConnection3}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql3)**<br> 


### OnPremiseMysql {#OnPremiseMysql3}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode6)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode6}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig6)**<br> 


### TLSConfig {#TLSConfig6}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret6}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### PostgresTarget {#PostgresTarget1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection3)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret7)**<br> 


### PostgresConnection {#PostgresConnection3}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres3)**<br> 


### OnPremisePostgres {#OnPremisePostgres3}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode7)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode7}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig7)**<br> 


### TLSConfig {#TLSConfig7}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret7}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


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



**rpc Update ([UpdateEndpointRequest](#UpdateEndpointRequest)) returns ([operation.Operation](#Operation1))**

### UpdateEndpointRequest {#UpdateEndpointRequest}

Field | Description
--- | ---
endpoint_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
settings | **[EndpointSettings](#EndpointSettings2)**<br> 


### EndpointSettings {#EndpointSettings2}

Field | Description
--- | ---
settings | **oneof:** `mysql_source`, `postgres_source`, `mysql_target` or `postgres_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./#endpoint)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./#endpoint)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./#endpoint)**<br> 


### MysqlSource {#MysqlSource2}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection4)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret8)**<br> 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br> 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings2)**<br> 


### MysqlConnection {#MysqlConnection4}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql4)**<br> 


### OnPremiseMysql {#OnPremiseMysql4}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode8)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode8}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig8)**<br> 


### TLSConfig {#TLSConfig8}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret8}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings2}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br> <ul><ul/>
routine | enum **ObjectTransferStage**<br> <ul><ul/>
trigger | enum **ObjectTransferStage**<br> <ul><ul/>


### PostgresSource {#PostgresSource2}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection4)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret9)**<br> 
include_tables[] | **string**<br> 
exclude_tables[] | **string**<br> 
slot_byte_lag_limit | **int64**<br> 
service_schema | **string**<br> 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings2)**<br> 


### PostgresConnection {#PostgresConnection4}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres4)**<br> 


### OnPremisePostgres {#OnPremisePostgres4}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode9)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode9}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig9)**<br> 


### TLSConfig {#TLSConfig9}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret9}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings2}

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


### MysqlTarget {#MysqlTarget2}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection5)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret10)**<br> 
sql_mode | **string**<br> 
skip_constraint_checks | **bool**<br> 
timezone | **string**<br> 


### MysqlConnection {#MysqlConnection5}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql5)**<br> 


### OnPremiseMysql {#OnPremiseMysql5}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode10)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode10}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig10)**<br> 


### TLSConfig {#TLSConfig10}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret10}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


### PostgresTarget {#PostgresTarget2}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection5)**<br> 
database | **string**<br> 
user | **string**<br> 
password | **[Secret](#Secret11)**<br> 


### PostgresConnection {#PostgresConnection5}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres5)**<br> 


### OnPremisePostgres {#OnPremisePostgres5}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode11)**<br> 
subnet_id | **string**<br> 


### TLSMode {#TLSMode11}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig11)**<br> 


### TLSConfig {#TLSConfig11}

Field | Description
--- | ---
ca_certificate | **string**<br> 


### Secret {#Secret11}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br> 


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



**rpc Delete ([DeleteEndpointRequest](#DeleteEndpointRequest)) returns ([operation.Operation](#Operation2))**

### DeleteEndpointRequest {#DeleteEndpointRequest}

Field | Description
--- | ---
endpoint_id | **string**<br> 


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


