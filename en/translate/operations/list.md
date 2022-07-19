# Getting a list of supported languages

## Before you start {#before-you-begin}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

## Get the list of supported languages {#get-languages}

Get the list of supported languages using the [listLanguages](../api-ref/Translation/listLanguages) method:

```bash
export FOLDER_ID=b1gvmob95yysaplct532
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d "{\"folderId\": \"${FOLDER_ID}\"}" \
    "https://translate.api.cloud.yandex.net/translate/v2/languages"
```

The response will contain a list of language names in the corresponding language:

```json
{
    "languages": [
        {
        "code": "az",
        "name": "azərbaycan"
        },
        {
        "code": "sq",
        "name": "shqip"
        },
        {
        "code": "am",
        "name": "አማርኛ"
        },
        {
        "code": "en",
        "name": "English"
        },
        ...
    ]
}
```

