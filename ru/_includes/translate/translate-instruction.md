## Перед началом {#before-begin}

{% include [curl](../curl.md) %}

{% include [ai-before-beginning](../translate/ai-before-beginning.md) %}

{% include [bash-windows-note-single](bash-windows-note-single.md) %}

## Перевести текст с любого языка {#any-language}

Чтобы перевести текст, передайте его с помощью метода [translate](../../translate/api-ref/Translation/translate):

{% list tabs %}

- Bash

    Будет выполнен перевод на русский язык двух строк с текстом: <q>Hello</q> и <q>World</q>. Язык исходного текста будет определен автоматически.

    1. Создайте файл с телом запроса (например, `body.json`):

        ```json
        {
            "folderId": "<идентификатор каталога>",
            "texts": ["Hello", "World"],
            "targetLanguageCode": "ru"
        }
        ```

        Где:

        * `folderId` — идентификатор каталога, полученный [перед началом работы](#before-begin).
        * `texts` — текст для перевода в виде списка из строк.
        * `targetLanguageCode` — язык, на который переводится текст, в формате [ISO 639-1](https://ru.wikipedia.org/wiki/ISO_639-1). Вы можете узнать код языка вместе со [списком поддерживаемых языков](../../translate/operations/list.md).

    1. Передайте файл на перевод, выполнив команду:

        {% include [translate-file](../translate/translate-file.md) %}

        Где `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

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

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык исходного текста будет определен автоматически.

    Создайте файл с телом запроса (например, `body.py`):

    ```python
    import requests

    IAM_TOKEN = '<IAM-токен>'
    folder_id = '<идентификатор каталога>'
    target_language = 'ru'
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

    response = requests.post('https://translate.{{ api-host }}/translate/v2/translate',
        json = body,
        headers = headers
    )

    print(response.text)
    ```

    Где:

    * `folder_id` — идентификатор каталога, полученный [перед началом работы](#before-begin).
    * `texts` — текст для перевода в виде списка из строк.
    * `target_language` — язык, на который переводится текст, в формате [ISO 639-1](https://ru.wikipedia.org/wiki/ISO_639-1). Вы можете узнать код языка вместе со [списком поддерживаемых языков](../../translate/operations/list.md).
    * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

- PHP

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык исходного текста будет определен автоматически.

    Создайте файл с телом запроса (например, `body.php`):

    ```php
    $IAM_TOKEN = '<IAM-токен>';
    $folder_id = '<идентификатор каталога>';
    $target_language = 'ru';
    $texts = ["Hello", "World"];

    $url = 'https://translate.{{ api-host }}/translate/v2/translate';

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

    Где: 
    
    * `folder_id` — идентификатор каталога, полученный [перед началом работы](#before-begin).
    * `texts` — текст для перевода в виде списка из строк.
    * `target_language` — язык, на который переводится текст, в формате [ISO 639-1](https://ru.wikipedia.org/wiki/ISO_639-1). Вы можете узнать код языка вместе со [списком поддерживаемых языков](../../translate/operations/list.md).
    * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

{% endlist %}
