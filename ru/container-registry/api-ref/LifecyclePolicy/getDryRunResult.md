---
editable: false
---

# Method getDryRunResult
Returns the dry run result of the specified lifecycle policy.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/dryRunLifecyclePolicyResults/{dryRunLifecyclePolicyResultId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dryRunLifecyclePolicyResultId | Required. ID of the dry run result of the lifecycle policy.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "dryRunLifecyclePolicyResultId": "string",
  "lifecyclePolicyId": "string",
  "runAt": "string",
  "affectedImagesCount": "string"
}
```

 
Field | Description
--- | ---
dryRunLifecyclePolicyResultId | **string**<br><p>ID of the dry run result of the lifecycle policy.</p> 
lifecyclePolicyId | **string**<br><p>ID of the lifecycle policy.</p> 
runAt | **string** (date-time)<br><p>Time of the getting result.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
affectedImagesCount | **string** (int64)<br><p>Count of affected images.</p> 