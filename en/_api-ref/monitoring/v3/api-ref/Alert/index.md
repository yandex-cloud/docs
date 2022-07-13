---
editable: false
---

# Alert
A set of methods for managing Alert resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
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
id | **string**<br><p>ID of the alert.</p> 
folderId | **string**<br><p>ID of the folder that the alert belongs on.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the alert.</p> 
description | **string**<br><p>Description of the alert.</p> 
labels | **object**<br><p>Resource labels as key:value pairs.</p> 
status | **string**<br>Status of current alert.<br><ul> <li>STATUS_ACTIVE: Active.</li> <li>STATUS_INACTIVE: Muted.</li> <li>STATUS_DELETED: Deleted.</li> </ul> 
window | **string**<br><p>Alert evaluation window in seconds.</p> 
delay | **string**<br><p>Alert evaluation delay in seconds.</p> 
annotations | **object**<br><p>Annotations.</p> 
channels[] | **object**<br><p>Channels.</p> 
channels[].<br>channelId | **string**<br><p>ID of the channel.</p> 
channels[].<br>notifyAboutStatuses[] | **string**<br><ul> <li>EVALUATION_STATUS_OK: OK.</li> <li>EVALUATION_STATUS_WARN: Warning.</li> <li>EVALUATION_STATUS_ALARM: Alarm.</li> <li>EVALUATION_STATUS_NO_DATA: No data.</li> <li>EVALUATION_STATUS_ERROR: Error.</li> </ul> 
channels[].<br>repeatPeriod | **string**<br><p>Repeat notification period in seconds. Zero means no repeating.</p> 
threshold | **object**
threshold.<br>selectors | **string**<br><p>Selectors that query data to be checked.</p> 
threshold.<br>transformations | **string**<br><p>Transformations to be applied to the data before checking.</p> 
threshold.<br>predicateRules[] | **object**<br><p>A list of predicate rules to test against the data.</p> 
threshold.<br>predicateRules[].<br>type | **string**<br><p>Criteria by which the alert will be checked.</p> <ul> <li>THRESHOLD_TYPE_AT_LEAST_ONE: At least one.</li> <li>THRESHOLD_TYPE_AT_ALL_TIMES: At all times.</li> <li>THRESHOLD_TYPE_LAST_NON_NAN: Last non-NaN value.</li> <li>THRESHOLD_TYPE_AVG: Average.</li> <li>THRESHOLD_TYPE_MIN: Minimum.</li> <li>THRESHOLD_TYPE_MAX: Maximum.</li> <li>THRESHOLD_TYPE_SUM: Sum.</li> <li>THRESHOLD_TYPE_COUNT: Count.</li> </ul> 
threshold.<br>predicateRules[].<br>comparison | **string**<br><p>Operation used to compare with threshold value.</p> <ul> <li>COMPARISON_EQ: Equal the specified value.</li> <li>COMPARISON_NE: Not equal the specified value.</li> <li>COMPARISON_GT: Greater than the specified value.</li> <li>COMPARISON_LT: Less than the specified value.</li> <li>COMPARISON_GTE: Greater than or equal to the specified value.</li> <li>COMPARISON_LTE: Less than or equal to the specified value.</li> </ul> 
threshold.<br>predicateRules[].<br>threshold | **number** (double)<br><p>Threshold value.</p> 
threshold.<br>predicateRules[].<br>targetStatus | **string**<br><p>Target status of the alert if the predicate is true.</p> <ul> <li>TARGET_STATUS_OK: OK.</li> <li>TARGET_STATUS_WARN: Warn.</li> <li>TARGET_STATUS_ALARM: Alarm.</li> <li>TARGET_STATUS_NO_DATA: No data.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a alert.
[delete](delete.md) | Deletes the specified alert.
[explainEvaluation](explainEvaluation.md) | 
[explainNewEvaluation](explainNewEvaluation.md) | 
[get](get.md) | Returns the specified Alert resource.
[getEvaluationState](getEvaluationState.md) | 
[getEvaluationStats](getEvaluationStats.md) | 
[getNotificationState](getNotificationState.md) | 
[getNotificationStats](getNotificationStats.md) | 
[getStats](getStats.md) | Folder stats.
[list](list.md) | Retrieves the list of Alert resources.
[listOperations](listOperations.md) | Lists operations for the specified alert.
[mute](mute.md) | Mute the specified alert.
[unmute](unmute.md) | Unmute the specified alert.
[update](update.md) | Updates the specified alert.