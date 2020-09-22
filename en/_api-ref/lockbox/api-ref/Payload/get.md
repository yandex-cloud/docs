---
editable: false
---

# Method get
Returns payload of the given secret
 

 
## HTTP request {#https-request}
```
GET https://lockbox.api.cloud.yandex.net/lockbox/v1/secrets/{secretId}/payload
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
secretId | Required. ID of the secret.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | Optional ID of the version. Defaults to the current version if not specified  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versionId": "string",
  "entries": [
    {
      "key": "string",

      // `entries[]` includes only one of the fields `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "string",
      // end of the list of possible fields`entries[]`

    }
  ]
}
```

 
Field | Description
--- | ---
versionId | **string**<br><p>ID of the version that the payload belongs to.</p> 
entries[] | **object**<br><p>Payload entries.</p> 
entries[].<br>key | **string**<br><p>Non-confidential key of the entry.</p> 
entries[].<br>textValue | **string** <br>`entries[]` includes only one of the fields `textValue`, `binaryValue`<br><br><p>Text value.</p> 
entries[].<br>binaryValue | **string** (byte) <br>`entries[]` includes only one of the fields `textValue`, `binaryValue`<br><br><p>Binary value.</p> 