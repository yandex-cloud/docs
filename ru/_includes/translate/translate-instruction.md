## Перед началом {#before-begin}

{% include [ai-before-beginning](../../_includes/ai-before-beginning.md) %}

## Перевести текст с любого языка {#any-language}

{% list tabs %}

- CLI

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык текста будет определен автоматически.

    1. Создайте файл с телом запроса, например `body.json`.
        В `folderId` укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Строки текста для перевода перечислите в поле `texts`.

        В поле `targetLanguageCode` укажите язык перевода в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1). Для русского языка это `ru`. Код языка можно получить вместе со [списком поддерживаемых языков](../../translate/operations/list.md).

        ```json
        {
            "folderId": "b1gvmob95yysaplct532",
            "texts": ["Hello", "World"],
            "targetLanguageCode": "ru"
        }
        ```
    1. Передайте файл на перевод с помощью метода [translate](../../translate/api-ref/Translation/translate):

        {% include [translate-file](../../_includes/translate/translate-file.md) %}

        В ответе сервис вернет переведенные строки текста:
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

- Python

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык текста будет определен автоматически.

    В переменной `folder_id` укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Строки текста для перевода перечислите в поле `texts`.

    В переменной `target_language` укажите язык перевода в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1). Для русского языка это `ru`. Код языка можно получить вместе со [списком поддерживаемых языков](../../translate/operations/list.md).

    ```python
    import requests

    IAM_TOKEN = 'CggaATEVAgA...'        // Токен
    folder_id = 'b1gvmob95yysaplct532'  // Идентификатор каталога
    target_language = 'ru'              // На какой язык переводим
    texts = ["Hello", "World"]

    body = {
        "targetLanguageCode": target_language,
        "texts": texts,
        "folderId": folder_id,
    }

    headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer {0}".format(IAM_TOKEN)
    }

    response = requests.post('https://translate.api.cloud.yandex.net/translate/v2/translate',
        json = body,
        headers = headers
    )

    print(response.text)
    ```

- PHP

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык текста будет определен автоматически.

    В переменной `folder_id` укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Строки текста для перевода перечислите в поле `texts`.

    В переменной `target_language` укажите язык перевода в формате [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1). Для русского языка это `ru`. Код языка можно получить вместе со [списком поддерживаемых языков](../../translate/operations/list.md).

    ```php
    $IAM_TOKEN = 'CggaATEVAgA...';
    $folder_id = 'b1gvmob95yysaplct532';
    $target_language = 'ru';
    $texts = ["Hello", "World"];

    $url = 'https://translate.api.cloud.yandex.net/translate/v2/translate';

    $headers = [
        'Content-Type: application/json',
        "Authorization: Bearer $IAM_TOKEN"
    ];

    $post_data = [
        "targetLanguageCode" => $target_language,
        "texts" => $texts,
        "folderId" => $folder_id,
    ];

    $data_json = json_encode($post_data);

    $curl = curl_init();
    curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    // curl_setopt($curl, CURLOPT_VERBOSE, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data_json);
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_POST, true);

    $result = curl_exec($curl);

    curl_close($curl);

    var_dump($result);
    ```