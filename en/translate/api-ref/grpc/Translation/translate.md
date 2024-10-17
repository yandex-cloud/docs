---
editable: false
sourcePath: en/_api-ref-grpc/ai/translate/v2/api-ref/grpc/Translation/translate.md
---

# Translate API v2, gRPC: TranslationService.Translate {#Translate}

Translates the text to the specified language.

## gRPC request

**rpc Translate ([TranslateRequest](#yandex.cloud.ai.translate.v2.TranslateRequest)) returns ([TranslateResponse](#yandex.cloud.ai.translate.v2.TranslateResponse))**

## TranslateRequest {#yandex.cloud.ai.translate.v2.TranslateRequest}

```json
{
  "sourceLanguageCode": "string",
  "targetLanguageCode": "string",
  "format": "Format",
  "texts": [
    "string"
  ],
  "folderId": "string",
  "model": "string",
  "glossaryConfig": {
    // Includes only one of the fields `glossaryData`
    "glossaryData": {
      "glossaryPairs": [
        {
          "sourceText": "string",
          "translatedText": "string",
          "exact": "bool"
        }
      ]
    }
    // end of the list of possible fields
  },
  "speller": "bool"
}
```

#|
||Field | Description ||
|| sourceLanguageCode | **string**

The text language to translate from.
Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``).

Required for translating with glossary. ||
|| targetLanguageCode | **string**

Required field. The target language to translate the text.
Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` en ``). ||
|| format | enum **Format**

Format of the text.

- `FORMAT_UNSPECIFIED`
- `PLAIN_TEXT`: Text without markup. Default value.
- `HTML`: Text in the HTML format. ||
|| texts[] | **string**

Array of the strings to translate.
The maximum total length of all strings is 10000 characters. ||
|| folderId | **string**

ID of the folder to which you have access.
Required for authorization with a user account (see [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/grpc/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount) resource).
Don't specify this field if you make the request on behalf of a service account. ||
|| model | **string**

Do not specify this field, custom models are not supported yet. ||
|| glossaryConfig | **[TranslateGlossaryConfig](#yandex.cloud.ai.translate.v2.TranslateGlossaryConfig)**

Glossary to be applied for the translation. For more information, see [Glossaries](/docs/translate/concepts/glossary). ||
|| speller | **bool**

use speller ||
|#

## TranslateGlossaryConfig {#yandex.cloud.ai.translate.v2.TranslateGlossaryConfig}

#|
||Field | Description ||
|| glossaryData | **[GlossaryData](#yandex.cloud.ai.translate.v2.GlossaryData)**

Pass glossary data in the request. Currently, only this way to pass glossary is supported.

Includes only one of the fields `glossaryData`. ||
|#

## GlossaryData {#yandex.cloud.ai.translate.v2.GlossaryData}

#|
||Field | Description ||
|| glossaryPairs[] | **[GlossaryPair](#yandex.cloud.ai.translate.v2.GlossaryPair)**

Array of text pairs.

The maximum total length of all source texts is 10000 characters.
The maximum total length of all translated texts is 10000 characters. ||
|#

## GlossaryPair {#yandex.cloud.ai.translate.v2.GlossaryPair}

#|
||Field | Description ||
|| sourceText | **string**

Required field. Text in the source language. ||
|| translatedText | **string**

Required field. Text in the target language. ||
|| exact | **bool** ||
|#

## TranslateResponse {#yandex.cloud.ai.translate.v2.TranslateResponse}

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

#|
||Field | Description ||
|| translations[] | **[TranslatedText](#yandex.cloud.ai.translate.v2.TranslatedText)**

Array of the translations. ||
|#

## TranslatedText {#yandex.cloud.ai.translate.v2.TranslatedText}

#|
||Field | Description ||
|| text | **string**

Translated text. ||
|| detectedLanguageCode | **string**

The language code of the source text.
Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` en ``). ||
|#