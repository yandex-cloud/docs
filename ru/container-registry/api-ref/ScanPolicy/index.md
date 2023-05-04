---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/ScanPolicy/index.md
---

# Container Registry API, REST: ScanPolicy methods
A set of methods for managing scan policy resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "registryId": "string",
  "name": "string",
  "description": "string",
  "rules": {
    "pushRule": {
      "repositoryPrefixes": [
        "string"
      ],
      "disabled": true
    },
    "scheduleRules": [
      {
        "repositoryPrefixes": [
          "string"
        ],
        "rescanPeriod": "string",
        "disabled": true
      }
    ]
  },
  "createdAt": "string",
  "disabled": true
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the scan policy.</p> 
registryId | **string**<br><p>ID of the registry that the scan policy belongs to. Required. The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the scan policy.</p> 
description | **string**<br><p>Description of the scan policy. The maximum string length in characters is 256.</p> 
rules | **object**<br><p>The rules of scan policy.</p> 
rules.<br>pushRule | **object**<br><p>Description of on-push scan rule.</p> 
rules.<br>pushRule.<br>repositoryPrefixes[] | **string**<br><p>Required. List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry</p> <p>Must contain at least one element. Each value must match the regular expression ``\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))*``.</p> 
rules.<br>pushRule.<br>disabled | **boolean** (boolean)<br><p>Turns off scan rule.</p> 
rules.<br>scheduleRules[] | **object**<br><p>Description of time based rescan rule.</p> 
rules.<br>scheduleRules[].<br>repositoryPrefixes[] | **string**<br><p>Required. List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry</p> <p>Must contain at least one element. Each value must match the regular expression ``\*\|[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))*``.</p> 
rules.<br>scheduleRules[].<br>rescanPeriod | **string**<br><p>Required. Period of time since last scan to trigger automatic rescan.</p> 
rules.<br>scheduleRules[].<br>disabled | **boolean** (boolean)<br><p>Turns off scan rule.</p> 
createdAt | **string** (date-time)<br><p>Output only. Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
disabled | **boolean** (boolean)<br><p>Turns off scan policy.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a scan policy for the specified registry.
[delete](delete.md) | Deletes the specified scan policy.
[get](get.md) | Returns the specified scan policy.
[getByRegistry](getByRegistry.md) | Returns scan policy for the registry if any exists.
[update](update.md) | Updates the specified scan policy.