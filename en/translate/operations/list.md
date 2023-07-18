# Getting a list of supported languages

## Getting started {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [ai-before-beginning](../../_includes/translate/ai-before-beginning.md) %}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

## Get the list of supported languages {#get-languages}

Get the list of supported languages using the [listLanguages](../api-ref/Translation/listLanguages) method:

{% list tabs %}

- Bash

    ```bash
    export FOLDER_ID=<folder ID>
    export IAM_TOKEN=<IAM token>
    curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "{\"folderId\": \"${FOLDER_ID}\"}" \
       "https://translate.{{ api-host }}/translate/v2/languages"
    ```

    Where:

    * `FOLDER_ID`: Folder ID received [before starting](#before-begin).
    * `IAM_TOKEN`: IAM token received [before starting](#before-begin).

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

{% endlist %}