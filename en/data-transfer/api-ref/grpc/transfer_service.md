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
description | **string**<br> 
folder_id | **string**<br> 
runtime | **[Runtime](#Runtime)**<br> 
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li></ul>
name | **string**<br> 
labels | **map<string,string>**<br> 
transformation | **[Transformation](#Transformation)**<br> 


### Runtime {#Runtime}

Field | Description
--- | ---
runtime | **oneof:** `yc_runtime`<br>
&nbsp;&nbsp;yc_runtime | **[YcRuntime](#YcRuntime)**<br> 


### YcRuntime {#YcRuntime}

Field | Description
--- | ---
job_count | **int64**<br> 
upload_shard_params | **[ShardingUploadParams](#ShardingUploadParams)**<br> 


### ShardingUploadParams {#ShardingUploadParams}

Field | Description
--- | ---
job_count | **int64**<br> 
process_count | **int64**<br> 


### Transformation {#Transformation}

Field | Description
--- | ---
transformers[] | **[Transformer](#Transformer)**<br>Transformers are set as a list. When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list. 


### Transformer {#Transformer}

Field | Description
--- | ---
transformer | **oneof:** `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer` or `filter_rows`<br>
&nbsp;&nbsp;mask_field | **[MaskFieldTransformer](#MaskFieldTransformer)**<br> 
&nbsp;&nbsp;filter_columns | **[FilterColumnsTransformer](#FilterColumnsTransformer)**<br> 
&nbsp;&nbsp;rename_tables | **[RenameTablesTransformer](#RenameTablesTransformer)**<br> 
&nbsp;&nbsp;replace_primary_key | **[ReplacePrimaryKeyTransformer](#ReplacePrimaryKeyTransformer)**<br> 
&nbsp;&nbsp;convert_to_string | **[ToStringTransformer](#ToStringTransformer)**<br> 
&nbsp;&nbsp;sharder_transformer | **[SharderTransformer](#SharderTransformer)**<br> 
&nbsp;&nbsp;table_splitter_transformer | **[TableSplitterTransformer](#TableSplitterTransformer)**<br> 
&nbsp;&nbsp;filter_rows | **[FilterRowsTransformer](#FilterRowsTransformer)**<br> 


### MaskFieldTransformer {#MaskFieldTransformer}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter)**<br>List of included and excluded tables 
columns[] | **string**<br>Specify the name of the column for data masking (a regular expression). 
function | **[MaskFunction](#MaskFunction)**<br>Mask function 


### TablesFilter {#TablesFilter}

Field | Description
--- | ---
include_tables[] | **string**<br>List of tables that will be included to transfer 
exclude_tables[] | **string**<br>List of tables that will be excluded to transfer 


### MaskFunction {#MaskFunction}

Field | Description
--- | ---
mask_function | **oneof:** `mask_function_hash`<br>
&nbsp;&nbsp;mask_function_hash | **[MaskFunctionHash](#MaskFunctionHash)**<br>Hash mask function 


### MaskFunctionHash {#MaskFunctionHash}

Field | Description
--- | ---
user_defined_salt | **string**<br>This string will be used in the HMAC(sha256, salt) function applied to the column data. 


### FilterColumnsTransformer {#FilterColumnsTransformer}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter1)**<br>List of the tables to filter using lists of included and excluded tables. 
columns | **[ColumnsFilter](#ColumnsFilter)**<br>List of the columns to transfer to the target tables using lists of included and excluded columns. 


### ColumnsFilter {#ColumnsFilter}

Field | Description
--- | ---
include_columns[] | **string**<br>List of columns that will be included to transfer 
exclude_columns[] | **string**<br>List of columns that will be excluded to transfer 


### RenameTablesTransformer {#RenameTablesTransformer}

Field | Description
--- | ---
rename_tables[] | **[RenameTable](#RenameTable)**<br>List of renaming rules 


### RenameTable {#RenameTable}

Field | Description
--- | ---
original_name | **[Table](#Table)**<br>Specify the current names of the table in the source 
new_name | **[Table](#Table)**<br>Specify the new names for this table in the target 


### Table {#Table}

Field | Description
--- | ---
name_space | **string**<br> 
name | **string**<br> 


### ReplacePrimaryKeyTransformer {#ReplacePrimaryKeyTransformer}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter1)**<br>List of included and excluded tables 
keys[] | **string**<br>List of columns to be used as primary keys 


### ToStringTransformer {#ToStringTransformer}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter1)**<br>List of included and excluded tables 
columns | **[ColumnsFilter](#ColumnsFilter1)**<br>List of included and excluded columns 


### SharderTransformer {#SharderTransformer}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter1)**<br>List of included and excluded tables 
columns | **[ColumnsFilter](#ColumnsFilter1)**<br>List of included and excluded columns 
shards_count | **int64**<br>Number of shards 


### TableSplitterTransformer {#TableSplitterTransformer}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter1)**<br>List of included and excluded tables 
columns[] | **string**<br>Specify the columns in the tables to be partitioned. 
splitter | **string**<br>Specify the split string to be used for merging components in a new table name. 


### FilterRowsTransformer {#FilterRowsTransformer}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter1)**<br>List of included and excluded tables 
filter | **string**<br>Filtering criterion. This can be comparison operators for numeric, string, and Boolean values, comparison to NULL, and checking whether a substring is part of a string. For more details see [documentation](/docs/data-transfer/concepts/data-transformation#append-only-sources). 


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
runtime | **[Runtime](#Runtime1)**<br> 
name | **string**<br>The new transfer name. Must be unique within the folder. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask specifying transfer fields to be updated. Semantics for this field is described here: <https://pkg.go.dev/google.golang.org/protobuf/types/known/fieldmaskpb#FieldMask> The only exception: if the repeated field is specified in the mask, then the new value replaces the old one instead of being appended to the old one. 
labels | **map<string,string>**<br> 
transformation | **[Transformation](#Transformation1)**<br> 


### Runtime {#Runtime1}

Field | Description
--- | ---
runtime | **oneof:** `yc_runtime`<br>
&nbsp;&nbsp;yc_runtime | **[YcRuntime](#YcRuntime1)**<br> 


### YcRuntime {#YcRuntime1}

Field | Description
--- | ---
job_count | **int64**<br> 
upload_shard_params | **[ShardingUploadParams](#ShardingUploadParams1)**<br> 


### ShardingUploadParams {#ShardingUploadParams1}

Field | Description
--- | ---
job_count | **int64**<br> 
process_count | **int64**<br> 


### Transformation {#Transformation1}

Field | Description
--- | ---
transformers[] | **[Transformer](#Transformer1)**<br>Transformers are set as a list. When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list. 


### Transformer {#Transformer1}

Field | Description
--- | ---
transformer | **oneof:** `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer` or `filter_rows`<br>
&nbsp;&nbsp;mask_field | **[MaskFieldTransformer](#MaskFieldTransformer1)**<br> 
&nbsp;&nbsp;filter_columns | **[FilterColumnsTransformer](#FilterColumnsTransformer1)**<br> 
&nbsp;&nbsp;rename_tables | **[RenameTablesTransformer](#RenameTablesTransformer1)**<br> 
&nbsp;&nbsp;replace_primary_key | **[ReplacePrimaryKeyTransformer](#ReplacePrimaryKeyTransformer1)**<br> 
&nbsp;&nbsp;convert_to_string | **[ToStringTransformer](#ToStringTransformer1)**<br> 
&nbsp;&nbsp;sharder_transformer | **[SharderTransformer](#SharderTransformer1)**<br> 
&nbsp;&nbsp;table_splitter_transformer | **[TableSplitterTransformer](#TableSplitterTransformer1)**<br> 
&nbsp;&nbsp;filter_rows | **[FilterRowsTransformer](#FilterRowsTransformer1)**<br> 


### MaskFieldTransformer {#MaskFieldTransformer1}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter1)**<br>List of included and excluded tables 
columns[] | **string**<br>Specify the name of the column for data masking (a regular expression). 
function | **[MaskFunction](#MaskFunction1)**<br>Mask function 


### TablesFilter {#TablesFilter1}

Field | Description
--- | ---
include_tables[] | **string**<br>List of tables that will be included to transfer 
exclude_tables[] | **string**<br>List of tables that will be excluded to transfer 


### MaskFunction {#MaskFunction1}

Field | Description
--- | ---
mask_function | **oneof:** `mask_function_hash`<br>
&nbsp;&nbsp;mask_function_hash | **[MaskFunctionHash](#MaskFunctionHash1)**<br>Hash mask function 


### MaskFunctionHash {#MaskFunctionHash1}

Field | Description
--- | ---
user_defined_salt | **string**<br>This string will be used in the HMAC(sha256, salt) function applied to the column data. 


### FilterColumnsTransformer {#FilterColumnsTransformer1}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter2)**<br>List of the tables to filter using lists of included and excluded tables. 
columns | **[ColumnsFilter](#ColumnsFilter1)**<br>List of the columns to transfer to the target tables using lists of included and excluded columns. 


### ColumnsFilter {#ColumnsFilter1}

Field | Description
--- | ---
include_columns[] | **string**<br>List of columns that will be included to transfer 
exclude_columns[] | **string**<br>List of columns that will be excluded to transfer 


### RenameTablesTransformer {#RenameTablesTransformer1}

Field | Description
--- | ---
rename_tables[] | **[RenameTable](#RenameTable1)**<br>List of renaming rules 


### RenameTable {#RenameTable1}

Field | Description
--- | ---
original_name | **[Table](#Table1)**<br>Specify the current names of the table in the source 
new_name | **[Table](#Table1)**<br>Specify the new names for this table in the target 


### Table {#Table1}

Field | Description
--- | ---
name_space | **string**<br> 
name | **string**<br> 


### ReplacePrimaryKeyTransformer {#ReplacePrimaryKeyTransformer1}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter2)**<br>List of included and excluded tables 
keys[] | **string**<br>List of columns to be used as primary keys 


### ToStringTransformer {#ToStringTransformer1}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter2)**<br>List of included and excluded tables 
columns | **[ColumnsFilter](#ColumnsFilter2)**<br>List of included and excluded columns 


### SharderTransformer {#SharderTransformer1}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter2)**<br>List of included and excluded tables 
columns | **[ColumnsFilter](#ColumnsFilter2)**<br>List of included and excluded columns 
shards_count | **int64**<br>Number of shards 


### TableSplitterTransformer {#TableSplitterTransformer1}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter2)**<br>List of included and excluded tables 
columns[] | **string**<br>Specify the columns in the tables to be partitioned. 
splitter | **string**<br>Specify the split string to be used for merging components in a new table name. 


### FilterRowsTransformer {#FilterRowsTransformer1}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter2)**<br>List of included and excluded tables 
filter | **string**<br>Filtering criterion. This can be comparison operators for numeric, string, and Boolean values, comparison to NULL, and checking whether a substring is part of a string. For more details see [documentation](/docs/data-transfer/concepts/data-transformation#append-only-sources). 


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
runtime | **[Runtime](#Runtime2)**<br> 
status | enum **TransferStatus**<br> <ul><li>`CREATING`: Transfer does some work before running</li><li>`CREATED`: Transfer created but not started by user</li><li>`RUNNING`: Transfer currently doing replication work</li><li>`STOPPING`: Transfer shutdown</li><li>`STOPPED`: Transfer stopped by user</li><li>`ERROR`: Transfer stopped by system</li><li>`SNAPSHOTTING`: Transfer copy snapshot</li><li>`DONE`: Transfer reach terminal phase</li></ul>
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li></ul>
warning | **string**<br> 
transformation | **[Transformation](#Transformation2)**<br> 
prestable | **bool**<br> 


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
settings | **oneof:** `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source` or `yds_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](#MysqlSource)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](#PostgresSource)**<br> 
&nbsp;&nbsp;ydb_source | **[endpoint.YdbSource](#YdbSource)**<br> 
&nbsp;&nbsp;yds_source | **[endpoint.YDSSource](#YDSSource)**<br> 
&nbsp;&nbsp;kafka_source | **[endpoint.KafkaSource](#KafkaSource)**<br> 
&nbsp;&nbsp;mongo_source | **[endpoint.MongoSource](#MongoSource)**<br> 
&nbsp;&nbsp;clickhouse_source | **[endpoint.ClickhouseSource](#ClickhouseSource)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](#MysqlTarget)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](#PostgresTarget)**<br> 
&nbsp;&nbsp;clickhouse_target | **[endpoint.ClickhouseTarget](#ClickhouseTarget)**<br> 
&nbsp;&nbsp;ydb_target | **[endpoint.YdbTarget](#YdbTarget)**<br> 
&nbsp;&nbsp;kafka_target | **[endpoint.KafkaTarget](#KafkaTarget)**<br> 
&nbsp;&nbsp;mongo_target | **[endpoint.MongoTarget](#MongoTarget)**<br> 
&nbsp;&nbsp;metrika_source | **[endpoint.MetrikaSource](#MetrikaSource)**<br> 
&nbsp;&nbsp;yds_target | **[endpoint.YDSTarget](#YDSTarget)**<br> 


### MysqlSource {#MysqlSource}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection)**<br>Database connection settings 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
user | **string**<br>User for database access. 
password | **[Secret](#Secret)**<br>Password for database access. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
security_groups[] | **string**<br>Security groups 
service_database | **string**<br>Database for service tables <br>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 


### MysqlConnection {#MysqlConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed Service for MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql)**<br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql}

Field | Description
--- | ---
port | **int64**<br>Database port 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
hosts[] | **string**<br> 
tls_mode | **[TLSMode](#TLSMode)**<br>TLS settings for server connection. Disabled by default. 


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
database | **string**<br>Database name 
user | **string**<br>User for database access. 
password | **[Secret](#Secret1)**<br>Password for database access. 
include_tables[] | **string**<br>Included tables <br>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns. 
exclude_tables[] | **string**<br>Excluded tables <br>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns. 
slot_byte_lag_limit | **int64**<br>Maximum lag of replication slot (in bytes); after exceeding this limit replication will be aborted. 
service_schema | **string**<br>Database schema for service tables (__consumer_keeper, __data_transfer_mole_finder). Default is public 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings)**<br>Select database objects to be transferred during activation or deactivation. 
security_groups[] | **string**<br>Security groups 


### PostgresConnection {#PostgresConnection}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed Service for PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres)**<br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres}

Field | Description
--- | ---
port | **int64**<br>Will be used if the cluster ID is not specified. 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
hosts[] | **string**<br> 
tls_mode | **[TLSMode](#TLSMode1)**<br>TLS settings for server connection. Disabled by default. 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
materialized_view | enum **ObjectTransferStage**<br>Materialized views <br>CREATE MATERIALIZED VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
sequence_set | enum **ObjectTransferStage**<br> <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>


### YdbSource {#YdbSource}

Field | Description
--- | ---
database | **string**<br>Path in YDB where to store tables 
instance | **string**<br>Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 
paths[] | **string**<br> 
service_account_id | **string**<br> 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
sa_key_content | **string**<br>Authorization Key 
security_groups[] | **string**<br>Security groups 
changefeed_custom_name | **string**<br>Pre-created change feed 


### YDSSource {#YDSSource}

Field | Description
--- | ---
database | **string**<br>Database 
stream | **string**<br>Stream 
service_account_id | **string**<br>SA which has read access to the stream. 
supported_codecs[] | enum **YdsCompressionCodec**<br>Compression codec 
parser | **[Parser](#Parser)**<br>Data parsing rules 
allow_ttl_rewind | **bool**<br>Should continue working, if consumer read lag exceed TTL of topic False: stop the transfer in error state, if detected lost data. True: continue working with losing part of data 
endpoint | **string**<br>for dedicated db 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
security_groups[] | **string**<br>Security groups 
consumer | **string**<br>for important streams 


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
unescape_string_values | **bool**<br>Unescape string values 


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

Empty.

### CloudLoggingParser {#CloudLoggingParser}

Empty.

### KafkaSource {#KafkaSource}

Field | Description
--- | ---
connection | **[KafkaConnectionOptions](#KafkaConnectionOptions)**<br>Connection settings 
auth | **[KafkaAuth](#KafkaAuth)**<br>Authentication settings 
security_groups[] | **string**<br>Security groups 
topic_name | **string**<br>Full source topic name Deprecated in favor of topic names 
transformer | **[DataTransformationOptions](#DataTransformationOptions)**<br>Data transformation rules 
parser | **[Parser](#Parser1)**<br>Data parsing rules 
topic_names[] | **string**<br>List of topic names to read 


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
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
tls_mode | **[TLSMode](#TLSMode1)**<br>TLS settings for broker connection. Disabled by default. 


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
mechanism | enum **KafkaMechanism**<br>SASL mechanism for authentication 
password | **[Secret](#Secret1)**<br>Password for user 


### NoAuth {#NoAuth}

Empty.

### DataTransformationOptions {#DataTransformationOptions}

Field | Description
--- | ---
cloud_function | **string**<br>Cloud function 
number_of_retries | **int64**<br>Number of retries 
buffer_size | **string**<br>Buffer size for function 
buffer_flush_interval | **string**<br>Flush interval 
invocation_timeout | **string**<br>Invocation timeout 
service_account_id | **string**<br>Service account 


### MongoSource {#MongoSource}

Field | Description
--- | ---
connection | **[MongoConnection](#MongoConnection)**<br> 
subnet_id | **string**<br> 
collections[] | **[MongoCollection](#MongoCollection)**<br>List of collections for replication. Empty list implies replication of all tables on the deployment. Allowed to use * as collection name. 
excluded_collections[] | **[MongoCollection](#MongoCollection)**<br>List of forbidden collections for replication. Allowed to use * as collection name for forbid all collections of concrete schema. 
secondary_preferred_mode | **bool**<br>Read mode for mongo client 
security_groups[] | **string**<br>Security groups 


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
replica_set | **string**<br> 
tls_mode | **[TLSMode](#TLSMode1)**<br> 


### MongoCollection {#MongoCollection}

Field | Description
--- | ---
database_name | **string**<br> 
collection_name | **string**<br> 


### ClickhouseSource {#ClickhouseSource}

Field | Description
--- | ---
connection | **[ClickhouseConnection](#ClickhouseConnection)**<br> 
include_tables[] | **string**<br>While list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns. 
exclude_tables[] | **string**<br>Exclude list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns. 
subnet_id | **string**<br> 
security_groups[] | **string**<br> 


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
user | **string**<br> 
password | **[Secret](#Secret1)**<br> 
database | **string**<br>Database 


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
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>User for database access. 
password | **[Secret](#Secret1)**<br>Password for database access. 
sql_mode | **string**<br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy <br>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED. <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>
service_database | **string**<br>Database schema for service table <br>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 
security_groups[] | **string**<br>Security groups 


### PostgresTarget {#PostgresTarget}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection1)**<br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>User for database access. 
password | **[Secret](#Secret1)**<br>Password for database access. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy for activate, reactivate and reupload processes. Default is truncate. <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>
security_groups[] | **string**<br>Security groups 


### ClickhouseTarget {#ClickhouseTarget}

Field | Description
--- | ---
connection | **[ClickhouseConnection](#ClickhouseConnection1)**<br> 
subnet_id | **string**<br> 
alt_names[] | **[AltName](#AltName)**<br>Alternative table names in target 
cleanup_policy | enum **ClickhouseCleanupPolicy**<br> 
sharding | **[ClickhouseSharding](#ClickhouseSharding)**<br> 
clickhouse_cluster_name | **string**<br> 
security_groups[] | **string**<br> 


### AltName {#AltName}

Field | Description
--- | ---
from_name | **string**<br>Source table name 
to_name | **string**<br>Target table name 


### ClickhouseSharding {#ClickhouseSharding}

Field | Description
--- | ---
sharding | **oneof:** `column_value_hash`, `custom_mapping`, `transfer_id` or `round_robin`<br>
&nbsp;&nbsp;column_value_hash | **[ColumnValueHash](#ColumnValueHash)**<br> 
&nbsp;&nbsp;custom_mapping | **[ColumnValueMapping](#ColumnValueMapping)**<br> 
&nbsp;&nbsp;transfer_id | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;round_robin | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 


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


### YdbTarget {#YdbTarget}

Field | Description
--- | ---
database | **string**<br>Path in YDB where to store tables 
instance | **string**<br>Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 
path | **string**<br>Path extension for database, each table will be layouted into this path 
service_account_id | **string**<br> 
cleanup_policy | enum **YdbCleanupPolicy**<br>Cleanup policy 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
sa_key_content | **string**<br>SA content 
security_groups[] | **string**<br>Security groups 
is_table_column_oriented | **bool**<br>Should create column-oriented table (OLAP). By default it creates row-oriented (OLTP) 
default_compression | enum **YdbDefaultCompression**<br>Compression that will be used for default columns family on YDB table creation 


### KafkaTarget {#KafkaTarget}

Field | Description
--- | ---
connection | **[KafkaConnectionOptions](#KafkaConnectionOptions1)**<br>Connection settings 
auth | **[KafkaAuth](#KafkaAuth1)**<br>Authentication settings 
security_groups[] | **string**<br>Security groups 
topic_settings | **[KafkaTargetTopicSettings](#KafkaTargetTopicSettings)**<br>Target topic settings 
serializer | **[Serializer](#Serializer)**<br>Data serialization format settings 


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


### Serializer {#Serializer}

Field | Description
--- | ---
serializer | **oneof:** `serializer_auto`, `serializer_json` or `serializer_debezium`<br>
&nbsp;&nbsp;serializer_auto | **[SerializerAuto](#SerializerAuto)**<br>Select the serialization format automatically 
&nbsp;&nbsp;serializer_json | **[SerializerJSON](#SerializerJSON)**<br>Serialize data in json format 
&nbsp;&nbsp;serializer_debezium | **[SerializerDebezium](#SerializerDebezium)**<br>Serialize data in debezium format 


### SerializerAuto {#SerializerAuto}

Empty.

### SerializerJSON {#SerializerJSON}

Empty.

### SerializerDebezium {#SerializerDebezium}

Field | Description
--- | ---
serializer_parameters[] | **[DebeziumSerializerParameter](#DebeziumSerializerParameter)**<br>Settings of sterilization parameters as key-value pairs 


### DebeziumSerializerParameter {#DebeziumSerializerParameter}

Field | Description
--- | ---
key | **string**<br>Name of the serializer parameter 
value | **string**<br>Value of the serializer parameter 


### MongoTarget {#MongoTarget}

Field | Description
--- | ---
connection | **[MongoConnection](#MongoConnection1)**<br> 
database | **string**<br>Database name 
cleanup_policy | enum **CleanupPolicy**<br> <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>
subnet_id | **string**<br> 
security_groups[] | **string**<br>Security groups 


### MetrikaSource {#MetrikaSource}

Field | Description
--- | ---
counter_ids[] | **int64**<br> 
token | **[Secret](#Secret1)**<br> 
streams[] | **[MetrikaStream](#MetrikaStream)**<br> 


### MetrikaStream {#MetrikaStream}

Field | Description
--- | ---
type | enum **MetrikaStreamType**<br> 
columns[] | **string**<br> 


### YDSTarget {#YDSTarget}

Field | Description
--- | ---
database | **string**<br>Database 
stream | **string**<br>Stream 
service_account_id | **string**<br>SA which has read access to the stream. 
save_tx_order | **bool**<br>Save transaction order Not to split events queue into separate per-table queues. Incompatible with setting Topic prefix, only with Topic full name. 
serializer | **[Serializer](#Serializer1)**<br>Data serialization format 
endpoint | **string**<br>for dedicated db 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
security_groups[] | **string**<br>Security groups 


### Runtime {#Runtime2}

Field | Description
--- | ---
runtime | **oneof:** `yc_runtime`<br>
&nbsp;&nbsp;yc_runtime | **[YcRuntime](#YcRuntime2)**<br> 


### YcRuntime {#YcRuntime2}

Field | Description
--- | ---
job_count | **int64**<br> 
upload_shard_params | **[ShardingUploadParams](#ShardingUploadParams2)**<br> 


### ShardingUploadParams {#ShardingUploadParams2}

Field | Description
--- | ---
job_count | **int64**<br> 
process_count | **int64**<br> 


### Transformation {#Transformation2}

Field | Description
--- | ---
transformers[] | **[Transformer](#Transformer2)**<br>Transformers are set as a list. When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list. 


### Transformer {#Transformer2}

Field | Description
--- | ---
transformer | **oneof:** `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer` or `filter_rows`<br>
&nbsp;&nbsp;mask_field | **[MaskFieldTransformer](#MaskFieldTransformer2)**<br> 
&nbsp;&nbsp;filter_columns | **[FilterColumnsTransformer](#FilterColumnsTransformer2)**<br> 
&nbsp;&nbsp;rename_tables | **[RenameTablesTransformer](#RenameTablesTransformer2)**<br> 
&nbsp;&nbsp;replace_primary_key | **[ReplacePrimaryKeyTransformer](#ReplacePrimaryKeyTransformer2)**<br> 
&nbsp;&nbsp;convert_to_string | **[ToStringTransformer](#ToStringTransformer2)**<br> 
&nbsp;&nbsp;sharder_transformer | **[SharderTransformer](#SharderTransformer2)**<br> 
&nbsp;&nbsp;table_splitter_transformer | **[TableSplitterTransformer](#TableSplitterTransformer2)**<br> 
&nbsp;&nbsp;filter_rows | **[FilterRowsTransformer](#FilterRowsTransformer2)**<br> 


### MaskFieldTransformer {#MaskFieldTransformer2}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter2)**<br>List of included and excluded tables 
columns[] | **string**<br>Specify the name of the column for data masking (a regular expression). 
function | **[MaskFunction](#MaskFunction2)**<br>Mask function 


### TablesFilter {#TablesFilter2}

Field | Description
--- | ---
include_tables[] | **string**<br>List of tables that will be included to transfer 
exclude_tables[] | **string**<br>List of tables that will be excluded to transfer 


### MaskFunction {#MaskFunction2}

Field | Description
--- | ---
mask_function | **oneof:** `mask_function_hash`<br>
&nbsp;&nbsp;mask_function_hash | **[MaskFunctionHash](#MaskFunctionHash2)**<br>Hash mask function 


### MaskFunctionHash {#MaskFunctionHash2}

Field | Description
--- | ---
user_defined_salt | **string**<br>This string will be used in the HMAC(sha256, salt) function applied to the column data. 


### FilterColumnsTransformer {#FilterColumnsTransformer2}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter3)**<br>List of the tables to filter using lists of included and excluded tables. 
columns | **[ColumnsFilter](#ColumnsFilter2)**<br>List of the columns to transfer to the target tables using lists of included and excluded columns. 


### ColumnsFilter {#ColumnsFilter2}

Field | Description
--- | ---
include_columns[] | **string**<br>List of columns that will be included to transfer 
exclude_columns[] | **string**<br>List of columns that will be excluded to transfer 


### RenameTablesTransformer {#RenameTablesTransformer2}

Field | Description
--- | ---
rename_tables[] | **[RenameTable](#RenameTable2)**<br>List of renaming rules 


### RenameTable {#RenameTable2}

Field | Description
--- | ---
original_name | **[Table](#Table2)**<br>Specify the current names of the table in the source 
new_name | **[Table](#Table2)**<br>Specify the new names for this table in the target 


### Table {#Table2}

Field | Description
--- | ---
name_space | **string**<br> 
name | **string**<br> 


### ReplacePrimaryKeyTransformer {#ReplacePrimaryKeyTransformer2}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter3)**<br>List of included and excluded tables 
keys[] | **string**<br>List of columns to be used as primary keys 


### ToStringTransformer {#ToStringTransformer2}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter3)**<br>List of included and excluded tables 
columns | **[ColumnsFilter](#ColumnsFilter3)**<br>List of included and excluded columns 


### SharderTransformer {#SharderTransformer2}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter3)**<br>List of included and excluded tables 
columns | **[ColumnsFilter](#ColumnsFilter3)**<br>List of included and excluded columns 
shards_count | **int64**<br>Number of shards 


### TableSplitterTransformer {#TableSplitterTransformer2}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter3)**<br>List of included and excluded tables 
columns[] | **string**<br>Specify the columns in the tables to be partitioned. 
splitter | **string**<br>Specify the split string to be used for merging components in a new table name. 


### FilterRowsTransformer {#FilterRowsTransformer2}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter3)**<br>List of included and excluded tables 
filter | **string**<br>Filtering criterion. This can be comparison operators for numeric, string, and Boolean values, comparison to NULL, and checking whether a substring is part of a string. For more details see [documentation](/docs/data-transfer/concepts/data-transformation#append-only-sources). 


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
runtime | **[Runtime](#Runtime3)**<br> 
status | enum **TransferStatus**<br> <ul><li>`CREATING`: Transfer does some work before running</li><li>`CREATED`: Transfer created but not started by user</li><li>`RUNNING`: Transfer currently doing replication work</li><li>`STOPPING`: Transfer shutdown</li><li>`STOPPED`: Transfer stopped by user</li><li>`ERROR`: Transfer stopped by system</li><li>`SNAPSHOTTING`: Transfer copy snapshot</li><li>`DONE`: Transfer reach terminal phase</li></ul>
type | enum **TransferType**<br> <ul><li>`SNAPSHOT_AND_INCREMENT`: Snapshot and increment</li><li>`SNAPSHOT_ONLY`: Snapshot</li><li>`INCREMENT_ONLY`: Increment</li></ul>
warning | **string**<br> 
transformation | **[Transformation](#Transformation3)**<br> 
prestable | **bool**<br> 


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
settings | **oneof:** `mysql_source`, `postgres_source`, `ydb_source`, `yds_source`, `kafka_source`, `mongo_source`, `clickhouse_source`, `mysql_target`, `postgres_target`, `clickhouse_target`, `ydb_target`, `kafka_target`, `mongo_target`, `metrika_source` or `yds_target`<br>
&nbsp;&nbsp;mysql_source | **[endpoint.MysqlSource](#MysqlSource1)**<br> 
&nbsp;&nbsp;postgres_source | **[endpoint.PostgresSource](#PostgresSource1)**<br> 
&nbsp;&nbsp;ydb_source | **[endpoint.YdbSource](#YdbSource1)**<br> 
&nbsp;&nbsp;yds_source | **[endpoint.YDSSource](#YDSSource1)**<br> 
&nbsp;&nbsp;kafka_source | **[endpoint.KafkaSource](#KafkaSource1)**<br> 
&nbsp;&nbsp;mongo_source | **[endpoint.MongoSource](#MongoSource1)**<br> 
&nbsp;&nbsp;clickhouse_source | **[endpoint.ClickhouseSource](#ClickhouseSource1)**<br> 
&nbsp;&nbsp;mysql_target | **[endpoint.MysqlTarget](#MysqlTarget1)**<br> 
&nbsp;&nbsp;postgres_target | **[endpoint.PostgresTarget](#PostgresTarget1)**<br> 
&nbsp;&nbsp;clickhouse_target | **[endpoint.ClickhouseTarget](#ClickhouseTarget1)**<br> 
&nbsp;&nbsp;ydb_target | **[endpoint.YdbTarget](#YdbTarget1)**<br> 
&nbsp;&nbsp;kafka_target | **[endpoint.KafkaTarget](#KafkaTarget1)**<br> 
&nbsp;&nbsp;mongo_target | **[endpoint.MongoTarget](#MongoTarget1)**<br> 
&nbsp;&nbsp;metrika_source | **[endpoint.MetrikaSource](#MetrikaSource1)**<br> 
&nbsp;&nbsp;yds_target | **[endpoint.YDSTarget](#YDSTarget1)**<br> 


### MysqlSource {#MysqlSource1}

Field | Description
--- | ---
connection | **[MysqlConnection](#MysqlConnection1)**<br>Database connection settings 
database | **string**<br>Database name <br>You can leave it empty, then it will be possible to transfer tables from several databases at the same time from this source. 
user | **string**<br>User for database access. 
password | **[Secret](#Secret1)**<br>Password for database access. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
object_transfer_settings | **[MysqlObjectTransferSettings](#MysqlObjectTransferSettings1)**<br>Schema migration <br>Select database objects to be transferred during activation or deactivation. 
include_tables_regex[] | **string**<br> 
exclude_tables_regex[] | **string**<br> 
security_groups[] | **string**<br>Security groups 
service_database | **string**<br>Database for service tables <br>Default: data source database. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 


### MysqlConnection {#MysqlConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed Service for MySQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremiseMysql](#OnPremiseMysql1)**<br>Connection options for on-premise MySQL 


### OnPremiseMysql {#OnPremiseMysql1}

Field | Description
--- | ---
port | **int64**<br>Database port 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
hosts[] | **string**<br> 
tls_mode | **[TLSMode](#TLSMode1)**<br>TLS settings for server connection. Disabled by default. 


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
database | **string**<br>Database name 
user | **string**<br>User for database access. 
password | **[Secret](#Secret2)**<br>Password for database access. 
include_tables[] | **string**<br>Included tables <br>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns. 
exclude_tables[] | **string**<br>Excluded tables <br>If none or empty list is presented, all tables are replicated. Full table name with schema. Can contain schema_name.* patterns. 
slot_byte_lag_limit | **int64**<br>Maximum lag of replication slot (in bytes); after exceeding this limit replication will be aborted. 
service_schema | **string**<br>Database schema for service tables (__consumer_keeper, __data_transfer_mole_finder). Default is public 
object_transfer_settings | **[PostgresObjectTransferSettings](#PostgresObjectTransferSettings1)**<br>Select database objects to be transferred during activation or deactivation. 
security_groups[] | **string**<br>Security groups 


### PostgresConnection {#PostgresConnection1}

Field | Description
--- | ---
connection | **oneof:** `mdb_cluster_id` or `on_premise`<br>
&nbsp;&nbsp;mdb_cluster_id | **string**<br>Managed Service for PostgreSQL cluster ID 
&nbsp;&nbsp;on_premise | **[OnPremisePostgres](#OnPremisePostgres1)**<br>Connection options for on-premise PostgreSQL 


### OnPremisePostgres {#OnPremisePostgres1}

Field | Description
--- | ---
port | **int64**<br>Will be used if the cluster ID is not specified. 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
hosts[] | **string**<br> 
tls_mode | **[TLSMode](#TLSMode2)**<br>TLS settings for server connection. Disabled by default. 


### PostgresObjectTransferSettings {#PostgresObjectTransferSettings1}

Field | Description
--- | ---
sequence | enum **ObjectTransferStage**<br>Sequences <br>CREATE SEQUENCE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
sequence_owned_by | enum **ObjectTransferStage**<br>Owned sequences <br>CREATE SEQUENCE ... OWNED BY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
table | enum **ObjectTransferStage**<br>Tables <br>CREATE TABLE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
primary_key | enum **ObjectTransferStage**<br>Primary keys <br>ALTER TABLE ... ADD PRIMARY KEY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
fk_constraint | enum **ObjectTransferStage**<br>Foreign keys <br>ALTER TABLE ... ADD FOREIGN KEY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
default_values | enum **ObjectTransferStage**<br>Default values <br>ALTER TABLE ... ALTER COLUMN ... SET DEFAULT ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
constraint | enum **ObjectTransferStage**<br>Constraints <br>ALTER TABLE ... ADD CONSTRAINT ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
index | enum **ObjectTransferStage**<br>Indexes <br>CREATE INDEX ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
view | enum **ObjectTransferStage**<br>Views <br>CREATE VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
function | enum **ObjectTransferStage**<br>Functions <br>CREATE FUNCTION ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
trigger | enum **ObjectTransferStage**<br>Triggers <br>CREATE TRIGGER ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
type | enum **ObjectTransferStage**<br>Types <br>CREATE TYPE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
rule | enum **ObjectTransferStage**<br>Rules <br>CREATE RULE ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
collation | enum **ObjectTransferStage**<br>Collations <br>CREATE COLLATION ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
policy | enum **ObjectTransferStage**<br>Policies <br>CREATE POLICY ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
cast | enum **ObjectTransferStage**<br>Casts <br>CREATE CAST ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
materialized_view | enum **ObjectTransferStage**<br>Materialized views <br>CREATE MATERIALIZED VIEW ... <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>
sequence_set | enum **ObjectTransferStage**<br> <ul><li>`BEFORE_DATA`: Before data transfer</li><li>`AFTER_DATA`: After data transfer</li><li>`NEVER`: Don't copy</li></ul>


### YdbSource {#YdbSource1}

Field | Description
--- | ---
database | **string**<br>Path in YDB where to store tables 
instance | **string**<br>Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 
paths[] | **string**<br> 
service_account_id | **string**<br> 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
sa_key_content | **string**<br>Authorization Key 
security_groups[] | **string**<br>Security groups 
changefeed_custom_name | **string**<br>Pre-created change feed 


### YDSSource {#YDSSource1}

Field | Description
--- | ---
database | **string**<br>Database 
stream | **string**<br>Stream 
service_account_id | **string**<br>SA which has read access to the stream. 
supported_codecs[] | enum **YdsCompressionCodec**<br>Compression codec 
parser | **[Parser](#Parser1)**<br>Data parsing rules 
allow_ttl_rewind | **bool**<br>Should continue working, if consumer read lag exceed TTL of topic False: stop the transfer in error state, if detected lost data. True: continue working with losing part of data 
endpoint | **string**<br>for dedicated db 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
security_groups[] | **string**<br>Security groups 
consumer | **string**<br>for important streams 


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
unescape_string_values | **bool**<br>Unescape string values 


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

Empty.

### CloudLoggingParser {#CloudLoggingParser1}

Empty.

### KafkaSource {#KafkaSource1}

Field | Description
--- | ---
connection | **[KafkaConnectionOptions](#KafkaConnectionOptions1)**<br>Connection settings 
auth | **[KafkaAuth](#KafkaAuth1)**<br>Authentication settings 
security_groups[] | **string**<br>Security groups 
topic_name | **string**<br>Full source topic name Deprecated in favor of topic names 
transformer | **[DataTransformationOptions](#DataTransformationOptions1)**<br>Data transformation rules 
parser | **[Parser](#Parser2)**<br>Data parsing rules 
topic_names[] | **string**<br>List of topic names to read 


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
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
tls_mode | **[TLSMode](#TLSMode2)**<br>TLS settings for broker connection. Disabled by default. 


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
mechanism | enum **KafkaMechanism**<br>SASL mechanism for authentication 
password | **[Secret](#Secret2)**<br>Password for user 


### NoAuth {#NoAuth1}

Empty.

### DataTransformationOptions {#DataTransformationOptions1}

Field | Description
--- | ---
cloud_function | **string**<br>Cloud function 
number_of_retries | **int64**<br>Number of retries 
buffer_size | **string**<br>Buffer size for function 
buffer_flush_interval | **string**<br>Flush interval 
invocation_timeout | **string**<br>Invocation timeout 
service_account_id | **string**<br>Service account 


### MongoSource {#MongoSource1}

Field | Description
--- | ---
connection | **[MongoConnection](#MongoConnection1)**<br> 
subnet_id | **string**<br> 
collections[] | **[MongoCollection](#MongoCollection1)**<br>List of collections for replication. Empty list implies replication of all tables on the deployment. Allowed to use * as collection name. 
excluded_collections[] | **[MongoCollection](#MongoCollection1)**<br>List of forbidden collections for replication. Allowed to use * as collection name for forbid all collections of concrete schema. 
secondary_preferred_mode | **bool**<br>Read mode for mongo client 
security_groups[] | **string**<br>Security groups 


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
replica_set | **string**<br> 
tls_mode | **[TLSMode](#TLSMode2)**<br> 


### MongoCollection {#MongoCollection1}

Field | Description
--- | ---
database_name | **string**<br> 
collection_name | **string**<br> 


### ClickhouseSource {#ClickhouseSource1}

Field | Description
--- | ---
connection | **[ClickhouseConnection](#ClickhouseConnection1)**<br> 
include_tables[] | **string**<br>While list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns. 
exclude_tables[] | **string**<br>Exclude list of tables for replication. If none or empty list is presented - will replicate all tables. Can contain * patterns. 
subnet_id | **string**<br> 
security_groups[] | **string**<br> 


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
user | **string**<br> 
password | **[Secret](#Secret2)**<br> 
database | **string**<br>Database 


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
database | **string**<br>Database name <br>Allowed to leave it empty, then the tables will be created in databases with the same names as on the source. If this field is empty, then you must fill below db schema for service table. 
user | **string**<br>User for database access. 
password | **[Secret](#Secret2)**<br>Password for database access. 
sql_mode | **string**<br>Default: NO_AUTO_VALUE_ON_ZERO,NO_DIR_IN_CREATE,NO_ENGINE_SUBSTITUTION. 
skip_constraint_checks | **bool**<br>Disable constraints checks <br>Recommend to disable for increase replication speed, but if schema contain cascading operations we don't recommend to disable. This option set FOREIGN_KEY_CHECKS=0 and UNIQUE_CHECKS=0. 
timezone | **string**<br>Database timezone <br>Is used for parsing timestamps for saving source timezones. Accepts values from IANA timezone database. Default: local timezone. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy <br>Cleanup policy for activate, reactivate and reupload processes. Default is DISABLED. <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>
service_database | **string**<br>Database schema for service table <br>Default: db name. Here created technical tables (__tm_keeper, __tm_gtid_keeper). 
security_groups[] | **string**<br>Security groups 


### PostgresTarget {#PostgresTarget1}

Field | Description
--- | ---
connection | **[PostgresConnection](#PostgresConnection2)**<br>Database connection settings 
database | **string**<br>Database name 
user | **string**<br>User for database access. 
password | **[Secret](#Secret2)**<br>Password for database access. 
cleanup_policy | enum **CleanupPolicy**<br>Cleanup policy for activate, reactivate and reupload processes. Default is truncate. <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>
security_groups[] | **string**<br>Security groups 


### ClickhouseTarget {#ClickhouseTarget1}

Field | Description
--- | ---
connection | **[ClickhouseConnection](#ClickhouseConnection2)**<br> 
subnet_id | **string**<br> 
alt_names[] | **[AltName](#AltName1)**<br>Alternative table names in target 
cleanup_policy | enum **ClickhouseCleanupPolicy**<br> 
sharding | **[ClickhouseSharding](#ClickhouseSharding1)**<br> 
clickhouse_cluster_name | **string**<br> 
security_groups[] | **string**<br> 


### AltName {#AltName1}

Field | Description
--- | ---
from_name | **string**<br>Source table name 
to_name | **string**<br>Target table name 


### ClickhouseSharding {#ClickhouseSharding1}

Field | Description
--- | ---
sharding | **oneof:** `column_value_hash`, `custom_mapping`, `transfer_id` or `round_robin`<br>
&nbsp;&nbsp;column_value_hash | **[ColumnValueHash](#ColumnValueHash1)**<br> 
&nbsp;&nbsp;custom_mapping | **[ColumnValueMapping](#ColumnValueMapping1)**<br> 
&nbsp;&nbsp;transfer_id | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 
&nbsp;&nbsp;round_robin | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**<br> 


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


### YdbTarget {#YdbTarget1}

Field | Description
--- | ---
database | **string**<br>Path in YDB where to store tables 
instance | **string**<br>Instance of YDB. example: ydb-ru-prestable.yandex.net:2135 
path | **string**<br>Path extension for database, each table will be layouted into this path 
service_account_id | **string**<br> 
cleanup_policy | enum **YdbCleanupPolicy**<br>Cleanup policy 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
sa_key_content | **string**<br>SA content 
security_groups[] | **string**<br>Security groups 
is_table_column_oriented | **bool**<br>Should create column-oriented table (OLAP). By default it creates row-oriented (OLTP) 
default_compression | enum **YdbDefaultCompression**<br>Compression that will be used for default columns family on YDB table creation 


### KafkaTarget {#KafkaTarget1}

Field | Description
--- | ---
connection | **[KafkaConnectionOptions](#KafkaConnectionOptions2)**<br>Connection settings 
auth | **[KafkaAuth](#KafkaAuth2)**<br>Authentication settings 
security_groups[] | **string**<br>Security groups 
topic_settings | **[KafkaTargetTopicSettings](#KafkaTargetTopicSettings1)**<br>Target topic settings 
serializer | **[Serializer](#Serializer1)**<br>Data serialization format settings 


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


### Serializer {#Serializer1}

Field | Description
--- | ---
serializer | **oneof:** `serializer_auto`, `serializer_json` or `serializer_debezium`<br>
&nbsp;&nbsp;serializer_auto | **[SerializerAuto](#SerializerAuto1)**<br>Select the serialization format automatically 
&nbsp;&nbsp;serializer_json | **[SerializerJSON](#SerializerJSON1)**<br>Serialize data in json format 
&nbsp;&nbsp;serializer_debezium | **[SerializerDebezium](#SerializerDebezium1)**<br>Serialize data in debezium format 


### SerializerAuto {#SerializerAuto1}

Empty.

### SerializerJSON {#SerializerJSON1}

Empty.

### SerializerDebezium {#SerializerDebezium1}

Field | Description
--- | ---
serializer_parameters[] | **[DebeziumSerializerParameter](#DebeziumSerializerParameter1)**<br>Settings of sterilization parameters as key-value pairs 


### DebeziumSerializerParameter {#DebeziumSerializerParameter1}

Field | Description
--- | ---
key | **string**<br>Name of the serializer parameter 
value | **string**<br>Value of the serializer parameter 


### MongoTarget {#MongoTarget1}

Field | Description
--- | ---
connection | **[MongoConnection](#MongoConnection2)**<br> 
database | **string**<br>Database name 
cleanup_policy | enum **CleanupPolicy**<br> <ul><li>`DISABLED`: Don't cleanup</li><li>`DROP`: Drop</li><li>`TRUNCATE`: Truncate</li></ul>
subnet_id | **string**<br> 
security_groups[] | **string**<br>Security groups 


### MetrikaSource {#MetrikaSource1}

Field | Description
--- | ---
counter_ids[] | **int64**<br> 
token | **[Secret](#Secret2)**<br> 
streams[] | **[MetrikaStream](#MetrikaStream1)**<br> 


### MetrikaStream {#MetrikaStream1}

Field | Description
--- | ---
type | enum **MetrikaStreamType**<br> 
columns[] | **string**<br> 


### YDSTarget {#YDSTarget1}

Field | Description
--- | ---
database | **string**<br>Database 
stream | **string**<br>Stream 
service_account_id | **string**<br>SA which has read access to the stream. 
save_tx_order | **bool**<br>Save transaction order Not to split events queue into separate per-table queues. Incompatible with setting Topic prefix, only with Topic full name. 
serializer | **[Serializer](#Serializer2)**<br>Data serialization format 
endpoint | **string**<br>for dedicated db 
subnet_id | **string**<br>Network interface for endpoint. If none will assume public ipv4 
security_groups[] | **string**<br>Security groups 


### Runtime {#Runtime3}

Field | Description
--- | ---
runtime | **oneof:** `yc_runtime`<br>
&nbsp;&nbsp;yc_runtime | **[YcRuntime](#YcRuntime3)**<br> 


### YcRuntime {#YcRuntime3}

Field | Description
--- | ---
job_count | **int64**<br> 
upload_shard_params | **[ShardingUploadParams](#ShardingUploadParams3)**<br> 


### ShardingUploadParams {#ShardingUploadParams3}

Field | Description
--- | ---
job_count | **int64**<br> 
process_count | **int64**<br> 


### Transformation {#Transformation3}

Field | Description
--- | ---
transformers[] | **[Transformer](#Transformer3)**<br>Transformers are set as a list. When activating a transfer, a transformation plan is made for the tables that match the specified criteria. Transformers are applied to the tables in the sequence specified in the list. 


### Transformer {#Transformer3}

Field | Description
--- | ---
transformer | **oneof:** `mask_field`, `filter_columns`, `rename_tables`, `replace_primary_key`, `convert_to_string`, `sharder_transformer`, `table_splitter_transformer` or `filter_rows`<br>
&nbsp;&nbsp;mask_field | **[MaskFieldTransformer](#MaskFieldTransformer3)**<br> 
&nbsp;&nbsp;filter_columns | **[FilterColumnsTransformer](#FilterColumnsTransformer3)**<br> 
&nbsp;&nbsp;rename_tables | **[RenameTablesTransformer](#RenameTablesTransformer3)**<br> 
&nbsp;&nbsp;replace_primary_key | **[ReplacePrimaryKeyTransformer](#ReplacePrimaryKeyTransformer3)**<br> 
&nbsp;&nbsp;convert_to_string | **[ToStringTransformer](#ToStringTransformer3)**<br> 
&nbsp;&nbsp;sharder_transformer | **[SharderTransformer](#SharderTransformer3)**<br> 
&nbsp;&nbsp;table_splitter_transformer | **[TableSplitterTransformer](#TableSplitterTransformer3)**<br> 
&nbsp;&nbsp;filter_rows | **[FilterRowsTransformer](#FilterRowsTransformer3)**<br> 


### MaskFieldTransformer {#MaskFieldTransformer3}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter3)**<br>List of included and excluded tables 
columns[] | **string**<br>Specify the name of the column for data masking (a regular expression). 
function | **[MaskFunction](#MaskFunction3)**<br>Mask function 


### TablesFilter {#TablesFilter3}

Field | Description
--- | ---
include_tables[] | **string**<br>List of tables that will be included to transfer 
exclude_tables[] | **string**<br>List of tables that will be excluded to transfer 


### MaskFunction {#MaskFunction3}

Field | Description
--- | ---
mask_function | **oneof:** `mask_function_hash`<br>
&nbsp;&nbsp;mask_function_hash | **[MaskFunctionHash](#MaskFunctionHash3)**<br>Hash mask function 


### MaskFunctionHash {#MaskFunctionHash3}

Field | Description
--- | ---
user_defined_salt | **string**<br>This string will be used in the HMAC(sha256, salt) function applied to the column data. 


### FilterColumnsTransformer {#FilterColumnsTransformer3}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter4)**<br>List of the tables to filter using lists of included and excluded tables. 
columns | **[ColumnsFilter](#ColumnsFilter3)**<br>List of the columns to transfer to the target tables using lists of included and excluded columns. 


### ColumnsFilter {#ColumnsFilter3}

Field | Description
--- | ---
include_columns[] | **string**<br>List of columns that will be included to transfer 
exclude_columns[] | **string**<br>List of columns that will be excluded to transfer 


### RenameTablesTransformer {#RenameTablesTransformer3}

Field | Description
--- | ---
rename_tables[] | **[RenameTable](#RenameTable3)**<br>List of renaming rules 


### RenameTable {#RenameTable3}

Field | Description
--- | ---
original_name | **[Table](#Table3)**<br>Specify the current names of the table in the source 
new_name | **[Table](#Table3)**<br>Specify the new names for this table in the target 


### Table {#Table3}

Field | Description
--- | ---
name_space | **string**<br> 
name | **string**<br> 


### ReplacePrimaryKeyTransformer {#ReplacePrimaryKeyTransformer3}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter4)**<br>List of included and excluded tables 
keys[] | **string**<br>List of columns to be used as primary keys 


### ToStringTransformer {#ToStringTransformer3}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter4)**<br>List of included and excluded tables 
columns | **[ColumnsFilter](#ColumnsFilter4)**<br>List of included and excluded columns 


### SharderTransformer {#SharderTransformer3}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter4)**<br>List of included and excluded tables 
columns | **[ColumnsFilter](#ColumnsFilter4)**<br>List of included and excluded columns 
shards_count | **int64**<br>Number of shards 


### TableSplitterTransformer {#TableSplitterTransformer3}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter4)**<br>List of included and excluded tables 
columns[] | **string**<br>Specify the columns in the tables to be partitioned. 
splitter | **string**<br>Specify the split string to be used for merging components in a new table name. 


### FilterRowsTransformer {#FilterRowsTransformer3}

Field | Description
--- | ---
tables | **[TablesFilter](#TablesFilter4)**<br>List of included and excluded tables 
filter | **string**<br>Filtering criterion. This can be comparison operators for numeric, string, and Boolean values, comparison to NULL, and checking whether a substring is part of a string. For more details see [documentation](/docs/data-transfer/concepts/data-transformation#append-only-sources). 


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


