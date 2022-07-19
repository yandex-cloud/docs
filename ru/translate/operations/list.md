# Получение списка поддерживаемых языков

## Перед началом {#before-you-begin}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

## Получить список поддерживаемых языков {#get-languages}

Получите список поддерживаемых языков с помощью метода [listLanguages](../api-ref/Translation/listLanguages):

```bash
export FOLDER_ID=b1gvmob95yysaplct532
export IAM_TOKEN=CggaATEVAgA...
curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d "{\"folderId\": \"${FOLDER_ID}\"}" \
    "https://translate.{{ api-host }}/translate/v2/languages"
```

Ответ будет содержать список языков с названиями на соответствующем языке:

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