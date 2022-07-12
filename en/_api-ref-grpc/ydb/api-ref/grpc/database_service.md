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
| [Start](#Start) | Starts the specified database. |
| [Stop](#Stop) | Stops the specified database. |
| [ListAccessBindings](#ListAccessBindings) |  |
| [SetAccessBindings](#SetAccessBindings) |  |
| [UpdateAccessBindings](#UpdateAccessBindings) |  |
| [Delete](#Delete) | Deletes the specified database. |
| [Restore](#Restore) | Restores the specified backup |
| [Backup](#Backup) |  |

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
status | enum **Status**<br> 
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
backup_config | **[BackupConfig](#BackupConfig)**<br> 
document_api_endpoint | **string**<br> 
kinesis_api_endpoint | **string**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig)**<br> 


### StorageConfig {#StorageConfig}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings)**<br> 


### BackupSettings {#BackupSettings}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert)**<br> 


### Alert {#Alert}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue)**<br> 


### DoubleParameterValue {#DoubleParameterValue}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


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
status | enum **Status**<br> 
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
backup_config | **[BackupConfig](#BackupConfig1)**<br> 
document_api_endpoint | **string**<br> 
kinesis_api_endpoint | **string**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig1)**<br> 


### StorageConfig {#StorageConfig2}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption2)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig1}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings1)**<br> 


### BackupSettings {#BackupSettings1}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule1)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule1}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule1)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule1)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule1)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule1}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule1}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule1)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule1}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule1}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig1}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert1)**<br> 


### Alert {#Alert1}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel1)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter1)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter1)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel1}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter1}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue1)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue1)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue1)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue1)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue1)**<br> 


### DoubleParameterValue {#DoubleParameterValue1}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue1}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue1}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue1}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue1}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


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
backup_config | **[BackupConfig](#BackupConfig2)**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig2)**<br> 


### StorageConfig {#StorageConfig4}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption4)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig2}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings2)**<br> 


### BackupSettings {#BackupSettings2}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule2)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule2}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule2)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule2)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule2)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule2}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule2}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule2)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule2}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule2}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig2}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert2)**<br> 


### Alert {#Alert2}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel2)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter2)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter2)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel2}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter2}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue2)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue2)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue2)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue2)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue2)**<br> 


### DoubleParameterValue {#DoubleParameterValue2}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue2}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue2}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue2}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue2}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


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
status | enum **Status**<br> 
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
backup_config | **[BackupConfig](#BackupConfig3)**<br> 
document_api_endpoint | **string**<br> 
kinesis_api_endpoint | **string**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig3)**<br> 


### StorageConfig {#StorageConfig6}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption6)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig3}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings3)**<br> 


### BackupSettings {#BackupSettings3}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule3)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule3}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule3)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule3)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule3)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule3}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule3}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule3)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule3}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule3}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig3}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert3)**<br> 


### Alert {#Alert3}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel3)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter3)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter3)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel3}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter3}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue3)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue3)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue3)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue3)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue3)**<br> 


### DoubleParameterValue {#DoubleParameterValue3}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue3}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue3}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue3}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue3}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


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
backup_config | **[BackupConfig](#BackupConfig4)**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig4)**<br> 


### StorageConfig {#StorageConfig8}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption8)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig4}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings4)**<br> 


### BackupSettings {#BackupSettings4}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule4)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule4}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule4)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule4)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule4)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule4}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule4}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule4)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule4}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule4}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig4}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert4)**<br> 


### Alert {#Alert4}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel4)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter4)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter4)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel4}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter4}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue4)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue4)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue4)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue4)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue4)**<br> 


### DoubleParameterValue {#DoubleParameterValue4}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue4}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue4}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue4}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue4}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


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
status | enum **Status**<br> 
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
backup_config | **[BackupConfig](#BackupConfig5)**<br> 
document_api_endpoint | **string**<br> 
kinesis_api_endpoint | **string**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig5)**<br> 


### StorageConfig {#StorageConfig10}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption10)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


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

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig5}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings5)**<br> 


### BackupSettings {#BackupSettings5}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule5)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule5}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule5)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule5)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule5)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule5}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule5}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule5)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule5}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule5}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig5}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert5)**<br> 


### Alert {#Alert5}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel5)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter5)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter5)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel5}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter5}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue5)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue5)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue5)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue5)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue5)**<br> 


### DoubleParameterValue {#DoubleParameterValue5}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue5}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue5}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue5}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue5}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


## Start {#Start}

Starts the specified database.

**rpc Start ([StartDatabaseRequest](#StartDatabaseRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartDatabaseMetadata](#StartDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database4)<br>

### StartDatabaseRequest {#StartDatabaseRequest}

Field | Description
--- | ---
database_id | **string**<br>Required.  The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartDatabaseMetadata](#StartDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database4)>**<br>if operation finished successfully. 


### StartDatabaseMetadata {#StartDatabaseMetadata}

Field | Description
--- | ---
database_id | **string**<br> 
database_name | **string**<br> 


### Database {#Database4}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> 
endpoint | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig12)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy12)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase6)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase6)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase6)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase6)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 
backup_config | **[BackupConfig](#BackupConfig6)**<br> 
document_api_endpoint | **string**<br> 
kinesis_api_endpoint | **string**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig6)**<br> 


### StorageConfig {#StorageConfig12}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption12)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


### StorageOption {#StorageOption12}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy12}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale12)**<br> 


### FixedScale {#FixedScale12}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase6}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase6}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase6}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig13)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy13)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig13}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption13)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


### StorageOption {#StorageOption13}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy13}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale13)**<br> 


### FixedScale {#FixedScale13}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase6}

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig6}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings6)**<br> 


### BackupSettings {#BackupSettings6}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule6)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule6}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule6)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule6)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule6)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule6}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule6}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule6)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule6}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule6}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig6}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert6)**<br> 


### Alert {#Alert6}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel6)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter6)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter6)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel6}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter6}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue6)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue6)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue6)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue6)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue6)**<br> 


### DoubleParameterValue {#DoubleParameterValue6}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue6}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue6}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue6}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue6}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


## Stop {#Stop}

Stops the specified database.

**rpc Stop ([StopDatabaseRequest](#StopDatabaseRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopDatabaseMetadata](#StopDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database5)<br>

### StopDatabaseRequest {#StopDatabaseRequest}

Field | Description
--- | ---
database_id | **string**<br>Required.  The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopDatabaseMetadata](#StopDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database5)>**<br>if operation finished successfully. 


### StopDatabaseMetadata {#StopDatabaseMetadata}

Field | Description
--- | ---
database_id | **string**<br> 
database_name | **string**<br> 


### Database {#Database5}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> 
endpoint | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig14)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy14)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase7)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase7)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase7)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase7)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 
backup_config | **[BackupConfig](#BackupConfig7)**<br> 
document_api_endpoint | **string**<br> 
kinesis_api_endpoint | **string**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig7)**<br> 


### StorageConfig {#StorageConfig14}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption14)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


### StorageOption {#StorageOption14}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy14}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale14)**<br> 


### FixedScale {#FixedScale14}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase7}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase7}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase7}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig15)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy15)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig15}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption15)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


### StorageOption {#StorageOption15}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy15}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale15)**<br> 


### FixedScale {#FixedScale15}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase7}

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig7}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings7)**<br> 


### BackupSettings {#BackupSettings7}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule7)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule7}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule7)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule7)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule7)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule7}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule7}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule7)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule7}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule7}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig7}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert7)**<br> 


### Alert {#Alert7}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel7)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter7)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter7)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel7}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter7}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue7)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue7)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue7)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue7)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue7)**<br> 


### DoubleParameterValue {#DoubleParameterValue7}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue7}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue7}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue7}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue7}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


## ListAccessBindings {#ListAccessBindings}



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


## Delete {#Delete}

Deletes the specified database.

**rpc Delete ([DeleteDatabaseRequest](#DeleteDatabaseRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDatabaseRequest {#DeleteDatabaseRequest}

Field | Description
--- | ---
database_id | **string**<br> 


### Operation {#Operation6}

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


## Restore {#Restore}

Restores the specified backup

**rpc Restore ([RestoreBackupRequest](#RestoreBackupRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreBackupMetadata](#RestoreBackupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database6)<br>

### RestoreBackupRequest {#RestoreBackupRequest}

Field | Description
--- | ---
backup_id | **string**<br>Required. Required. ID of the YDB backup. The maximum string length in characters is 50.
database_id | **string**<br>Required. Required. ID of the YDB database. The maximum string length in characters is 50.
paths_to_restore[] | **string**<br>Specify paths to restore. If empty, all paths will restored by default. 
target_path | **string**<br>Specify target path. 


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestoreBackupMetadata](#RestoreBackupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database6)>**<br>if operation finished successfully. 


### RestoreBackupMetadata {#RestoreBackupMetadata}

Field | Description
--- | ---
backup_id | **string**<br> 
database_id | **string**<br> 


### Database {#Database6}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> 
endpoint | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig16)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy16)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase8)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase8)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase8)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase8)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 
backup_config | **[BackupConfig](#BackupConfig8)**<br> 
document_api_endpoint | **string**<br> 
kinesis_api_endpoint | **string**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig8)**<br> 


### StorageConfig {#StorageConfig16}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption16)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


### StorageOption {#StorageOption16}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy16}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale16)**<br> 


### FixedScale {#FixedScale16}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase8}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase8}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase8}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig17)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy17)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig17}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption17)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


### StorageOption {#StorageOption17}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy17}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale17)**<br> 


### FixedScale {#FixedScale17}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase8}

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig8}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings8)**<br> 


### BackupSettings {#BackupSettings8}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule8)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule8}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule8)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule8)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule8)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule8}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule8}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule8)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule8}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule8}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig8}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert8)**<br> 


### Alert {#Alert8}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel8)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter8)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter8)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel8}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter8}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue8)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue8)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue8)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue8)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue8)**<br> 


### DoubleParameterValue {#DoubleParameterValue8}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue8}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue8}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue8}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue8}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


## Backup {#Backup}



**rpc Backup ([BackupDatabaseRequest](#BackupDatabaseRequest)) returns ([operation.Operation](#Operation8))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupDatabaseMetadata](#BackupDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database7)<br>

### BackupDatabaseRequest {#BackupDatabaseRequest}

Field | Description
--- | ---
database_id | **string**<br> 
backup_settings | **[BackupSettings](#BackupSettings9)**<br>custom backup options, if required. 


### BackupSettings {#BackupSettings9}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule9)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule9}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule9)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule9)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule9)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule9}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule9}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule9)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule9}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule9}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### Operation {#Operation8}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackupDatabaseMetadata](#BackupDatabaseMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database7)>**<br>if operation finished successfully. 


### BackupDatabaseMetadata {#BackupDatabaseMetadata}

Field | Description
--- | ---
backup_id | **string**<br> 
database_id | **string**<br> 


### Database {#Database7}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
status | enum **Status**<br> 
endpoint | **string**<br> 
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig18)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy18)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
database_type | **oneof:** `zonal_database`, `regional_database`, `dedicated_database` or `serverless_database`<br>
&nbsp;&nbsp;zonal_database | **[ZonalDatabase](#ZonalDatabase9)**<br>deprecated field 
&nbsp;&nbsp;regional_database | **[RegionalDatabase](#RegionalDatabase9)**<br>deprecated field 
&nbsp;&nbsp;dedicated_database | **[DedicatedDatabase](#DedicatedDatabase9)**<br> 
&nbsp;&nbsp;serverless_database | **[ServerlessDatabase](#ServerlessDatabase9)**<br> 
assign_public_ips | **bool**<br> 
location_id | **string**<br> 
labels | **map<string,string>**<br> 
backup_config | **[BackupConfig](#BackupConfig9)**<br> 
document_api_endpoint | **string**<br> 
kinesis_api_endpoint | **string**<br> 
monitoring_config | **[MonitoringConfig](#MonitoringConfig9)**<br> 


### StorageConfig {#StorageConfig18}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption18)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


### StorageOption {#StorageOption18}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy18}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale18)**<br> 


### FixedScale {#FixedScale18}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ZonalDatabase {#ZonalDatabase9}

Field | Description
--- | ---
zone_id | **string**<br>Required.  


### RegionalDatabase {#RegionalDatabase9}

Field | Description
--- | ---
region_id | **string**<br>Required.  


### DedicatedDatabase {#DedicatedDatabase9}

Field | Description
--- | ---
resource_preset_id | **string**<br> 
storage_config | **[StorageConfig](#StorageConfig19)**<br> 
scale_policy | **[ScalePolicy](#ScalePolicy19)**<br> 
network_id | **string**<br> 
subnet_ids[] | **string**<br> 
assign_public_ips | **bool**<br> 


### StorageConfig {#StorageConfig19}

Field | Description
--- | ---
storage_options[] | **[StorageOption](#StorageOption19)**<br> The minimum number of elements is 1.
storage_size_limit | **int64**<br>output only field: storage size limit of dedicated database. 


### StorageOption {#StorageOption19}

Field | Description
--- | ---
storage_type_id | **string**<br> 
group_count | **int64**<br> 


### ScalePolicy {#ScalePolicy19}

Field | Description
--- | ---
scale_type | **oneof:** `fixed_scale`<br>
&nbsp;&nbsp;fixed_scale | **[FixedScale](#FixedScale19)**<br> 


### FixedScale {#FixedScale19}

Field | Description
--- | ---
size | **int64**<br> The minimum value is 1.


### ServerlessDatabase {#ServerlessDatabase9}

Field | Description
--- | ---
throttling_rcu_limit | **int64**<br>Let's define 1 RU  - 1 request unit Let's define 1 RCU - 1 request capacity unit, which is 1 RU per second. If `enable_throttling_rcu_limit` flag is true, the database will be throttled using `throttling_rcu_limit` value. Otherwise, the database is throttled using the cloud quotas. If zero, all requests will be blocked until non zero value is set. 
storage_size_limit | **int64**<br>Specify serverless database storage size limit. If zero, default value is applied. 
enable_throttling_rcu_limit | **bool**<br>If false, the database is throttled by cloud value. 
provisioned_rcu_limit | **int64**<br>Specify the number of provisioned RCUs to pay less if the database has predictable load. You will be charged for the provisioned capacity regularly even if this capacity is not fully consumed. You will be charged for the on-demand consumption only if provisioned capacity is consumed. 


### BackupConfig {#BackupConfig9}

Field | Description
--- | ---
backup_settings[] | **[BackupSettings](#BackupSettings10)**<br> 


### BackupSettings {#BackupSettings10}

Field | Description
--- | ---
name | **string**<br>name of backup settings The maximum string length in characters is 256.
description | **string**<br>human readable description. The maximum string length in characters is 256.
backup_schedule | **[BackupSchedule](#BackupSchedule10)**<br>provide schedule. if empty, backup will be disabled. 
backup_time_to_live | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>provide time to live of backup. 
source_paths[] | **string**<br>provide a list of source paths. Each path can be directory, table or even database itself. Each directory (or database) will be traversed recursively and all childs of directory will be included to backup. By default, backup will be created for full database. The maximum number of elements is 256.
source_paths_to_exclude[] | **string**<br>provide a list of paths to exclude from backup. Each path is a directory, table, or database. Each directory (or database) will be traversed recursively and all childs of directory will be excluded. The maximum number of elements is 256.
type | enum **[Type](./storage_type#undefined)**<br> 
storage_class | enum **StorageClass**<br> 


### BackupSchedule {#BackupSchedule10}

Field | Description
--- | ---
policy | **oneof:** `daily_backup_schedule`, `weekly_backup_schedule` or `recurring_backup_schedule`<br>
&nbsp;&nbsp;daily_backup_schedule | **[DailyBackupSchedule](#DailyBackupSchedule10)**<br> 
&nbsp;&nbsp;weekly_backup_schedule | **[WeeklyBackupSchedule](#WeeklyBackupSchedule10)**<br> 
&nbsp;&nbsp;recurring_backup_schedule | **[RecurringBackupSchedule](#RecurringBackupSchedule10)**<br> 
next_execute_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>output only field: when next backup will be executed using provided schedule. 


### DailyBackupSchedule {#DailyBackupSchedule10}

Field | Description
--- | ---
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### WeeklyBackupSchedule {#WeeklyBackupSchedule10}

Field | Description
--- | ---
days_of_week[] | **[DaysOfWeekBackupSchedule](#DaysOfWeekBackupSchedule10)**<br> The number of elements must be in the range 1-7.


### DaysOfWeekBackupSchedule {#DaysOfWeekBackupSchedule10}

Field | Description
--- | ---
days[] | **google.type.DayOfWeek**<br> The number of elements must be in the range 1-7.
execute_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Required.  


### RecurringBackupSchedule {#RecurringBackupSchedule10}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the first recurrence. 
recurrence | **string**<br>Required. An RRULE (https://tools.ietf.org/html/rfc5545#section-3.8.5.3) for how this backup reccurs. The FREQ values of MINUTELY, and SECONDLY are not supported. 


### MonitoringConfig {#MonitoringConfig9}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert9)**<br> 


### Alert {#Alert9}

Field | Description
--- | ---
alert_id | **string**<br>output only field. 
alert_template_id | **string**<br>template of the alert. 
name | **string**<br>name of the alert. 
description | **string**<br>human readable description of the alert. 
notification_channels[] | **[NotificationChannel](#NotificationChannel9)**<br>the notification channels of the alert. 
alert_parameters[] | **[AlertParameter](#AlertParameter9)**<br>alert parameters to override. 
alert_thresholds[] | **[AlertParameter](#AlertParameter9)**<br>alert paratemers to override. 


### NotificationChannel {#NotificationChannel9}

Field | Description
--- | ---
notification_channel_id | **string**<br> 
notify_about_statuses[] | enum **AlertEvaluationStatus**<br> 
repeate_notify_delay_ms | **int64**<br> 


### AlertParameter {#AlertParameter9}

Field | Description
--- | ---
parameter | **oneof:** `double_parameter_value`, `integer_parameter_value`, `text_parameter_value`, `text_list_parameter_value` or `label_list_parameter_value`<br>
&nbsp;&nbsp;double_parameter_value | **[DoubleParameterValue](#DoubleParameterValue9)**<br> 
&nbsp;&nbsp;integer_parameter_value | **[IntegerParameterValue](#IntegerParameterValue9)**<br> 
&nbsp;&nbsp;text_parameter_value | **[TextParameterValue](#TextParameterValue9)**<br> 
&nbsp;&nbsp;text_list_parameter_value | **[TextListParameterValue](#TextListParameterValue9)**<br> 
&nbsp;&nbsp;label_list_parameter_value | **[LabelListParameterValue](#LabelListParameterValue9)**<br> 


### DoubleParameterValue {#DoubleParameterValue9}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **double**<br>Required. Parameter value 


### IntegerParameterValue {#IntegerParameterValue9}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **int64**<br>Required. Parameter value 


### TextParameterValue {#TextParameterValue9}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
value | **string**<br>Required. Parameter value 


### TextListParameterValue {#TextListParameterValue9}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


### LabelListParameterValue {#LabelListParameterValue9}

Field | Description
--- | ---
name | **string**<br>Required. Parameter name 
values[] | **string**<br>Required. Parameter value 


