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
`topic` | [Языковая модель](../stt/index.md#model), которую следует использовать при распознавании.<br/>Чем точнее выбрана модель, тем лучше результат распознавания. В одном запросе можно указать только одну модель.<br/>Значение параметра по умолчанию: `general`.
`lang` | Язык, для которого будет выполнено распознавание.<br/>Допустимые значения:<ul><li>`ru-RU` — русский язык,</li><li>`en-US` — английский язык.</li></ul>Значение параметра по умолчанию: `ru-RU`.<br/>Допустимые значения параметра `topic` для различных значений `lang` приведены в разделе [[!TITLE]](../stt/index.md#model).
`profanityFilter` | Параметр, регулирующий работу фильтра ненормативной лексики в распознанной речи.<br>Допустимые значения:<ul><li>`false` — ненормативная лексика не будет исключена из результатов распознавания;</li><li>`true` — ненормативная лексика будет исключена из результатов распознавания.</li></ul>Значение параметра по умолчанию: `false`.
`format` | Формат передаваемого аудио.<br/>Допустимые значения:<ul><li>`lpcm` — аудиофайл в формате [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) без WAV-заголовка. Характеристики аудио:<ul><li>Дискретизация — 8, 16 или 48 kHz в зависимости от значения параметра `sampleRateHertz`.</li><li>Разрядность квантования — 16-bit.</li><li>Порядок байтов — обратный (little-endian).</li><li>Аудиоданные хранятся как знаковые числа (signed integer).</li></ul></li><li>`oggopus` — данные закодированы с помощью аудиокодека OPUS и упакованы в контейнер OGG ([OggOpus](https://wiki.xiph.org/OggOpus)).</li></ul>Значение параметра по умолчанию: `oggopus`.
`sampleRateHertz` | Частота дискретизации передаваемого аудио.<br/>Применяется, если значение `format` равно `lpcm`. Допустимые значения:<ul><li>`48000` — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>Значение параметра по умолчанию: `48000`. 
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

### Пример запроса {#request_examples}

---

**[!TAB POST-запрос]**

```httpget
POST /speech/v1/stt:recognize/?topic=general&lang=ru-RU&folderId=<folder id> HTTP/1.1
Host: stt.api.cloud.yandex.net
Authorization: Bearer <IAM-token>
  
... (двоичное содержимое аудиофайла)
```

**[!TAB cURL]**

```httpget
export FOLDER_ID=<folder id>
export TOKEN=<IAM-token>
curl -X POST \
     -H "Authorization: Bearer ${TOKEN}" \
     -H "Transfer-Encoding: chunked" \
     --data-binary "@speech.ogg" \
     "https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderId=${FOLDER_ID}"
```

**[!TAB Python]**

```python
import urllib.request
import json
with open("speech.ogg", "rb") as f:
    data = f.read()
url = urllib.request.Request("https://stt.api.cloud.yandex.net/speech/v1/stt:recognize/?topic=general&folderId=<folder id>", data=data)
url.add_header("Authorization", "Bearer <IAM-token>")
responseData = urllib.request.urlopen(url).read().decode('UTF-8')
decodedData = json.loads(responseData)
if decodedData.get("error_code") is None:
    print(decodedData.get("result"))
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
