## Before you start {#before-begin}

{% include [curl](../curl.md) %}

{% include [ai-before-beginning](../translate/ai-before-beginning.md) %}

## Translate text from any language {#any-language}

To translate a text, pass it using the [translate](../../translate/api-ref/Translation/translate) method:

{% list tabs %}

- CLI

   This example shows how to translate the following two lines of text into Russian: <q>Hello</q> and <q>World</q>. The source language of a text is recognized automatically.

   1. Create a file with the request body (for example, `body.json`).

      ```json
      {
          "folderId": "<Folder ID>",
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

      Where `IAM_TOKEN`: IAM token received [before starting](#before-begin).

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

   IAM_TOKEN = '<IAM-токен>'
   folder_id = '<Folder ID>'
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

   * `folder_id`: Folder ID received [before starting](#before-begin).
   * `texts`: Text to translate as a list of strings.
   * `target_language`: Target language in [ISO 639-1](https://ru.wikipedia.org/wiki/ISO_639-1) format. You can get the language code with a [list of supported languages](../../translate/operations/list.md).
   * `IAM_TOKEN`: IAM token received [before starting](#before-begin).

- PHP

   This example shows how to translate the following two lines of text into Russian: <q>Hello</q> and <q>World</q>. The source language of a text is recognized automatically.

   Create a file with the request body (for example, `body.php`).

   ```php
   $IAM_TOKEN = '<IAM-токен>';
   $folder_id = '<Folder ID>';
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

   Where:

   * `folder_id`: Folder ID received [before starting](#before-begin).
   * `texts`: Text to translate as a list of strings.
   * `target_language`: Target language in [ISO 639-1](https://ru.wikipedia.org/wiki/ISO_639-1) format. You can get the language code with a [list of supported languages](../../translate/operations/list.md).
   * `IAM_TOKEN`: IAM token received [before starting](#before-begin).

{% endlist %}
