---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/RefreshToken/index.md
---

# Identity and Access Management API, REST: RefreshToken methods
A set of methods for managing Refresh Tokens.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "clientInstanceInfo": "string",
  "clientId": "string",
  "subjectId": "string",
  "createdAt": "string",
  "expiresAt": "string",
  "lastUsedAt": "string",
  "protectionLevel": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>Refresh Token id.</p> 
clientInstanceInfo | **string**<br><p>Information about the app for which the Refresh Token was issued.</p> 
clientId | **string**<br><p>The OAuth client identifier for which the Refresh Token was issued.</p> 
subjectId | **string**<br><p>The subject identifier for whom the Refresh Token was issued.</p> 
createdAt | **string** (date-time)<br><p>Refresh token creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
expiresAt | **string** (date-time)<br><p>Refresh token expiration time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
lastUsedAt | **string** (date-time)<br><p>Timestamp for the last authentication using this Refresh Token.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
protectionLevel | **string**<br><p>Protection level of the refresh token.</p> <p>It shows whether DPOP was used to protect the Refresh Token and and the level of security of the storage used for the DPOP key.</p> <p>Protection level of the refresh token.</p> <ul> <li>NO_PROTECTION: Refresh token without DPOP</li> <li>INSECURE_KEY_DPOP: Refresh token with dpop. The dpop key is not a YubiKey PIV key with required pin/touch policy and attestation.</li> <li>SECURE_KEY_DPOP: Refresh token with dpop. The dpop key is a YubiKey PIV key with required pin/touch policy and attestation.</li> </ul> 

## Methods {#methods}
Method | Description
--- | ---
[list](list.md) | List subjects Refresh Tokens.
[revoke](revoke.md) | Revoke Refresh Tokens. Several Refresh Tokens can be revoked by one request.