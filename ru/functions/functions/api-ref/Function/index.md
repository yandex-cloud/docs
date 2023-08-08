---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/index.md
---

# Cloud Functions Service, REST: Function methods
A set of methods for managing serverless functions.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "logGroupId": "string",
  "httpInvokeUrl": "string",
  "status": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the function. Generated at creation time.</p> 
folderId | **string**<br><p>ID of the folder that the function belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the function.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the function. The name is unique within the folder.</p> <p>The string length in characters must be 3-63.</p> 
description | **string**<br><p>Description of the function.</p> <p>The string length in characters must be 0-256.</p> 
labels | **object**<br><p>Function labels as ``key:value`` pairs.</p> <p>No more than 64 per resource.</p> 
logGroupId | **string**<br><p>ID of the log group for the function.</p> 
httpInvokeUrl | **string**<br><p>URL that needs to be requested to invoke the function.</p> 
status | **string**<br><p>Status of the function.</p> <ul> <li>CREATING: Function is being created.</li> <li>ACTIVE: Function is ready to be invoked.</li> <li>DELETING: Function is being deleted.</li> <li>ERROR: Function failed.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a function in the specified folder.
[createVersion](createVersion.md) | Creates a version for the specified function.
[delete](delete.md) | Deletes the specified function.
[deleteVersion](deleteVersion.md) | Deletes the specified version of a function.
[get](get.md) | Returns the specified function.
[getVersion](getVersion.md) | Returns the specified version of a function.
[getVersionByTag](getVersionByTag.md) | Returns all versions with the specified tag.
[list](list.md) | Retrieves the list of functions in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified function.
[listOperations](listOperations.md) | Lists operations for the specified function.
[listRuntimes](listRuntimes.md) | Lists available runtime environments for the specified function.
[listScalingPolicies](listScalingPolicies.md) | Lists existing scaling policies for specified function
[listTagHistory](listTagHistory.md) | Returns the log of tags assigned to versions of the specified function.
[listVersions](listVersions.md) | Retrieves the list of versions for the specified function, or of all function versions in the specified folder.
[removeScalingPolicy](removeScalingPolicy.md) | Remove scaling policy for specified function and tag
[removeTag](removeTag.md) | Remove a tag from the specified version of a function.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the function.
[setScalingPolicy](setScalingPolicy.md) | Set scaling policy for specified function and tag
[setTag](setTag.md) | Set a tag for the specified version of a function.
[update](update.md) | Updates the specified function.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified function.