---
editable: false
---

# Lockbox API, REST: Secret.list
Retrieves the list of secrets in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-lockbox }}/lockbox/v1/secrets
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list secrets in.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a [ListSecretsRequest.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the [ListSecretsRequest.next_page_token] returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "secrets": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "kmsKeyId": "string",
      "status": "string",
      "currentVersion": {
        "id": "string",
        "secretId": "string",
        "createdAt": "string",
        "destroyAt": "string",
        "description": "string",
        "status": "string",
        "payloadEntryKeys": [
          "string"
        ]
      },
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
secrets[] | **object**<br><p>List of secrets in the specified folder.</p> 
secrets[].<br>id | **string**<br><p>ID of the secret.</p> 
secrets[].<br>folderId | **string**<br><p>ID of the folder that the secret belongs to.</p> 
secrets[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
secrets[].<br>name | **string**<br><p>Name of the secret.</p> 
secrets[].<br>description | **string**<br><p>Description of the secret.</p> 
secrets[].<br>labels | **object**<br><p>Custom labels for the secret as ``key:value`` pairs. Maximum 64 per key.</p> 
secrets[].<br>kmsKeyId | **string**<br><p>Optional ID of the KMS key will be used to encrypt and decrypt the secret.</p> 
secrets[].<br>status | **string**<br><p>Status of the secret.</p> <ul> <li> <p>CREATING: The secret is being created.</p> </li> <li> <p>ACTIVE: The secret is active and the secret payload can be accessed.</p> <p>Can be set to INACTIVE using the <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a> method.</p> </li> <li> <p>INACTIVE: The secret is inactive and unusable.</p> <p>Can be set to ACTIVE using the <a href="/docs/lockbox/api-ref/Secret/deactivate">deactivate</a> method.</p> </li> </ul> 
secrets[].<br>currentVersion | **object**<br><p>Current (i.e. the ``latest``) version of the secret.</p> 
secrets[].<br>currentVersion.<br>id | **string**<br><p>ID of the version.</p> 
secrets[].<br>currentVersion.<br>secretId | **string**<br><p>ID of the secret that the version belongs to.</p> 
secrets[].<br>currentVersion.<br>createdAt | **string** (date-time)<br><p>Time when the version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
secrets[].<br>currentVersion.<br>destroyAt | **string** (date-time)<br><p>Time when the version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
secrets[].<br>currentVersion.<br>description | **string**<br><p>Description of the version.</p> 
secrets[].<br>currentVersion.<br>status | **string**<br><p>Status of the secret.</p> <ul> <li>ACTIVE: The version is active and the secret payload can be accessed.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
secrets[].<br>currentVersion.<br>payloadEntryKeys[] | **string**<br><p>Keys of the entries contained in the version payload.</p> 
secrets[].<br>deletionProtection | **boolean** (boolean)<br><p>Flag that inhibits deletion of the secret.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/lockbox/api-ref/Secret/list#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/lockbox/api-ref/Secret/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 