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
Required for authorization with a user account (see [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/grpc/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount) resource).
Don't specify this field if you make the request on behalf of a service account. ||
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
Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` en ``). ||
|| name | **string**

The name of the language (for example, `` English ``). ||
|#