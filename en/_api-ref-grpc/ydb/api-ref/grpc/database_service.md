---
editable: false
---

# DatabaseService

A set of methods for managing databases.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified database. |
| [List](#List) | Retrieves a list of databases. |
| [Create](#Create) | Creates a new database. |
| [Update](#Update) | Modifies the specified database. |
| [Delete](#Delete) | Deletes the specified database. |

## Calls DatabaseService {#calls}

## Get {#Get}

Returns the specified database.

**rpc Get ([GetDatabaseRequest](#GetDatabaseRequest)) returns ([Database](../database.proto#Database))**

### GetDatabaseRequest {#GetDatabaseRequest}

Field | Description
--- | ---
database_id | **string**<br>Required. Required. ID of the YDB cluster. false The maximum string length in characters is 50.


### Database {#Database}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> <ul><ul/>
endpoint | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](../database.proto#ZonalDatabase)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](../database.proto#RegionalDatabase)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](../database.proto#DedicatedDatabase)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](../database.proto#ServerlessDatabase)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](../database.proto#StorageOption)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../database.proto#FixedScale)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false


### RegionalDatabase {#RegionalDatabase}

Field | Description
--- | ---
region_id | **string**<br>Required.  false


### DedicatedDatabase {#DedicatedDatabase}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig1)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy1)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](../database.proto#StorageOption1)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../database.proto#FixedScale1)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase}



## List {#List}

Retrieves a list of databases.

**rpc List ([ListDatabasesRequest](#ListDatabasesRequest)) returns ([ListDatabasesResponse](#ListDatabasesResponse))**

### ListDatabasesRequest {#ListDatabasesRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListDatabases requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListDatabases request to get the next page of results. The maximum string length in characters is 100.


### ListDatabasesResponse {#ListDatabasesResponse}

Field | Description
--- | ---
databases[] | **[Database](../database.proto#Database1)**<br> 
next_page_token | **string**<br>This token allows you to get the next page of results for ListDatabases requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListDatabases request. Subsequent ListDatabases requests will have their own `next_page_token` to continue paging through the results. 


### Database {#Database}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> <ul><ul/>
endpoint | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig2)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy2)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](../database.proto#ZonalDatabase1)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](../database.proto#RegionalDatabase1)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](../database.proto#DedicatedDatabase1)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](../database.proto#ServerlessDatabase1)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](../database.proto#StorageOption2)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../database.proto#FixedScale2)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false


### RegionalDatabase {#RegionalDatabase}

Field | Description
--- | ---
region_id | **string**<br>Required.  false


### DedicatedDatabase {#DedicatedDatabase}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig3)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy3)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](../database.proto#StorageOption3)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../database.proto#FixedScale3)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase}



## Create {#Create}

Creates a new database.

**rpc Create ([CreateDatabaseRequest](#CreateDatabaseRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDatabaseMetadata](#CreateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](../database.proto#Database2)<br>

### CreateDatabaseRequest {#CreateDatabaseRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig4)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy4)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](../database.proto#ZonalDatabase2)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](../database.proto#RegionalDatabase2)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](../database.proto#DedicatedDatabase2)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](../database.proto#ServerlessDatabase2)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](../database.proto#StorageOption4)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../database.proto#FixedScale4)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false


### RegionalDatabase {#RegionalDatabase}

Field | Description
--- | ---
region_id | **string**<br>Required.  false


### DedicatedDatabase {#DedicatedDatabase}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig5)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy5)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](../database.proto#StorageOption5)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../database.proto#FixedScale5)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase}



### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDatabaseMetadata](#CreateDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](../database.proto#Database2)>**<br>if operation finished successfully. 


### CreateDatabaseMetadata {#CreateDatabaseMetadata}

Field | Description
--- | ---
database_id | **string**<br>Required. ID of the YDB cluster. 
database_name | **string**<br>Required. Name of the creating database. 


### Database {#Database}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> <ul><ul/>
endpoint | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig6)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy6)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](../database.proto#ZonalDatabase3)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](../database.proto#RegionalDatabase3)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](../database.proto#DedicatedDatabase3)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](../database.proto#ServerlessDatabase3)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 


## Update {#Update}

Modifies the specified database.

**rpc Update ([UpdateDatabaseRequest](#UpdateDatabaseRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDatabaseMetadata](#UpdateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](../database.proto#Database3)<br>

### UpdateDatabaseRequest {#UpdateDatabaseRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
database_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig6)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy6)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](../database.proto#ZonalDatabase3)**<br> 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](../database.proto#RegionalDatabase3)**<br> 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](../database.proto#DedicatedDatabase3)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](../database.proto#ServerlessDatabase3)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](../database.proto#StorageOption6)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../database.proto#FixedScale6)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase}

Field | Description
--- | ---
zone_id | **string**<br>Required.  false


### RegionalDatabase {#RegionalDatabase}

Field | Description
--- | ---
region_id | **string**<br>Required.  false


### DedicatedDatabase {#DedicatedDatabase}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig7)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy7)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](../database.proto#StorageOption7)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](../database.proto#FixedScale7)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase}



### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDatabaseMetadata](#UpdateDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](../database.proto#Database3)>**<br>if operation finished successfully. 


### UpdateDatabaseMetadata {#UpdateDatabaseMetadata}

Field | Description
--- | ---
database_id | **string**<br> 
database_name | **string**<br> 


### Database {#Database}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> <ul><ul/>
endpoint | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](../database.proto#StorageConfig8)**<br> 
scale_policy | **[ScalePolicy](../database.proto#ScalePolicy8)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](../database.proto#ZonalDatabase4)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](../database.proto#RegionalDatabase4)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](../database.proto#DedicatedDatabase4)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](../database.proto#ServerlessDatabase4)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 


## Delete {#Delete}

Deletes the specified database.

**rpc Delete ([DeleteDatabaseRequest](#DeleteDatabaseRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDatabaseRequest {#DeleteDatabaseRequest}

Field | Description
--- | ---
database_id | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDatabaseMetadata {#DeleteDatabaseMetadata}

Field | Description
--- | ---
database_id | **string**<br> 
database_name | **string**<br> 


