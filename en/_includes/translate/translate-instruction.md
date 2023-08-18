## Getting started {#before-begin}

{% include [curl](../curl.md) %}

{% include [ai-before-beginning](../translate/ai-before-beginning.md) %}

{% include [bash-windows-note-single](bash-windows-note-single.md) %}

## Translate text from any language {#any-language}

To translate a text, pass it using the [translate](../../translate/api-ref/Translation/translate) method:

{% list tabs %}

- Bash

   We will translate two text strings into Russian: <q>Hello</q> and <q>World</q>. The source language of a text is recognized automatically.

   1. Create a file with the request body (for example, `body.json`).

      ```json
      {
          "folderId": "<Folder_ID>",
          "texts": ["Hello", "World"],
          "targetLanguageCode": "ru"
      }
      ```

      Where:

      * `folderId`: Folder ID received [before starting](#before-begin).
      * `texts`: Text to translate as a list of strings.
      * `targetLanguageCode`: Target language in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format. You can get the language code with a [list of supported languages](../../translate/operations/list.md).

   1. To upload the file to translate, run the command:

      {% include [translate-file](../translate/translate-file.md) %}

      Where `IAM_TOKEN` is the IAM token received [before starting](#before-begin).

      The response from the service will contain translated text:
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

   This example shows how to translate the following two lines of text into Russian: <q>Hello</q> and <q>World</q>. The source language of a text is recognized automatically.

   Create a file with the request body (for example, `body.ру`).

   ```python
   import requests

   IAM_TOKEN = '<IAM token>'
   folder_id = '<Folder_ID>'
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

   Where:

   * `IAM_TOKEN`: IAM token received [before starting](#before-begin).
   * `folder_id`: Folder ID received [before starting](#before-begin).
   * `target_language`: Target language in [ISO 639-1](https://ru.wikipedia.org/wiki/ISO_639-1) format. You can get the language code with a [list of supported languages](../../translate/operations/list.md).
   * `texts`: Text to translate as a list of strings.

   You can save your IAM token to a file. To do this, specify the file path in the `token_path` variable:

   {% cut "**body.py**" %}

   ```python
   import os
   import requests

   token_path = '<path_to_file_with_IAM_token>'
   folder_id = '<folder_ID>'
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

- PHP

   This example shows how to translate the following two lines of text into Russian: <q>Hello</q> and <q>World</q>. The source language of a text is recognized automatically.

   Create a file with the request body (for example, `body.php`).

   ```php
   <?php

   $IAM_TOKEN = '<IAM token>';
   $folder_id = '<Folder_ID>';
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

   Where:

   * `IAM_TOKEN`: IAM token received [before starting](#before-begin).
   * `folder_id`: Folder ID received [before starting](#before-begin).
   * `target_language`: Target language in [ISO 639-1](https://ru.wikipedia.org/wiki/ISO_639-1) format. You can get the language code with a [list of supported languages](../../translate/operations/list.md).
   * `texts`: Text to translate as an array of strings.

   You can save your IAM token to a file. To do this, specify the file path in the `token_path` variable:

   {% cut "**body.php**" %}

   ```php
   <?php

   $token_path = '<path_to_file_with_IAM_token>';
   $folder_id = '<folder_ID>';
   $target_language = 'ru';
   $texts = ["Hello", "World"];

   $IAM_TOKEN = trim(file_get_contents(realpath($token_path)));
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

   ?>
   ```

   {% endcut %}

{% endlist %}
