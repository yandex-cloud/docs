---
editable: false
sourcePath: en/_api-ref/ai/translate/api-ref/Translation/translate.md
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
  "folderId": "string",
  "model": "string",
  "glossaryConfig": {
    "glossaryData": {
      "glossaryPairs": [
        {
          "sourceText": "string",
          "translatedText": "string",
          "exact": true
        }
      ]
    }
  },
  "speller": true
}
```

 
Field | Description
--- | ---
sourceLanguageCode | **string**<br><p>The text language to translate from. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, ``ru``).</p> <p>Required for translating with glossary.</p> <p>The maximum string length in characters is 3.</p> 
targetLanguageCode | **string**<br><p>Required. The target language to translate the text. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, ``en``).</p> <p>The maximum string length in characters is 3.</p> 
format | **string**<br><p>Format of the text.</p> <ul> <li>PLAIN_TEXT: Text without markup. Default value.</li> <li>HTML: Text in the HTML format.</li> </ul> 
texts[] | **string**<br><p>Required. Array of the strings to translate. The maximum total length of all strings is 10000 characters.</p> <p>Must contain at least one element.</p> 
folderId | **string**<br><p>ID of the folder to which you have access. Required for authorization with a user account (see <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make the request on behalf of a service account.</p> <p>The maximum string length in characters is 50.</p> 
model | **string**<br><p>Do not specify this field, custom models are not supported yet.</p> <p>The maximum string length in characters is 50.</p> 
glossaryConfig | **object**<br><p>Glossary to be applied for the translation. For more information, see <a href="/docs/translate/concepts/glossary">Glossaries</a>.</p> 
glossaryConfig.<br>glossaryData | **object**<br>Pass glossary data in the request. Currently, only this way to pass glossary is supported.
glossaryConfig.<br>glossaryData.<br>glossaryPairs[] | **object**<br><p>Required. Array of text pairs.</p> <p>The maximum total length of all source texts is 10000 characters. The maximum total length of all translated texts is 10000 characters.</p> <p>The number of elements must be in the range 1-50.</p> 
glossaryConfig.<br>glossaryData.<br>glossaryPairs[].<br>sourceText | **string**<br><p>Required. Text in the source language.</p> 
glossaryConfig.<br>glossaryData.<br>glossaryPairs[].<br>translatedText | **string**<br><p>Required. Text in the target language.</p> 
glossaryConfig.<br>glossaryData.<br>glossaryPairs[].<br>exact | **boolean** (boolean)
speller | **boolean** (boolean)<br><p>use speller</p> 
 
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
translations[].<br>detectedLanguageCode | **string**<br><p>The language code of the source text. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, ``en``).</p> 