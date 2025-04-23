## Translating a text from any language {#any-language}

To translate a text from any [supported language](../../translate/concepts/supported-languages.md), provide it using the [translate](../../translate/api-ref/Translation/translate.md) method:

{% list tabs group=programming_language %}

- cURL {#curl}

    {% include [curl](../curl.md) %}

    {% include [bash](translate-bash.md) %}

- Python {#python}

    This example shows how to translate the following two lines of text into Russian: <q>Hello</q> and <q>World</q>. The text source language is recognized automatically.

    Create a file with the request body, e.g., `body.py`:

    ```python
    import requests

    # Parameters for authentication with an API key as a service account:
    API_KEY = "<API_key>"
    # Parameters for authentication with an IAM token:
    # IAM_TOKEN = '<IAM_token>'
    folder_id = "<folder_ID>"
    target_language = "ru"
    texts = ["Hello", "World"]

    body = {
        "targetLanguageCode": target_language,
        "texts": texts,
        "folderId": folder_id,
    }

    headers = {
        "Content-Type": "application/json",
        # Parameters for authentication with an API key as a service account:
        "Authorization": "Api-Key {0}".format(API_KEY),
        # Parameters for authentication with an IAM token:
        # "Authorization": "Bearer {0}".format(IAM_TOKEN)
    }

    response = requests.post(
        "https://translate.{{ api-host }}/translate/v2/translate",
        json=body,
        headers=headers,
    )

    print(response.text)
    ```

    Where:

    * {% include [api-key-legend-desc](./api-key-legend-desc.md) %}
    * `folder_id`: Folder [ID](../../resource-manager/operations/folder/get-id.md) you got [before you started](#before-begin).
    * `target_language`: Target [language](../../translate/concepts/supported-languages.md). You can get the language code together with a [list of supported languages](../../translate/operations/list.md).
    * `texts`: Text to translate, as a list of strings.

    You can save your API key to a file. In which case specify the file path in the `key_path` variable:

    {% cut "**body.py**" %}

    ```python
    import os
    import requests

    # Parameters for authentication with an API key as a service account:
    key_path = "<API_key_file_path>"
    # Parameters for authentication with an IAM token:
    # token_path = '<IAM_token_file_path>'
    folder_id = "<folder_ID>"
    target_language = "ru"
    texts = ["Hello", "World"]

    # Parameters for authentication with an API key as a service account:
    API_KEY = os.path.join(os.getcwd(), key_path)
    with open(API_KEY) as f:
        API_KEY = f.read().strip()
    # Parameters for authentication with an IAM token:
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
        # Parameters for authentication with an API key as a service account:
        "Authorization": "Api-Key {0}".format(API_KEY),
        # Parameters for authentication with an IAM token:
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

    This example shows how to translate the following two lines of text into Russian: _Hello_ and _World_. The source language of a text is recognized automatically.

    Create a file with the request body, e.g., `body.php`:

    ```php
    <?php

    // Parameters for authentication with an API key as a service account:
    $API_KEY = '<API_key>';
    // Parameters for authentication with an IAM token:
    // $IAM_TOKEN = '<IAM_token>';
    $folder_id = '<folder_ID>';
    $target_language = 'ru';
    $texts = ["Hello", "World"];

    $url = 'https://translate.{{ api-host }}/translate/v2/translate';

    $headers = [
        'Content-Type: application/json',
        // Parameters for authentication with an API key as a service account:
        "Authorization: Api-Key $API_KEY"
        // Parameters for authentication with an IAM token:
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

    Where: 

    * {% include [api-key-legend-desc](./api-key-legend-desc.md) %}
    * `folder_id`: Folder [ID](../../resource-manager/operations/folder/get-id.md) you got [before you started](#before-begin).
    * `target_language`: Target [language](../../translate/concepts/supported-languages.md). You can get the language code together with a [list of supported languages](../../translate/operations/list.md).
    * `texts`: Text to translate as an array of strings.

    You can save your API key to a file. In which case specify the file path in the `key_path` variable:

    {% cut "**body.php**" %}

    ```php
    <?php

    // Parameters for authentication with an API key as a service account:
    $key_path = '<API_key_file_path>';
    // Parameters for authentication with an IAM token:
    // $token_path = '<IAM_token_file_path>';
    $folder_id = '<folder_ID>';
    $target_language = 'ru';
    $texts = ["Hello", "World"];

    $url = 'https://translate.{{ api-host }}/translate/v2/translate';

    // Parameters for authentication with an API key as a service account:
    $API_KEY = trim(file_get_contents(realpath($key_path)));
    // Parameters for authentication with an IAM token:
    // $IAM_TOKEN = trim(file_get_contents(realpath($token_path)));

    $headers = [
        'Content-Type: application/json',
        // Parameters for authentication with an API key as a service account:
        "Authorization: Api-Key $API_KEY"
        // Parameters for authentication with an IAM token:
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
