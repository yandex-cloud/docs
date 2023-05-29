---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/LifecyclePolicy/getDryRunResult.md
---

# Container Registry API, REST: LifecyclePolicy.getDryRunResult
Returns the dry run result of the specified lifecycle policy.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults/{dryRunLifecyclePolicyResultId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
dryRunLifecyclePolicyResultId | <p>Required. ID of the dry run result of the lifecycle policy.</p> <p>The maximum string length in characters is 50.</p> 
 
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
runAt | **string** (date-time)<br><p>Time of the getting result.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
affectedImagesCount | **string** (int64)<br><p>Count of affected images.</p> 