# Detecting the text language using {{ translate-name }}

To detect the language of a text, use the [detectLanguage](../api-ref/Translation/detectLanguage) method.

{% note info %}

The [detectLanguage](../api-ref/Translation/detectLanguage) method returns the language code of the source text. If the language cannot be detected, the language code field in the response will be empty.

{% endnote %}

## Getting started {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [bash-windows-note](../../_includes/translate/bash-windows-note.md) %}

{% include [translate-instruction-auth](../../_includes/translate/translate-instruction-auth.md) %}

## Detect the language of a phrase {#simple-example}

In this example, we will detect the language that the phrase _Hello, world_ is written in.

To detect the language of the text, pass it in the [detectLanguage](../api-ref/Translation/detectLanguage) request body:

{% list tabs group=programming_language %}

- cURL {#curl}

    ```bash
    export FOLDER_ID=<folder_ID>
    export API_KEY=<API_key>
    export TEXT="Hello, world"
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Api-Key ${API_KEY}" \
      --data "{\"folderId\": \"${FOLDER_ID}\", \"text\": \"${TEXT}\"}" \
      "https://translate.{{ api-host }}/translate/v2/detect"
    ```

    Where:

    * `FOLDER_ID`: Folder [ID](../../resource-manager/operations/folder/get-id.md) you got [before you started](#before-begin).
    * {% include [api-key-legend-desc](../../_includes/translate/api-key-legend-desc.md) %}

    The service will respond with the [language](../concepts/supported-languages.md) code of the source text:

    ```json
    {
        "languageCode": "en"
    }
    ```

{% endlist %}

## Specify the most likely languages {#specify-language}

Some words are spelled the same in different languages. For example, the English word <q>hand</q> is also written as <q>hand</q> in German, Swedish, and Dutch. If the text you provide contains such words, {{ translate-short-name }} may detect the wrong source language.

To avoid mistakes, you can use the `languageCodeHints` field to specify which languages should be prioritized when determining the text language:

{% list tabs group=programming_language %}

- cURL {#curl}

    ```json
    {
        "folderId": "<folder_ID>",
        "languageCodeHints":["ru", "de"],
        "text": "hand"
    }
    ```

    Where:

    * `folderId`: Folder [ID](../../resource-manager/operations/folder/get-id.md) you got [before you started](#before-begin).
    * `languageCodeHints`: Languages to prioritize when determining the language of the text.
    * `text`: Text to translate as a string.

    Save the request body to a file (e.g., `body.json`) and provide the file using the [detectLanguage](../api-ref/Translation/detectLanguage) method:

    ```bash
    export API_KEY=<API_key>
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Api-Key ${API_KEY}" \
      --data '@body.json' \
      "https://translate.{{ api-host }}/translate/v2/detect"

    {
        "languageCode": "de"
    }
    ```

    {% include [api-key-legend-desc](../../_includes/translate/api-key-legend-desc.md) %}

{% endlist %}