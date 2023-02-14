---
editable: false
sourcePath: en/_api-ref-grpc/logging/api-ref/grpc/log_reading_service.md
---

# Cloud Logging Service, gRPC: LogReadingService

A set of methods for reading from log groups. To make a request use `reader.logging.yandexcloud.net`.

| Call | Description |
| --- | --- |
| [Read](#Read) | Read log entries from the specified log group. |

## Calls LogReadingService {#calls}

## Read {#Read}

Read log entries from the specified log group.

**rpc Read ([ReadRequest](#ReadRequest)) returns ([ReadResponse](#ReadResponse))**

### ReadRequest {#ReadRequest}

Field | Description
--- | ---
selector | **oneof:** `page_token` or `criteria`<br>Read selector.
&nbsp;&nbsp;page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ReadResponse.next_page_token](#ReadResponse) or [ReadResponse.previous_page_token](#ReadResponse) returned by a previous read request. 
&nbsp;&nbsp;criteria | **[Criteria](#Criteria)**<br>Read criteria. <br>See [Criteria](#Criteria) for details. 


### Criteria {#Criteria}

Field | Description
--- | ---
log_group_id | **string**<br>Required. ID of the log group to return. <br>To get a log group ID make a [LogGroupService.List](./log_group_service#List) request. The maximum string length in characters is 64.
resource_types[] | **string**<br>List of resource types to limit log entries to. <br>Empty list disables filter. Each value must match the regular expression ` \|[a-zA-Z][-a-zA-Z0-9_.]{0,63} `. The maximum number of elements is 100.
resource_ids[] | **string**<br>List of resource IDs to limit log entries to. <br>Empty list disables filter. Each value must match the regular expression ` \|[a-zA-Z0-9][-a-zA-Z0-9_.]{0,63} `. The maximum number of elements is 100.
since | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Lower bound of log entries timestamps. 
until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Upper bound of log entries timestamps. 
levels[] | **[LogLevel.Level](#LogLevel)**<br>List of log levels to limit log entries to. <br>Empty list disables filter. The maximum number of elements is 10.
filter | **string**<br>Filter expression. For details about filtering, see [documentation](/docs/logging/concepts/filter). The maximum string length in characters is 1000.
stream_names[] | **string**<br>List of stream names to limit log entries to. <br>Empty list disables filter. Each value must match the regular expression ` \|[a-zA-Z][-a-zA-Z0-9_.]{0,63} `. The maximum number of elements is 100.
page_size | **int64**<br>The maximum number of results per page to return. Acceptable values are 0 to 1000, inclusive.
max_response_size | **int64**<br>Limits response to maximum size in bytes. Prevents gRPC resource exhaustion. <br>Default value for max response size is 3.5 MiB Acceptable values are 0 to 10485760, inclusive.


### ReadResponse {#ReadResponse}

Field | Description
--- | ---
log_group_id | **string**<br>Log group ID the read was performed from. 
entries[] | **[LogEntry](#LogEntry)**<br>List of matching log entries. 
next_page_token | **string**<br>Token for getting the next page of the log entries. <br>After getting log entries initially with [Criteria](#Criteria), you can use `next_page_token` as the value for the [ReadRequest.page_token](#ReadRequest) parameter in the next read request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 
previous_page_token | **string**<br>Token for getting the previous page of the log entries. <br>After getting log entries initially with [Criteria](#Criteria), you can use `previous_page_token` as the value for the [ReadRequest.page_token](#ReadRequest) parameter in the next read request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### LogEntry {#LogEntry}

Field | Description
--- | ---
uid | **string**<br>Unique entry ID. <br>Useful for logs deduplication. 
resource | **[LogEntryResource](#LogEntryResource)**<br>Entry resource specification. <br>May contain information about source service and resource ID. Also may be provided by the user. 
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the entry. 
ingested_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Entry ingestion time observed by [LogIngestionService]. 
saved_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Entry save time. <br>Entry is ready to be read since this moment. 
level | **[LogLevel.Level](#LogLevel)**<br>Entry severity. <br>See [LogLevel.Level](#LogLevel) for details. 
message | **string**<br>Entry text message. 
json_payload | **google.protobuf.Struct**<br>Entry annotation. 
stream_name | **string**<br>Entry stream name. Value must match the regular expression ` \|[a-zA-Z][-a-zA-Z0-9_.]{0,63} `.


### LogEntryResource {#LogEntryResource}

Field | Description
--- | ---
type | **string**<br>Resource type, i.e., `serverless.function` Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
id | **string**<br>Resource ID, i.e., ID of the function producing logs. Value must match the regular expression ` ([a-zA-Z0-9][-a-zA-Z0-9_.]{0,63})? `.


