---
editable: false
---

# Identity and Access Management API, REST: Key methods
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
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