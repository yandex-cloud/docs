---
editable: false
sourcePath: en/_api-ref-grpc/ai/translate/v2/api-ref/grpc/Translation/listLanguages.md
---

# Translate API v2, gRPC: TranslationService.ListLanguages

Retrieves the list of supported languages.

## gRPC request

**rpc ListLanguages ([ListLanguagesRequest](#yandex.cloud.ai.translate.v2.ListLanguagesRequest)) returns ([ListLanguagesResponse](#yandex.cloud.ai.translate.v2.ListLanguagesResponse))**

## ListLanguagesRequest {#yandex.cloud.ai.translate.v2.ListLanguagesRequest}

```json
{
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to which you have access.
Required for authorization with a [user account](/docs/iam/concepts/users/accounts).
Do not specify this field if you make the request on behalf of a [service account](/docs/iam/concepts/users/accounts#sa). ||
|#

## ListLanguagesResponse {#yandex.cloud.ai.translate.v2.ListLanguagesResponse}

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
Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it. ||
|| name | **string**

The name of the language (for example, `` English ``). ||
|#