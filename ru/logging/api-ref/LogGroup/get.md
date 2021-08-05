---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# Method get
Returns the specified log group.
 
To get the list of all available log groups, make a [list](/docs/logging/api-ref/LogGroup/list) request.
 
## HTTP request {#https-request}
```
GET https://logging.api.cloud.yandex.net/logging/v1/logGroups/{logGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
logGroupId | Required. ID of the log group to return.  To get a log group ID make a [list](/docs/logging/api-ref/LogGroup/list) request.  The maximum string length in characters is 64.
 
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
  "retentionPeriod": "string"
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
status | **string**<br><p>Status of the log group.</p> <p>Possible log group statuses.</p> <ul> <li>STATUS_UNSPECIFIED: Unknown status.</li> </ul> <p>Should never occur.</p> <ul> <li>CREATING: Log group is creating.</li> <li>ACTIVE: Log group is ready to accept messages,</li> <li>DELETING: Log group is being deleted.</li> </ul> <p>No messages will be accepted.</p> <ul> <li>ERROR: Log group is in failed state.</li> </ul> 
retentionPeriod | **string**<br><p>Log group entry retention period.</p> <p>Entries will be present in group during this period.</p> 