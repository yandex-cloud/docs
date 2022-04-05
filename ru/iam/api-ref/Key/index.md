---
editable: false
sourcePath: en/_api-ref/iam/api-ref/Key/index.md
---

# Key
A set of methods for managing Key resources.
## JSON Representation {#representation}
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
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Key resource.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
description | **string**<br><p>Description of the Key resource. 0-256 characters long.</p> 
keyAlgorithm | **string**<br>An algorithm used to generate a key pair of the Key resource.<br><ul> <li>RSA_2048: RSA with a 2048-bit key size. Default value.</li> <li>RSA_4096: RSA with a 4096-bit key size.</li> </ul> 
publicKey | **string**<br><p>A public key of the Key resource.</p> 
userAccountId | **string** <br> includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the user account that the Key resource belongs to.</p> 
serviceAccountId | **string** <br> includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the service account that the Key resource belongs to.</p> 

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a key pair for the specified service account.
[delete](delete.md) | Deletes the specified key pair.
[get](get.md) | Returns the specified Key resource.
[list](list.md) | Retrieves the list of Key resources for the specified service account.
[listOperations](listOperations.md) | Lists operations for the specified key.
[update](update.md) | Updates the specified key pair.