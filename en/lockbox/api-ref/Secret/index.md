---
editable: false
sourcePath: en/_api-ref/lockbox/api-ref/Secret/index.md
---

# Secret
A set of methods for managing secrets.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "kmsKeyId": "string",
  "status": "string",
  "currentVersion": {
    "id": "string",
    "secretId": "string",
    "createdAt": "string",
    "destroyAt": "string",
    "description": "string",
    "status": "string",
    "payloadEntryKeys": [
      "string"
    ]
  },
  "deletionProtection": true
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the secret.</p> 
folderId | **string**<br><p>ID of the folder that the secret belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the secret.</p> 
description | **string**<br><p>Description of the secret.</p> 
labels | **object**<br><p>Custom labels for the secret as ``key:value`` pairs. Maximum 64 per key.</p> 
kmsKeyId | **string**<br><p>Optional ID of the KMS key will be used to encrypt and decrypt the secret.</p> 
status | **string**<br><p>Status of the secret.</p> <ul> <li> <p>CREATING: The secret is being created.</p> </li> <li> <p>ACTIVE: The secret is active and the secret payload can be accessed.</p> <p>Can be set to INACTIVE using the <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a> method.</p> </li> <li> <p>INACTIVE: The secret is inactive and unusable.</p> <p>Can be set to ACTIVE using the <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a> method.</p> </li> </ul> 
currentVersion | **object**<br><p>Current (i.e. the ``latest``) version of the secret.</p> 
currentVersion.<br>id | **string**<br><p>ID of the version.</p> 
currentVersion.<br>secretId | **string**<br><p>ID of the secret that the version belongs to.</p> 
currentVersion.<br>createdAt | **string** (date-time)<br><p>Time when the version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
currentVersion.<br>destroyAt | **string** (date-time)<br><p>Time when the version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
currentVersion.<br>description | **string**<br><p>Description of the version.</p> 
currentVersion.<br>status | **string**<br><p>Status of the secret.</p> <ul> <li>ACTIVE: The version is active and the secret payload can be accessed.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
currentVersion.<br>payloadEntryKeys[] | **string**<br><p>Keys of the entries contained in the version payload.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the secret.</p> 

## Methods {#methods}
Method | Description
--- | ---
[activate](activate.md) | Activates the specified secret.
[addVersion](addVersion.md) | Adds new version based on a previous one.
[cancelVersionDestruction](cancelVersionDestruction.md) | Cancels previously scheduled version destruction, if the version hasn't been destroyed yet.
[create](create.md) | Creates a secret in the specified folder.
[deactivate](deactivate.md) | Deactivates the specified secret.
[delete](delete.md) | Deletes the specified secret.
[get](get.md) | Returns the specified secret.
[list](list.md) | Retrieves the list of secrets in the specified folder.
[listAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified secret.
[listOperations](listOperations.md) | Lists operations for the specified secret.
[listVersions](listVersions.md) | Retrieves the list of versions of the specified secret.
[scheduleVersionDestruction](scheduleVersionDestruction.md) | Schedules the specified version for destruction.
[setAccessBindings](setAccessBindings.md) | Sets access bindings for the secret.
[update](update.md) | Updates the specified secret.
[updateAccessBindings](updateAccessBindings.md) | Updates access bindings for the secret.