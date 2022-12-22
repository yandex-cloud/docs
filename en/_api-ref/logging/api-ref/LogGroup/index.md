---
editable: false
---

# Cloud Logging Service, REST: LogGroup methods
A set of methods for managing log groups.
## JSON Representation {#representation}
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
createdAt | **string** (date-time)<br><p>Log group creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Log group name.</p> 
description | **string**<br><p>Log group description.</p> 
labels | **object**<br><p>Log group labels.</p> 
status | **string**<br><p>Status of the log group.</p> <p>Possible log group statuses.</p> <ul> <li>STATUS_UNSPECIFIED: Unknown status.</li> </ul> <p>Should never occur. - CREATING: Log group is creating.</p> <ul> <li> <p>ACTIVE: Log group is ready to accept messages,</p> </li> <li> <p>DELETING: Log group is being deleted.</p> <p>No messages will be accepted.</p> </li> <li> <p>ERROR: Log group is in failed state.</p> </li> </ul> 
retentionPeriod | **string**<br><p>Log group entry retention period.</p> <p>Entries will be present in group during this period.</p> 
dataStream | **string**<br><p>Data stream name</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a log group in the specified folder.
[delete](delete.md) | Deletes the specified log group.
[get](get.md) | Returns the specified log group.
[list](list.md) | Retrieves the list of log groups in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified log group.
[listOperations](listOperations.md) | Lists operations for the specified log group.
[listResources](listResources.md) | Retrieves the resources (type and IDs) in the specified log group.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified log group.
[stats](stats.md) | Returns stats for the specified log group.
[update](update.md) | Updates the specified log group.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified log group.