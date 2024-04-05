---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/Key/create.md
---

# Identity and Access Management API, REST: Key.create
Creates a key pair for the specified service account.
 

 
## HTTP request {#https-request}
```
POST https://iam.{{ api-host }}/iam/v1/keys
```
 
## Body parameters {#body_params}
 
```json 
{
  "serviceAccountId": "string",
  "description": "string",
  "format": "string",
  "keyAlgorithm": "string"
}
```

 
Field | Description
--- | ---
serviceAccountId | **string**<br><p>ID of the service account to create a key pair for. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request. If not specified, it defaults to the subject that made the request.</p> <p>The maximum string length in characters is 50.</p> 
description | **string**<br><p>Description of the key pair.</p> <p>The maximum string length in characters is 256.</p> 
format | **string**<br><p>Output format of the key.</p> <ul> <li>PEM_FILE: Privacy-Enhanced Mail (PEM) format. Default value.</li> </ul> 
keyAlgorithm | **string**<br><p>An algorithm used to generate a key pair of the Key resource.</p> <ul> <li>RSA_2048: RSA with a 2048-bit key size. Default value.</li> <li>RSA_4096: RSA with a 4096-bit key size.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "key": {
    "id": "string",
    "createdAt": "string",
    "description": "string",
    "keyAlgorithm": "string",
    "publicKey": "string",
    "lastUsedAt": "string",

    // `key` includes only one of the fields `userAccountId`, `serviceAccountId`
    "userAccountId": "string",
    "serviceAccountId": "string",
    // end of the list of possible fields`key`

  },
  "privateKey": "string"
}
```

 
Field | Description
--- | ---
key | **object**<br><p>Key resource.</p> <p>A Key resource. For more information, see <a href="/docs/iam/concepts/authorization/key">Authorized keys</a>.</p> 
key.<br>id | **string**<br><p>ID of the Key resource.</p> 
key.<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
key.<br>description | **string**<br><p>Description of the Key resource. 0-256 characters long.</p> 
key.<br>keyAlgorithm | **string**<br>An algorithm used to generate a key pair of the Key resource.<br><ul> <li>RSA_2048: RSA with a 2048-bit key size. Default value.</li> <li>RSA_4096: RSA with a 4096-bit key size.</li> </ul> 
key.<br>publicKey | **string**<br><p>A public key of the Key resource.</p> 
key.<br>lastUsedAt | **string** (date-time)<br><p>Timestamp for the last use of this key.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
key.<br>userAccountId | **string** <br>`key` includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the user account that the Key resource belongs to.</p> 
key.<br>serviceAccountId | **string** <br>`key` includes only one of the fields `userAccountId`, `serviceAccountId`<br><br><p>ID of the service account that the Key resource belongs to.</p> 
privateKey | **string**<br><p>A private key of the Key resource. This key must be stored securely.</p> 