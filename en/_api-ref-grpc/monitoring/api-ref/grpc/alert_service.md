---
editable: false
---

# Monitoring API, gRPC: AlertService

A set of methods for managing Alert resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Alert resource. |
| [List](#List) | Retrieves the list of Alert resources. |
| [Create](#Create) | Creates a alert. |
| [Update](#Update) | Updates the specified alert. |
| [Delete](#Delete) | Deletes the specified alert. |
| [GetEvaluationStats](#GetEvaluationStats) |  |
| [GetNotificationStats](#GetNotificationStats) |  |
| [GetEvaluationState](#GetEvaluationState) |  |
| [GetNotificationState](#GetNotificationState) |  |
| [ExplainEvaluation](#ExplainEvaluation) |  |
| [ExplainNewEvaluation](#ExplainNewEvaluation) |  |
| [GetStats](#GetStats) | Folder stats. |
| [Mute](#Mute) | Mute the specified alert. |
| [Unmute](#Unmute) | Unmute the specified alert. |
| [ListOperations](#ListOperations) | Lists operations for the specified alert. |

## Calls AlertService {#calls}

## Get {#Get}

Returns the specified Alert resource. <br>To get the list of available Alert resources, make a [List](#List) request.

**rpc Get ([GetAlertRequest](#GetAlertRequest)) returns ([Alert](#Alert))**

### GetAlertRequest {#GetAlertRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required. ID of the Alert resource to return. The maximum string length in characters is 50.


### Alert {#Alert}

Field | Description
--- | ---
id | **string**<br>ID of the alert. 
folder_id | **string**<br>ID of the folder that the alert belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the alert. 
description | **string**<br>Description of the alert. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
status | enum **Status**<br>Status of current alert. <ul><li>`STATUS_ACTIVE`: Active.</li><li>`STATUS_INACTIVE`: Muted.</li><li>`STATUS_DELETED`: Deleted.</li></ul>
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig)**<br>Channels. 


### ThresholdAlert {#ThresholdAlert}

Field | Description
--- | ---
selectors | **string**<br>Selectors that query data to be checked. 
transformations | **string**<br>Transformations to be applied to the data before checking. 
predicate_rules[] | **[PredicateRule](#PredicateRule)**<br>A list of predicate rules to test against the data. 


### PredicateRule {#PredicateRule}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Criteria by which the alert will be checked. <ul><li>`THRESHOLD_TYPE_AT_LEAST_ONE`: At least one.</li><li>`THRESHOLD_TYPE_AT_ALL_TIMES`: At all times.</li><li>`THRESHOLD_TYPE_LAST_NON_NAN`: Last non-NaN value.</li><li>`THRESHOLD_TYPE_AVG`: Average.</li><li>`THRESHOLD_TYPE_MIN`: Minimum.</li><li>`THRESHOLD_TYPE_MAX`: Maximum.</li><li>`THRESHOLD_TYPE_SUM`: Sum.</li><li>`THRESHOLD_TYPE_COUNT`: Count.</li></ul>
comparison | enum **Comparison**<br>Operation used to compare with threshold value. <ul><li>`COMPARISON_EQ`: Equal the specified value.</li><li>`COMPARISON_NE`: Not equal the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li></ul>
threshold | **double**<br>Threshold value. 
target_status | enum **TargetStatus**<br>Target status of the alert if the predicate is true. <ul><li>`TARGET_STATUS_OK`: OK.</li><li>`TARGET_STATUS_WARN`: Warn.</li><li>`TARGET_STATUS_ALARM`: Alarm.</li><li>`TARGET_STATUS_NO_DATA`: No data.</li></ul>


### NotificationConfig {#NotificationConfig}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
notify_about_statuses[] | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
repeat_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Repeat notification period in seconds. Zero means no repeating. 


## List {#List}

Retrieves the list of Alert resources.

**rpc List ([ListAlertsRequest](#ListAlertsRequest)) returns ([ListAlertsResponse](#ListAlertsResponse))**

### ListAlertsRequest {#ListAlertsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list alerts in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListAlertsResponse.next_page_token](#ListAlertsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAlertsResponse.next_page_token](#ListAlertsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [Alert.id](#Alert1) or [Alert.name](#Alert1) field. The maximum string length in characters is 1000.


### ListAlertsResponse {#ListAlertsResponse}

Field | Description
--- | ---
alerts[] | **[Alert](#Alert1)**<br>List of Alert resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAlertsRequest.page_size](#ListAlertsRequest), use the `next_page_token` as the value for the [ListAlertsRequest.page_token](#ListAlertsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Alert {#Alert1}

Field | Description
--- | ---
id | **string**<br>ID of the alert. 
folder_id | **string**<br>ID of the folder that the alert belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the alert. 
description | **string**<br>Description of the alert. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
status | enum **Status**<br>Status of current alert. <ul><li>`STATUS_ACTIVE`: Active.</li><li>`STATUS_INACTIVE`: Muted.</li><li>`STATUS_DELETED`: Deleted.</li></ul>
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert1)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig1)**<br>Channels. 


### ThresholdAlert {#ThresholdAlert1}

Field | Description
--- | ---
selectors | **string**<br>Selectors that query data to be checked. 
transformations | **string**<br>Transformations to be applied to the data before checking. 
predicate_rules[] | **[PredicateRule](#PredicateRule1)**<br>A list of predicate rules to test against the data. 


### PredicateRule {#PredicateRule1}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Criteria by which the alert will be checked. <ul><li>`THRESHOLD_TYPE_AT_LEAST_ONE`: At least one.</li><li>`THRESHOLD_TYPE_AT_ALL_TIMES`: At all times.</li><li>`THRESHOLD_TYPE_LAST_NON_NAN`: Last non-NaN value.</li><li>`THRESHOLD_TYPE_AVG`: Average.</li><li>`THRESHOLD_TYPE_MIN`: Minimum.</li><li>`THRESHOLD_TYPE_MAX`: Maximum.</li><li>`THRESHOLD_TYPE_SUM`: Sum.</li><li>`THRESHOLD_TYPE_COUNT`: Count.</li></ul>
comparison | enum **Comparison**<br>Operation used to compare with threshold value. <ul><li>`COMPARISON_EQ`: Equal the specified value.</li><li>`COMPARISON_NE`: Not equal the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li></ul>
threshold | **double**<br>Threshold value. 
target_status | enum **TargetStatus**<br>Target status of the alert if the predicate is true. <ul><li>`TARGET_STATUS_OK`: OK.</li><li>`TARGET_STATUS_WARN`: Warn.</li><li>`TARGET_STATUS_ALARM`: Alarm.</li><li>`TARGET_STATUS_NO_DATA`: No data.</li></ul>


### NotificationConfig {#NotificationConfig1}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
notify_about_statuses[] | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
repeat_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Repeat notification period in seconds. Zero means no repeating. 


## Create {#Create}

Creates a alert.

**rpc Create ([CreateAlertRequest](#CreateAlertRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateAlertMetadata](#CreateAlertMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Alert](#Alert2)<br>

### CreateAlertRequest {#CreateAlertRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create alert in. The maximum string length in characters is 50.
name | **string**<br>Name of the alert. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the alert. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert2)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig2)**<br> 


### ThresholdAlert {#ThresholdAlert2}

Field | Description
--- | ---
selectors | **string**<br>Selectors that query data to be checked. 
transformations | **string**<br>Transformations to be applied to the data before checking. 
predicate_rules[] | **[PredicateRule](#PredicateRule2)**<br>A list of predicate rules to test against the data. 


### PredicateRule {#PredicateRule2}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Criteria by which the alert will be checked. <ul><li>`THRESHOLD_TYPE_AT_LEAST_ONE`: At least one.</li><li>`THRESHOLD_TYPE_AT_ALL_TIMES`: At all times.</li><li>`THRESHOLD_TYPE_LAST_NON_NAN`: Last non-NaN value.</li><li>`THRESHOLD_TYPE_AVG`: Average.</li><li>`THRESHOLD_TYPE_MIN`: Minimum.</li><li>`THRESHOLD_TYPE_MAX`: Maximum.</li><li>`THRESHOLD_TYPE_SUM`: Sum.</li><li>`THRESHOLD_TYPE_COUNT`: Count.</li></ul>
comparison | enum **Comparison**<br>Operation used to compare with threshold value. <ul><li>`COMPARISON_EQ`: Equal the specified value.</li><li>`COMPARISON_NE`: Not equal the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li></ul>
threshold | **double**<br>Threshold value. 
target_status | enum **TargetStatus**<br>Target status of the alert if the predicate is true. <ul><li>`TARGET_STATUS_OK`: OK.</li><li>`TARGET_STATUS_WARN`: Warn.</li><li>`TARGET_STATUS_ALARM`: Alarm.</li><li>`TARGET_STATUS_NO_DATA`: No data.</li></ul>


### NotificationConfig {#NotificationConfig2}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
notify_about_statuses[] | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
repeat_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Repeat notification period in seconds. Zero means no repeating. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateAlertMetadata](#CreateAlertMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Alert](#Alert2)>**<br>if operation finished successfully. 


### CreateAlertMetadata {#CreateAlertMetadata}

Field | Description
--- | ---
alert_id | **string**<br>ID of the alert. 


### Alert {#Alert2}

Field | Description
--- | ---
id | **string**<br>ID of the alert. 
folder_id | **string**<br>ID of the folder that the alert belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the alert. 
description | **string**<br>Description of the alert. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
status | enum **Status**<br>Status of current alert. <ul><li>`STATUS_ACTIVE`: Active.</li><li>`STATUS_INACTIVE`: Muted.</li><li>`STATUS_DELETED`: Deleted.</li></ul>
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert3)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig3)**<br>Channels. 


## Update {#Update}

Updates the specified alert.

**rpc Update ([UpdateAlertRequest](#UpdateAlertRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAlertMetadata](#UpdateAlertMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Alert](#Alert3)<br>

### UpdateAlertRequest {#UpdateAlertRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required. ID of the alert. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Alert resource are going to be updated. 
name | **string**<br>Name of the alert. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the alert. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert3)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig3)**<br> 


### ThresholdAlert {#ThresholdAlert3}

Field | Description
--- | ---
selectors | **string**<br>Selectors that query data to be checked. 
transformations | **string**<br>Transformations to be applied to the data before checking. 
predicate_rules[] | **[PredicateRule](#PredicateRule3)**<br>A list of predicate rules to test against the data. 


### PredicateRule {#PredicateRule3}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Criteria by which the alert will be checked. <ul><li>`THRESHOLD_TYPE_AT_LEAST_ONE`: At least one.</li><li>`THRESHOLD_TYPE_AT_ALL_TIMES`: At all times.</li><li>`THRESHOLD_TYPE_LAST_NON_NAN`: Last non-NaN value.</li><li>`THRESHOLD_TYPE_AVG`: Average.</li><li>`THRESHOLD_TYPE_MIN`: Minimum.</li><li>`THRESHOLD_TYPE_MAX`: Maximum.</li><li>`THRESHOLD_TYPE_SUM`: Sum.</li><li>`THRESHOLD_TYPE_COUNT`: Count.</li></ul>
comparison | enum **Comparison**<br>Operation used to compare with threshold value. <ul><li>`COMPARISON_EQ`: Equal the specified value.</li><li>`COMPARISON_NE`: Not equal the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li></ul>
threshold | **double**<br>Threshold value. 
target_status | enum **TargetStatus**<br>Target status of the alert if the predicate is true. <ul><li>`TARGET_STATUS_OK`: OK.</li><li>`TARGET_STATUS_WARN`: Warn.</li><li>`TARGET_STATUS_ALARM`: Alarm.</li><li>`TARGET_STATUS_NO_DATA`: No data.</li></ul>


### NotificationConfig {#NotificationConfig3}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
notify_about_statuses[] | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
repeat_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Repeat notification period in seconds. Zero means no repeating. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAlertMetadata](#UpdateAlertMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Alert](#Alert3)>**<br>if operation finished successfully. 


### UpdateAlertMetadata {#UpdateAlertMetadata}

Field | Description
--- | ---
alert_id | **string**<br>ID of the alert that is being updated. 


### Alert {#Alert3}

Field | Description
--- | ---
id | **string**<br>ID of the alert. 
folder_id | **string**<br>ID of the folder that the alert belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the alert. 
description | **string**<br>Description of the alert. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
status | enum **Status**<br>Status of current alert. <ul><li>`STATUS_ACTIVE`: Active.</li><li>`STATUS_INACTIVE`: Muted.</li><li>`STATUS_DELETED`: Deleted.</li></ul>
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert4)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig4)**<br>Channels. 


## Delete {#Delete}

Deletes the specified alert.

**rpc Delete ([DeleteAlertRequest](#DeleteAlertRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAlertMetadata](#DeleteAlertMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAlertRequest {#DeleteAlertRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required. ID of the alert to delete. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAlertMetadata](#DeleteAlertMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteAlertMetadata {#DeleteAlertMetadata}

Field | Description
--- | ---
alert_id | **string**<br>ID of the alert that is being deleted. 


## GetEvaluationStats {#GetEvaluationStats}



**rpc GetEvaluationStats ([GetAlertEvaluationStatsRequest](#GetAlertEvaluationStatsRequest)) returns ([GetAlertEvaluationStatsResponse](#GetAlertEvaluationStatsResponse))**

### GetAlertEvaluationStatsRequest {#GetAlertEvaluationStatsRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required. ID of the alert. The maximum string length in characters is 50.


### GetAlertEvaluationStatsResponse {#GetAlertEvaluationStatsResponse}

Field | Description
--- | ---
evaluation_stats | **[EvaluationStats](#EvaluationStats)**<br> 


### EvaluationStats {#EvaluationStats}

Field | Description
--- | ---
ok_count | **int64**<br> 
warn_count | **int64**<br> 
alarm_count | **int64**<br> 
error_count | **int64**<br> 
no_data_count | **int64**<br> 


## GetNotificationStats {#GetNotificationStats}



**rpc GetNotificationStats ([GetAlertNotificationStatsRequest](#GetAlertNotificationStatsRequest)) returns ([GetAlertNotificationStatsResponse](#GetAlertNotificationStatsResponse))**

### GetAlertNotificationStatsRequest {#GetAlertNotificationStatsRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required. ID of the alert. The maximum string length in characters is 50.


### GetAlertNotificationStatsResponse {#GetAlertNotificationStatsResponse}

Field | Description
--- | ---
notification_stats | **[NotificationStats](#NotificationStats)**<br> 


### NotificationStats {#NotificationStats}

Field | Description
--- | ---
unknown | **int64**<br> 
success | **int64**<br> 
error | **int64**<br> 
invalid_request | **int64**<br> 
absent_notification_channel | **int64**<br> 
retry_error | **int64**<br> 
resource_exhausted | **int64**<br> 
permission_denied | **int64**<br> 
not_subscribed | **int64**<br> 


## GetEvaluationState {#GetEvaluationState}



**rpc GetEvaluationState ([GetAlertEvaluationStateRequest](#GetAlertEvaluationStateRequest)) returns ([GetAlertEvaluationStateResponse](#GetAlertEvaluationStateResponse))**

### GetAlertEvaluationStateRequest {#GetAlertEvaluationStateRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required. ID of the Alert. The maximum string length in characters is 50.


### GetAlertEvaluationStateResponse {#GetAlertEvaluationStateResponse}

Field | Description
--- | ---
folder_id | **string**<br>Reference to folder that contains alert. 
alert_id | **string**<br>Unique identity for alert. 
alert_version | **int64**<br>Version of alert that will be use to evaluate latest time. Each change of alert reset state. 
status | enum **EvaluationStatus**<br>Evaluation status and details. It's status of latest change between statuses, for example from OK to ALARM. <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
since | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when evaluation state will changed latest time, for example from OK to ALARM. 
latest_eval | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>UNIX time when latest alert evaluation occurs. Since - LatestEval = how much time alert in particular state. 
previous_status | enum **EvaluationStatus**<br>Evaluation status and details. It's status of previous change between statuses, for example from OK to ALARM. <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>


## GetNotificationState {#GetNotificationState}



**rpc GetNotificationState ([GetAlertNotificationStateRequest](#GetAlertNotificationStateRequest)) returns ([GetAlertNotificationStateResponse](#GetAlertNotificationStateResponse))**

### GetAlertNotificationStateRequest {#GetAlertNotificationStateRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required. ID of the alert. The maximum string length in characters is 50.


### GetAlertNotificationStateResponse {#GetAlertNotificationStateResponse}

Field | Description
--- | ---
channel_states[] | **[ChannelState](#ChannelState)**<br> 


### ChannelState {#ChannelState}

Field | Description
--- | ---
folder_id | **string**<br>Reference to folder that contains alert. 
channel_id | **string**<br>Reference to notification channel. 
status | enum **NotificationStatus**<br>Latest notification status. <ul><li>`SKIP_REPEAT`: Send notification was skipped because already notified.</li><li>`SKIP_BY_STATUS`: Skip notification because status absent in subscribe list.</li><li>`SUCCESS`: Notification successfully delivered.</li><li>`ERROR`: Not classified kind of error occurs.</li><li>`INVALID_REQUEST`: Target service reject notification because it not valid or notification channel configured. not correctly</li><li>`OBSOLETE`: Notification not valid any more.</li><li>`ABSENT_NOTIFICATION_CHANNEL`: Notification was send to /dev/null because reference notificaiton channel not exists.</li><li>`ERROR_ABLE_TO_RETRY`: Notification should be repeated because target destination not ready yet accept it.</li><li>`RESOURCE_EXHAUSTED`: One of the quote exhausted.</li><li>`PERMISSION_DENIED`: User have no rights to receive notifications.</li><li>`NOT_SUBSCRIBED`: User unsubscribed or missing settings (e.g. no phone specified).</li></ul>
latest_eval | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when notification was triggered latest time. 


## ExplainEvaluation {#ExplainEvaluation}



**rpc ExplainEvaluation ([ExplainAlertEvaluationRequest](#ExplainAlertEvaluationRequest)) returns ([ExplainAlertEvaluationResponse](#ExplainAlertEvaluationResponse))**

### ExplainAlertEvaluationRequest {#ExplainAlertEvaluationRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required.  The maximum string length in characters is 50.
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


### ExplainAlertEvaluationResponse {#ExplainAlertEvaluationResponse}

Field | Description
--- | ---
evaluation_status | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
series[] | **[AlertTimeseries](#AlertTimeseries)**<br> 


### AlertTimeseries {#AlertTimeseries}

Field | Description
--- | ---
alias | **string**<br>Alias of timeseries, or empty if not specified. 
labels | **map<string,string>**<br>Labels of timeseries, or empty if absent by any reason. 
timestamps[] | **int64**<br>Array with timestamps of timeseries. 
values[] | **double**<br>Array with values of timeseries. 


## ExplainNewEvaluation {#ExplainNewEvaluation}



**rpc ExplainNewEvaluation ([ExplainNewAlertEvaluationRequest](#ExplainNewAlertEvaluationRequest)) returns ([ExplainNewAlertEvaluationResponse](#ExplainNewAlertEvaluationResponse))**

### ExplainNewAlertEvaluationRequest {#ExplainNewAlertEvaluationRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required.  The maximum string length in characters is 50.
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Name of the alert. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the alert. The maximum string length in characters is 256.
status | **[Alert.Status](#Alert4)**<br>Status of current alert. 
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert4)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig4)**<br> 


### ThresholdAlert {#ThresholdAlert4}

Field | Description
--- | ---
selectors | **string**<br>Selectors that query data to be checked. 
transformations | **string**<br>Transformations to be applied to the data before checking. 
predicate_rules[] | **[PredicateRule](#PredicateRule4)**<br>A list of predicate rules to test against the data. 


### PredicateRule {#PredicateRule4}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Criteria by which the alert will be checked. <ul><li>`THRESHOLD_TYPE_AT_LEAST_ONE`: At least one.</li><li>`THRESHOLD_TYPE_AT_ALL_TIMES`: At all times.</li><li>`THRESHOLD_TYPE_LAST_NON_NAN`: Last non-NaN value.</li><li>`THRESHOLD_TYPE_AVG`: Average.</li><li>`THRESHOLD_TYPE_MIN`: Minimum.</li><li>`THRESHOLD_TYPE_MAX`: Maximum.</li><li>`THRESHOLD_TYPE_SUM`: Sum.</li><li>`THRESHOLD_TYPE_COUNT`: Count.</li></ul>
comparison | enum **Comparison**<br>Operation used to compare with threshold value. <ul><li>`COMPARISON_EQ`: Equal the specified value.</li><li>`COMPARISON_NE`: Not equal the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li></ul>
threshold | **double**<br>Threshold value. 
target_status | enum **TargetStatus**<br>Target status of the alert if the predicate is true. <ul><li>`TARGET_STATUS_OK`: OK.</li><li>`TARGET_STATUS_WARN`: Warn.</li><li>`TARGET_STATUS_ALARM`: Alarm.</li><li>`TARGET_STATUS_NO_DATA`: No data.</li></ul>


### NotificationConfig {#NotificationConfig4}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
notify_about_statuses[] | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
repeat_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Repeat notification period in seconds. Zero means no repeating. 


### ExplainNewAlertEvaluationResponse {#ExplainNewAlertEvaluationResponse}

Field | Description
--- | ---
evaluation_status | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
series[] | **[AlertTimeseries](#AlertTimeseries1)**<br> 


### AlertTimeseries {#AlertTimeseries1}

Field | Description
--- | ---
alias | **string**<br>Alias of timeseries, or empty if not specified. 
labels | **map<string,string>**<br>Labels of timeseries, or empty if absent by any reason. 
timestamps[] | **int64**<br>Array with timestamps of timeseries. 
values[] | **double**<br>Array with values of timeseries. 


## GetStats {#GetStats}

Folder stats.

**rpc GetStats ([GetAlertStatsRequest](#GetAlertStatsRequest)) returns ([GetAlertStatsResponse](#GetAlertStatsResponse))**

### GetAlertStatsRequest {#GetAlertStatsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. Folder ID. The maximum string length in characters is 50.


### GetAlertStatsResponse {#GetAlertStatsResponse}

Field | Description
--- | ---
alert_count | **int64**<br> 
evaluation_stats | **[EvaluationStats](#EvaluationStats)**<br> 
notification_stats | **[NotificationStats](#NotificationStats1)**<br> 


### EvaluationStats {#EvaluationStats1}

Field | Description
--- | ---
ok_count | **int64**<br> 
warn_count | **int64**<br> 
alarm_count | **int64**<br> 
error_count | **int64**<br> 
no_data_count | **int64**<br> 


### NotificationStats {#NotificationStats1}

Field | Description
--- | ---
unknown | **int64**<br> 
success | **int64**<br> 
error | **int64**<br> 
invalid_request | **int64**<br> 
absent_notification_channel | **int64**<br> 
retry_error | **int64**<br> 
resource_exhausted | **int64**<br> 
permission_denied | **int64**<br> 
not_subscribed | **int64**<br> 


## Mute {#Mute}

Mute the specified alert.

**rpc Mute ([MuteAlertRequest](#MuteAlertRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MuteAlertMetadata](#MuteAlertMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Alert](#Alert4)<br>

### MuteAlertRequest {#MuteAlertRequest}

Field | Description
--- | ---
alert_id | **string**<br> 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MuteAlertMetadata](#MuteAlertMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Alert](#Alert4)>**<br>if operation finished successfully. 


### MuteAlertMetadata {#MuteAlertMetadata}

Field | Description
--- | ---
alert_id | **string**<br> 


### Alert {#Alert4}

Field | Description
--- | ---
id | **string**<br>ID of the alert. 
folder_id | **string**<br>ID of the folder that the alert belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the alert. 
description | **string**<br>Description of the alert. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
status | enum **Status**<br>Status of current alert. <ul><li>`STATUS_ACTIVE`: Active.</li><li>`STATUS_INACTIVE`: Muted.</li><li>`STATUS_DELETED`: Deleted.</li></ul>
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert5)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig5)**<br>Channels. 


### ThresholdAlert {#ThresholdAlert5}

Field | Description
--- | ---
selectors | **string**<br>Selectors that query data to be checked. 
transformations | **string**<br>Transformations to be applied to the data before checking. 
predicate_rules[] | **[PredicateRule](#PredicateRule5)**<br>A list of predicate rules to test against the data. 


### PredicateRule {#PredicateRule5}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Criteria by which the alert will be checked. <ul><li>`THRESHOLD_TYPE_AT_LEAST_ONE`: At least one.</li><li>`THRESHOLD_TYPE_AT_ALL_TIMES`: At all times.</li><li>`THRESHOLD_TYPE_LAST_NON_NAN`: Last non-NaN value.</li><li>`THRESHOLD_TYPE_AVG`: Average.</li><li>`THRESHOLD_TYPE_MIN`: Minimum.</li><li>`THRESHOLD_TYPE_MAX`: Maximum.</li><li>`THRESHOLD_TYPE_SUM`: Sum.</li><li>`THRESHOLD_TYPE_COUNT`: Count.</li></ul>
comparison | enum **Comparison**<br>Operation used to compare with threshold value. <ul><li>`COMPARISON_EQ`: Equal the specified value.</li><li>`COMPARISON_NE`: Not equal the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li></ul>
threshold | **double**<br>Threshold value. 
target_status | enum **TargetStatus**<br>Target status of the alert if the predicate is true. <ul><li>`TARGET_STATUS_OK`: OK.</li><li>`TARGET_STATUS_WARN`: Warn.</li><li>`TARGET_STATUS_ALARM`: Alarm.</li><li>`TARGET_STATUS_NO_DATA`: No data.</li></ul>


### NotificationConfig {#NotificationConfig5}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
notify_about_statuses[] | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
repeat_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Repeat notification period in seconds. Zero means no repeating. 


## Unmute {#Unmute}

Unmute the specified alert.

**rpc Unmute ([UnmuteAlertRequest](#UnmuteAlertRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UnmuteAlertMetadata](#UnmuteAlertMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Alert](#Alert5)<br>

### UnmuteAlertRequest {#UnmuteAlertRequest}

Field | Description
--- | ---
alert_id | **string**<br> 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UnmuteAlertMetadata](#UnmuteAlertMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Alert](#Alert5)>**<br>if operation finished successfully. 


### UnmuteAlertMetadata {#UnmuteAlertMetadata}

Field | Description
--- | ---
alert_id | **string**<br> 


### Alert {#Alert5}

Field | Description
--- | ---
id | **string**<br>ID of the alert. 
folder_id | **string**<br>ID of the folder that the alert belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the alert. 
description | **string**<br>Description of the alert. 
labels | **map<string,string>**<br>Resource labels as key:value pairs. 
status | enum **Status**<br>Status of current alert. <ul><li>`STATUS_ACTIVE`: Active.</li><li>`STATUS_INACTIVE`: Muted.</li><li>`STATUS_DELETED`: Deleted.</li></ul>
window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation window in seconds. 
delay | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Alert evaluation delay in seconds. 
type | **oneof:** `threshold`<br>
&nbsp;&nbsp;threshold | **[ThresholdAlert](#ThresholdAlert6)**<br>Threshold alert. 
annotations | **map<string,string>**<br>Annotations. 
channels[] | **[NotificationConfig](#NotificationConfig6)**<br>Channels. 


### ThresholdAlert {#ThresholdAlert6}

Field | Description
--- | ---
selectors | **string**<br>Selectors that query data to be checked. 
transformations | **string**<br>Transformations to be applied to the data before checking. 
predicate_rules[] | **[PredicateRule](#PredicateRule6)**<br>A list of predicate rules to test against the data. 


### PredicateRule {#PredicateRule6}

Field | Description
--- | ---
type | enum **ThresholdType**<br>Criteria by which the alert will be checked. <ul><li>`THRESHOLD_TYPE_AT_LEAST_ONE`: At least one.</li><li>`THRESHOLD_TYPE_AT_ALL_TIMES`: At all times.</li><li>`THRESHOLD_TYPE_LAST_NON_NAN`: Last non-NaN value.</li><li>`THRESHOLD_TYPE_AVG`: Average.</li><li>`THRESHOLD_TYPE_MIN`: Minimum.</li><li>`THRESHOLD_TYPE_MAX`: Maximum.</li><li>`THRESHOLD_TYPE_SUM`: Sum.</li><li>`THRESHOLD_TYPE_COUNT`: Count.</li></ul>
comparison | enum **Comparison**<br>Operation used to compare with threshold value. <ul><li>`COMPARISON_EQ`: Equal the specified value.</li><li>`COMPARISON_NE`: Not equal the specified value.</li><li>`COMPARISON_GT`: Greater than the specified value.</li><li>`COMPARISON_LT`: Less than the specified value.</li><li>`COMPARISON_GTE`: Greater than or equal to the specified value.</li><li>`COMPARISON_LTE`: Less than or equal to the specified value.</li></ul>
threshold | **double**<br>Threshold value. 
target_status | enum **TargetStatus**<br>Target status of the alert if the predicate is true. <ul><li>`TARGET_STATUS_OK`: OK.</li><li>`TARGET_STATUS_WARN`: Warn.</li><li>`TARGET_STATUS_ALARM`: Alarm.</li><li>`TARGET_STATUS_NO_DATA`: No data.</li></ul>


### NotificationConfig {#NotificationConfig6}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
notify_about_statuses[] | enum **EvaluationStatus**<br> <ul><li>`EVALUATION_STATUS_OK`: OK.</li><li>`EVALUATION_STATUS_WARN`: Warning.</li><li>`EVALUATION_STATUS_ALARM`: Alarm.</li><li>`EVALUATION_STATUS_NO_DATA`: No data.</li><li>`EVALUATION_STATUS_ERROR`: Error.</li></ul>
repeat_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Repeat notification period in seconds. Zero means no repeating. 


## ListOperations {#ListOperations}

Lists operations for the specified alert.

**rpc ListOperations ([ListAlertOperationsRequest](#ListAlertOperationsRequest)) returns ([ListAlertOperationsResponse](#ListAlertOperationsResponse))**

### ListAlertOperationsRequest {#ListAlertOperationsRequest}

Field | Description
--- | ---
alert_id | **string**<br>Required. ID of the alert to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListAlertOperationsResponse.next_page_token](#ListAlertOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAlertOperationsResponse.next_page_token](#ListAlertOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListAlertOperationsResponse {#ListAlertOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified alert. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAlertOperationsRequest.page_size](#ListAlertOperationsRequest), use the `next_page_token` as the value for the [ListAlertOperationsRequest.page_token](#ListAlertOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation5}

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


