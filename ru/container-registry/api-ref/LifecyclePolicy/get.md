---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/LifecyclePolicy/get.md
---

# Method get
Returns the specified lifecycle policy.
 
To get the list of all available lifecycle policies, make a [list](/docs/container-registry/api-ref/LifecyclePolicy/list) request.
 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/lifecyclePolicies/{lifecyclePolicyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
lifecyclePolicyId | <p>Required. ID of the lifecycle policy.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
rules[] | **object**<br><p>The rules of lifecycle policy.</p> 
rules[].<br>description | **string**<br><p>Description of the lifecycle policy rule.</p> <p>The maximum string length in characters is 256.</p> 
rules[].<br>expirePeriod | **string**<br><p>Period of time for automatic deletion. Period must be a multiple of 24 hours.</p> <p>The minimum value is 86400 seconds.</p> 
rules[].<br>tagRegexp | **string**<br><p>Tag for specifying a filter in the form of a regular expression.</p> <p>The maximum string length in characters is 256.</p> 
rules[].<br>untagged | **boolean** (boolean)<br><p>Tag for applying the rule to Docker images without tags.</p> 
rules[].<br>retainedTop | **string** (int64)<br><p>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.</p> <p>The minimum value is 0.</p> 