---
title: How to get a list of supported languages in {{ translate-full-name }}
description: In this tutorial, you will learn how to get a list of supported languages in {{ translate-name }}.
---

# Getting a list of supported languages

## Getting started {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [translate-instruction-auth](../../_includes/translate/translate-instruction-auth.md) %}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

## Get the list of supported languages {#get-languages}

Get the list of [supported languages](../concepts/supported-languages.md) using the [listLanguages](../api-ref/Translation/listLanguages) method:

{% list tabs group=programming_language %}

- cURL {#curl}

    ```bash
    export FOLDER_ID=<folder_ID>
    export API_KEY=<API_key>
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Api-Key ${API_KEY}" \
      --data "{\"folderId\": \"${FOLDER_ID}\"}" \
      "https://translate.{{ api-host }}/translate/v2/languages"
    ```

    Where:

    * `FOLDER_ID`: Folder [ID](../../resource-manager/operations/folder/get-id.md) you got [before you started](#before-begin).
    * {% include [api-key-legend-desc](../../_includes/translate/api-key-legend-desc.md) %}

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