---
editable: false
sourcePath: en/_api-ref/ai/translate/v2/api-ref/Translation/detectLanguage.md
---

# Translate API v2, REST: Translation.DetectLanguage

Detects the language of the text.

## HTTP request

```
POST https://translate.{{ api-host }}/translate/v2/detect
```

## Body parameters {#yandex.cloud.ai.translate.v2.DetectLanguageRequest}

```json
{
  "text": "string",
  "languageCodeHints": [
    "string"
  ],
  "folderId": "string"
}
```

#|
||Field | Description ||
|| text | **string**

Required field. The text to detect the language for. ||
|| languageCodeHints[] | **string**

List of the most likely languages. These languages will be given preference when detecting the text language.
Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it.

To get the list of supported languages, use a [TranslationService.ListLanguages](/docs/translate/api-ref/Translation/listLanguages#ListLanguages) request. ||
|| folderId | **string**

ID of the folder to which you have access.
Required for authorization with a user account (see [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/UserAccount/get#yandex.cloud.iam.v1.UserAccount) resource).
Don't specify this field if you make the request on behalf of a service account. ||
|#

## Response {#yandex.cloud.ai.translate.v2.DetectLanguageResponse}

**HTTP Code: 200 - OK**

```json
{
  "languageCode": "string"
}
```

#|
||Field | Description ||
|| languageCode | **string**

Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it.

To get the language name, use a [TranslationService.ListLanguages](/docs/translate/api-ref/Translation/listLanguages#ListLanguages) request. ||
|#