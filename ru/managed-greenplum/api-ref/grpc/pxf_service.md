---
editable: false
sourcePath: en/_api-ref-grpc/managed-greenplum/api-ref/grpc/pxf_service.md
---

# Managed Service for Greenplum® API, gRPC: PXFDatasourceService



| Call | Description |
| --- | --- |
| [List](#List) | List all PXF datasources |
| [Create](#Create) | Creates PXF datasource |
| [Update](#Update) | Update PXF datasource |
| [Delete](#Delete) | Delete PXF datasource |

## Calls PXFDatasourceService {#calls}

## List {#List}

List all PXF datasources

**rpc List ([ListPXFDatasourcesRequest](#ListPXFDatasourcesRequest)) returns ([ListPXFDatasourcesResponse](#ListPXFDatasourcesResponse))**

### ListPXFDatasourcesRequest {#ListPXFDatasourcesRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.


### ListPXFDatasourcesResponse {#ListPXFDatasourcesResponse}

Field | Description
--- | ---
datasources[] | **[PXFDatasource](#PXFDatasource)**<br> 


### PXFDatasource {#PXFDatasource}

Field | Description
--- | ---
name | **string**<br>Required.  The string length in characters must be 3-200.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS3)**<br> 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC)**<br> 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS)**<br> 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive)**<br> 


### PXFDatasourceS3 {#PXFDatasourceS3}

Field | Description
--- | ---
access_key | **string**<br> The maximum string length in characters is 200.
secret_key | **string**<br> The maximum string length in characters is 200.
fast_upload | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
endpoint | **string**<br> The maximum string length in characters is 200.


### PXFDatasourceJDBC {#PXFDatasourceJDBC}

Field | Description
--- | ---
driver | **string**<br>Matches jdbc.driver The maximum string length in characters is 50.
url | **string**<br>Matches jdbc.url The maximum string length in characters is 200.
user | **string**<br>Matches jdbc.user The maximum string length in characters is 200.
password | **string**<br>Matches jdbc.password The maximum string length in characters is 200.
statement_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.batchsize Acceptable values are 50 to 1000, inclusive.
statement_fetch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.fetchsize Acceptable values are 50 to 10000, inclusive.
statement_query_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.querytimeout Acceptable values are 5 to 600, inclusive.
pool_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Matches jdbc.pool.enabled 
pool_maximum_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.maximumpoolsize Acceptable values are 10 to 200, inclusive.
pool_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.connectiontimeout Acceptable values are 5000 to 600000, inclusive.
pool_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.idletimeout Acceptable values are 5000 to 600000, inclusive.
pool_minimum_idle | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.minimumidle Acceptable values are 0 to 200, inclusive.


### PXFDatasourceHDFS {#PXFDatasourceHDFS}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore)**<br> 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos)**<br> 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
username | **string**<br> The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
dfs | **[PXFDatasourceHDFSDfs](#PXFDatasourceHDFSDfs)**<br> 
yarn | **[PXFDatasourceHDFSYarn](#PXFDatasourceHDFSYarn)**<br> 


### PXFDatasourceCore {#PXFDatasourceCore}

Field | Description
--- | ---
default_fs | **string**<br> The maximum string length in characters is 200.
security_auth_to_local | **string**<br> The maximum string length in characters is 1000.


### PXFDatasourceKerberos {#PXFDatasourceKerberos}

Field | Description
--- | ---
enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
primary | **string**<br> The maximum string length in characters is 128.
realm | **string**<br> The maximum string length in characters is 1000.
kdc_servers[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
admin_server | **string**<br> The maximum string length in characters is 128.
default_domain | **string**<br> The maximum string length in characters is 128.
keytab_base64 | **string**<br> Value must match the regular expression ` ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$ `. The maximum string length in characters is 65536.


### PXFDatasourceHDFSDfs {#PXFDatasourceHDFSDfs}

Field | Description
--- | ---
ha_automatic_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
block_access_token_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
use_datanode_hostname | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
namenodes | **map<string,PXFDatasourceHDFSDfsNamenode>**<br> No more than 10000 per resource.


### PXFDatasourceHDFSYarn {#PXFDatasourceHDFSYarn}

Field | Description
--- | ---
resourcemanager_ha_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_ha_auto_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_ha_auto_failover_embedded | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_cluster_id | **string**<br> The maximum string length in characters is 1000.
ha_rm | **map<string,PXFDatasourceHDFSYarnHaRm>**<br> No more than 10000 per resource.


### PXFDatasourceHive {#PXFDatasourceHive}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore1)**<br> 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos1)**<br> 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
username | **string**<br> The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
ppd | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
metastore_uris[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
metastore_kerberos_principal | **string**<br> The maximum string length in characters is 1000.
auth_kerberos_principal | **string**<br> The maximum string length in characters is 1000.


## Create {#Create}

Creates PXF datasource

**rpc Create ([CreatePXFDatasourceRequest](#CreatePXFDatasourceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreatePXFDatasourceMetadata](#CreatePXFDatasourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PXFDatasource](#PXFDatasource1)<br>

### CreatePXFDatasourceRequest {#CreatePXFDatasourceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource | **[PXFDatasource](#PXFDatasource1)**<br> 


### PXFDatasource {#PXFDatasource1}

Field | Description
--- | ---
name | **string**<br>Required.  The string length in characters must be 3-200.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS31)**<br> 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC1)**<br> 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS1)**<br> 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive1)**<br> 


### PXFDatasourceS3 {#PXFDatasourceS31}

Field | Description
--- | ---
access_key | **string**<br> The maximum string length in characters is 200.
secret_key | **string**<br> The maximum string length in characters is 200.
fast_upload | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
endpoint | **string**<br> The maximum string length in characters is 200.


### PXFDatasourceJDBC {#PXFDatasourceJDBC1}

Field | Description
--- | ---
driver | **string**<br>Matches jdbc.driver The maximum string length in characters is 50.
url | **string**<br>Matches jdbc.url The maximum string length in characters is 200.
user | **string**<br>Matches jdbc.user The maximum string length in characters is 200.
password | **string**<br>Matches jdbc.password The maximum string length in characters is 200.
statement_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.batchsize Acceptable values are 50 to 1000, inclusive.
statement_fetch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.fetchsize Acceptable values are 50 to 10000, inclusive.
statement_query_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.querytimeout Acceptable values are 5 to 600, inclusive.
pool_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Matches jdbc.pool.enabled 
pool_maximum_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.maximumpoolsize Acceptable values are 10 to 200, inclusive.
pool_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.connectiontimeout Acceptable values are 5000 to 600000, inclusive.
pool_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.idletimeout Acceptable values are 5000 to 600000, inclusive.
pool_minimum_idle | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.minimumidle Acceptable values are 0 to 200, inclusive.


### PXFDatasourceHDFS {#PXFDatasourceHDFS1}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore1)**<br> 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos1)**<br> 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
username | **string**<br> The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
dfs | **[PXFDatasourceHDFSDfs](#PXFDatasourceHDFSDfs1)**<br> 
yarn | **[PXFDatasourceHDFSYarn](#PXFDatasourceHDFSYarn1)**<br> 


### PXFDatasourceCore {#PXFDatasourceCore1}

Field | Description
--- | ---
default_fs | **string**<br> The maximum string length in characters is 200.
security_auth_to_local | **string**<br> The maximum string length in characters is 1000.


### PXFDatasourceKerberos {#PXFDatasourceKerberos1}

Field | Description
--- | ---
enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
primary | **string**<br> The maximum string length in characters is 128.
realm | **string**<br> The maximum string length in characters is 1000.
kdc_servers[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
admin_server | **string**<br> The maximum string length in characters is 128.
default_domain | **string**<br> The maximum string length in characters is 128.
keytab_base64 | **string**<br> Value must match the regular expression ` ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$ `. The maximum string length in characters is 65536.


### PXFDatasourceHDFSDfs {#PXFDatasourceHDFSDfs1}

Field | Description
--- | ---
ha_automatic_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
block_access_token_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
use_datanode_hostname | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
namenodes | **map<string,PXFDatasourceHDFSDfsNamenode>**<br> No more than 10000 per resource.


### PXFDatasourceHDFSYarn {#PXFDatasourceHDFSYarn1}

Field | Description
--- | ---
resourcemanager_ha_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_ha_auto_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_ha_auto_failover_embedded | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_cluster_id | **string**<br> The maximum string length in characters is 1000.
ha_rm | **map<string,PXFDatasourceHDFSYarnHaRm>**<br> No more than 10000 per resource.


### PXFDatasourceHive {#PXFDatasourceHive1}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore2)**<br> 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos2)**<br> 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
username | **string**<br> The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
ppd | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
metastore_uris[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
metastore_kerberos_principal | **string**<br> The maximum string length in characters is 1000.
auth_kerberos_principal | **string**<br> The maximum string length in characters is 1000.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreatePXFDatasourceMetadata](#CreatePXFDatasourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PXFDatasource](#PXFDatasource2)>**<br>if operation finished successfully. 


### CreatePXFDatasourceMetadata {#CreatePXFDatasourceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource_name | **string**<br>Required.  The string length in characters must be 3-200.


### PXFDatasource {#PXFDatasource2}

Field | Description
--- | ---
name | **string**<br>Required.  The string length in characters must be 3-200.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS32)**<br> 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC2)**<br> 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS2)**<br> 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive2)**<br> 


## Update {#Update}

Update PXF datasource

**rpc Update ([UpdatePXFDatasourceRequest](#UpdatePXFDatasourceRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdatePXFDatasourceMetadata](#UpdatePXFDatasourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PXFDatasource](#PXFDatasource3)<br>

### UpdatePXFDatasourceRequest {#UpdatePXFDatasourceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
datasource | **[PXFDatasource](#PXFDatasource3)**<br> 


### PXFDatasource {#PXFDatasource3}

Field | Description
--- | ---
name | **string**<br>Required.  The string length in characters must be 3-200.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS32)**<br> 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC2)**<br> 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS2)**<br> 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive2)**<br> 


### PXFDatasourceS3 {#PXFDatasourceS32}

Field | Description
--- | ---
access_key | **string**<br> The maximum string length in characters is 200.
secret_key | **string**<br> The maximum string length in characters is 200.
fast_upload | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
endpoint | **string**<br> The maximum string length in characters is 200.


### PXFDatasourceJDBC {#PXFDatasourceJDBC2}

Field | Description
--- | ---
driver | **string**<br>Matches jdbc.driver The maximum string length in characters is 50.
url | **string**<br>Matches jdbc.url The maximum string length in characters is 200.
user | **string**<br>Matches jdbc.user The maximum string length in characters is 200.
password | **string**<br>Matches jdbc.password The maximum string length in characters is 200.
statement_batch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.batchsize Acceptable values are 50 to 1000, inclusive.
statement_fetch_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.fetchsize Acceptable values are 50 to 10000, inclusive.
statement_query_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.statement.querytimeout Acceptable values are 5 to 600, inclusive.
pool_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Matches jdbc.pool.enabled 
pool_maximum_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.maximumpoolsize Acceptable values are 10 to 200, inclusive.
pool_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.connectiontimeout Acceptable values are 5000 to 600000, inclusive.
pool_idle_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.idletimeout Acceptable values are 5000 to 600000, inclusive.
pool_minimum_idle | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Matches jdbc.pool.property.minimumidle Acceptable values are 0 to 200, inclusive.


### PXFDatasourceHDFS {#PXFDatasourceHDFS2}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore2)**<br> 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos2)**<br> 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
username | **string**<br> The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
dfs | **[PXFDatasourceHDFSDfs](#PXFDatasourceHDFSDfs2)**<br> 
yarn | **[PXFDatasourceHDFSYarn](#PXFDatasourceHDFSYarn2)**<br> 


### PXFDatasourceCore {#PXFDatasourceCore2}

Field | Description
--- | ---
default_fs | **string**<br> The maximum string length in characters is 200.
security_auth_to_local | **string**<br> The maximum string length in characters is 1000.


### PXFDatasourceKerberos {#PXFDatasourceKerberos2}

Field | Description
--- | ---
enable | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
primary | **string**<br> The maximum string length in characters is 128.
realm | **string**<br> The maximum string length in characters is 1000.
kdc_servers[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
admin_server | **string**<br> The maximum string length in characters is 128.
default_domain | **string**<br> The maximum string length in characters is 128.
keytab_base64 | **string**<br> Value must match the regular expression ` ^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==\|[A-Za-z0-9+/]{3}=)?$ `. The maximum string length in characters is 65536.


### PXFDatasourceHDFSDfs {#PXFDatasourceHDFSDfs2}

Field | Description
--- | ---
ha_automatic_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
block_access_token_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
use_datanode_hostname | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
namenodes | **map<string,PXFDatasourceHDFSDfsNamenode>**<br> No more than 10000 per resource.


### PXFDatasourceHDFSYarn {#PXFDatasourceHDFSYarn2}

Field | Description
--- | ---
resourcemanager_ha_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_ha_auto_failover_enabled | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_ha_auto_failover_embedded | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
resourcemanager_cluster_id | **string**<br> The maximum string length in characters is 1000.
ha_rm | **map<string,PXFDatasourceHDFSYarnHaRm>**<br> No more than 10000 per resource.


### PXFDatasourceHive {#PXFDatasourceHive2}

Field | Description
--- | ---
core | **[PXFDatasourceCore](#PXFDatasourceCore3)**<br> 
kerberos | **[PXFDatasourceKerberos](#PXFDatasourceKerberos3)**<br> 
user_impersonation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
username | **string**<br> The maximum string length in characters is 128.
sasl_connection_retries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br> Acceptable values are 1 to 50, inclusive.
zk_hosts[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
ppd | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br> 
metastore_uris[] | **string**<br> The maximum number of elements is 200. The string length in characters for each value must be 1-200.
metastore_kerberos_principal | **string**<br> The maximum string length in characters is 1000.
auth_kerberos_principal | **string**<br> The maximum string length in characters is 1000.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdatePXFDatasourceMetadata](#UpdatePXFDatasourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PXFDatasource](#PXFDatasource4)>**<br>if operation finished successfully. 


### UpdatePXFDatasourceMetadata {#UpdatePXFDatasourceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource_name | **string**<br>Required.  The string length in characters must be 3-200.


### PXFDatasource {#PXFDatasource4}

Field | Description
--- | ---
name | **string**<br>Required.  The string length in characters must be 3-200.
settings | **oneof:** `s3`, `jdbc`, `hdfs` or `hive`<br>
&nbsp;&nbsp;s3 | **[PXFDatasourceS3](#PXFDatasourceS33)**<br> 
&nbsp;&nbsp;jdbc | **[PXFDatasourceJDBC](#PXFDatasourceJDBC3)**<br> 
&nbsp;&nbsp;hdfs | **[PXFDatasourceHDFS](#PXFDatasourceHDFS3)**<br> 
&nbsp;&nbsp;hive | **[PXFDatasourceHive](#PXFDatasourceHive3)**<br> 


## Delete {#Delete}

Delete PXF datasource

**rpc Delete ([DeletePXFDatasourceRequest](#DeletePXFDatasourceRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeletePXFDatasourceMetadata](#DeletePXFDatasourceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeletePXFDatasourceRequest {#DeletePXFDatasourceRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource_name | **string**<br>Required.  The string length in characters must be 3-200.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeletePXFDatasourceMetadata](#DeletePXFDatasourceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeletePXFDatasourceMetadata {#DeletePXFDatasourceMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>Required.  The maximum string length in characters is 50.
datasource_name | **string**<br>Required.  The string length in characters must be 3-200.


