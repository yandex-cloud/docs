---
title: How to get a list of supported languages in {{ translate-full-name }}
description: In this tutorial, you will learn how to get a list of supported languages in {{ translate-name }}.
---

# Getting a list of supported languages

## Getting started {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [ai-before-beginning](../../_includes/translate/ai-before-beginning.md) %}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

## Get the list of supported languages {#get-languages}

Get the list of supported languages using the [listLanguages](../api-ref/Translation/listLanguages) method:

{% list tabs group=programming_language %}

- Bash {#bash}

    ```bash
    export FOLDER_ID=<folder_ID>
    export IAM_TOKEN=<IAM_token>
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data "{\"folderId\": \"${FOLDER_ID}\"}" \
      "https://translate.{{ api-host }}/translate/v2/languages"
    ```

    Where:

    * `FOLDER_ID`: Folder ID you got [before you started](#before-begin).
    * `IAM_TOKEN`: IAM token you got [before you started](#before-begin).

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