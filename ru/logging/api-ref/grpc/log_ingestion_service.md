---
editable: false
sourcePath: en/_api-ref-grpc/logging/api-ref/grpc/log_ingestion_service.md
---

# Cloud Logging Service, gRPC: LogIngestionService

A set of methods for writing to log groups.

| Call | Description |
| --- | --- |
| [Write](#Write) | Write log entries to specified destination. |

## Calls LogIngestionService {#calls}

## Write {#Write}

Write log entries to specified destination.

**rpc Write ([WriteRequest](#WriteRequest)) returns ([WriteResponse](#WriteResponse))**

### WriteRequest {#WriteRequest}

Field | Description
--- | ---
destination | **[Destination](#Destination)**<br>Required. Log entries destination. <br>See [Destination](#Destination) for details. 
resource | **[LogEntryResource](#LogEntryResource)**<br>Common resource (type, ID) specification for log entries. 
entries[] | **[IncomingLogEntry](#IncomingLogEntry)**<br>List of log entries. The number of elements must be in the range 1-100.
defaults | **[LogEntryDefaults](#LogEntryDefaults)**<br>Log entries defaults. <br>See [LogEntryDefaults](#LogEntryDefaults) for details. 


### Destination {#Destination}

Field | Description
--- | ---
destination | **oneof:** `log_group_id` or `folder_id`<br>Entry destination.
&nbsp;&nbsp;log_group_id | **string**<br>Entry should be written to log group resolved by ID. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
&nbsp;&nbsp;folder_id | **string**<br>Entry should be written to default log group for the folder. Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.


### LogEntryResource {#LogEntryResource}

Field | Description
--- | ---
type | **string**<br>Resource type, i.e., `serverless.function` Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
id | **string**<br>Resource ID, i.e., ID of the function producing logs. Value must match the regular expression ` ([a-zA-Z0-9][-a-zA-Z0-9_.]{0,63})? `.


### IncomingLogEntry {#IncomingLogEntry}

Field | Description
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required. Timestamp of the entry. 
level | **[LogLevel.Level](#LogLevel)**<br>Entry severity. <br>See [LogLevel.Level](#LogLevel) for details. 
message | **string**<br>Entry text message. 
json_payload | **google.protobuf.Struct**<br>Entry annotation. 
stream_name | **string**<br>Entry stream name. Value must match the regular expression ` \|[a-zA-Z][-a-zA-Z0-9_.]{0,63} `.


### LogEntryDefaults {#LogEntryDefaults}

Field | Description
--- | ---
level | **[LogLevel.Level](#LogLevel)**<br>Default entry severity. Will be applied if entry level is unspecified. <br>See [LogLevel.Level](#LogLevel) for details. 
json_payload | **google.protobuf.Struct**<br>Default entry annotation. Will be merged with entry annotation. Any conflict will be resolved in favor of entry own annotation. 
stream_name | **string**<br>Entry stream name. Value must match the regular expression ` \|[a-zA-Z][-a-zA-Z0-9_.]{0,63} `.


### WriteResponse {#WriteResponse}

Field | Description
--- | ---
errors | **map<int64,google.rpc.Status>**<br>Map<idx, status> of ingest failures. <br>If entry with idx N is absent, it was ingested successfully. 


