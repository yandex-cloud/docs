---
editable: false
---

# Method translate
Translates the text to the specified language.
 

 
## HTTP request {#https-request}
```
POST https://translate.{{ api-host }}/translate/v2/translate
```
 
## Body parameters {#body_params}
 
```json 
 {
  "sourceLanguageCode": "string",
  "targetLanguageCode": "string",
  "format": "string",
  "texts": [
    "string"
  ],
  "folderId": "string"
}
```

 
Field | Description
--- | ---
sourceLanguageCode | **string**<br><p>The text language to translate from. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, <code>ru</code>).</p> <p>The maximum string length in characters is 3.</p> 
targetLanguageCode | **string**<br><p>Required. The target language to translate the text. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, <code>en</code>).</p> <p>The maximum string length in characters is 3.</p> 
format | **string**<br><p>Format of the text.</p> <ul> <li>PLAIN_TEXT: Text without markup. Default value.</li> <li>HTML: Text in the HTML format.</li> </ul> 
texts[] | **string**<br><p>Required. Array of the strings to translate. The maximum total length of all strings is 10000 characters.</p> <p>Must contain at least one element.</p> 
folderId | **string**<br><p>ID of the folder to which you have access. Required for authorization with a user account (see <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make the request on behalf of a service account.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
 {
  "translations": [
    {
      "text": "string",
      "detectedLanguageCode": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
translations[] | **object**<br><p>Array of the translations.</p> 
translations[].<br>text | **string**<br><p>Translated text.</p> 
translations[].<br>detectedLanguageCode | **string**<br><p>The language code of the source text. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, <code>en</code>).</p> 