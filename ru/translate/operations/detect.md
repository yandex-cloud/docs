# Определение языка текста с помощью {{ translate-name }}

Чтобы определить, на каком языке написан текст, воспользуйтесь методом [detectLanguage](../api-ref/Translation/detectLanguage).

{% note info %}

Метод [detectLanguage](../api-ref/Translation/detectLanguage) возвращает код языка заданного текста. Если определить язык невозможно, поле кода языка в ответе будет пустым.

{% endnote %}

## Перед началом работы {#before-you-begin}

{% include [curl](../../_includes/curl.md) %}

{% include [bash-windows-note](../../_includes/translate/bash-windows-note.md) %}

{% include [translate-instruction-auth](../../_includes/translate/translate-instruction-auth.md) %}

## Распознать язык фразы {#simple-example}

В этом примере мы определим, на каком языке написана фраза <q>Hello, world</q>.

Чтобы определить, на каком языке написан текст, передайте его в теле запроса [detectLanguage](../api-ref/Translation/detectLanguage):

{% list tabs group=programming_language %}

- cURL {#curl}

    ```bash
    export FOLDER_ID=<идентификатор_каталога>
    export API_KEY=<API-ключ>
    export TEXT="Hello, world"
    curl \
      --request POST \
      --header "Content-Type: application/json" \
      --header "Authorization: Api-Key ${API_KEY}" \
      --data "{\"folderId\": \"${FOLDER_ID}\", \"text\": \"${TEXT}\"}" \
      "https://translate.{{ api-host }}/translate/v2/detect"
    ```

    Где:

    * `FOLDER_ID` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, полученный [перед началом работы](#before-begin).
    * {% include [api-key-legend-desc](../../_includes/translate/api-key-legend-desc.md) %}

    В ответе сервис вернет код [языка](../concepts/supported-languages.md), на котором написан текст:

    ```json
    {
        "languageCode": "en"
    }
    ```

{% endlist %}

## Указать наиболее вероятные языки {#specify-language}

В некоторых языках одно и то же слово пишется одинаково. Например, слово <q>рука</q> пишется одинаково в английском, немецком, шведском и голландском языках — <q>hand</q>. Если переданный текст состоит из таких слов, то {{ translate-short-name }} может ошибиться при определении языка текста.

Чтобы избежать ошибки, вы можете указать языки в поле `languageCodeHints`, которым надо отдать приоритет при определении языка текста:

{% list tabs group=programming_language %}

- cURL {#curl}

    ```json
    {
        "folderId": "<идентификатор_каталога>",
        "languageCodeHints":["ru", "de"],
        "text": "hand"
    }
    ```

    Где:

    * `folderId` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, полученный [перед началом работы](#before-begin).
    * `languageCodeHints` — языки, которым отдается приоритет при определении языка текста.
    * `text` — текст для перевода в виде строки.

    Сохраните тело запроса в файле, например `body.json`, и передайте его с помощью метода [detectLanguage](../api-ref/Translation/detectLanguage):

    ```bash
    export API_KEY=<API-ключ>
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