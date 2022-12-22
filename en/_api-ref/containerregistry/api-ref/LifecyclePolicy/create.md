---
editable: false
---

# Container Registry API, REST: LifecyclePolicy.create
Creates a lifecycle policy in the specified repository.
 

 
## HTTP request {#https-request}
```
POST https://container-registry.{{ api-host }}/container-registry/v1/lifecyclePolicies
```
 
## Body parameters {#body_params}
 
```json 
{
  "repositoryId": "string",
  "name": "string",
  "description": "string",
  "status": "string",
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
repositoryId | **string**<br><p>Required. ID of the lifecycle policy repository.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of lifecycle policy.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of lifecycle policy.</p> <p>The maximum string length in characters is 256.</p> 
status | **string**<br><p>Required. Status of the lifecycle policy.</p> <ul> <li>ACTIVE: Policy is active and regularly deletes Docker images according to the established rules.</li> <li>DISABLED: Policy is disabled and does not delete Docker images in the repository. Policies in this status can be used for preparing and testing rules.</li> </ul> 
rules[] | **object**<br><p>The rules of the lifecycle policy.</p> 
rules[].<br>description | **string**<br><p>Description of the lifecycle policy rule.</p> <p>The maximum string length in characters is 256.</p> 
rules[].<br>expirePeriod | **string**<br><p>Period of time for automatic deletion. Period must be a multiple of 24 hours.</p> <p>The minimum value is 86400 seconds.</p> 
rules[].<br>tagRegexp | **string**<br><p>Tag for specifying a filter in the form of a regular expression.</p> <p>The maximum string length in characters is 256.</p> 
rules[].<br>untagged | **boolean** (boolean)<br><p>Tag for applying the rule to Docker images without tags.</p> 
rules[].<br>retainedTop | **string** (int64)<br><p>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.</p> <p>The minimum value is 0.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 