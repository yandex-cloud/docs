---
title: Как получить список поддерживаемых языков в {{ translate-full-name }}
description: Из статьи вы узнаете, как получить список поддерживаемых языков в {{ translate-name }}.
---

# Получение списка поддерживаемых языков

## Перед началом работы {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [translate-instruction-auth](../../_includes/translate/translate-instruction-auth.md) %}

{% include [bash-windows-note-single](../../_includes/translate/bash-windows-note-single.md) %}

## Получить список поддерживаемых языков {#get-languages}

Получите список [поддерживаемых языков](../concepts/supported-languages.md) с помощью метода [listLanguages](../api-ref/Translation/listLanguages):

{% list tabs group=programming_language %}

- cURL {#curl}

    ```bash
    export FOLDER_ID=<идентификатор_каталога>
    export API_KEY=<API-ключ>
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Api-Key ${API_KEY}" \
      --data "{\"folderId\": \"${FOLDER_ID}\"}" \
      "https://translate.{{ api-host }}/translate/v2/languages"
    ```

    Где:

    * `FOLDER_ID` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, полученный [перед началом работы](#before-begin).
    * {% include [api-key-legend-desc](../../_includes/translate/api-key-legend-desc.md) %}

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

{% endlist %}