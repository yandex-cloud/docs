## Before getting started {#before-begin}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

## Translate text from any language {#any-language}

This example shows how to translate the following two lines of text into Russian: <q>Hello</q> and <q>World</q>. The text language is recognized automatically.

1. Create a file with the request body (for example, `body.json`).
    In `folderId`, enter the [folder ID](../../resource-manager/operations/folder/get-id.md). List the text strings to translate in the `texts` field.

    In the `targetLanguageCode` field, enter the target language in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format. For Russian, it's `ru`. The language code can be obtained together with a [list of supported languages](../../translate/operations/list.md).

    ```json
    {
        "folderId": "b1gvmob95yysaplct532",
        "texts": ["Hello", "World"],
        "targetLanguageCode": "ru"
    }
    ```

1. To upload the file for translation, use the [translate](../../translate/api-ref/Translation/translate) method:

    {% include [translate-file](../../_includes/translate/translate-file.md) %}

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

