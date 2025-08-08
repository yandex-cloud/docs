---
editable: false
apiPlayground:
  - url: https://translate.{{ api-host }}/translate/v2/translate
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        sourceLanguageCode:
          description: |-
            **string**
            The text language to translate from.
            Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it.
            Required for translating with [glossary](/docs/translate/concepts/glossary).
          type: string
        targetLanguageCode:
          description: |-
            **string**
            Required field. The target language to translate the text.
            Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it.
          type: string
        format:
          description: |-
            **enum** (Format)
            Format of the text to be translated.
            - `FORMAT_UNSPECIFIED`
            - `PLAIN_TEXT`: Text without markup. Default value.
            - `HTML`: Text in the HTML format.
          type: string
          enum:
            - FORMAT_UNSPECIFIED
            - PLAIN_TEXT
            - HTML
        texts:
          description: |-
            **string**
            Array of the strings to translate.
            The maximum total length of all strings is 10000 characters.
          type: array
          items:
            type: string
        folderId:
          description: |-
            **string**
            ID of the folder to which you have access.
            Required for authorization with a [user account](/docs/iam/concepts/users/accounts).
            Do not specify this field if you make the request on behalf of a [service account](/docs/iam/concepts/users/accounts#sa).
          type: string
        model:
          description: |-
            **string**
            Model ID if you use custom model.
          type: string
        glossaryConfig:
          description: |-
            **[TranslateGlossaryConfig](/docs/translate/api-ref/Translation/translate#yandex.cloud.ai.translate.v2.TranslateGlossaryConfig)**
            Glossary to be applied for the translation. For more information, see [Glossaries](/docs/translate/concepts/glossary).
          oneOf:
            - type: object
              properties:
                glossaryData:
                  description: |-
                    **[GlossaryData](/docs/translate/api-ref/Translation/translate#yandex.cloud.ai.translate.v2.GlossaryData)**
                    Pass glossary data in the request. Currently, the only way to pass glossary.
                    Includes only one of the fields `glossaryData`.
                  $ref: '#/definitions/GlossaryData'
        speller:
          description: |-
            **boolean**
            Enable spell checking.
          type: boolean
      required:
        - targetLanguageCode
      additionalProperties: false
    definitions:
      GlossaryPair:
        type: object
        properties:
          sourceText:
            description: |-
              **string**
              Required field. Text in the source language.
            type: string
          translatedText:
            description: |-
              **string**
              Required field. Text in the target language.
            type: string
          exact:
            description: |-
              **boolean**
              Allows to add translations for specific terms to [neuroglossaries](/docs/translate/concepts/glossary#word-forms).
            type: boolean
        required:
          - sourceText
          - translatedText
      GlossaryData:
        type: object
        properties:
          glossaryPairs:
            description: |-
              **[GlossaryPair](/docs/translate/api-ref/Translation/translate#yandex.cloud.ai.translate.v2.GlossaryPair)**
              Array of text pairs.
              The maximum total length of all source texts is 10000 characters.
              The maximum total length of all translated texts is 10000 characters.
            type: array
            items:
              $ref: '#/definitions/GlossaryPair'
sourcePath: en/_api-ref/ai/translate/v2/api-ref/Translation/translate.md
---

# Translate API v2, REST: Translation.Translate

Translates the text to the specified language.

## HTTP request

```
POST https://translate.{{ api-host }}/translate/v2/translate
```

## Body parameters {#yandex.cloud.ai.translate.v2.TranslateRequest}

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
    // Includes only one of the fields `glossaryData`
    "glossaryData": {
      "glossaryPairs": [
        {
          "sourceText": "string",
          "translatedText": "string",
          "exact": "boolean"
        }
      ]
    }
    // end of the list of possible fields
  },
  "speller": "boolean"
}
```

#|
||Field | Description ||
|| sourceLanguageCode | **string**

The text language to translate from.
Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it.

Required for translating with [glossary](/docs/translate/concepts/glossary). ||
|| targetLanguageCode | **string**

Required field. The target language to translate the text.
Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it. ||
|| format | **enum** (Format)

Format of the text to be translated.

- `FORMAT_UNSPECIFIED`
- `PLAIN_TEXT`: Text without markup. Default value.
- `HTML`: Text in the HTML format. ||
|| texts[] | **string**

Array of the strings to translate.
The maximum total length of all strings is 10000 characters. ||
|| folderId | **string**

ID of the folder to which you have access.
Required for authorization with a [user account](/docs/iam/concepts/users/accounts).
Do not specify this field if you make the request on behalf of a [service account](/docs/iam/concepts/users/accounts#sa). ||
|| model | **string**

Model ID if you use custom model. ||
|| glossaryConfig | **[TranslateGlossaryConfig](#yandex.cloud.ai.translate.v2.TranslateGlossaryConfig)**

Glossary to be applied for the translation. For more information, see [Glossaries](/docs/translate/concepts/glossary). ||
|| speller | **boolean**

Enable spell checking. ||
|#

## TranslateGlossaryConfig {#yandex.cloud.ai.translate.v2.TranslateGlossaryConfig}

#|
||Field | Description ||
|| glossaryData | **[GlossaryData](#yandex.cloud.ai.translate.v2.GlossaryData)**

Pass glossary data in the request. Currently, the only way to pass glossary.

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
|| exact | **boolean**

Allows to add translations for specific terms to [neuroglossaries](/docs/translate/concepts/glossary#word-forms). ||
|#

## Response {#yandex.cloud.ai.translate.v2.TranslateResponse}

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
Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it. ||
|#