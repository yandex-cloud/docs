---
editable: false
---

# Method setAccessBindings
Sets access bindings for the specified API gateway.
 

 
## HTTP request {#https-request}
```
POST https://serverless-apigateway.{{ api-host }}/apigateways/v1/apigateways/{resourceId}:setAccessBindings
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourceId | <p>Required. ID of the resource for which access bindings are being set.</p> <p>To get the resource ID, use a corresponding List request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "accessBindings": [
    {
      "roleId": "string",
      "subject": {
        "id": "string",
        "type": "string"
      }
    }
  ]
}
```

 
Field | Description
--- | ---
accessBindings[] | **object**<br><p>Access bindings to be set. For more information, see <a href="/docs/iam/concepts/access-control/#access-bindings">Access Bindings</a>.</p> <p>The maximum number of elements is 1000.</p> 
accessBindings[].<br>roleId | **string**<br><p>Required. ID of the <a href="/docs/iam/api-ref/Role#representation">Role</a> that is assigned to the ``subject``.</p> <p>The maximum string length in characters is 50.</p> 
accessBindings[].<br>subject | **object**<br><p>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier.</p> 
accessBindings[].<br>subject.<br>id | **string**<br><p>Required. ID of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li>``allAuthenticatedUsers``: A special system identifier that represents anyone who is authenticated. It can be used only if the ``type`` is ``system``.</li> <li>``allUsers``: A special system identifier that represents anyone. No authentication is required. For example, you don't need to specify the IAM token in an API query.</li> <li>``&lt;cloud generated id&gt;``: An identifier that represents a user account. It can be used only if the ``type`` is ``userAccount``, ``federatedUser`` or ``serviceAccount``.</li> </ul> <p>The maximum string length in characters is 50.</p> 
accessBindings[].<br>subject.<br>type | **string**<br><p>Required. Type of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li>``userAccount``: An account on Yandex or Yandex Connect, added to Yandex Cloud.</li> <li>``serviceAccount``: A service account. This type represents the <a href="/docs/iam/api-ref/ServiceAccount#representation">ServiceAccount</a> resource.</li> <li>``federatedUser``: A federated account. This type represents a user from an identity federation, like Active Directory.</li> <li>``system``: System group. This type represents several accounts with a common system identifier.</li> </ul> <p>For more information, see <a href="/docs/iam/concepts/access-control/#subject">Subject to which the role is assigned</a>.</p> <p>The maximum string length in characters is 100.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 