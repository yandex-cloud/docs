---
editable: false
---

# Method update
Updates the specified alert.
 

 
## HTTP request {#https-request}
```
PATCH https://monitoring.{{ api-host }}/monitoring/v3/alerts/{alertId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
alertId | <p>Required. ID of the alert.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "window": "string",
  "delay": "string",
  "annotations": "object",
  "channels": [
    {
      "channelId": "string",
      "notifyAboutStatuses": [
        "string"
      ],
      "repeatPeriod": "string"
    }
  ],
  "threshold": {
    "selectors": "string",
    "transformations": "string",
    "predicateRules": [
      {
        "type": "string",
        "comparison": "string",
        "threshold": "number",
        "targetStatus": "string"
      }
    ]
  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br>Field mask that specifies which fields of the Alert resource are going to be updated.
name | **string**<br><p>Name of the alert.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the alert.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>Existing set of ``labels`` is completely replaced by the provided set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
window | **string**<br><p>Alert evaluation window in seconds.</p> 
delay | **string**<br><p>Alert evaluation delay in seconds.</p> 
annotations | **object**<br><p>Annotations.</p> 
channels[] | **object**
channels[].<br>channelId | **string**<br><p>ID of the channel.</p> 
channels[].<br>notifyAboutStatuses[] | **string**<br><ul> <li>EVALUATION_STATUS_OK: OK.</li> <li>EVALUATION_STATUS_WARN: Warning.</li> <li>EVALUATION_STATUS_ALARM: Alarm.</li> <li>EVALUATION_STATUS_NO_DATA: No data.</li> <li>EVALUATION_STATUS_ERROR: Error.</li> </ul> 
channels[].<br>repeatPeriod | **string**<br><p>Repeat notification period in seconds. Zero means no repeating.</p> 
threshold | **object**<br>Threshold alert.
threshold.<br>selectors | **string**<br><p>Selectors that query data to be checked.</p> 
threshold.<br>transformations | **string**<br><p>Transformations to be applied to the data before checking.</p> 
threshold.<br>predicateRules[] | **object**<br><p>A list of predicate rules to test against the data.</p> 
threshold.<br>predicateRules[].<br>type | **string**<br><p>Criteria by which the alert will be checked.</p> <ul> <li>THRESHOLD_TYPE_AT_LEAST_ONE: At least one.</li> <li>THRESHOLD_TYPE_AT_ALL_TIMES: At all times.</li> <li>THRESHOLD_TYPE_LAST_NON_NAN: Last non-NaN value.</li> <li>THRESHOLD_TYPE_AVG: Average.</li> <li>THRESHOLD_TYPE_MIN: Minimum.</li> <li>THRESHOLD_TYPE_MAX: Maximum.</li> <li>THRESHOLD_TYPE_SUM: Sum.</li> <li>THRESHOLD_TYPE_COUNT: Count.</li> </ul> 
threshold.<br>predicateRules[].<br>comparison | **string**<br><p>Operation used to compare with threshold value.</p> <ul> <li>COMPARISON_EQ: Equal the specified value.</li> <li>COMPARISON_NE: Not equal the specified value.</li> <li>COMPARISON_GT: Greater than the specified value.</li> <li>COMPARISON_LT: Less than the specified value.</li> <li>COMPARISON_GTE: Greater than or equal to the specified value.</li> <li>COMPARISON_LTE: Less than or equal to the specified value.</li> </ul> 
threshold.<br>predicateRules[].<br>threshold | **number** (double)<br><p>Threshold value.</p> 
threshold.<br>predicateRules[].<br>targetStatus | **string**<br><p>Target status of the alert if the predicate is true.</p> <ul> <li>TARGET_STATUS_OK: OK.</li> <li>TARGET_STATUS_WARN: Warn.</li> <li>TARGET_STATUS_ALARM: Alarm.</li> <li>TARGET_STATUS_NO_DATA: No data.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 