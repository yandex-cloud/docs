---
editable: false
---

# Method listLanguages
Retrieves the list of supported languages.
 

 
## HTTP request {#https-request}
```
POST https://translate.api.cloud.yandex.net/translate/v2/languages
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>ID of the folder to which you have access. Required for authorization with a user account (see <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make the request on behalf of a service account.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "languages": [
    {
      "code": "string",
      "name": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
languages[] | **object**<br><p>List of supported languages.</p> 
languages[].<br>code | **string**<br><p>The language code. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, `` en ``).</p> 
languages[].<br>name | **string**<br><p>The name of the language (for example, `` English ``).</p> 