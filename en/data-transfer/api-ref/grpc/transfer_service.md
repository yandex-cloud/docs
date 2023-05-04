---
editable: false
sourcePath: en/_api-ref-grpc/datatransfer/api-ref/grpc/transfer_service.md
---

# Data Transfer API, gRPC: TransferService



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
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li></ul>


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
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask specifying transfer fields to be updated. Semantics for this field is described here: <https://pkg.go.dev/google.golang.org/protobuf/types/known/fieldmaskpb#FieldMask> The only exception: if the repeated field is specified in the mask, then the new value replaces the old one instead of being appended to the old one. 


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
page_size | **int64**<br>The maximum number of transfers to be sent in the response message. If the folder contains more transfers than `page_size`, `next_page_token` will be included in the response message. Include it into the subsequent `ListTransfersRequest` to fetch the next page. Defaults to `100` if not specified. The maximum allowed value for this field is `500`. 
page_token | **string**<br>Opaque value identifying the transfers page to be fetched. Should be empty in the first `ListTransfersRequest`. Subsequent requests should have this field filled with the `next_page_token` from the previous `ListTransfersResponse`. 


### ListTransfersResponse {#ListTransfersResponse}

Field | Description
--- | ---
transfers[] | **[Transfer](#Transfer)**<br>The list of transfers. If there are more transfers in the folder, then `next_page_token` is a non-empty string to be included into the subsequent `ListTransfersRequest` to fetch the next transfers page. 
next_page_token | **string**<br>Opaque value identifying the next transfers page. This field is empty if there are no more transfers in the folder. Otherwise it is non-empty and should be included in the subsequent `ListTransfersRequest` to fetch the next transfers page. 


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
status | enum **TransferStatus**<br> <ul><li>`CREATING`: Transfer does some work before running</li><li>`CREATED`: Transfer created but not started by user</li><li>`RUNNING`: Transfer currently doing replication work</li><li>`STOPPING`: Transfer shutdown</li><li>`STOPPED`: Transfer stopped by user</li><li>`ERROR`: Transfer stopped by system</li><li>`SNAPSHOTTING`: Transfer copy snapshot</li><li>`DONE`: Transfer reach terminal phase</li></ul>
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li></ul>
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
settings | **oneof:** `mysql_source`, `postgres_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `kafka_target` or `mongo_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](#MysqlSource)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](#PostgresSource)**<br> 
&nbsp;&nbsp;kafka_source | **[endpoint.KafkaSource](#KafkaSource)**<br> 
&nbsp;&nbsp;mongo_source | **[endpoint.MongoSource](#MongoSource)**<br> 
&nbsp;&nbsp;clickhouse_source | **[endpoint.ClickhouseSource](#ClickhouseSource)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](#MysqlTarget)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](#PostgresTarget)**<br> 
&nbsp;&nbsp;clickhouse_target | **[endpoint.ClickhouseTarget](#ClickhouseTarget)**<br> 
&nbsp;&nbsp;kafka_target | **[endpoint.KafkaTarget](#KafkaTarget)**<br> 
&nbsp;&nbsp;mongo_target | **[endpoint.MongoTarget](#MongoTarget)**<br> 


### MysqlSource {#MysqlSource}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection)**<br>Database connection settings 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
service_database | **string**<br>Database for service tables <br>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 
user | **string**<br>User for database access. 
password | **[Secret](#Secret)**<br>Password for database access. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### MysqlConnection {#MysqlConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed Service for MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql)**<br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port 
tls_mode | **[TLSMode](#TLSMode)**<br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 


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
&nbsp;&nbsp;raw | **string**<br>Raw secret value 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
routine | enum **ObjectTransferStage**<br>Routines <br>CREATE PROCEDURE ...; CREATE FUNCTION ...; <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
tables | enum **ObjectTransferStage**<br> <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>


### PostgresSource {#PostgresSource}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection)**<br>Database connection settings 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name 
user | **string**<br>User for database access. 
password | **[Secret](#Secret1)**<br>Password for database access. 
include_tables[] | **string**<br>Included tables <br>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns. 
exclude_tables[] | **string**<br>Excluded tables <br>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns. 
slot_byte_lag_limit | **int64**<br>Maximum lag of replication slot (in bytes); after exceeding this limit replication will be aborted. 
service_schema | **string**<br>Database schema for service tables (__consumer_keeper, __data_transfer_mole_finder). Default is public 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings)**<br>Select database objects to be transferred during activation or deactivation. 


### PostgresConnection {#PostgresConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed Service for PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres)**<br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Will be used if the cluster ID is not specified. 
tls_mode | **[TLSMode](#TLSMode1)**<br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
sequence_set | enum **ObjectTransferStage**<br> <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
materialized_view | enum **ObjectTransferStage**<br>Materialized views <br>CREATE MATERIALIZED VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>


### KafkaSource {#KafkaSource}

Field | Description
--- | ---
connection | **[KafkaConnectionOptions](#KafkaConnectionOptions)**<br>Connection settings 
auth | **[KafkaAuth](#KafkaAuth)**<br>Authentication settings 
security_groups[] | **string**<br>Security groups 
topic_name | **string**<br>Full source topic name 
transformer | **[DataTransformationOptions](#DataTransformationOptions)**<br>Data transformation rules 
parser | **[Parser](#Parser)**<br>Data parsing rules 


### KafkaConnectionOptions {#KafkaConnectionOptions}

Field | Description
--- | ---
connection | **oneof:** `cluster_id` or `on_premise`<br>
&nbsp;&nbsp;cluster_id | **string**<br>Managed Service for Kafka cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseKafka](#OnPremiseKafka)**<br>Connection options for on-premise Kafka 


### OnPremiseKafka {#OnPremiseKafka}

Field | Description
--- | ---
broker_urls[] | **string**<br>Kafka broker URLs 
tls_mode | **[TLSMode](#TLSMode1)**<br>TLS settings for broker connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 


### KafkaAuth {#KafkaAuth}

Field | Description
--- | ---
security | **oneof:** `sasl` or `no_auth`<br>
&nbsp;&nbsp;sasl | **[KafkaSaslSecurity](#KafkaSaslSecurity)**<br>Authentication with SASL 
&nbsp;&nbsp;no_auth | **[NoAuth](#NoAuth)**<br>No authentication 


### KafkaSaslSecurity {#KafkaSaslSecurity}

Field | Description
--- | ---
user | **string**<br>User name 
password | **[Secret](#Secret1)**<br>Password for user 
mechanism | enum **KafkaMechanism**<br>SASL mechanism for authentication 


### NoAuth {#NoAuth}

Empty

### DataTransformationOptions {#DataTransformationOptions}

Field | Description
--- | ---
cloud_function | **string**<br>Cloud function 
service_account_id | **string**<br>Service account 
number_of_retries | **int64**<br>Number of retries 
buffer_size | **string**<br>Buffer size for function 
buffer_flush_interval | **string**<br>Flush interval 
invocation_timeout | **string**<br>Invocation timeout 


### Parser {#Parser}

Field | Description
--- | ---
parser | **oneof:** `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser` or `tskv_parser`<br>
&nbsp;&nbsp;json_parser | **[GenericParserCommon](#GenericParserCommon)**<br> 
&nbsp;&nbsp;audit_trails_v1_parser | **[AuditTrailsV1Parser](#AuditTrailsV1Parser)**<br> 
&nbsp;&nbsp;cloud_logging_parser | **[CloudLoggingParser](#CloudLoggingParser)**<br> 
&nbsp;&nbsp;tskv_parser | **[GenericParserCommon](#GenericParserCommon)**<br> 


### GenericParserCommon {#GenericParserCommon}

Field | Description
--- | ---
data_schema | **[DataSchema](#DataSchema)**<br> 
null_keys_allowed | **bool**<br>Allow null keys, if no - null keys will be putted to unparsed data 
add_rest_column | **bool**<br>Will add _rest column for all unknown fields 


### DataSchema {#DataSchema}

Field | Description
--- | ---
schema | **oneof:** `fields` or `json_fields`<br>
&nbsp;&nbsp;fields | **[FieldList](#FieldList)**<br> 
&nbsp;&nbsp;json_fields | **string**<br> 


### FieldList {#FieldList}

Field | Description
--- | ---
fields[] | **[ColSchema](#ColSchema)**<br>Column schema 


### ColSchema {#ColSchema}

Field | Description
--- | ---
name | **string**<br> 
type | enum **ColumnType**<br> 
key | **bool**<br> 
required | **bool**<br> 
path | **string**<br> 


### AuditTrailsV1Parser {#AuditTrailsV1Parser}

Empty

### CloudLoggingParser {#CloudLoggingParser}

Empty

### MongoSource {#MongoSource}

Field | Description
--- | ---
connection | **[MongoConnection](#MongoConnection)**<br> 
subnet_id | **string**<br> 
security_groups[] | **string**<br>Security groups 
collections[] | **[MongoCollection](#MongoCollection)**<br>List of collections for replication. Empty list implies replication of all tables on the deployment. Allowed to use * as collection name. 
excluded_collections[] | **[MongoCollection](#MongoCollection)**<br>List of forbidden collections for replication. Allowed to use * as collection name for forbid all collections of concrete schema. 
secondary_preferred_mode | **bool**<br>Read mode for mongo client 


### MongoConnection {#MongoConnection}

Field | Description
--- | ---
connection | **oneof:** `connection_options`<br>
&nbsp;&nbsp;connection_options | **[MongoConnectionOptions](#MongoConnectionOptions)**<br> 


### MongoConnectionOptions {#MongoConnectionOptions}

Field | Description
--- | ---
address | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseMongo](#OnPremiseMongo)**<br> 
user | **string**<br>User name 
password | **[Secret](#Secret1)**<br>Password for user 
auth_source | **string**<br>Database name associated with the credentials 


### OnPremiseMongo {#OnPremiseMongo}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode1)**<br> 
replica_set | **string**<br> 


### MongoCollection {#MongoCollection}

Field | Description
--- | ---
database_name | **string**<br> 
collection_name | **string**<br> 


### ClickhouseSource {#ClickhouseSource}

Field | Description
--- | ---
connection | **[ClickhouseConnection](#ClickhouseConnection)**<br> 
subnet_id | **string**<br> 
security_groups[] | **string**<br> 
include_tables[] | **string**<br>While list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns. 
exclude_tables[] | **string**<br>Exclude list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns. 


### ClickhouseConnection {#ClickhouseConnection}

Field | Description
--- | ---
connection | **oneof:** `connection_options`<br>
&nbsp;&nbsp;connection_options | **[ClickhouseConnectionOptions](#ClickhouseConnectionOptions)**<br> 


### ClickhouseConnectionOptions {#ClickhouseConnectionOptions}

Field | Description
--- | ---
address | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseClickhouse](#OnPremiseClickhouse)**<br> 
database | **string**<br>Database 
user | **string**<br> 
password | **[Secret](#Secret1)**<br> 


### OnPremiseClickhouse {#OnPremiseClickhouse}

Field | Description
--- | ---
shards[] | **[ClickhouseShard](#ClickhouseShard)**<br> 
http_port | **int64**<br> 
native_port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode1)**<br> 


### ClickhouseShard {#ClickhouseShard}

Field | Description
--- | ---
name | **string**<br> 
hosts[] | **string**<br> 


### MysqlTarget {#MysqlTarget}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection1)**<br>Database connection settings 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>User for database access. 
password | **[Secret](#Secret1)**<br>Password for database access. 
sql_mode | **string**<br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy <br>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED. <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>
service_database | **string**<br>Database schema for service table <br>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 


### PostgresTarget {#PostgresTarget}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection1)**<br>Database connection settings 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name 
user | **string**<br>User for database access. 
password | **[Secret](#Secret1)**<br>Password for database access. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy for activate, reactivate and reupload processes. Default is truncate. <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>


### ClickhouseTarget {#ClickhouseTarget}

Field | Description
--- | ---
connection | **[ClickhouseConnection](#ClickhouseConnection1)**<br> 
subnet_id | **string**<br> 
security_groups[] | **string**<br> 
clickhouse_cluster_name | **string**<br> 
alt_names[] | **[AltName](#AltName)**<br>Alternative table names in target 
sharding | **[ClickhouseSharding](#ClickhouseSharding)**<br> 
cleanup_policy | enum **ClickhouseCleanupPolicy**<br> 


### AltName {#AltName}

Field | Description
--- | ---
from_name | **string**<br>Source table name 
to_name | **string**<br>Target table name 


### ClickhouseSharding {#ClickhouseSharding}

Field | Description
--- | ---
sharding | **oneof:** `column_value_hash`, `custom_mapping` or `transfer_id`<br>
&nbsp;&nbsp;column_value_hash | **[ColumnValueHash](#ColumnValueHash)**<br> 
&nbsp;&nbsp;custom_mapping | **[ColumnValueMapping](#ColumnValueMapping)**<br> 
&nbsp;&nbsp;transfer_id | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 


### ColumnValueHash {#ColumnValueHash}

Field | Description
--- | ---
column_name | **string**<br> 


### ColumnValueMapping {#ColumnValueMapping}

Field | Description
--- | ---
column_name | **string**<br> 
mapping[] | **[ValueToShard](#ValueToShard)**<br> 


### ValueToShard {#ValueToShard}

Field | Description
--- | ---
column_value | **[ColumnValue](#ColumnValue)**<br> 
shard_name | **string**<br> 


### ColumnValue {#ColumnValue}

Field | Description
--- | ---
value | **oneof:** `string_value`<br>
&nbsp;&nbsp;string_value | **string**<br> 


### KafkaTarget {#KafkaTarget}

Field | Description
--- | ---
connection | **[KafkaConnectionOptions](#KafkaConnectionOptions1)**<br>Connection settings 
auth | **[KafkaAuth](#KafkaAuth1)**<br>Authentication settings 
security_groups[] | **string**<br>Security groups 
topic_settings | **[KafkaTargetTopicSettings](#KafkaTargetTopicSettings)**<br>Target topic settings 


### KafkaTargetTopicSettings {#KafkaTargetTopicSettings}

Field | Description
--- | ---
topic_settings | **oneof:** `topic` or `topic_prefix`<br>
&nbsp;&nbsp;topic | **[KafkaTargetTopic](#KafkaTargetTopic)**<br>Full topic name 
&nbsp;&nbsp;topic_prefix | **string**<br>Topic prefix <br>Analogue of the Debezium setting database.server.name. Messages will be sent to topic with name <topic_prefix>.<schema>.<table_name>. 


### KafkaTargetTopic {#KafkaTargetTopic}

Field | Description
--- | ---
topic_name | **string**<br>Topic name 
save_tx_order | **bool**<br>Save transactions order Not to split events queue into separate per-table queues. 


### MongoTarget {#MongoTarget}

Field | Description
--- | ---
connection | **[MongoConnection](#MongoConnection1)**<br> 
subnet_id | **string**<br> 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name 
cleanup_policy | enum **CleanupPolicy**<br> <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>


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
status | enum **TransferStatus**<br> <ul><li>`CREATING`: Transfer does some work before running</li><li>`CREATED`: Transfer created but not started by user</li><li>`RUNNING`: Transfer currently doing replication work</li><li>`STOPPING`: Transfer shutdown</li><li>`STOPPED`: Transfer stopped by user</li><li>`ERROR`: Transfer stopped by system</li><li>`SNAPSHOTTING`: Transfer copy snapshot</li><li>`DONE`: Transfer reach terminal phase</li></ul>
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li></ul>
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
settings | **oneof:** `mysql_source`, `postgres_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `kafka_target` or `mongo_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](#MysqlSource1)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](#PostgresSource1)**<br> 
&nbsp;&nbsp;kafka_source | **[endpoint.KafkaSource](#KafkaSource1)**<br> 
&nbsp;&nbsp;mongo_source | **[endpoint.MongoSource](#MongoSource1)**<br> 
&nbsp;&nbsp;clickhouse_source | **[endpoint.ClickhouseSource](#ClickhouseSource1)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](#MysqlTarget1)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](#PostgresTarget1)**<br> 
&nbsp;&nbsp;clickhouse_target | **[endpoint.ClickhouseTarget](#ClickhouseTarget1)**<br> 
&nbsp;&nbsp;kafka_target | **[endpoint.KafkaTarget](#KafkaTarget1)**<br> 
&nbsp;&nbsp;mongo_target | **[endpoint.MongoTarget](#MongoTarget1)**<br> 


### MysqlSource {#MysqlSource1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection1)**<br>Database connection settings 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
service_database | **string**<br>Database for service tables <br>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 
user | **string**<br>User for database access. 
password | **[Secret](#Secret1)**<br>Password for database access. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings1)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 


### MysqlConnection {#MysqlConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed Service for MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql1)**<br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Database port 
tls_mode | **[TLSMode](#TLSMode1)**<br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 


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
&nbsp;&nbsp;raw | **string**<br>Raw secret value 


### MysqlObjectTransferSettings {#MysqlObjectTransferSettings1}

Field | Description
--- | ---
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
routine | enum **ObjectTransferStage**<br>Routines <br>CREATE PROCEDURE ...; CREATE FUNCTION ...; <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
tables | enum **ObjectTransferStage**<br> <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>


### PostgresSource {#PostgresSource1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection1)**<br>Database connection settings 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name 
user | **string**<br>User for database access. 
password | **[Secret](#Secret2)**<br>Password for database access. 
include_tables[] | **string**<br>Included tables <br>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns. 
exclude_tables[] | **string**<br>Excluded tables <br>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns. 
slot_byte_lag_limit | **int64**<br>Maximum lag of replication slot (in bytes); after exceeding this limit replication will be aborted. 
service_schema | **string**<br>Database schema for service tables (__consumer_keeper, __data_transfer_mole_finder). Default is public 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings1)**<br>Select database objects to be transferred during activation or deactivation. 


### PostgresConnection {#PostgresConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed Service for PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres1)**<br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br>Will be used if the cluster ID is not specified. 
tls_mode | **[TLSMode](#TLSMode2)**<br>TLS settings for server connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings1}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
sequence_set | enum **ObjectTransferStage**<br> <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
materialized_view | enum **ObjectTransferStage**<br>Materialized views <br>CREATE MATERIALIZED VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>


### KafkaSource {#KafkaSource1}

Field | Description
--- | ---
connection | **[KafkaConnectionOptions](#KafkaConnectionOptions1)**<br>Connection settings 
auth | **[KafkaAuth](#KafkaAuth1)**<br>Authentication settings 
security_groups[] | **string**<br>Security groups 
topic_name | **string**<br>Full source topic name 
transformer | **[DataTransformationOptions](#DataTransformationOptions1)**<br>Data transformation rules 
parser | **[Parser](#Parser1)**<br>Data parsing rules 


### KafkaConnectionOptions {#KafkaConnectionOptions1}

Field | Description
--- | ---
connection | **oneof:** `cluster_id` or `on_premise`<br>
&nbsp;&nbsp;cluster_id | **string**<br>Managed Service for Kafka cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseKafka](#OnPremiseKafka1)**<br>Connection options for on-premise Kafka 


### OnPremiseKafka {#OnPremiseKafka1}

Field | Description
--- | ---
broker_urls[] | **string**<br>Kafka broker URLs 
tls_mode | **[TLSMode](#TLSMode2)**<br>TLS settings for broker connection. Disabled by default. 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 


### KafkaAuth {#KafkaAuth1}

Field | Description
--- | ---
security | **oneof:** `sasl` or `no_auth`<br>
&nbsp;&nbsp;sasl | **[KafkaSaslSecurity](#KafkaSaslSecurity1)**<br>Authentication with SASL 
&nbsp;&nbsp;no_auth | **[NoAuth](#NoAuth1)**<br>No authentication 


### KafkaSaslSecurity {#KafkaSaslSecurity1}

Field | Description
--- | ---
user | **string**<br>User name 
password | **[Secret](#Secret2)**<br>Password for user 
mechanism | enum **KafkaMechanism**<br>SASL mechanism for authentication 


### NoAuth {#NoAuth1}

Empty

### DataTransformationOptions {#DataTransformationOptions1}

Field | Description
--- | ---
cloud_function | **string**<br>Cloud function 
service_account_id | **string**<br>Service account 
number_of_retries | **int64**<br>Number of retries 
buffer_size | **string**<br>Buffer size for function 
buffer_flush_interval | **string**<br>Flush interval 
invocation_timeout | **string**<br>Invocation timeout 


### Parser {#Parser1}

Field | Description
--- | ---
parser | **oneof:** `json_parser`, `audit_trails_v1_parser`, `cloud_logging_parser` or `tskv_parser`<br>
&nbsp;&nbsp;json_parser | **[GenericParserCommon](#GenericParserCommon1)**<br> 
&nbsp;&nbsp;audit_trails_v1_parser | **[AuditTrailsV1Parser](#AuditTrailsV1Parser1)**<br> 
&nbsp;&nbsp;cloud_logging_parser | **[CloudLoggingParser](#CloudLoggingParser1)**<br> 
&nbsp;&nbsp;tskv_parser | **[GenericParserCommon](#GenericParserCommon1)**<br> 


### GenericParserCommon {#GenericParserCommon1}

Field | Description
--- | ---
data_schema | **[DataSchema](#DataSchema1)**<br> 
null_keys_allowed | **bool**<br>Allow null keys, if no - null keys will be putted to unparsed data 
add_rest_column | **bool**<br>Will add _rest column for all unknown fields 


### DataSchema {#DataSchema1}

Field | Description
--- | ---
schema | **oneof:** `fields` or `json_fields`<br>
&nbsp;&nbsp;fields | **[FieldList](#FieldList1)**<br> 
&nbsp;&nbsp;json_fields | **string**<br> 


### FieldList {#FieldList1}

Field | Description
--- | ---
fields[] | **[ColSchema](#ColSchema1)**<br>Column schema 


### ColSchema {#ColSchema1}

Field | Description
--- | ---
name | **string**<br> 
type | enum **ColumnType**<br> 
key | **bool**<br> 
required | **bool**<br> 
path | **string**<br> 


### AuditTrailsV1Parser {#AuditTrailsV1Parser1}

Empty

### CloudLoggingParser {#CloudLoggingParser1}

Empty

### MongoSource {#MongoSource1}

Field | Description
--- | ---
connection | **[MongoConnection](#MongoConnection1)**<br> 
subnet_id | **string**<br> 
security_groups[] | **string**<br>Security groups 
collections[] | **[MongoCollection](#MongoCollection1)**<br>List of collections for replication. Empty list implies replication of all tables on the deployment. Allowed to use * as collection name. 
excluded_collections[] | **[MongoCollection](#MongoCollection1)**<br>List of forbidden collections for replication. Allowed to use * as collection name for forbid all collections of concrete schema. 
secondary_preferred_mode | **bool**<br>Read mode for mongo client 


### MongoConnection {#MongoConnection1}

Field | Description
--- | ---
connection | **oneof:** `connection_options`<br>
&nbsp;&nbsp;connection_options | **[MongoConnectionOptions](#MongoConnectionOptions1)**<br> 


### MongoConnectionOptions {#MongoConnectionOptions1}

Field | Description
--- | ---
address | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseMongo](#OnPremiseMongo1)**<br> 
user | **string**<br>User name 
password | **[Secret](#Secret2)**<br>Password for user 
auth_source | **string**<br>Database name associated with the credentials 


### OnPremiseMongo {#OnPremiseMongo1}

Field | Description
--- | ---
hosts[] | **string**<br> 
port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode2)**<br> 
replica_set | **string**<br> 


### MongoCollection {#MongoCollection1}

Field | Description
--- | ---
database_name | **string**<br> 
collection_name | **string**<br> 


### ClickhouseSource {#ClickhouseSource1}

Field | Description
--- | ---
connection | **[ClickhouseConnection](#ClickhouseConnection1)**<br> 
subnet_id | **string**<br> 
security_groups[] | **string**<br> 
include_tables[] | **string**<br>While list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns. 
exclude_tables[] | **string**<br>Exclude list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns. 


### ClickhouseConnection {#ClickhouseConnection1}

Field | Description
--- | ---
connection | **oneof:** `connection_options`<br>
&nbsp;&nbsp;connection_options | **[ClickhouseConnectionOptions](#ClickhouseConnectionOptions1)**<br> 


### ClickhouseConnectionOptions {#ClickhouseConnectionOptions1}

Field | Description
--- | ---
address | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br> 
&nbsp;&nbsp;on_premise | **[OnPremiseClickhouse](#OnPremiseClickhouse1)**<br> 
database | **string**<br>Database 
user | **string**<br> 
password | **[Secret](#Secret2)**<br> 


### OnPremiseClickhouse {#OnPremiseClickhouse1}

Field | Description
--- | ---
shards[] | **[ClickhouseShard](#ClickhouseShard1)**<br> 
http_port | **int64**<br> 
native_port | **int64**<br> 
tls_mode | **[TLSMode](#TLSMode2)**<br> 


### ClickhouseShard {#ClickhouseShard1}

Field | Description
--- | ---
name | **string**<br> 
hosts[] | **string**<br> 


### MysqlTarget {#MysqlTarget1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection2)**<br>Database connection settings 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>User for database access. 
password | **[Secret](#Secret2)**<br>Password for database access. 
sql_mode | **string**<br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy <br>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED. <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>
service_database | **string**<br>Database schema for service table <br>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 


### PostgresTarget {#PostgresTarget1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection2)**<br>Database connection settings 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name 
user | **string**<br>User for database access. 
password | **[Secret](#Secret2)**<br>Password for database access. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy for activate, reactivate and reupload processes. Default is truncate. <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>


### ClickhouseTarget {#ClickhouseTarget1}

Field | Description
--- | ---
connection | **[ClickhouseConnection](#ClickhouseConnection2)**<br> 
subnet_id | **string**<br> 
security_groups[] | **string**<br> 
clickhouse_cluster_name | **string**<br> 
alt_names[] | **[AltName](#AltName1)**<br>Alternative table names in target 
sharding | **[ClickhouseSharding](#ClickhouseSharding1)**<br> 
cleanup_policy | enum **ClickhouseCleanupPolicy**<br> 


### AltName {#AltName1}

Field | Description
--- | ---
from_name | **string**<br>Source table name 
to_name | **string**<br>Target table name 


### ClickhouseSharding {#ClickhouseSharding1}

Field | Description
--- | ---
sharding | **oneof:** `column_value_hash`, `custom_mapping` or `transfer_id`<br>
&nbsp;&nbsp;column_value_hash | **[ColumnValueHash](#ColumnValueHash1)**<br> 
&nbsp;&nbsp;custom_mapping | **[ColumnValueMapping](#ColumnValueMapping1)**<br> 
&nbsp;&nbsp;transfer_id | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 


### ColumnValueHash {#ColumnValueHash1}

Field | Description
--- | ---
column_name | **string**<br> 


### ColumnValueMapping {#ColumnValueMapping1}

Field | Description
--- | ---
column_name | **string**<br> 
mapping[] | **[ValueToShard](#ValueToShard1)**<br> 


### ValueToShard {#ValueToShard1}

Field | Description
--- | ---
column_value | **[ColumnValue](#ColumnValue1)**<br> 
shard_name | **string**<br> 


### ColumnValue {#ColumnValue1}

Field | Description
--- | ---
value | **oneof:** `string_value`<br>
&nbsp;&nbsp;string_value | **string**<br> 


### KafkaTarget {#KafkaTarget1}

Field | Description
--- | ---
connection | **[KafkaConnectionOptions](#KafkaConnectionOptions2)**<br>Connection settings 
auth | **[KafkaAuth](#KafkaAuth2)**<br>Authentication settings 
security_groups[] | **string**<br>Security groups 
topic_settings | **[KafkaTargetTopicSettings](#KafkaTargetTopicSettings1)**<br>Target topic settings 


### KafkaTargetTopicSettings {#KafkaTargetTopicSettings1}

Field | Description
--- | ---
topic_settings | **oneof:** `topic` or `topic_prefix`<br>
&nbsp;&nbsp;topic | **[KafkaTargetTopic](#KafkaTargetTopic1)**<br>Full topic name 
&nbsp;&nbsp;topic_prefix | **string**<br>Topic prefix <br>Analogue of the Debezium setting database.server.name. Messages will be sent to topic with name <topic_prefix>.<schema>.<table_name>. 


### KafkaTargetTopic {#KafkaTargetTopic1}

Field | Description
--- | ---
topic_name | **string**<br>Topic name 
save_tx_order | **bool**<br>Save transactions order Not to split events queue into separate per-table queues. 


### MongoTarget {#MongoTarget1}

Field | Description
--- | ---
connection | **[MongoConnection](#MongoConnection2)**<br> 
subnet_id | **string**<br> 
security_groups[] | **string**<br>Security groups 
database | **string**<br>Database name 
cleanup_policy | enum **CleanupPolicy**<br> <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>


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


