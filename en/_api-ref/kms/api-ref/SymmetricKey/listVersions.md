---
editable: false
---

# Method listVersions
Retrieves the list of versions that belongs to given key
 

 
## HTTP request {#https-request}
```
GET https://kms.api.cloud.yandex.net/kms/v1/keys/{keyId}/versions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
keyId | Required. The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum value is 1000.
pageToken | The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "keyVersions": [
    {
      "id": "string",
      "keyId": "string",
      "status": "string",
      "algorithm": "string",
      "createdAt": "string",
      "primary": true,
      "destroyAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
keyVersions[] | **object**<br><p>Symmetric Key Version resource Key version is the object that is linked to crypto-material used for real encryption/decryption</p> 
keyVersions[].<br>id | **string**<br>
keyVersions[].<br>keyId | **string**<br>
keyVersions[].<br>status | **string**<br><p>possible version statuses</p> 
keyVersions[].<br>algorithm | **string**<br><p>Supported symmetric encryption algorithms</p> 
keyVersions[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
keyVersions[].<br>primary | **boolean** (boolean)<br>
keyVersions[].<br>destroyAt | **string** (date-time)<br><p>time when this version will be destroyed, status should be SCHEDULED_FOR_DESTRUCTION</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nextPageToken | **string**<br>