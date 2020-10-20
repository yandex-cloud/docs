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

**rpc Get ([GetDatabaseRequest](#GetDatabaseRequest)) returns ([Database](#Database))**

### GetDatabaseRequest {#GetDatabaseRequest}

Field | Description
--- | ---
database_id | **string**<br>Required. Required. ID of the YDB cluster. The maximum string length in characters is 50.


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
storage_config | **[StorageConfig](#StorageConfig)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 
document_api_endpoint | **string**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale)**<br> 


### FixedScale {#FixedScale}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig1)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy1)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig1}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption1)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption1}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy1}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale1)**<br> 


### FixedScale {#FixedScale1}

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
databases[] | **[Database](#Database1)**<br> 
next_page_token | **string**<br>This token allows you to get the next page of results for ListDatabases requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListDatabases request. Subsequent ListDatabases requests will have their own `next_page_token` to continue paging through the results. 


### Database {#Database1}

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
storage_config | **[StorageConfig](#StorageConfig2)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy2)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase1)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase1)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase1)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase1)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 
document_api_endpoint | **string**<br> 


### StorageConfig {#StorageConfig2}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption2)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption2}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy2}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale2)**<br> 


### FixedScale {#FixedScale2}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase1}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase1}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase1}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig3)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy3)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig3}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption3)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption3}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy3}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale3)**<br> 


### FixedScale {#FixedScale3}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase1}



## Create {#Create}

Creates a new database.

**rpc Create ([CreateDatabaseRequest](#CreateDatabaseRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDatabaseMetadata](#CreateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database2)<br>

### CreateDatabaseRequest {#CreateDatabaseRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig4)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy4)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase2)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase2)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase2)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase2)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 


### StorageConfig {#StorageConfig4}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption4)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption4}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy4}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale4)**<br> 


### FixedScale {#FixedScale4}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase2}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase2}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase2}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig5)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy5)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig5}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption5)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption5}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy5}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale5)**<br> 


### FixedScale {#FixedScale5}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase2}



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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database2)>**<br>if operation finished successfully. 


### CreateDatabaseMetadata {#CreateDatabaseMetadata}

Field | Description
--- | ---
database_id | **string**<br>Required. ID of the YDB cluster. 
database_name | **string**<br>Required. Name of the creating database. 


### Database {#Database2}

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
storage_config | **[StorageConfig](#StorageConfig6)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy6)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase3)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase3)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase3)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase3)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 
document_api_endpoint | **string**<br> 


### StorageConfig {#StorageConfig6}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption6)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption6}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy6}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale6)**<br> 


### FixedScale {#FixedScale6}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase3}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase3}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase3}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig7)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy7)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig7}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption7)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption7}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy7}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale7)**<br> 


### FixedScale {#FixedScale7}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase3}



## Update {#Update}

Modifies the specified database.

**rpc Update ([UpdateDatabaseRequest](#UpdateDatabaseRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDatabaseMetadata](#UpdateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database3)<br>

### UpdateDatabaseRequest {#UpdateDatabaseRequest}

Field | Description
--- | ---
folder_id | **string**<br> 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
database_id | **string**<br> 
name | **string**<br> 
description | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig8)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy8)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase4)**<br> 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase4)**<br> 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase4)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase4)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 


### StorageConfig {#StorageConfig8}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption8)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption8}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy8}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale8)**<br> 


### FixedScale {#FixedScale8}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase4}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase4}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase4}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig9)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy9)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig9}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption9)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption9}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy9}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale9)**<br> 


### FixedScale {#FixedScale9}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase4}



### Operation {#Operation1}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database3)>**<br>if operation finished successfully. 


### UpdateDatabaseMetadata {#UpdateDatabaseMetadata}

Field | Description
--- | ---
database_id | **string**<br> 
database_name | **string**<br> 


### Database {#Database3}

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
storage_config | **[StorageConfig](#StorageConfig10)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy10)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase5)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase5)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase5)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase5)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 
document_api_endpoint | **string**<br> 


### StorageConfig {#StorageConfig10}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption10)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption10}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy10}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale10)**<br> 


### FixedScale {#FixedScale10}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase5}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase5}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase5}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig11)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy11)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig11}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption11)**<br> The minimum number of elements is 1.


### StorageOption {#StorageOption11}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy11}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale11)**<br> 


### FixedScale {#FixedScale11}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase5}



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


### Operation {#Operation2}

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


