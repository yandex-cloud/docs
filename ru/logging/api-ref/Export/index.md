---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Export/index.md
---

# Cloud Logging Service, REST: Export methods
A set of methods for managing log exports.
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
  "groupId": "string",
  "sinkId": "string",
  "params": {
    "resourceTypes": [
      "string"
    ],
    "resourceIds": [
      "string"
    ],
    "streamNames": [
      "string"
    ],
    "levels": [
      "string"
    ],
    "filter": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Export ID.</p> 
folderId | **string**<br><p>Export folder ID.</p> 
cloudId | **string**<br><p>Export cloud ID.</p> 
createdAt | **string** (date-time)<br><p>Export creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Export name.</p> 
description | **string**<br><p>Export description.</p> 
labels | **object**<br><p>Export lables.</p> 
groupId | **string**<br><p>Group logs are exported from.</p> 
sinkId | **string**<br><p>Sink logs are exported to.</p> 
params | **object**<br><p>Parameters of logs filtration.</p> 
params.<br>resourceTypes[] | **string**<br><p>The maximum number of elements is 100. The maximum string length in characters for each value is 63.</p> 
params.<br>resourceIds[] | **string**<br><p>The maximum number of elements is 100. The maximum string length in characters for each value is 63.</p> 
params.<br>streamNames[] | **string**<br><p>The maximum number of elements is 100. The maximum string length in characters for each value is 63.</p> 
params.<br>levels[] | **string**<br><p>The maximum number of elements is 10.</p> <ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
params.<br>filter | **string**<br><p>The maximum string length in characters is 1000.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a export in the specified folder.
[delete](delete.md) | Deletes the specified export.
[get](get.md) | Returns the specified export.
[list](list.md) | Retrieves the list of exports in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified export.
[listOperations](listOperations.md) | Lists operations for the specified export.
[run](run.md) | Run new logs export from log group to sink
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the specified export.
[update](update.md) | Updates the specified export.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified export.