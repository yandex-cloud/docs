---
editable: false
sourcePath: en/_api-ref-grpc/datatransfer/api-ref/grpc/transfer_service.md
---


# TransferService



| Call | Description |
| --- | --- |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |
| [List](#List) |  |
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
labels | **map<string,string>**<br> 
folder_id | **string**<br> 
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li><ul/>


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
transfer_id | **string**<br>Identifier of the transfer to be updated. 
description | **string**<br>The new description for the transfer. 
labels | **map<string,string>**<br> 
name | **string**<br>The new transfer name. Must be unique within the folder. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask specifying transfer fields to be updated. Semantics for this field is described here: https://pkg.go.dev/google.golang.org/protobuf/types/known/fieldmaskpb#FieldMask The only exception is that if the repeated field is specified in the mask, then the new value replaces the old one instead of being appended to the old one. 


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


## List {#List}



**rpc List ([ListTransfersRequest](#ListTransfersRequest)) returns ([ListTransfersResponse](#ListTransfersResponse))**

### ListTransfersRequest {#ListTransfersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Identifier of the folder containing the transfers to be listed. 
page_size | **int64**<br>The maximum number of transfers to be sent in the response message. If the folder contains more transfers than page_size, next_page_token will be included in the response message. Include it into the subsequent ListTransfersRequest to fetch the next page. Defaults to 100 if not specified. The maximum allowed value for this field is 500. 
page_token | **string**<br>Opaque value identifying the transfers page to be fetched. Should be empty in the first ListTransfersRequest. Subsequent request should have this field filled with the next_page_token from the previous ListTransfersResponse. 


### ListTransfersResponse {#ListTransfersResponse}

Field | Description
--- | ---
transfers[] | **[Transfer](#Transfer)**<br>The list of transfers. If there are more transfers in the folder, then next_page_token is a non-empty string to be included into the subsequent ListTransfersRequest to fetch the next transfers page. 
next_page_token | **string**<br>Opaque value identifying the next transfers page. This field is empty if there are no more transfers in the folder. Otherwise it is non-empty and should be included in the subsequent ListTransfersRequest to fetch the next transfers page. 


### Transfer {#Transfer}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
source | **[Endpoint](#Endpoint)**<br> 
target | **[Endpoint](#Endpoint)**<br> 
status | enum **TransferStatus**<br> <ul><ul/>
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li><ul/>
warning | **string**<br> 


### Endpoint {#Endpoint}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
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
connection | **[MysqlConnection](#MysqlConnection)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret)**<br>Password <br>Password for database access. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### MysqlConnection {#MysqlConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig)**<br> 


### TLSConfig {#TLSConfig}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
routine | enum **ObjectTransferStage**<br>Routines <br>CREATE PROCEDURE ...; CREATE FUNCTION ...; <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>


### PostgresSource {#PostgresSource}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret1)**<br>Password <br>Password for database access. 
include_tables[] | **string**<br><ul><li>patterns.</li></ul> 
exclude_tables[] | **string**<br><ul><li>patterns.</li></ul> 
slot_byte_lag_limit | **int64**<br>Maximum WAL size for the replication slot <br>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default. 
service_schema | **string**<br>Database schema for service table <br>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder). 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### PostgresConnection {#PostgresConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode1)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode1}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig1)**<br> 


### TLSConfig {#TLSConfig1}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret1}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><ul/>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><ul/>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><ul/>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><ul/>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><ul/>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><ul/>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><ul/>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><ul/>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><ul/>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><ul/>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><ul/>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><ul/>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><ul/>


### MysqlTarget {#MysqlTarget}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection1)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret2)**<br>Password <br>Password for database access. 
sql_mode | **string**<br>sql_mode <br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy <br>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED. <ul><ul/>
service_database | **string**<br>Database schema for service table <br>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 


### MysqlConnection {#MysqlConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql1)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode2)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode2}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig2)**<br> 


### TLSConfig {#TLSConfig2}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret2}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresTarget {#PostgresTarget}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection1)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret3)**<br>Password <br>Password for database access. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy <br>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED. <ul><ul/>


### PostgresConnection {#PostgresConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres1)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode3)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode3}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig3)**<br> 


### TLSConfig {#TLSConfig3}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret3}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


## Get {#Get}



**rpc Get ([GetTransferRequest](#GetTransferRequest)) returns ([Transfer](#Transfer1))**

### GetTransferRequest {#GetTransferRequest}

Field | Description
--- | ---
transfer_id | **string**<br> 


### Transfer {#Transfer1}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
source | **[Endpoint](#Endpoint1)**<br> 
target | **[Endpoint](#Endpoint1)**<br> 
status | enum **TransferStatus**<br> <ul><ul/>
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li><ul/>
warning | **string**<br> 


### Endpoint {#Endpoint1}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
settings | **[EndpointSettings](#EndpointSettings1)**<br> 


### EndpointSettings {#EndpointSettings1}

Field | Description
--- | ---
settings | **oneof:** `mysql_source`, `postgres_source`, `mysql_target` or `postgres_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](./endpoint/common#MysqlSource)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](./endpoint/common#PostgresSource)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](./endpoint/common#MysqlTarget)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](./endpoint/common#PostgresTarget)**<br> 


### MysqlSource {#MysqlSource1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection2)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret4)**<br>Password <br>Password for database access. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings1)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### MysqlConnection {#MysqlConnection2}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql2)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql2}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode4)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode4}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig4)**<br> 


### TLSConfig {#TLSConfig4}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret4}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings1}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
routine | enum **ObjectTransferStage**<br>Routines <br>CREATE PROCEDURE ...; CREATE FUNCTION ...; <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>


### PostgresSource {#PostgresSource1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection2)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret5)**<br>Password <br>Password for database access. 
include_tables[] | **string**<br><ul><li>patterns.</li></ul> 
exclude_tables[] | **string**<br><ul><li>patterns.</li></ul> 
slot_byte_lag_limit | **int64**<br>Maximum WAL size for the replication slot <br>Maximum WAL size held by the replication slot. Exceeding this limit will result in a replication failure and deletion of the replication slot. Unlimited by default. 
service_schema | **string**<br>Database schema for service table <br>Default: public. Here created technical tables (__consumer_keeper, __data_transfer_mole_finder). 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings1)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### PostgresConnection {#PostgresConnection2}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres2)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres2}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode5)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode5}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig5)**<br> 


### TLSConfig {#TLSConfig5}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret5}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings1}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><ul/>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><ul/>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><ul/>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><ul/>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><ul/>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><ul/>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><ul/>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><ul/>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><ul/>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><ul/>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><ul/>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><ul/>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><ul/>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><ul/>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><ul/>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><ul/>


### MysqlTarget {#MysqlTarget1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection3)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret6)**<br>Password <br>Password for database access. 
sql_mode | **string**<br>sql_mode <br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy <br>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED. <ul><ul/>
service_database | **string**<br>Database schema for service table <br>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 


### MysqlConnection {#MysqlConnection3}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql3)**<br>On-premise <br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql3}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Default: 3306. 
tls_mode | **[TLSMode](#TLSMode6)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode6}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig6)**<br> 


### TLSConfig {#TLSConfig6}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret6}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


### PostgresTarget {#PostgresTarget1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection3)**<br>Connection settings <br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>Username <br>User for database access. 
password | **[Secret](#Secret7)**<br>Password <br>Password for database access. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy <br>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED. <ul><ul/>


### PostgresConnection {#PostgresConnection3}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed cluster <br>Yandex.Cloud Managed PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres3)**<br>On-premise <br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres3}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port <br>Will be used if the cluster ID is not specified. Default: 6432. 
tls_mode | **[TLSMode](#TLSMode7)**<br>TLS mode <br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint <br>Default: public IPv4. 


### TLSMode {#TLSMode7}

Field | Description
--- | ---
tls_mode | **oneof:** `disabled` or `enabled`<br>
&nbsp;&nbsp;disabled | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;enabled | **[TLSConfig](#TLSConfig7)**<br> 


### TLSConfig {#TLSConfig7}

Field | Description
--- | ---
ca_certificate | **string**<br>CA certificate <br>X.509 certificate of the certificate authority which issued the server's certificate, in PEM format. When CA certificate is specified TLS is used to connect to the server. 


### Secret {#Secret7}

Field | Description
--- | ---
value | **oneof:** `raw`<br>
&nbsp;&nbsp;raw | **string**<br>Password 


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


