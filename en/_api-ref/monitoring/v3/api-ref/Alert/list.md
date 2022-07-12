---
editable: false
---

# Method list
Retrieves the list of Alert resources.
 

 
## HTTP request {#https-request}
```
GET https://monitoring.{{ api-host }}/monitoring/v3/alerts
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list alerts in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/monitoring/api-ref/Alert/list#query_params">pageSize</a>, the service returns a <a href="/docs/monitoring/api-ref/Alert/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/monitoring/api-ref/Alert/list#query_params">pageToken</a> to the <a href="/docs/monitoring/api-ref/Alert/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. Currently you can use filtering only on the <a href="/docs/monitoring/api-ref/Alert#representation">Alert.id</a> or <a href="/docs/monitoring/api-ref/Alert#representation">Alert.name</a> field.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "alerts": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
alerts[] | **object**<br><p>List of Alert resources.</p> 
alerts[].<br>id | **string**<br><p>ID of the alert.</p> 
alerts[].<br>folderId | **string**<br><p>ID of the folder that the alert belongs on.</p> 
alerts[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
alerts[].<br>name | **string**<br><p>Name of the alert.</p> 
alerts[].<br>description | **string**<br><p>Description of the alert.</p> 
alerts[].<br>labels | **object**<br><p>Resource labels as key:value pairs.</p> 
alerts[].<br>status | **string**<br>Status of current alert.<br><ul> <li>STATUS_ACTIVE: Active.</li> <li>STATUS_INACTIVE: Muted.</li> <li>STATUS_DELETED: Deleted.</li> </ul> 
alerts[].<br>window | **string**<br><p>Alert evaluation window in seconds.</p> 
alerts[].<br>delay | **string**<br><p>Alert evaluation delay in seconds.</p> 
alerts[].<br>annotations | **object**<br><p>Annotations.</p> 
alerts[].<br>channels[] | **object**<br><p>Channels.</p> 
alerts[].<br>channels[].<br>channelId | **string**<br><p>ID of the channel.</p> 
alerts[].<br>channels[].<br>notifyAboutStatuses[] | **string**<br><ul> <li>EVALUATION_STATUS_OK: OK.</li> <li>EVALUATION_STATUS_WARN: Warning.</li> <li>EVALUATION_STATUS_ALARM: Alarm.</li> <li>EVALUATION_STATUS_NO_DATA: No data.</li> <li>EVALUATION_STATUS_ERROR: Error.</li> </ul> 
alerts[].<br>channels[].<br>repeatPeriod | **string**<br><p>Repeat notification period in seconds. Zero means no repeating.</p> 
alerts[].<br>threshold | **object**<br>Threshold alert.<br>
alerts[].<br>threshold.<br>selectors | **string**<br><p>Selectors that query data to be checked.</p> 
alerts[].<br>threshold.<br>transformations | **string**<br><p>Transformations to be applied to the data before checking.</p> 
alerts[].<br>threshold.<br>predicateRules[] | **object**<br><p>A list of predicate rules to test against the data.</p> 
alerts[].<br>threshold.<br>predicateRules[].<br>type | **string**<br><p>Criteria by which the alert will be checked.</p> <ul> <li>THRESHOLD_TYPE_AT_LEAST_ONE: At least one.</li> <li>THRESHOLD_TYPE_AT_ALL_TIMES: At all times.</li> <li>THRESHOLD_TYPE_LAST_NON_NAN: Last non-NaN value.</li> <li>THRESHOLD_TYPE_AVG: Average.</li> <li>THRESHOLD_TYPE_MIN: Minimum.</li> <li>THRESHOLD_TYPE_MAX: Maximum.</li> <li>THRESHOLD_TYPE_SUM: Sum.</li> <li>THRESHOLD_TYPE_COUNT: Count.</li> </ul> 
alerts[].<br>threshold.<br>predicateRules[].<br>comparison | **string**<br><p>Operation used to compare with threshold value.</p> <ul> <li>COMPARISON_EQ: Equal the specified value.</li> <li>COMPARISON_NE: Not equal the specified value.</li> <li>COMPARISON_GT: Greater than the specified value.</li> <li>COMPARISON_LT: Less than the specified value.</li> <li>COMPARISON_GTE: Greater than or equal to the specified value.</li> <li>COMPARISON_LTE: Less than or equal to the specified value.</li> </ul> 
alerts[].<br>threshold.<br>predicateRules[].<br>threshold | **number** (double)<br><p>Threshold value.</p> 
alerts[].<br>threshold.<br>predicateRules[].<br>targetStatus | **string**<br><p>Target status of the alert if the predicate is true.</p> <ul> <li>TARGET_STATUS_OK: OK.</li> <li>TARGET_STATUS_WARN: Warn.</li> <li>TARGET_STATUS_ALARM: Alarm.</li> <li>TARGET_STATUS_NO_DATA: No data.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/monitoring/api-ref/Alert/list#query_params">pageSize</a>, use the <a href="/docs/monitoring/api-ref/Alert/list#responses">nextPageToken</a> as the value for the <a href="/docs/monitoring/api-ref/Alert/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/monitoring/api-ref/Alert/list#responses">nextPageToken</a> to continue paging through the results.</p> 