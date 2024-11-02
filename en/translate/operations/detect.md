# Detecting the text language using {{ translate-name }}

To detect the language of a text, use the [detectLanguage](../api-ref/Translation/detectLanguage) method.

{% note info %}

The [detectLanguage](../api-ref/Translation/detectLanguage) method returns the language code of the source text. If the language cannot be detected, the language code field in the response will be empty.

{% endnote %}

## Getting started {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [bash-windows-note](../../_includes/translate/bash-windows-note.md) %}

{% include [ai-before-beginning](../../_includes/translate/ai-before-beginning.md) %}

## Detect the language of a phrase {#simple-example}

In this example, we will detect the language that the phrase _Hello, world_ is written in.

To detect the language of the text, pass it in the [detectLanguage](../api-ref/Translation/detectLanguage) request body:

{% list tabs group=programming_language %}

- Bash {#bash}

    ```bash
    export FOLDER_ID=<folder_ID>
    export IAM_TOKEN=<IAM_token>
    export TEXT="Hello, world"
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data "{\"folderId\": \"${FOLDER_ID}\", \"text\": \"${TEXT}\"}" \
      "https://translate.{{ api-host }}/translate/v2/detect"
    ```

    Where:

    * `FOLDER_ID`: Folder ID you got [before you started](#before-begin).
    * `IAM_TOKEN`: IAM token you got [before you started](#before-begin).

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

- Bash {#bash}

    ```json
    {
        "folderId": "<folder_ID>",
        "languageCodeHints":["ru", "de"],
        "text": "hand"
    }
    ```

    Where:

    * `folderId`: Folder ID you got [before you started](#before-begin).
    * `languageCodeHints`: Languages to prioritize when determining the language of the text.
    * `text`: Text to translate as a string.

    Save the request body to a file (e.g., `body.json`) and provide the file using the [detectLanguage](../api-ref/Translation/detectLanguage) method:

    ```bash
    export IAM_TOKEN=<IAM_token>
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data '@body.json' \
      "https://translate.{{ api-host }}/translate/v2/detect"

    {
        "languageCode": "de"
    }
    ```

    Where `IAM_TOKEN` is the IAM token you got [before you started](#before-begin).

{% endlist %}