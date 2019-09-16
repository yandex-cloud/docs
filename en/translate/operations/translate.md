# Translate text

To translate a text, use the [translate](../api-ref/Translation/translate) method.

## Examples

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

### Hello, world

In this example, we will translate two text strings into Russian: <q>Hello</q> and <q>World</q>.

1. Use the [listLanguages](../api-ref/Translation/listLanguages) method to get the code of the target language:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "{\"folder_id\": \"${FOLDER_ID}\"}" \
        "https://translate.api.cloud.yandex.net/translate/v2/languages"
    ```

    The response will contain a list of language names in the corresponding language:

    ```json
    {
        "languages": [
            ...
            {
            "code": "ru",
            "name": "Russian"
            },
            ...
        ]
    }
    ```

2. Create a file with the request body (for example, `body.json`).
List the text strings to translate in the `texts` field. Specify the target language in the `targetLanguageCode` field.

    ```json
    {
        "folder_id": "b1gvmob95yysaplct532",
        "texts": ["Hello", "World"],
        "targetLanguageCode": "ru"
    }
    ```

3. Use the [translate](../api-ref/Translation/translate) method to pass the file to be translated:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d @body.json \
        "https://translate.api.cloud.yandex.net/translate/v2/translate"
    ```

    The response from the service will contain translated text:

    ```json
    {
        "translations": [
            {
            "text": "Привет",
            "detectedLanguageCode": "en"
            },
            {
            "text": "Мир",
            "detectedLanguageCode": "en"
            }
        ]
    }
    ```

### Specify the source language

Sometimes words that are written identically in different languages, but are translated differently. For example, the word <q>angel</q> in English means a spiritual being, while in German it means a fishing rod. If the text you transmit contains words like this, {{ translate-short-name }} may detect the source language incorrectly.

To avoid mistakes, specify the source language in the `sourceLanguageCode` field:

```json
{
    "folder_id": "b1gvmob95yysaplct532",
    "texts": ["angel"],
    "targetLanguageCode": "ru",
    "sourceLanguageCode": "de"
}
```

Save the request body in a file (for example, `body.json`) and pass it using the [translate](../api-ref/Translation/translate) method:

```bash
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${IAM_TOKEN}" \
    -d @body.json \
    "https://translate.api.cloud.yandex.net/translate/v2/translate"

{
    "translations": [
        {
            "text": "удочка"
        }
    ]
}
```

