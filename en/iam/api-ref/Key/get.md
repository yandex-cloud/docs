---
editable: false
sourcePath: en/_api-ref/iam/api-ref/Key/get.md
---


# Method get
Returns the specified Key resource.
 
To get the list of available Key resources, make a [list](/docs/iam/api-ref/Key/list) request.
 
## HTTP request {#https-request}
```
GET https://iam.api.cloud.yandex.net/iam/v1/keys/{keyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. ID of the Key resource to return. To get the ID use a [list](/docs/iam/api-ref/Key/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
format | Output format of the key.<ul> <li>PEM_FILE: Privacy-Enhanced Mail (PEM) format. Default value.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "createdAt": "string",
  "description": "string",
  "keyAlgorithm": "string",
  "publicKey": "string",

  //  includes only one of the fields `userAccountId`, `serviceAccountId`
  "userAccountId": "string",
  "serviceAccountId": "string",
  // end of the list of possible fields

}
```
A Key resource. For more information, see [Authorized keys](/docs/iam/concepts/authorization/key).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Key resource.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
description | **string**<br><p>Description of the Key resource. 0-256 characters long.</p> 
keyAlgorithm | **string**<br>An algorithm used to generate a key pair of the Key resource.<br><ul> <li>RSA_2048: RSA with a 2048-bit key size. Default value.</li> <li>RSA_4096: RSA with a 4096-bit key size.</li> </ul> 
publicKey | **string**<br><p>A public key of the Key resource.</p> 
userAccountId | **string** <br> includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the user account that the Key resource belongs to.</p> 
serviceAccountId | **string** <br> includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the service account that the Key resource belongs to.</p> 