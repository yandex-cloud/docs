# Примеры использования API синхронного распознавания

## Пример запроса {#request_examples}

{% list tabs %}

- POST-запрос

  ```httpget
  POST /speech/v1/stt:recognize?topic=general&lang=ru-RU&folderId={идентификатор-каталога} HTTP/1.1
  Host: stt.api.cloud.yandex.net
  Authorization: Bearer <IAM-TOKEN>

  ... (двоичное содержимое аудиофайла)
  ```

- cURL

  ```httpget
  export FOLDER_ID=b1gvmob95yysaplct532
  export IAM_TOKEN=CggaATEVAgA...
  curl -X POST \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       -H "Transfer-Encoding: chunked" \
       --data-binary "@speech.ogg" \
       "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?topic=general&folderId=${FOLDER_ID}"
  ```

- Python 3

  ```python
  import urllib.request
  import json

  FOLDER_ID = "b1gvmob95yysaplct532" # Идентификатор каталога
  IAM_TOKEN = "CggaATEVAgA..." # IAM-токен

  with open("speech.ogg", "rb") as f:
      data = f.read()

  params = "&".join([
      "topic=general",
      "folderId=%s" % FOLDER_ID,
      "lang=ru-RU"
  ])

  url = urllib.request.Request("https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?%s" % params, data=data)
  url.add_header("Authorization", "Bearer %s" % IAM_TOKEN)

  responseData = urllib.request.urlopen(url).read().decode('UTF-8')
  decodedData = json.loads(responseData)

  if decodedData.get("error_code") is None:
      print(decodedData.get("result"))
  ```

- PHP

  ```php
  <?php

  $token = 'CggaATEVAgA...'; # IAM-токен
  $folderId = "b1gvmob95yysaplct532"; # Идентификатор каталога
  $audioFileName = "speech.ogg";

  $file = fopen($audioFileName, 'rb');

  $ch = curl_init();
  curl_setopt($ch, CURLOPT_URL, "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize?lang=ru-RU&folderId=${folderId}&format=oggopus");
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