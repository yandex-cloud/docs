# Detect the language of a text

To detect the language of a text, use the [detectLanguage](../api-ref/Translation/detectLanguage) method.

## Examples

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

### Hello, world

In this example, we will detect the language that the phrase <q>Hello, world</q> is written in.

1. To detect the language of the text, pass it in the [detectLanguage](../api-ref/Translation/detectLanguage) request body:

    ```bash
    $ export FOLDER_ID=b1gvmob95yysaplct532
    $ export IAM_TOKEN=CggaATEVAgA...
    $ export TEXT="Hello, world"
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "{\"folder_id\": \"${FOLDER_ID}\", \"text\": \"${TEXT}\"}" \
        "https://translate.api.cloud.yandex.net/translate/v2/detect"
    ```

    The service responds with the language code of the source text:

    ```json
    {
        "languageCode": "en"
    }
    ```

1. To find out what language corresponds to the received code, use the [listLanguages](../api-ref/Translation/listLanguages) method:

    ```bash
    curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "{\"folder_id\": \"${FOLDER_ID}\"}" \
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

### Specify the most likely languages

In some languages, one and the same word has the same spelling. For example, the English word <q>hand</q> is also written as <q>hand</q> in German, Swedish, and Dutch. If the text you transmit contains words like this, {{ translate-short-name }} may detect the source language incorrectly.

To avoid mistakes, you can use the `languageCodeHints` field to specify which languages should be given priority when determining the language of the text:

```json
{
    "folder_id": "b1gvmob95yysaplct532",
    "languageCodeHints":["ru", "de"],
    "text": "hand"
}
```

Save the request body in a file (for example, `body.json`) and pass it using the [detectLanguage](../api-ref/Translation/detectLanguage) method:

```bash
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d @body.json \
    "https://translate.api.cloud.yandex.net/translate/v2/detect"

{
    "languageCode": "de"
}
```

