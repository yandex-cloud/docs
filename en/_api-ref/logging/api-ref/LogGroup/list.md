---
editable: false
---

# Method list
Retrieves the list of log groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://logging.api.cloud.yandex.net/logging/v1/logGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. Folder ID of the log groups to return.  To get a folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 64.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/logging/api-ref/LogGroup/list#responses) that can be used to get the next page of results in subsequent list requests.  Default value: 100.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/logging/api-ref/LogGroup/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters log groups listed in the response.  The expression must specify: 1. The field name. Currently filtering can only be applied to the [LogGroup.name](/docs/logging/api-ref/LogGroup#representation) field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Example of a filter: `name=my-log-group`.  The maximum string length in characters is 1000.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "groups": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "retentionPeriod": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
groups[] | **object**<br><p>List of log groups in the specified folder.</p> 
groups[].<br>id | **string**<br><p>Log group ID.</p> 
groups[].<br>folderId | **string**<br><p>Log group folder ID.</p> 
groups[].<br>cloudId | **string**<br><p>Log group cloud ID.</p> 
groups[].<br>createdAt | **string** (date-time)<br><p>Log group creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
groups[].<br>name | **string**<br><p>Log group name.</p> 
groups[].<br>description | **string**<br><p>Log group description.</p> 
groups[].<br>labels | **object**<br><p>Log group labels.</p> 
groups[].<br>status | **string**<br><p>Status of the log group.</p> <p>Possible log group statuses.</p> <ul> <li>STATUS_UNSPECIFIED: Unknown status.</li> </ul> <p>Should never occur.</p> <ul> <li>CREATING: Log group is creating.</li> <li>ACTIVE: Log group is ready to accept messages,</li> <li>DELETING: Log group is being deleted.</li> </ul> <p>No messages will be accepted.</p> <ul> <li>ERROR: Log group is in failed state.</li> </ul> 
groups[].<br>retentionPeriod | **string**<br><p>Log group entry retention period.</p> <p>Entries will be present in group during this period.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/logging/api-ref/LogGroup/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/logging/api-ref/LogGroup/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 