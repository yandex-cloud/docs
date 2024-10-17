---
editable: false
sourcePath: en/_api-ref/ai/translate/v2/api-ref/Translation/listLanguages.md
---

# Translate API v2, REST: Translation.ListLanguages {#ListLanguages}

Retrieves the list of supported languages.

## HTTP request

```
POST https://translate.{{ api-host }}/translate/v2/languages
```

## Body parameters {#yandex.cloud.ai.translate.v2.ListLanguagesRequest}

```json
{
  "folderId": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to which you have access.
Required for authorization with a user account (see [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount) resource).
Don't specify this field if you make the request on behalf of a service account. ||
|#

## Response {#yandex.cloud.ai.translate.v2.ListLanguagesResponse}

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

#|
||Field | Description ||
|| languages[] | **[Language](#yandex.cloud.ai.translate.v2.Language)**

List of supported languages. ||
|#

## Language {#yandex.cloud.ai.translate.v2.Language}

#|
||Field | Description ||
|| code | **string**

The language code.
Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` en ``). ||
|| name | **string**

The name of the language (for example, `` English ``). ||
|#