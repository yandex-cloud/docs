---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# Method get
Returns the payload of the specified secret.
 
To get the list of all available secrets, make a [list](/docs/lockbox/api-ref/Secret/list) request.
 
## HTTP request {#https-request}
```
GET https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/{secretId}/payload
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
secretId | Required. ID of the secret.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
versionId | Optional ID of the version.  The maximum string length in characters is 50.
 
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
A payload.
 
Field | Description
--- | ---
versionId | **string**<br><p>ID of the version that the payload belongs to.</p> 
entries[] | **object**<br><p>Payload entries.</p> 
entries[].<br>key | **string**<br><p>Non-confidential key of the entry.</p> 
entries[].<br>textValue | **string** <br>`entries[]` includes only one of the fields `textValue`, `binaryValue`<br><br><p>Text value.</p> 
entries[].<br>binaryValue | **string** (byte) <br>`entries[]` includes only one of the fields `textValue`, `binaryValue`<br><br><p>Binary value.</p> 