## Перевести текст с любого языка {#any-language}

Чтобы перевести текст с любого [поддерживаемого языка](../../translate/concepts/supported-languages.md), передайте его с помощью метода [translate](../../translate/api-ref/Translation/translate):

{% list tabs group=programming_language %}

- cURL {#curl}

    {% include [curl](../curl.md) %}

    {% include [bash](translate-bash.md) %}

- Python {#python}

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык исходного текста будет определен автоматически.

    Создайте файл с телом запроса (например, `body.py`):

    ```python
    import requests

    # Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
    API_KEY = "<API-ключ>"
    # Параметры для аутентификации с помощью IAM-токена:
    # IAM_TOKEN = '<IAM-токен>'
    folder_id = "<идентификатор_каталога>"
    target_language = "ru"
    texts = ["Hello", "World"]

    body = {
        "targetLanguageCode": target_language,
        "texts": texts,
        "folderId": folder_id,
    }

    headers = {
        "Content-Type": "application/json",
        # Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
        "Authorization": "Api-Key {0}".format(API_KEY),
        # Параметры для аутентификации с помощью IAM-токена:
        # "Authorization": "Bearer {0}".format(IAM_TOKEN)
    }

    response = requests.post(
        "https://translate.{{ api-host }}/translate/v2/translate",
        json=body,
        headers=headers,
    )

    print(response.text)
    ```

    Где:

    * {% include [api-key-legend-desc](./api-key-legend-desc.md) %}
    * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, полученный [перед началом работы](#before-begin).
    * `target_language` — [язык](../../translate/concepts/supported-languages.md), на который переводится текст. Вы можете узнать код языка вместе со [списком поддерживаемых языков](../../translate/operations/list.md).
    * `texts` — текст для перевода в виде списка из строк.

    API-ключ можно сохранить в файл. В таком случае укажите путь к этому файлу в переменной `key_path`:

    {% cut "**body.py**" %}

    ```python
    import os
    import requests

    # Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
    key_path = "<путь_к_файлу_с_API-ключом>"
    # Параметры для аутентификации с помощью IAM-токена:
    # token_path = '<путь_к_файлу_с_IAM-токеном>'
    folder_id = "<идентификатор_каталога>"
    target_language = "ru"
    texts = ["Hello", "World"]

    # Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
    API_KEY = os.path.join(os.getcwd(), key_path)
    with open(API_KEY) as f:
        API_KEY = f.read().strip()
    # Параметры для аутентификации с помощью IAM-токена:
    # IAM_TOKEN = os.path.join(os.getcwd(), token_path)
    # with open(IAM_TOKEN) as f:
    #     IAM_TOKEN = f.read().strip()

    body = {
        "targetLanguageCode": target_language,
        "texts": texts,
        "folderId": folder_id,
    }

    headers = {
        "Content-Type": "application/json",
        # Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
        "Authorization": "Api-Key {0}".format(API_KEY),
        # Параметры для аутентификации с помощью IAM-токена:
        # "Authorization": "Bearer {0}".format(IAM_TOKEN)
    }

    response = requests.post(
        "https://translate.{{ api-host }}/translate/v2/translate",
        json=body,
        headers=headers,
    )

    print(response.text)
    ```

    {% endcut %}

- PHP {#php}

    В этом примере показано, как перевести на русский язык две строки с текстом: <q>Hello</q> и <q>World</q>. Язык исходного текста будет определен автоматически.

    Создайте файл с телом запроса (например, `body.php`):

    ```php
    <?php

    // Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
    $API_KEY = '<API-ключ>';
    // Параметры для аутентификации с помощью IAM-токена:
    // $IAM_TOKEN = '<IAM-токен>';
    $folder_id = '<идентификатор_каталога>';
    $target_language = 'ru';
    $texts = ["Hello", "World"];

    $url = 'https://translate.{{ api-host }}/translate/v2/translate';

    $headers = [
        'Content-Type: application/json',
        // Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
        "Authorization: Api-Key $API_KEY"
        // Параметры для аутентификации с помощью IAM-токена:
        // "Authorization: Bearer $IAM_TOKEN"
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

    * {% include [api-key-legend-desc](./api-key-legend-desc.md) %}
    * `folder_id` — [идентификатор](../../resource-manager/operations/folder/get-id.md) каталога, полученный [перед началом работы](#before-begin).
    * `target_language` — [язык](../../translate/concepts/supported-languages.md), на который переводится текст. Вы можете узнать код языка вместе со [списком поддерживаемых языков](../../translate/operations/list.md).
    * `texts` — текст для перевода в виде массива строк.

    API-ключ можно сохранить в файл. В таком случае укажите путь к этому файлу в переменной `key_path`:

    {% cut "**body.php**" %}

    ```php
    <?php

    // Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
    $key_path = '<путь_к_файлу_с_API-ключом>';
    // Параметры для аутентификации с помощью IAM-токена:
    // $token_path = '<путь_к_файлу_с_IAM-токеном>';
    $folder_id = '<идентификатор_каталога>';
    $target_language = 'ru';
    $texts = ["Hello", "World"];

    $url = 'https://translate.{{ api-host }}/translate/v2/translate';

    // Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
    $API_KEY = trim(file_get_contents(realpath($key_path)));
    // Параметры для аутентификации с помощью IAM-токена:
    // $IAM_TOKEN = trim(file_get_contents(realpath($token_path)));

    $headers = [
        'Content-Type: application/json',
        // Параметры для аутентификации с помощью API-ключа от имени сервисного аккаунта:
        "Authorization: Api-Key $API_KEY"
        // Параметры для аутентификации с помощью IAM-токена:
        // "Authorization: Bearer $IAM_TOKEN"
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
