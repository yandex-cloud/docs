# Описание метода API

Преобразует речь из переданного аудиофайла в текст.


## HTTP-запрос {#http_request}

```
POST https://stt.api.cloud.yandex.net/speech/v1/stt:recognize
```

Используйте заголовок `"Transfer-Encoding: chunked"` для потоковой передачи данных.


## Query-параметры {#query_params}

Параметр | Описание
----- | -----
`lang` | Язык, для которого будет выполнено распознавание.<br/>Допустимые значения:<ul><li>`ru-RU` (по умолчанию) — русский язык,</li><li>`en-US` — английский язык.</li><li>`tr-TR` — турецкий язык.</li></ul>
`topic` | Языковая модель, которую следует использовать при распознавании.<br/>Чем точнее выбрана модель, тем лучше результат распознавания. В одном запросе можно указать только одну модель.<br/>[Допустимые значения](../stt/index.md#model) зависят от выбранного языка. Значение параметра по умолчанию: `general`.
`profanityFilter` | Параметр, регулирующий работу фильтра ненормативной лексики в распознанной речи.<br>Допустимые значения:<ul><li>`false` (по умолчанию) — ненормативная лексика не будет исключена из результатов распознавания;</li><li>`true` — ненормативная лексика будет исключена из результатов распознавания.</li></ul>
`format` | Формат передаваемого аудио.<br/>Допустимые значения:<ul><li>`lpcm` — аудиофайл в формате [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) без WAV-заголовка. Характеристики аудио:<ul><li>Дискретизация — 8, 16 или 48 kHz в зависимости от значения параметра `sampleRateHertz`.</li><li>Разрядность квантования — 16-bit.</li><li>Порядок байтов — обратный (little-endian).</li><li>Аудиоданные хранятся как знаковые числа (signed integer).</li></ul></li><li>`oggopus` (по умолчанию) — данные закодированы с помощью аудиокодека OPUS и упакованы в контейнер OGG ([OggOpus](https://wiki.xiph.org/OggOpus)).</li></ul>
`sampleRateHertz` | Частота дискретизации передаваемого аудио.<br/>Применяется, если значение `format` равно `lpcm`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
`folderId` | Обязательный параметр.<br/>Идентификатор вашего каталога.<br/>Для этого метода API `folderId` передается в Query параметрах, а не в теле запроса.<br/>Подробнее о том, как узнать идентификатор каталога читайте в разделе [Авторизация в API](../concepts/auth.md).


## Параметры в теле запроса {#body_params}

В теле необходимо передать двоичное содержимое аудиофайла, удовлетворяющего следующим требованиям:
1. Размер — не более 1 МБ.
1. Длительность — не более 1 минуты.
1. Количество аудиоканалов — 1.


## Ответ {#response}

Ответ содержит гипотезу распознавания.

Гипотеза распознавания — это предположение системы распознавания о том, что было произнесено.

Распознанный текст обрабатывается перед отправкой — числительные преобразуются в цифры, расставляются некоторые знаки препинания (например, дефисы) и т. д. Этот преобразованный текст и является финальным результатом распознавания, который отправляется в теле ответа.

Ответ возвращается в формате JSON.

```json
{
  "result": <гипотеза распознавания>
}
```


## Примеры {#examples}

Чтобы распознать русскую речь с помощью SpeechKit API, отправьте небольшой аудиофрагмент, например [speech.ogg](https://download.cdn.yandex.net/from/yandex.ru/tech/ru/speechkit/cloud/doc/guide/files/speech.ogg), с помощью POST-запроса.

### Пример запроса {#request_examples}

---

**[!TAB POST-запрос]**

```httpget
POST /speech/v1/stt:recognize/?topic=general&lang=ru-RU&folderId={идентификатор-каталога} HTTP/1.1
Host: stt.api.cloud.yandex.net
Authorization: Bearer <IAM-TOKEN>

... (двоичное содержимое аудиофайла)
```

**[!TAB cURL]**

```httpget
$ export FOLDER_ID=b1gvmob95yysaplct532
$ export IAM_TOKEN=CggaATEVAgA...
$ curl -X POST \
     -H "Authorization: Bearer ${IAM_TOKEN}" \
     -H "Transfer-Encoding: chunked" \
     --data-binary "@speech.ogg" \
     "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderId=${FOLDER_ID}"
```

**[!TAB Python]**

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

url = urllib.request.Request("https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?%s" % params, data=data)
url.add_header("Authorization", "Bearer %s" % IAM_TOKEN)
url.add_header("Transfer-Encoding", "chunked")

responseData = urllib.request.urlopen(url).read().decode('UTF-8')
decodedData = json.loads(responseData)

if decodedData.get("error_code") is None:
    print(decodedData.get("result"))
```

**[!TAB PHP]**

```php
<?php

$token = 'CggaATEVAgA...'; # IAM-токен
$folderId = "b1gvmob95yysaplct532"; # Идентификатор каталога
$audioFileName = "speech.ogg";

$file = fopen($audioFileName, 'rb');

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?lang=ru-RU&folderId=${folderId}&format=oggopus");
curl_setopt($ch, CURLOPT_HTTPHEADER, array('Authorization: Bearer ' . $token, 'Transfer-Encoding: chunked'));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
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

---

### Пример ответа {#response_examples}

```
HTTP/1.1 200 OK
YaCloud-Billing-Units: 15
{
  "result": "твой номер 212-85-06"
}
```
