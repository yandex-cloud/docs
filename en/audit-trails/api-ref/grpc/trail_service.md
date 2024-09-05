---
editable: false
sourcePath: en/_api-ref-grpc/audit-trails/api-ref/grpc/trail_service.md
---

# Audit Trails API, gRPC: TrailService

A set of methods for managing trails.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified trail. |
| [List](#List) | Retrieves the list of trails in the specified folder. |
| [Create](#Create) | Creates a trail in the specified folder. |
| [Update](#Update) | Updates the specified trail. |
| [Delete](#Delete) | Deletes the specified trail. |
| [ListOperations](#ListOperations) | Lists operations for the specified trail. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified trail. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the trail. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the trail. |

## Calls TrailService {#calls}

## Get {#Get}

Returns the specified trail. <br>To get the list of all available trails, make a [List](#List) request.

**rpc Get ([GetTrailRequest](#GetTrailRequest)) returns ([Trail](#Trail))**

### GetTrailRequest {#GetTrailRequest}

Field | Description
--- | ---
trail_id | **string**<br>Required. ID of the trail to return. <br>To get a trail ID make a [List](#List) request. The maximum string length in characters is 50.


### Trail {#Trail}

Field | Description
--- | ---
id | **string**<br>ID of the trail 
folder_id | **string**<br>Required. ID of the folder that the trail belongs to The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The timestamp for the creation operation 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The timestamp of the last update operation 
name | **string**<br>Name of the trail Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the trail The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels of the trail as `key:value` pairs. Maximum 64 per key No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
destination | **[Destination](#Destination)**<br>Required. Destination configuration of the trail 
service_account_id | **string**<br>Service account ID of the trail The maximum string length in characters is 50.
status | enum **Status**<br>Required. Status of the trail <ul><li>`ACTIVE`: The trail is active and Audit events are processed</li><li>`ERROR`: The trail configuration has issues that are preventing Audit Trails from delivering events</li><li>`DELETED`: The trail is being deleted</li></ul>
filter | **[Filter](#Filter)**<br>Filtering configuration of the trail deprecated: use filtering_policy instead 
status_error_message | **string**<br>Current error message of the trail. Empty in case if the trail is active 
cloud_id | **string**<br>Required. ID of the cloud that the trail belongs to The maximum string length in characters is 50.
filtering_policy | **[FilteringPolicy](#FilteringPolicy)**<br>Event filtering policy Describes which groups of events will be sent and which resources will be monitored 


### Destination {#Destination}

Field | Description
--- | ---
destination | **oneof:** `object_storage`, `cloud_logging` or `data_stream`<br>
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage)**<br>Configuration for event delivery to Object Storage <br>Uploaded objects will have prefix <trail_id>/ by default 
&nbsp;&nbsp;cloud_logging | **[CloudLogging](#CloudLogging)**<br>Configuration for event delivery to Cloud Logging 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream)**<br>Configuration for event delivery to YDS 


### ObjectStorage {#ObjectStorage}

Field | Description
--- | ---
bucket_id | **string**<br>Name of the destination bucket The string length in characters must be 3-63.
object_prefix | **string**<br>Prefix for exported objects. Optional If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/ 


### CloudLogging {#CloudLogging}

Field | Description
--- | ---
destination | **oneof:** `log_group_id`<br>Placeholder for folder_id
&nbsp;&nbsp;log_group_id | **string**<br>ID of the Cloud Logging destination group The maximum string length in characters is 64.


### DataStream {#DataStream}

Field | Description
--- | ---
database_id | **string**<br>ID of the database hosting the destination YDS 
stream_name | **string**<br>Name of the destination YDS 


### Filter {#Filter}

Field | Description
--- | ---
path_filter | **[PathFilter](#PathFilter)**<br>Configuration of default events gathering for the trail If not specified, default events won't be gathered for the trail 
event_filter | **[EventFilter](#EventFilter)**<br>Required. Configuration of additional events gathering from specific services 


### PathFilter {#PathFilter}

Field | Description
--- | ---
root | **[PathFilterElement](#PathFilterElement)**<br>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself 


### PathFilterElement {#PathFilterElement}

Field | Description
--- | ---
element | **oneof:** `any_filter` or `some_filter`<br>
&nbsp;&nbsp;any_filter | **[PathFilterElementAny](#PathFilterElementAny)**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource 
&nbsp;&nbsp;some_filter | **[PathFilterElementSome](#PathFilterElementSome)**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource 


### PathFilterElementAny {#PathFilterElementAny}

Field | Description
--- | ---
resource | **[Resource](#Resource)**<br>Required. Resource definition 


### PathFilterElementSome {#PathFilterElementSome}

Field | Description
--- | ---
resource | **[Resource](#Resource)**<br>Required. Definition of the resource that contains nested resources 
filters[] | **[PathFilterElement](#PathFilterElement)**<br>Filters for the resources contained in the parent resource The number of elements must be greater than 0.


### Resource {#Resource}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource The maximum string length in characters is 64.
type | **string**<br>Required. Type of the resource The maximum string length in characters is 50.


### EventFilter {#EventFilter}

Field | Description
--- | ---
filters[] | **[EventFilterElement](#EventFilterElement)**<br>List of filters for services The minimum number of elements is 0.


### EventFilterElement {#EventFilterElement}

Field | Description
--- | ---
service | **string**<br>Required. Service ID of the gathered events 
categories[] | **[EventFilterElementCategory](#EventFilterElementCategory)**<br>List of the event categories gathered for a specified service The number of elements must be greater than 0.
path_filter | **[PathFilter](#PathFilter)**<br>Required. Resource path filter for a specified service 


### EventFilterElementCategory {#EventFilterElementCategory}

Field | Description
--- | ---
plane | enum **EventCategoryFilter**<br>Required. Plane of the gathered category <ul><li>`CONTROL_PLANE`: The events that are generated during the interaction with the service's resources</li><li>`DATA_PLANE`: Events that are generated during interaction with data within the service's resources</li></ul>
type | enum **EventAccessTypeFilter**<br>Required. Type of the gathered category <ul><li>`WRITE`: Events for operations that do perform some modification</li><li>`READ`: Events for operations that do not perform any modifications</li></ul>


### DataEventsFiltering {#DataEventsFiltering}

Field | Description
--- | ---
service | **string**<br>Required. Name of the service whose events will be delivered 
additional_rules | **oneof:** `included_events` or `excluded_events`<br>
&nbsp;&nbsp;included_events | **[EventTypes](#EventTypes)**<br>Explicitly included events of specified service New events of the service won't be delivered by default 
&nbsp;&nbsp;excluded_events | **[EventTypes](#EventTypes)**<br>Explicitly excluded events of specified service New events of the service will be delivered by default 
resource_scopes[] | **[Resource](#Resource)**<br>A list of resources which will be monitored by the trail The number of elements must be in the range 1-1024.


### EventTypes {#EventTypes}

Field | Description
--- | ---
event_types[] | **string**<br> The number of elements must be in the range 1-1024.


### ManagementEventsFiltering {#ManagementEventsFiltering}

Field | Description
--- | ---
resource_scopes[] | **[Resource](#Resource)**<br>A list of resources which will be monitored by the trail The number of elements must be in the range 1-1024.


### FilteringPolicy {#FilteringPolicy}

Field | Description
--- | ---
management_events_filter | **[ManagementEventsFiltering](#ManagementEventsFiltering)**<br>Singular filter describing gathering management events 
data_events_filters[] | **[DataEventsFiltering](#DataEventsFiltering)**<br>List of filters describing gathering data events The number of elements must be less than 128.


## List {#List}

Retrieves the list of trails in the specified folder.

**rpc List ([ListTrailsRequest](#ListTrailsRequest)) returns ([ListTrailsResponse](#ListTrailsResponse))**

### ListTrailsRequest {#ListTrailsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list trails in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListTrailsResponse.next_page_token](#ListTrailsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListTrailsRequest.next_page_token](#ListTrailsRequest) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters subscription locks listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering on [Trail.name, Trail.created_at] fields. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be in double quotes `""`. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name="my-name"`. 
order_by | **string**<br>By which column the listing should be ordered and in which direction. format is "<field> desc|acs" 


### ListTrailsResponse {#ListTrailsResponse}

Field | Description
--- | ---
trails[] | **[Trail](#Trail1)**<br>List of trails in the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified [ListTrailsRequest.page_size](#ListTrailsRequest), use the `next_page_token` as the value for the [ListTrailsRequest.page_token](#ListTrailsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Trail {#Trail1}

Field | Description
--- | ---
id | **string**<br>ID of the trail 
folder_id | **string**<br>Required. ID of the folder that the trail belongs to The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The timestamp for the creation operation 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The timestamp of the last update operation 
name | **string**<br>Name of the trail Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the trail The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels of the trail as `key:value` pairs. Maximum 64 per key No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
destination | **[Destination](#Destination1)**<br>Required. Destination configuration of the trail 
service_account_id | **string**<br>Service account ID of the trail The maximum string length in characters is 50.
status | enum **Status**<br>Required. Status of the trail <ul><li>`ACTIVE`: The trail is active and Audit events are processed</li><li>`ERROR`: The trail configuration has issues that are preventing Audit Trails from delivering events</li><li>`DELETED`: The trail is being deleted</li></ul>
filter | **[Filter](#Filter1)**<br>Filtering configuration of the trail deprecated: use filtering_policy instead 
status_error_message | **string**<br>Current error message of the trail. Empty in case if the trail is active 
cloud_id | **string**<br>Required. ID of the cloud that the trail belongs to The maximum string length in characters is 50.
filtering_policy | **[FilteringPolicy](#FilteringPolicy1)**<br>Event filtering policy Describes which groups of events will be sent and which resources will be monitored 


### Destination {#Destination1}

Field | Description
--- | ---
destination | **oneof:** `object_storage`, `cloud_logging` or `data_stream`<br>
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage1)**<br>Configuration for event delivery to Object Storage <br>Uploaded objects will have prefix <trail_id>/ by default 
&nbsp;&nbsp;cloud_logging | **[CloudLogging](#CloudLogging1)**<br>Configuration for event delivery to Cloud Logging 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream1)**<br>Configuration for event delivery to YDS 


### ObjectStorage {#ObjectStorage1}

Field | Description
--- | ---
bucket_id | **string**<br>Name of the destination bucket The string length in characters must be 3-63.
object_prefix | **string**<br>Prefix for exported objects. Optional If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/ 


### CloudLogging {#CloudLogging1}

Field | Description
--- | ---
destination | **oneof:** `log_group_id`<br>Placeholder for folder_id
&nbsp;&nbsp;log_group_id | **string**<br>ID of the Cloud Logging destination group The maximum string length in characters is 64.


### DataStream {#DataStream1}

Field | Description
--- | ---
database_id | **string**<br>ID of the database hosting the destination YDS 
stream_name | **string**<br>Name of the destination YDS 


### Filter {#Filter1}

Field | Description
--- | ---
path_filter | **[PathFilter](#PathFilter1)**<br>Configuration of default events gathering for the trail If not specified, default events won't be gathered for the trail 
event_filter | **[EventFilter](#EventFilter1)**<br>Required. Configuration of additional events gathering from specific services 


### PathFilter {#PathFilter1}

Field | Description
--- | ---
root | **[PathFilterElement](#PathFilterElement1)**<br>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself 


### PathFilterElement {#PathFilterElement1}

Field | Description
--- | ---
element | **oneof:** `any_filter` or `some_filter`<br>
&nbsp;&nbsp;any_filter | **[PathFilterElementAny](#PathFilterElementAny1)**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource 
&nbsp;&nbsp;some_filter | **[PathFilterElementSome](#PathFilterElementSome1)**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource 


### PathFilterElementAny {#PathFilterElementAny1}

Field | Description
--- | ---
resource | **[Resource](#Resource1)**<br>Required. Resource definition 


### PathFilterElementSome {#PathFilterElementSome1}

Field | Description
--- | ---
resource | **[Resource](#Resource1)**<br>Required. Definition of the resource that contains nested resources 
filters[] | **[PathFilterElement](#PathFilterElement1)**<br>Filters for the resources contained in the parent resource The number of elements must be greater than 0.


### Resource {#Resource1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource The maximum string length in characters is 64.
type | **string**<br>Required. Type of the resource The maximum string length in characters is 50.


### EventFilter {#EventFilter1}

Field | Description
--- | ---
filters[] | **[EventFilterElement](#EventFilterElement1)**<br>List of filters for services The minimum number of elements is 0.


### EventFilterElement {#EventFilterElement1}

Field | Description
--- | ---
service | **string**<br>Required. Service ID of the gathered events 
categories[] | **[EventFilterElementCategory](#EventFilterElementCategory1)**<br>List of the event categories gathered for a specified service The number of elements must be greater than 0.
path_filter | **[PathFilter](#PathFilter1)**<br>Required. Resource path filter for a specified service 


### EventFilterElementCategory {#EventFilterElementCategory1}

Field | Description
--- | ---
plane | enum **EventCategoryFilter**<br>Required. Plane of the gathered category <ul><li>`CONTROL_PLANE`: The events that are generated during the interaction with the service's resources</li><li>`DATA_PLANE`: Events that are generated during interaction with data within the service's resources</li></ul>
type | enum **EventAccessTypeFilter**<br>Required. Type of the gathered category <ul><li>`WRITE`: Events for operations that do perform some modification</li><li>`READ`: Events for operations that do not perform any modifications</li></ul>


### DataEventsFiltering {#DataEventsFiltering1}

Field | Description
--- | ---
service | **string**<br>Required. Name of the service whose events will be delivered 
additional_rules | **oneof:** `included_events` or `excluded_events`<br>
&nbsp;&nbsp;included_events | **[EventTypes](#EventTypes1)**<br>Explicitly included events of specified service New events of the service won't be delivered by default 
&nbsp;&nbsp;excluded_events | **[EventTypes](#EventTypes1)**<br>Explicitly excluded events of specified service New events of the service will be delivered by default 
resource_scopes[] | **[Resource](#Resource1)**<br>A list of resources which will be monitored by the trail The number of elements must be in the range 1-1024.


### EventTypes {#EventTypes1}

Field | Description
--- | ---
event_types[] | **string**<br> The number of elements must be in the range 1-1024.


### ManagementEventsFiltering {#ManagementEventsFiltering1}

Field | Description
--- | ---
resource_scopes[] | **[Resource](#Resource1)**<br>A list of resources which will be monitored by the trail The number of elements must be in the range 1-1024.


### FilteringPolicy {#FilteringPolicy1}

Field | Description
--- | ---
management_events_filter | **[ManagementEventsFiltering](#ManagementEventsFiltering1)**<br>Singular filter describing gathering management events 
data_events_filters[] | **[DataEventsFiltering](#DataEventsFiltering1)**<br>List of filters describing gathering data events The number of elements must be less than 128.


## Create {#Create}

Creates a trail in the specified folder.

**rpc Create ([CreateTrailRequest](#CreateTrailRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateTrailMetadata](#CreateTrailMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trail](#Trail2)<br>

### CreateTrailRequest {#CreateTrailRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a trail in. The maximum string length in characters is 50.
name | **string**<br>Name of the trail. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the trail. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. For example, `"type": "critical"` or `"source": "dictionary"`. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
destination | **[Trail.Destination](#Trail2)**<br>Required. Destination configuration for the trail 
service_account_id | **string**<br>Required. Service account ID of the trail The maximum string length in characters is 50.
filter | **[Trail.Filter](#Trail2)**<br>Event filtering configuration of the trail deprecated: use filtering_policy instead 
filtering_policy | **[Trail.FilteringPolicy](#Trail2)**<br>Event filtering policy of the trail 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateTrailMetadata](#CreateTrailMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Trail](#Trail2)>**<br>if operation finished successfully. 


### CreateTrailMetadata {#CreateTrailMetadata}

Field | Description
--- | ---
trail_id | **string**<br>ID of the trail that is being created 


### Trail {#Trail2}

Field | Description
--- | ---
id | **string**<br>ID of the trail 
folder_id | **string**<br>Required. ID of the folder that the trail belongs to The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The timestamp for the creation operation 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The timestamp of the last update operation 
name | **string**<br>Name of the trail Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the trail The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels of the trail as `key:value` pairs. Maximum 64 per key No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
destination | **[Destination](#Destination2)**<br>Required. Destination configuration of the trail 
service_account_id | **string**<br>Service account ID of the trail The maximum string length in characters is 50.
status | enum **Status**<br>Required. Status of the trail <ul><li>`ACTIVE`: The trail is active and Audit events are processed</li><li>`ERROR`: The trail configuration has issues that are preventing Audit Trails from delivering events</li><li>`DELETED`: The trail is being deleted</li></ul>
filter | **[Filter](#Filter2)**<br>Filtering configuration of the trail deprecated: use filtering_policy instead 
status_error_message | **string**<br>Current error message of the trail. Empty in case if the trail is active 
cloud_id | **string**<br>Required. ID of the cloud that the trail belongs to The maximum string length in characters is 50.
filtering_policy | **[FilteringPolicy](#FilteringPolicy2)**<br>Event filtering policy Describes which groups of events will be sent and which resources will be monitored 


### Destination {#Destination2}

Field | Description
--- | ---
destination | **oneof:** `object_storage`, `cloud_logging` or `data_stream`<br>
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage2)**<br>Configuration for event delivery to Object Storage <br>Uploaded objects will have prefix <trail_id>/ by default 
&nbsp;&nbsp;cloud_logging | **[CloudLogging](#CloudLogging2)**<br>Configuration for event delivery to Cloud Logging 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream2)**<br>Configuration for event delivery to YDS 


### ObjectStorage {#ObjectStorage2}

Field | Description
--- | ---
bucket_id | **string**<br>Name of the destination bucket The string length in characters must be 3-63.
object_prefix | **string**<br>Prefix for exported objects. Optional If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/ 


### CloudLogging {#CloudLogging2}

Field | Description
--- | ---
destination | **oneof:** `log_group_id`<br>Placeholder for folder_id
&nbsp;&nbsp;log_group_id | **string**<br>ID of the Cloud Logging destination group The maximum string length in characters is 64.


### DataStream {#DataStream2}

Field | Description
--- | ---
database_id | **string**<br>ID of the database hosting the destination YDS 
stream_name | **string**<br>Name of the destination YDS 


### Filter {#Filter2}

Field | Description
--- | ---
path_filter | **[PathFilter](#PathFilter2)**<br>Configuration of default events gathering for the trail If not specified, default events won't be gathered for the trail 
event_filter | **[EventFilter](#EventFilter2)**<br>Required. Configuration of additional events gathering from specific services 


### PathFilter {#PathFilter2}

Field | Description
--- | ---
root | **[PathFilterElement](#PathFilterElement2)**<br>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself 


### PathFilterElement {#PathFilterElement2}

Field | Description
--- | ---
element | **oneof:** `any_filter` or `some_filter`<br>
&nbsp;&nbsp;any_filter | **[PathFilterElementAny](#PathFilterElementAny2)**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource 
&nbsp;&nbsp;some_filter | **[PathFilterElementSome](#PathFilterElementSome2)**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource 


### PathFilterElementAny {#PathFilterElementAny2}

Field | Description
--- | ---
resource | **[Resource](#Resource2)**<br>Required. Resource definition 


### PathFilterElementSome {#PathFilterElementSome2}

Field | Description
--- | ---
resource | **[Resource](#Resource2)**<br>Required. Definition of the resource that contains nested resources 
filters[] | **[PathFilterElement](#PathFilterElement2)**<br>Filters for the resources contained in the parent resource The number of elements must be greater than 0.


### Resource {#Resource2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource The maximum string length in characters is 64.
type | **string**<br>Required. Type of the resource The maximum string length in characters is 50.


### EventFilter {#EventFilter2}

Field | Description
--- | ---
filters[] | **[EventFilterElement](#EventFilterElement2)**<br>List of filters for services The minimum number of elements is 0.


### EventFilterElement {#EventFilterElement2}

Field | Description
--- | ---
service | **string**<br>Required. Service ID of the gathered events 
categories[] | **[EventFilterElementCategory](#EventFilterElementCategory2)**<br>List of the event categories gathered for a specified service The number of elements must be greater than 0.
path_filter | **[PathFilter](#PathFilter2)**<br>Required. Resource path filter for a specified service 


### EventFilterElementCategory {#EventFilterElementCategory2}

Field | Description
--- | ---
plane | enum **EventCategoryFilter**<br>Required. Plane of the gathered category <ul><li>`CONTROL_PLANE`: The events that are generated during the interaction with the service's resources</li><li>`DATA_PLANE`: Events that are generated during interaction with data within the service's resources</li></ul>
type | enum **EventAccessTypeFilter**<br>Required. Type of the gathered category <ul><li>`WRITE`: Events for operations that do perform some modification</li><li>`READ`: Events for operations that do not perform any modifications</li></ul>


### DataEventsFiltering {#DataEventsFiltering2}

Field | Description
--- | ---
service | **string**<br>Required. Name of the service whose events will be delivered 
additional_rules | **oneof:** `included_events` or `excluded_events`<br>
&nbsp;&nbsp;included_events | **[EventTypes](#EventTypes2)**<br>Explicitly included events of specified service New events of the service won't be delivered by default 
&nbsp;&nbsp;excluded_events | **[EventTypes](#EventTypes2)**<br>Explicitly excluded events of specified service New events of the service will be delivered by default 
resource_scopes[] | **[Resource](#Resource2)**<br>A list of resources which will be monitored by the trail The number of elements must be in the range 1-1024.


### EventTypes {#EventTypes2}

Field | Description
--- | ---
event_types[] | **string**<br> The number of elements must be in the range 1-1024.


### ManagementEventsFiltering {#ManagementEventsFiltering2}

Field | Description
--- | ---
resource_scopes[] | **[Resource](#Resource2)**<br>A list of resources which will be monitored by the trail The number of elements must be in the range 1-1024.


### FilteringPolicy {#FilteringPolicy2}

Field | Description
--- | ---
management_events_filter | **[ManagementEventsFiltering](#ManagementEventsFiltering2)**<br>Singular filter describing gathering management events 
data_events_filters[] | **[DataEventsFiltering](#DataEventsFiltering2)**<br>List of filters describing gathering data events The number of elements must be less than 128.


## Update {#Update}

Updates the specified trail.

**rpc Update ([UpdateTrailRequest](#UpdateTrailRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateTrailMetadata](#UpdateTrailMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Trail](#Trail3)<br>

### UpdateTrailRequest {#UpdateTrailRequest}

Field | Description
--- | ---
trail_id | **string**<br>Required. ID of the trail to update. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the trail are going to be updated. 
name | **string**<br>New name of the trail. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>New description of the trail. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>New custom labels for the secret as `key:value` pairs. Maximum 64 per key. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
destination | **[Trail.Destination](#Trail3)**<br>New destination configuration for the trail 
service_account_id | **string**<br>New service account ID of the trail The maximum string length in characters is 50.
filter | **[Trail.Filter](#Trail3)**<br>Updated filtering configuration of the trail deprecated: use filtering_policy instead 
filtering_policy | **[Trail.FilteringPolicy](#Trail3)**<br>Updated event filtering policy 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateTrailMetadata](#UpdateTrailMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Trail](#Trail3)>**<br>if operation finished successfully. 


### UpdateTrailMetadata {#UpdateTrailMetadata}

Field | Description
--- | ---
trail_id | **string**<br>ID of the trail that is being updated 


### Trail {#Trail3}

Field | Description
--- | ---
id | **string**<br>ID of the trail 
folder_id | **string**<br>Required. ID of the folder that the trail belongs to The maximum string length in characters is 50.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The timestamp for the creation operation 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. The timestamp of the last update operation 
name | **string**<br>Name of the trail Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the trail The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels of the trail as `key:value` pairs. Maximum 64 per key No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
destination | **[Destination](#Destination3)**<br>Required. Destination configuration of the trail 
service_account_id | **string**<br>Service account ID of the trail The maximum string length in characters is 50.
status | enum **Status**<br>Required. Status of the trail <ul><li>`ACTIVE`: The trail is active and Audit events are processed</li><li>`ERROR`: The trail configuration has issues that are preventing Audit Trails from delivering events</li><li>`DELETED`: The trail is being deleted</li></ul>
filter | **[Filter](#Filter3)**<br>Filtering configuration of the trail deprecated: use filtering_policy instead 
status_error_message | **string**<br>Current error message of the trail. Empty in case if the trail is active 
cloud_id | **string**<br>Required. ID of the cloud that the trail belongs to The maximum string length in characters is 50.
filtering_policy | **[FilteringPolicy](#FilteringPolicy3)**<br>Event filtering policy Describes which groups of events will be sent and which resources will be monitored 


### Destination {#Destination3}

Field | Description
--- | ---
destination | **oneof:** `object_storage`, `cloud_logging` or `data_stream`<br>
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage3)**<br>Configuration for event delivery to Object Storage <br>Uploaded objects will have prefix <trail_id>/ by default 
&nbsp;&nbsp;cloud_logging | **[CloudLogging](#CloudLogging3)**<br>Configuration for event delivery to Cloud Logging 
&nbsp;&nbsp;data_stream | **[DataStream](#DataStream3)**<br>Configuration for event delivery to YDS 


### ObjectStorage {#ObjectStorage3}

Field | Description
--- | ---
bucket_id | **string**<br>Name of the destination bucket The string length in characters must be 3-63.
object_prefix | **string**<br>Prefix for exported objects. Optional If specified, uploaded objects will have prefix <object_prefix>/<trail_id>/ 


### CloudLogging {#CloudLogging3}

Field | Description
--- | ---
destination | **oneof:** `log_group_id`<br>Placeholder for folder_id
&nbsp;&nbsp;log_group_id | **string**<br>ID of the Cloud Logging destination group The maximum string length in characters is 64.


### DataStream {#DataStream3}

Field | Description
--- | ---
database_id | **string**<br>ID of the database hosting the destination YDS 
stream_name | **string**<br>Name of the destination YDS 


### Filter {#Filter3}

Field | Description
--- | ---
path_filter | **[PathFilter](#PathFilter3)**<br>Configuration of default events gathering for the trail If not specified, default events won't be gathered for the trail 
event_filter | **[EventFilter](#EventFilter3)**<br>Required. Configuration of additional events gathering from specific services 


### PathFilter {#PathFilter3}

Field | Description
--- | ---
root | **[PathFilterElement](#PathFilterElement3)**<br>Required. Root element of the resource path filter for the trail Resource described in that filter node must contain the trail itself 


### PathFilterElement {#PathFilterElement3}

Field | Description
--- | ---
element | **oneof:** `any_filter` or `some_filter`<br>
&nbsp;&nbsp;any_filter | **[PathFilterElementAny](#PathFilterElementAny3)**<br>Filter element with ANY type. If used, configures the trail to gather any events from the resource 
&nbsp;&nbsp;some_filter | **[PathFilterElementSome](#PathFilterElementSome3)**<br>Filter element with SOME type. If used, configures the trail to gather some of the events from the resource 


### PathFilterElementAny {#PathFilterElementAny3}

Field | Description
--- | ---
resource | **[Resource](#Resource3)**<br>Required. Resource definition 


### PathFilterElementSome {#PathFilterElementSome3}

Field | Description
--- | ---
resource | **[Resource](#Resource3)**<br>Required. Definition of the resource that contains nested resources 
filters[] | **[PathFilterElement](#PathFilterElement3)**<br>Filters for the resources contained in the parent resource The number of elements must be greater than 0.


### Resource {#Resource3}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource The maximum string length in characters is 64.
type | **string**<br>Required. Type of the resource The maximum string length in characters is 50.


### EventFilter {#EventFilter3}

Field | Description
--- | ---
filters[] | **[EventFilterElement](#EventFilterElement3)**<br>List of filters for services The minimum number of elements is 0.


### EventFilterElement {#EventFilterElement3}

Field | Description
--- | ---
service | **string**<br>Required. Service ID of the gathered events 
categories[] | **[EventFilterElementCategory](#EventFilterElementCategory3)**<br>List of the event categories gathered for a specified service The number of elements must be greater than 0.
path_filter | **[PathFilter](#PathFilter3)**<br>Required. Resource path filter for a specified service 


### EventFilterElementCategory {#EventFilterElementCategory3}

Field | Description
--- | ---
plane | enum **EventCategoryFilter**<br>Required. Plane of the gathered category <ul><li>`CONTROL_PLANE`: The events that are generated during the interaction with the service's resources</li><li>`DATA_PLANE`: Events that are generated during interaction with data within the service's resources</li></ul>
type | enum **EventAccessTypeFilter**<br>Required. Type of the gathered category <ul><li>`WRITE`: Events for operations that do perform some modification</li><li>`READ`: Events for operations that do not perform any modifications</li></ul>


### DataEventsFiltering {#DataEventsFiltering3}

Field | Description
--- | ---
service | **string**<br>Required. Name of the service whose events will be delivered 
additional_rules | **oneof:** `included_events` or `excluded_events`<br>
&nbsp;&nbsp;included_events | **[EventTypes](#EventTypes3)**<br>Explicitly included events of specified service New events of the service won't be delivered by default 
&nbsp;&nbsp;excluded_events | **[EventTypes](#EventTypes3)**<br>Explicitly excluded events of specified service New events of the service will be delivered by default 
resource_scopes[] | **[Resource](#Resource3)**<br>A list of resources which will be monitored by the trail The number of elements must be in the range 1-1024.


### EventTypes {#EventTypes3}

Field | Description
--- | ---
event_types[] | **string**<br> The number of elements must be in the range 1-1024.


### ManagementEventsFiltering {#ManagementEventsFiltering3}

Field | Description
--- | ---
resource_scopes[] | **[Resource](#Resource3)**<br>A list of resources which will be monitored by the trail The number of elements must be in the range 1-1024.


### FilteringPolicy {#FilteringPolicy3}

Field | Description
--- | ---
management_events_filter | **[ManagementEventsFiltering](#ManagementEventsFiltering3)**<br>Singular filter describing gathering management events 
data_events_filters[] | **[DataEventsFiltering](#DataEventsFiltering3)**<br>List of filters describing gathering data events The number of elements must be less than 128.


## Delete {#Delete}

Deletes the specified trail.

**rpc Delete ([DeleteTrailRequest](#DeleteTrailRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteTrailMetadata](#DeleteTrailMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteTrailRequest {#DeleteTrailRequest}

Field | Description
--- | ---
trail_id | **string**<br>Required. ID of the trail to be deleted. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteTrailMetadata](#DeleteTrailMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteTrailMetadata {#DeleteTrailMetadata}

Field | Description
--- | ---
trail_id | **string**<br>ID of the trail that is being deleted 


## ListOperations {#ListOperations}

Lists operations for the specified trail.

**rpc ListOperations ([ListTrailOperationsRequest](#ListTrailOperationsRequest)) returns ([ListTrailOperationsResponse](#ListTrailOperationsResponse))**

### ListTrailOperationsRequest {#ListTrailOperationsRequest}

Field | Description
--- | ---
trail_id | **string**<br>Required. ID of the trail to get operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListTrailOperationsResponse.next_page_token](#ListTrailOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListTrailOperationsRequest.next_page_token](#ListTrailOperationsRequest) returned by a previous list request. The maximum string length in characters is 100.


### ListTrailOperationsResponse {#ListTrailOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified trail. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListTrailOperationsResponse.page_size](#ListTrailOperationsResponse), use the `next_page_token` as the value for the [ListTrailOperationsResponse.page_token](#ListTrailOperationsResponse) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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

Lists existing access bindings for the specified trail.

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

Sets access bindings for the trail.

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

Updates access bindings for the trail.

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


