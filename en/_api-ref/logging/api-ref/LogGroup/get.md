---
editable: false
---

# Method get
Returns the specified log group.
 
To get the list of all available log groups, make a [list](/docs/logging/api-ref/LogGroup/list) request.
 
## HTTP request {#https-request}
```
GET https://logging.{{ api-host }}/logging/v1/logGroups/{logGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | <p>Required. ID of the log group to return.</p> <p>To get a log group ID make a <a href="/docs/logging/api-ref/LogGroup/list">list</a> request.</p> <p>The maximum string length in characters is 64.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
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
```

 
Field | Description
--- | ---
id | **string**<br><p>Log group ID.</p> 
folderId | **string**<br><p>Log group folder ID.</p> 
cloudId | **string**<br><p>Log group cloud ID.</p> 
createdAt | **string** (date-time)<br><p>Log group creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Log group name.</p> 
description | **string**<br><p>Log group description.</p> 
labels | **object**<br><p>Log group labels.</p> 
status | **string**<br><p>Status of the log group.</p> <p>Possible log group statuses.</p> <ul> <li>STATUS_UNSPECIFIED: Unknown status.</li> </ul> <p>Should never occur. - CREATING: Log group is creating.</p> <ul> <li> <p>ACTIVE: Log group is ready to accept messages,</p> </li> <li> <p>DELETING: Log group is being deleted.</p> <p>No messages will be accepted.</p> </li> <li> <p>ERROR: Log group is in failed state.</p> </li> </ul> 
retentionPeriod | **string**<br><p>Log group entry retention period.</p> <p>Entries will be present in group during this period.</p> 
dataStream | **string**<br><p>Data stream name</p> 