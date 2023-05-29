---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/LogGroup/list.md
---

# Cloud Logging Service, REST: LogGroup.list
Retrieves the list of log groups in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://logging.{{ api-host }}/logging/v1/logGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. Folder ID of the log groups to return.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 64.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/logging/api-ref/LogGroup/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/logging/api-ref/LogGroup/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters log groups listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to the <a href="/docs/logging/api-ref/LogGroup#representation">LogGroup.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-log-group``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
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
      "retentionPeriod": "string",
      "dataStream": "string"
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
groups[].<br>createdAt | **string** (date-time)<br><p>Log group creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
groups[].<br>name | **string**<br><p>Log group name.</p> 
groups[].<br>description | **string**<br><p>Log group description.</p> 
groups[].<br>labels | **object**<br><p>Log group labels.</p> 
groups[].<br>status | **string**<br><p>Status of the log group.</p> <p>Possible log group statuses.</p> <ul> <li>STATUS_UNSPECIFIED: Unknown status.</li> </ul> <p>Should never occur. - CREATING: Log group is creating.</p> <ul> <li> <p>ACTIVE: Log group is ready to accept messages,</p> </li> <li> <p>DELETING: Log group is being deleted.</p> <p>No messages will be accepted.</p> </li> <li> <p>ERROR: Log group is in failed state.</p> </li> </ul> 
groups[].<br>retentionPeriod | **string**<br><p>Log group entry retention period.</p> <p>Entries will be present in group during this period.</p> 
groups[].<br>dataStream | **string**<br><p>Data stream name</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/logging/api-ref/LogGroup/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/logging/api-ref/LogGroup/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 