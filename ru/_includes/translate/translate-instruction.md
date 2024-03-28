## Перевести текст с любого языка {#any-language}

Чтобы перевести текст с любого [поддерживаемого языка](../../translate/concepts/supported-languages.md), передайте его с помощью метода [translate](../../translate/api-ref/Translation/translate):

{% list tabs group=programming_language %}

- Bash {#bash}

    {% include [curl](../curl.md) %}

    {% include [bash](translate-bash.md) %}

- Python {#python}

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык исходного текста будет определен автоматически.

    Создайте файл с телом запроса (например, `body.py`):

    ```python
    import requests

    IAM_TOKEN = '<IAM-токен>'
    folder_id = '<идентификатор_каталога>'
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

    * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin). 
    * `folder_id` — идентификатор каталога, полученный [перед началом работы](#before-begin).
    * `target_language` — [язык](../../translate/concepts/supported-languages.md), на который переводится текст. Вы можете узнать код языка вместе со [списком поддерживаемых языков](../../translate/operations/list.md).
    * `texts` — текст для перевода в виде списка из строк.

    IAM-токен можно сохранить в файл. В таком случае укажите путь к этому файлу в переменной `token_path`:

    {% cut "**body.py**" %}

    ```python
    import os
    import requests

    token_path = '<путь_к_файлу_с_IAM-токеном>'
    folder_id = '<идентификатор_каталога>'
    target_language = 'ru'
    texts = ["Hello", "World"]
    IAM_TOKEN = os.path.join(os.getcwd(), token_path)
    with open(IAM_TOKEN) as f:
        IAM_TOKEN = f.read().strip()

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

    {% endcut %}

- PHP {#php}

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык исходного текста будет определен автоматически.

    Создайте файл с телом запроса (например, `body.php`):

    ```php
    <?php
    
    $IAM_TOKEN = '<IAM-токен>';
    $folder_id = '<идентификатор_каталога>';
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
    
    ?>
    ```

    Где: 

    * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin). 
    * `folder_id` — идентификатор каталога, полученный [перед началом работы](#before-begin).
    * `target_language` — [язык](../../translate/concepts/supported-languages.md), на который переводится текст. Вы можете узнать код языка вместе со [списком поддерживаемых языков](../../translate/operations/list.md).
    * `texts` — текст для перевода в виде массива строк.

    IAM-токен можно сохранить в файл. В таком случае укажите путь к этому файлу в переменной `token_path`:

    {% cut "**body.php**" %}

    ```php
    <?php

    $token_path = '<путь_к_файлу_с_IAM-токеном>';
    $folder_id = '<идентификатор_каталога>';
    $target_language = 'ru';
    $texts = ["Hello", "World"];

    $IAM_TOKEN = trim(file_get_contents(realpath($token_path)));
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

    ?>
    ```

    {% endcut %}

{% endlist %}
