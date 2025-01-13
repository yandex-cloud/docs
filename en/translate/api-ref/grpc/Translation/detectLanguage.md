---
editable: false
sourcePath: en/_api-ref-grpc/ai/translate/v2/api-ref/grpc/Translation/detectLanguage.md
---

# Translate API v2, gRPC: TranslationService.DetectLanguage

Detects the language of the text.

## gRPC request

**rpc DetectLanguage ([DetectLanguageRequest](#yandex.cloud.ai.translate.v2.DetectLanguageRequest)) returns ([DetectLanguageResponse](#yandex.cloud.ai.translate.v2.DetectLanguageResponse))**

## DetectLanguageRequest {#yandex.cloud.ai.translate.v2.DetectLanguageRequest}

```json
{
  "text": "string",
  "language_code_hints": [
    "string"
  ],
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| text | **string**

Required field. The text to detect the language for. ||
|| language_code_hints[] | **string**

List of the most likely languages. These languages will be given preference when detecting the text language.
Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it.

To get the list of supported languages, use a [TranslationService.ListLanguages](/docs/translate/api-ref/grpc/Translation/listLanguages#ListLanguages) request. ||
|| folder_id | **string**

ID of the folder to which you have access.
Required for authorization with a user account (see [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/grpc/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount) resource).
Don't specify this field if you make the request on behalf of a service account. ||
|#

## DetectLanguageResponse {#yandex.cloud.ai.translate.v2.DetectLanguageResponse}

```json
{
  "language_code": "string"
}
```

#|
||Field | Description ||
|| language_code | **string**

Most languages are specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `` ru ``), but the field are not limited to it.

To get the language name, use a [TranslationService.ListLanguages](/docs/translate/api-ref/grpc/Translation/listLanguages#ListLanguages) request. ||
|#