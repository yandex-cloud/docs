# Распознавание коротких аудио

Распознавание коротких аудио отличается быстрой скоростью ответа и подходит для одноканального аудио небольшого размера.

Если вы хотите распознавать речь в рамках одного соединения, используйте [потоковый режим](streaming.md). В потоковом режиме вы сможете получать промежуточные результаты распознавания.

## Требования к аудио {#Audio-requirements}

Передаваемое аудио должно соответствовать требованиям:

1. Максимальный размер файла — {{ stt-short-fileSize }}.
1. Максимальная длительность — {{ stt-short-audioLength }}.
1. Максимальное количество аудиоканалов — {{ stt-short-channelsCount }}.

Если ваш файл больше, длиннее или у него больше аудиоканалов, используйте [распознавание длинных аудио](transcribation.md).

## HTTP-запрос {#http_request}

```
POST https://stt.api.cloud.yandex.net/speech/v1/stt:recognize
```

Используйте заголовок `"Transfer-Encoding: chunked"` для потоковой передачи данных.


### Query-параметры {#query_params}

Параметр | Описание
----- | -----
lang | **string**<br>Язык, для которого будет выполнено распознавание.<br/>Допустимые значения:<ul><li>`ru-RU` (по умолчанию) — русский язык,</li><li>`en-US` — английский язык.</li><li>`tr-TR` — турецкий язык.</li></ul>
topic | **string**<br>Языковая модель, которую следует использовать при распознавании.<br/>Чем точнее выбрана модель, тем лучше результат распознавания. В одном запросе можно указать только одну модель.<br/>[Допустимые значения](../stt/models.md) зависят от выбранного языка. Значение параметра по умолчанию: `general`.
profanityFilter | **boolean**<br>Параметр, регулирующий работу фильтра ненормативной лексики в распознанной речи.<br>Допустимые значения:<ul><li>`false` (по умолчанию) — ненормативная лексика не будет исключена из результатов распознавания;</li><li>`true` — ненормативная лексика будет исключена из результатов распознавания.</li></ul>
format | **string**<br>[Формат](formats.md) передаваемого аудио.<br/>Допустимые значения:<ul><li>`lpcm` — [LPCM без WAV-заголовка](formats.md#lpcm).</li><li>`oggopus` (по умолчанию) — [OggOpus](formats.md#oggopus).</li></ul>
sampleRateHertz | **string**<br>Частота дискретизации передаваемого аудио.<br/>Применяется, если значение `format` равно `lpcm`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
folderId | **string**<br><p>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p>


### Параметры в теле запроса {#body_params}

В теле необходимо передать двоичное содержимое аудиофайла.

## Ответ {#response}

Распознанный текст возвращается в ответе в поле `result`.

```json
{
  "result": <распознанный текст>
}
```


## Примеры {#examples}

Чтобы распознать русскую речь, отправьте аудиофрагмент, например [speech.ogg](https://download.cdn.yandex.net/from/yandex.ru/tech/ru/speechkit/cloud/doc/guide/files/speech.ogg).

### Пример запроса {#request_examples}

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
  $ export FOLDER_ID=b1gvmob95yysaplct532
  $ export IAM_TOKEN=CggaATEVAgA...
  $ curl -X POST \
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

### Пример ответа {#response_examples}

```
HTTP/1.1 200 OK
YaCloud-Billing-Units: 15
{
  "result": "твой номер 212-85-06"
}
```
