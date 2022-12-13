---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/LifecyclePolicy/index.md
---

# Container Registry API, REST: LifecyclePolicy methods
A set of methods for managing Lifecycle policy resources.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "name": "string",
  "repositoryId": "string",
  "description": "string",
  "status": "string",
  "createdAt": "string",
  "rules": [
    {
      "description": "string",
      "expirePeriod": "string",
      "tagRegexp": "string",
      "untagged": true,
      "retainedTop": "string"
    }
  ]
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the lifecycle policy.</p> 
name | **string**<br><p>Name of the lifecycle policy.</p> 
repositoryId | **string**<br><p>ID of the repository that the lifecycle policy belongs to. Required. The maximum string length in characters is 50.</p> 
description | **string**<br><p>Description of the lifecycle policy. The maximum string length in characters is 256.</p> 
status | **string**<br><p>Status of lifecycle policy.</p> <ul> <li>ACTIVE: Policy is active and regularly deletes Docker images according to the established rules.</li> <li>DISABLED: Policy is disabled and does not delete Docker images in the repository. Policies in this status can be used for preparing and testing rules.</li> </ul> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
rules[] | **object**<br><p>The rules of lifecycle policy.</p> 
rules[].<br>description | **string**<br><p>Description of the lifecycle policy rule.</p> <p>The maximum string length in characters is 256.</p> 
rules[].<br>expirePeriod | **string**<br><p>Period of time for automatic deletion. Period must be a multiple of 24 hours.</p> <p>The minimum value is 86400 seconds.</p> 
rules[].<br>tagRegexp | **string**<br><p>Tag for specifying a filter in the form of a regular expression.</p> <p>The maximum string length in characters is 256.</p> 
rules[].<br>untagged | **boolean** (boolean)<br><p>Tag for applying the rule to Docker images without tags.</p> 
rules[].<br>retainedTop | **string** (int64)<br><p>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.</p> <p>The minimum value is 0.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a lifecycle policy in the specified repository.
[delete](delete.md) | Deletes the specified lifecycle policy.
[dryRun](dryRun.md) | Creates a request of a dry run of the lifecycle policy.
[get](get.md) | Returns the specified lifecycle policy.
[getDryRunResult](getDryRunResult.md) | Returns the dry run result of the specified lifecycle policy.
[list](list.md) | Retrieves the list of lifecycle policies in the specified repository.
[listDryRunResultAffectedImages](listDryRunResultAffectedImages.md) | Retrieves the list of the affected images.
[listDryRunResults](listDryRunResults.md) | Retrieves the list of the dry run results.
[update](update.md) | Updates the specified lifecycle policy.