---
editable: false
sourcePath: en/_api-ref/ai/translate/api-ref/Translation/detectLanguage.md
---

# Translate API v2, REST: Translation.detectLanguage
Detects the language of the text.
 

 
## HTTP request {#https-request}
```
POST https://translate.{{ api-host }}/translate/v2/detect
```
 
## Body parameters {#body_params}
 
```json 
{
  "text": "string",
  "languageCodeHints": [
    "string"
  ],
  "folderId": "string"
}
```

 
Field | Description
--- | ---
text | **string**<br><p>Required. The text to detect the language for.</p> <p>The maximum string length in characters is 1000.</p> 
languageCodeHints[] | **string**<br><p>List of the most likely languages. These languages will be given preference when detecting the text language. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, ``ru``).</p> <p>To get the list of supported languages, use a <a href="/docs/translate/api-ref/Translation/listLanguages">listLanguages</a> request.</p> <p>The maximum number of elements is 10. The maximum string length in characters for each value is 3.</p> 
folderId | **string**<br><p>ID of the folder to which you have access. Required for authorization with a user account (see <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make the request on behalf of a service account.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "languageCode": "string"
}
```

 
Field | Description
--- | ---
languageCode | **string**<br><p>The text language in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, ``ru``).</p> <p>To get the language name, use a <a href="/docs/translate/api-ref/Translation/listLanguages">listLanguages</a> request.</p> 