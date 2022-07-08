# Примеры использования API синхронного распознавания

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

## Пример запроса {#request_examples}

Выполните запрос, указав в параметрах [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) и [IAM-токен](../../../iam/concepts/authorization/iam-token.md) для авторизации:

{% list tabs %}

- POST-запрос

  ```httpget
  POST /speech/v1/stt:recognize?topic=general&lang=ru-RU&folderId={<идентификатор каталога>} HTTP/1.1
  Host: stt.{{ api-host }}
  Authorization: Bearer <IAM-токен>

  ... (двоичное содержимое аудиофайла)
  ```

- cURL

  ```httpget
  export FOLDER_ID=<идентификатор каталога>
  export IAM_TOKEN=<IAM-токен>
  curl -X POST \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       -H "Transfer-Encoding: chunked" \
       --data-binary "@speech.ogg" \
       "https://stt.{{ api-host }}/speech/v1/stt:recognize?topic=general&folderId=${FOLDER_ID}"
  ```

- Python 3

  ```python
  import urllib.request
  import json

  FOLDER_ID = "<идентификатор каталога>" # Идентификатор каталога
  IAM_TOKEN = "<IAM-токен>" # IAM-токен

  with open("speech.ogg", "rb") as f:
      data = f.read()

  params = "&".join([
      "topic=general",
      "folderId=%s" % FOLDER_ID,
      "lang=ru-RU"
  ])

  url = urllib.request.Request("https://stt.{{ api-host }}/speech/v1/stt:recognize?%s" % params, data=data)
  url.add_header("Authorization", "Bearer %s" % IAM_TOKEN)

  responseData = urllib.request.urlopen(url).read().decode('UTF-8')
  decodedData = json.loads(responseData)

  if decodedData.get("error_code") is None:
      print(decodedData.get("result"))
  ```

- PHP

  ```php
  <?php

  $token = '<IAM-токен>'; # IAM-токен
  $folderId = "<идентификатор каталога>"; # Идентификатор каталога
  $audioFileName = "speech.ogg";

  $file = fopen($audioFileName, 'rb');

  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "https://stt.{{ api-host }}/speech/v1/stt:recognize?lang=ru-RU&folderId=${folderId}&format=oggopus");
  curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $token, 'Transfer-Encoding: chunked'));
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  curl_setopt($ch, CURLOPT_POST, true);
  curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
  curl_setopt($ch, CURLOPT_BINARYTRANSFER, true);

  curl_setopt($ch, CURLOPT_INFILE, $file);
  curl_setopt($ch, CURLOPT_INFILESIZE, filesize($audioFileName));
  $res = curl_exec($ch);
  curl_close($ch);
  $decodedResponse = json_decode($res, true);
  if (isset($decodedResponse["result"])) {
      echo $decodedResponse["result"];
  } else {
      echo "Error code: " . $decodedResponse["error_code"] . "\r\n";
      echo "Error message: " . $decodedResponse["error_message"] . "\r\n";
  }

  fclose($file);
  ```

{% endlist %}

## Пример ответа {#response_examples}

```
HTTP/1.1 200 OK
YaCloud-Billing-Units: 15
{
  "result": "твой номер 212-85-06"
}
```