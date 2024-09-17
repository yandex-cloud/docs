---
editable: false
sourcePath: en/_api-ref/lockbox/v1/api-ref/Secret/index.md
---

# Lockbox API, REST: Secret methods
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
    ],
    "passwordPayloadSpecification": {
      "passwordKey": "string",
      "length": "string",
      "includeUppercase": true,
      "includeLowercase": true,
      "includeDigits": true,
      "includePunctuation": true,
      "includedPunctuation": "string",
      "excludedPunctuation": "string"
    }
  },
  "deletionProtection": true,
  "passwordPayloadSpecification": {
    "passwordKey": "string",
    "length": "string",
    "includeUppercase": true,
    "includeLowercase": true,
    "includeDigits": true,
    "includePunctuation": true,
    "includedPunctuation": "string",
    "excludedPunctuation": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the secret.</p> 
folderId | **string**<br><p>ID of the folder that the secret belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the secret.</p> 
description | **string**<br><p>Description of the secret.</p> 
labels | **object**<br><p>Custom labels for the secret as ``key:value`` pairs. Maximum 64 per key.</p> 
kmsKeyId | **string**<br><p>Optional ID of the KMS key will be used to encrypt and decrypt the secret.</p> 
status | **string**<br>Status of the secret.<br><ul> <li> <p>CREATING: The secret is being created.</p> </li> <li> <p>ACTIVE: The secret is active and the secret payload can be accessed.</p> <p>Can be set to INACTIVE using the <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a> method.</p> </li> <li> <p>INACTIVE: The secret is inactive and unusable.</p> <p>Can be set to ACTIVE using the <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a> method.</p> </li> </ul> 
currentVersion | **object**
currentVersion.<br>id | **string**<br><p>ID of the version.</p> 
currentVersion.<br>secretId | **string**<br><p>ID of the secret that the version belongs to.</p> 
currentVersion.<br>createdAt | **string** (date-time)<br><p>Time when the version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
currentVersion.<br>destroyAt | **string** (date-time)<br><p>Time when the version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
currentVersion.<br>description | **string**<br><p>Description of the version.</p> 
currentVersion.<br>status | **string**<br>Status of the secret.<br><ul> <li>ACTIVE: The version is active and the secret payload can be accessed.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
currentVersion.<br>payloadEntryKeys[] | **string**<br><p>Keys of the entries contained in the version payload.</p> 
currentVersion.<br>passwordPayloadSpecification | **object**
currentVersion.<br>passwordPayloadSpecification.<br>passwordKey | **string**<br><p>Required. key of the entry to store generated password value</p> <p>The maximum string length in characters is 256. Value must match the regular expression ``[-_./\\@0-9a-zA-Z]+``.</p> 
currentVersion.<br>passwordPayloadSpecification.<br>length | **string** (int64)<br><p>password length; by default, a reasonable length will be decided</p> <p>The maximum value is 256.</p> 
currentVersion.<br>passwordPayloadSpecification.<br>includeUppercase | **boolean** (boolean)<br><p>whether at least one A..Z character is included in the password, true by default</p> 
currentVersion.<br>passwordPayloadSpecification.<br>includeLowercase | **boolean** (boolean)<br><p>whether at least one a..z character is included in the password, true by default</p> 
currentVersion.<br>passwordPayloadSpecification.<br>includeDigits | **boolean** (boolean)<br><p>whether at least one 0..9 character is included in the password, true by default</p> 
currentVersion.<br>passwordPayloadSpecification.<br>includePunctuation | **boolean** (boolean)<br><p>whether at least one punctuation character is included in the password, true by default punctuation characters by default (there are 32): !"#$%&amp;'()*+,-./:;&lt;=&gt;?@[]^_`{\|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below</p> 
currentVersion.<br>passwordPayloadSpecification.<br>includedPunctuation | **string**<br><p>If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use (at most, all the 32)</p> <p>The maximum string length in characters is 32.</p> 
currentVersion.<br>passwordPayloadSpecification.<br>excludedPunctuation | **string**<br><p>a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32)</p> <p>The maximum string length in characters is 31.</p> 
deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the secret.</p> 
passwordPayloadSpecification | **object**
passwordPayloadSpecification.<br>passwordKey | **string**<br><p>Required. key of the entry to store generated password value</p> <p>The maximum string length in characters is 256. Value must match the regular expression ``[-_./\\@0-9a-zA-Z]+``.</p> 
passwordPayloadSpecification.<br>length | **string** (int64)<br><p>password length; by default, a reasonable length will be decided</p> <p>The maximum value is 256.</p> 
passwordPayloadSpecification.<br>includeUppercase | **boolean** (boolean)<br><p>whether at least one A..Z character is included in the password, true by default</p> 
passwordPayloadSpecification.<br>includeLowercase | **boolean** (boolean)<br><p>whether at least one a..z character is included in the password, true by default</p> 
passwordPayloadSpecification.<br>includeDigits | **boolean** (boolean)<br><p>whether at least one 0..9 character is included in the password, true by default</p> 
passwordPayloadSpecification.<br>includePunctuation | **boolean** (boolean)<br><p>whether at least one punctuation character is included in the password, true by default punctuation characters by default (there are 32): !"#$%&amp;'()*+,-./:;&lt;=&gt;?@[]^_`{\|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below</p> 
passwordPayloadSpecification.<br>includedPunctuation | **string**<br><p>If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use (at most, all the 32)</p> <p>The maximum string length in characters is 32.</p> 
passwordPayloadSpecification.<br>excludedPunctuation | **string**<br><p>a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32)</p> <p>The maximum string length in characters is 31.</p> 

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