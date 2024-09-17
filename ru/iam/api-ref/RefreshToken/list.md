---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/RefreshToken/list.md
---

# Identity and Access Management API, REST: RefreshToken.list
List subjects Refresh Tokens.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/refreshTokens
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
subjectId | <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/RefreshToken/list#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/RefreshToken/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/RefreshToken/list#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/RefreshToken/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 2000.</p> 
filter | <p>A filter expression that filters refresh tokens listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/iam/api-ref/RefreshToken#representation">RefreshToken.clientInstanceInfo</a>, <a href="/docs/iam/api-ref/RefreshToken#representation">RefreshToken.clientId</a> or <a href="/docs/iam/api-ref/RefreshToken#representation">RefreshToken.protectionLevel</a> fields.</li> <li>The operator. An ``=`` operator can be used for all fields. An 'IN' operator can be used for <a href="/docs/iam/api-ref/RefreshToken#representation">RefreshToken.protectionLevel</a>.</li> <li>The value. The value must be in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-zA-Z][_-a-zA-Z0-9]{1,61}[a-z0-9]``. Example of a filter: ``client_instance_info="clientInstanceInfo" AND protection_level IN ("INSECURE_KEY_DPOP", "SECURE_KEY_DPOP")``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "refreshTokens": [
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
refreshTokens[] | **object**<br><p>List of Refresh Tokens</p> 
refreshTokens[].<br>id | **string**<br><p>Refresh Token id.</p> 
refreshTokens[].<br>clientInstanceInfo | **string**<br><p>Information about the app for which the Refresh Token was issued.</p> 
refreshTokens[].<br>clientId | **string**<br><p>The OAuth client identifier for which the Refresh Token was issued.</p> 
refreshTokens[].<br>subjectId | **string**<br><p>The subject identifier for whom the Refresh Token was issued.</p> 
refreshTokens[].<br>createdAt | **string** (date-time)<br><p>Refresh token creation time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
refreshTokens[].<br>expiresAt | **string** (date-time)<br><p>Refresh token expiration time.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
refreshTokens[].<br>lastUsedAt | **string** (date-time)<br><p>Timestamp for the last authentication using this Refresh Token.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
refreshTokens[].<br>protectionLevel | **string**<br><p>Protection level of the refresh token.</p> <p>It shows whether DPOP was used to protect the Refresh Token and and the level of security of the storage used for the DPOP key.</p> <p>Protection level of the refresh token.</p> <ul> <li>NO_PROTECTION: Refresh token without DPOP</li> <li>INSECURE_KEY_DPOP: Refresh token with dpop. The dpop key is not a YubiKey PIV key with required pin/touch policy and attestation.</li> <li>SECURE_KEY_DPOP: Refresh token with dpop. The dpop key is a YubiKey PIV key with required pin/touch policy and attestation.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListRefreshTokensForSubjectRequest.page_size], use the <a href="/docs/iam/api-ref/RefreshToken/list#responses">nextPageToken</a> as the value for the [ListRefreshTokensForSubjectRequest.page_token] query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/RefreshToken/list#responses">nextPageToken</a> to continue paging through the results.</p> 