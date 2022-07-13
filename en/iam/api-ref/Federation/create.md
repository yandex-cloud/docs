---
editable: false
sourcePath: en/_api-ref/iam/api-ref/Federation/create.md
---

# Method create
Creates a federation in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://iam.{{ api-host }}/iam/v1/saml/federations
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "cookieMaxAge": "string",
  "autoCreateAccountOnLogin": true,
  "issuer": "string",
  "ssoBinding": "string",
  "ssoUrl": "string",
  "securitySettings": {
    "encryptedAssertions": true
  },
  "caseInsensitiveNameIds": true
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>ID of the folder to create a federation in. To get the folder ID, make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the federation. The name must be unique within the cloud.</p> <p>Value must match the regular expression ``[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the federation.</p> <p>The maximum string length in characters is 256.</p> 
cookieMaxAge | **string**<br><p>Browser cookie lifetime in seconds. If the cookie is still valid, the management console authenticates the user immediately and redirects them to the home page. The default value is ``8h``.</p> <p>Acceptable values are 600 seconds to 43200 seconds, inclusive.</p> 
autoCreateAccountOnLogin | **boolean** (boolean)<br><p>Add new users automatically on successful authentication. The user will get the ``resource-manager.clouds.member`` role automatically, but you need to grant other roles to them.</p> <p>If the value is ``false``, users who aren't added to the cloud can't log in, even if they have authenticated on your server.</p> 
issuer | **string**<br><p>Required. ID of the IdP server to be used for authentication. The IdP server also responds to IAM with this ID after the user authenticates.</p> <p>The maximum string length in characters is 8000.</p> 
ssoBinding | **string**<br><p>Single sign-on endpoint binding type. Most Identity Providers support the ``POST`` binding type.</p> <p>SAML Binding is a mapping of a SAML protocol message onto standard messaging formats and/or communications protocols.</p> <ul> <li>POST: HTTP POST binding.</li> <li>REDIRECT: HTTP redirect binding.</li> <li>ARTIFACT: HTTP artifact binding.</li> </ul> 
ssoUrl | **string**<br><p>Required. Single sign-on endpoint URL. Specify the link to the IdP login page here.</p> <p>The maximum string length in characters is 8000.</p> 
securitySettings | **object**<br><p>Federation security settings.</p> <p>Federation security settings.</p> 
securitySettings.<br>encryptedAssertions | **boolean** (boolean)<br><p>Enable encrypted assertions.</p> 
caseInsensitiveNameIds | **boolean** (boolean)<br><p>Use case insensitive Name IDs.</p> 
 
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