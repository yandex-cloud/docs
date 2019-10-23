# Распознавание длинных аудио

Распознавание длинных аудио подходит для многоканальных аудиофайлов до {{ stt-long-fileSize }}.

Распознавание длинных аудио немного дешевле других [способов распознавания](./index.md#stt-ways), однако не подходит в сценариях распознавания речи онлайн — время ответа больше. Подробнее о стоимости в разделе [{#T}](../pricing.md).

{% note info %}

Сейчас вы можете распознавать длинные аудио только на русском языке.

{% endnote %}

## Перед началом

1. Запрос на распознавание необходимо отправлять от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md). Если у вас еще нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).
1. Убедитесь, что у сервисного аккаунта есть доступ к каталогу, в котором он создан.
1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md) или [API-ключ](../../iam/operations/api-key/create.md) для вашего сервисного аккаунта. В примерах для аутентификации используется IAM-токен.

    Чтобы использовать API-ключ, передайте его в заголовке `Authorization` в следующем формате:
    ```
    Authorization: Api-Key <API-ключ>
    ```
1. Загрузите аудиофайл в сервис {{ objstorage-full-name }} и получите ссылку на загруженный файл:

    1. Если у вас еще нет бакета в {{ objstorage-name }}, [создайте](../../storage/operations/buckets/create.md) его.
    1. [Загрузите аудиофайл](../../storage/operations/objects/upload.md) в ваш бакет. В терминах {{ objstorage-name }} загружаемые файлы называются _объектами_.
    1. [Получите ссылку](../../storage/operations/objects/link-for-download.md) на загруженный файл. Используйте эту ссылку в запросе на распознавание аудио.

        Ссылка на загруженный файл имеет вид:
        ```
        https://{{ s3-storage-host }}/<имя-бакета>/<путь-к-файлу>
        ```

        Для бакета с ограниченным доступом в ссылке будут дополнительные query-параметры (после знака `?`). В {{ speechkit-name }} эти параметры не надо передавать — они игнорируются.

## Отправить файл на распознавание

Отправьте файл на распознавание с помощью POST-запроса:

### HTTP-запрос

```
POST https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize
```

### Параметры в теле запроса

```json
{
    "config": {
        "specification": {
            "languageCode": "string",
            "profanityFilter": "string",
            "audioEncoding": "string",
            "sampleRateHertz": "integer",
            "audioChannelCount": "integer"
        }
    },
    "audio": {
        "uri": "string"
    }
}
```

Параметр | Описание
----- | -----
config | **object**<br>Поле с настройками распознавания.
config.<br>specification | **object**<br>Настройки распознавания.
config.<br>specification.<br>languageCode | **string**<br>Язык, для которого будет выполнено распознавание.<br/>Сейчас поддерживается только русский язык — `ru-RU`.
config.<br>specification.<br>profanityFilter | **boolean**<br>Фильтр ненормативной лексики.<br/>Допустимые значения:<ul><li>`true` — исключать ненормативную лексику из результатов распознавания.</li><li>`false` (по умолчанию) — не исключать ненормативную лексику.</li></ul>
config.<br>specification.<br>audioEncoding | **string**<br>[Формат](formats.md) передаваемого аудио.<br/>Допустимые значения:<ul><li>`LINEAR16_PCM` — [LPCM без WAV-заголовка](formats.md#lpcm).</li><li>`OGG_OPUS` (по умолчанию) — формат [OggOpus](formats.md#oggopus).</li></ul>
config.<br>specification.<br>sampleRateHertz | **integer** (int64)<br>Частота дискретизации передаваемого аудио.<br/>Этот параметр обязателен, если значение `format` равно `LINEAR16_PCM`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
config.<br>specification.<br>audioChannelCount | **integer** (int64)<br>Количество каналов для файлов в [формате LPCM](formats.md#lpcm). По умолчанию используется значение `1`.<br>Не используйте это поле для файлов в формате [OggOpus](formats.md#oggopus).
config.<br>specification.<br>raw_results | **boolean** <br>Флаг, указывающий, как писать числа. `true` — писать прописью, `false` (по умолчанию) — писать цифрами.
audio.<br>uri | **string**<br>URI аудиофайла для распознавания. Поддерживаются только ссылки на файлы, которые хранятся в [Yandex Object Storage](/docs/storage/).

### Ответ

Если запрос был составлен правильно, сервис возвращает [объект Operation](../../api-design-guide/concepts/operation.md), в котором содержится идентификатор операции распознавания (`id`):

```json
{
 "done": false,
 "id": "e03sup6d5h7rq574ht8g",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato88ehbbhqq",
 "modifiedAt": "2019-04-21T22:49:29Z"
}
```

Используйте полученный идентификатор на следующем шаге.

## Получить результаты распознавания

[Проверяйте результаты распознавания](../../api-design-guide/concepts/operation.md#monitoring), используя полученный идентификатор. Количество запросов на проверку результатов [ограничено](../concepts/limits.md), поэтому учитывайте скорость распознавания: 1 минута одноканального аудио распознается примерно за 10 секунд.

{% note important %}

Результаты распознавания хранятся на сервере {{ stt-long-resultsStorageTime }}. После этого вы не сможете запросить результаты распознавания используя полученный идентификатор.

{% endnote %}

### HTTP-запрос

```
GET https://operation.api.cloud.yandex.net/operations/{operationId}
```

### Path-параметры

Параметр | Описание
----- | -----
operationId | Идентификатор операции, полученный при отправке запроса на распознавание.

### Ответ

Когда распознавание будет закончено, значение поля `done` будет `true`, а в поле `response` будет список результатов распознавания `chunks[]`.

Каждый результат в `chunks[]` содержит поля:

* `alternatives[]` - список вариантов распознанного текста. Каждый вариант содержит поля:
    * `words[]` - список распознанных слов.
      * `startTime` — временная отметка начала слова на аудиозаписи. Возможна погрешность в пределах 1-2 секунд.
      * `endTime` — временная отметка конца слова. Возможна погрешность в пределах 1-2 секунд.
      * `word` — распознанное слово. Распознанные числа пишутся прописью, например не `12`, а `двенадцать`.
      * `condfidence` - достоверность определения. Сейчас сервис всегда возвращает значение `1`, которое эквивалентно 100%.
    * `text` - распознанный текст целиком.
      По умолчанию числа пишутся цифрами. Чтобы весь текст был прописью, укажите `true` в поле `raw_results`.
    * `confidence` - достоверность определения. Сейчас сервис всегда возвращает значение `1`, которое эквивалентно 100%.
* `channelTag` - аудиоканал, для которого выполнено распознавание.

```json
{
 "done": true,
 "response": {
  "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
  "chunks": [
   {
    "alternatives": [
     {
      "words": [
       {
        "startTime": "0.879999999s",
        "endTime": "1.159999992s",
        "word": "при",
        "confidence": 1
       },
       {
        "startTime": "1.219999995s",
        "endTime": "1.539999988s",
        "word": "написании",
        "confidence": 1
       },
       ...
      ],
      "text": "при написании хоббита толкин обращался к мотивам скандинавской мифологии древней английской поэмы беовульф",
      "confidence": 1
     }
    ],
    "channelTag": "1"
   },
   ...
  ]
 },
 "id": "e03sup6d5h7rq574ht8g",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato88ehbbhqq",
 "modifiedAt": "2019-04-21T22:49:36Z"
}
```

## Примеры {#examples}

* [{#T}](#examples_ogg)
* [{#T}](#examples_lpcm)

### Распознать русскую речь в формате OggOpus {#examples_ogg}

Чтобы распознать речь в формате [OggOpus](formats.md#oggopus), достаточно указать в конфигурации язык распознавания в поле `languageCode`.

{% list tabs %}

- cURL
  1. Сформируйте тело запроса и сохраните его в файл, например `body.json`. Ссылку на аудиофайл в {{ objstorage-name }} укажите в поле `uri`:

      ```json
      {
          "config": {
              "specification": {
                  "languageCode": "ru-RU"
              }
          },
          "audio": {
              "uri": "https://storage.yandexcloud.net/speechkit/speech.ogg"
          }
      }
      ```
  1. Отправьте запрос на распознавание:
      ```bash
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d @body.json \
          https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize

      {
          "done": false,
          "id": "e03sup6d5h1qr574ht99",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato88ehbbhqq",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Сохраните идентификатор операции распознавания, полученный в ответе.
  1. Подождите немного, пока закончится распознавание. 1 минута одноканального аудио распознается примерно за 10 секунд.
  1. Отправьте запрос на [получение информации об операции](../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.api.cloud.yandex.net/operations/e03sup6d5h1qr574ht99

      {
       "done": true,
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
        "chunks": [
         {
          "alternatives": [
           {
            "text": "твой номер 212-85-06",
            "confidence": 1
           }
          ],
          "channelTag": "1"
         }
        ]
       },
       "id": "e03sup6d5h1qr574ht99",
       "createdAt": "2019-04-21T22:49:29Z",
       "createdBy": "ajes08feato88ehbbhqq",
       "modifiedAt": "2019-04-21T22:49:36Z"
      }
      ```

- Python

  1. [Создайте API-ключ](../../iam/operations/api-key/create.md), используемый для аутентификации в этом примере. Чтобы использовать IAM-токен для аутентификации, исправьте заголовок в переменной `header`: замените `Api-Key` на `Bearer` и добавьте код, для [получения IAM-токена](../../iam/operations/iam-token/create-for-sa.md) вместо API-ключа.
  1. Создайте Python-файл, например `test.py`, и добавьте в него следующий код:

      ```python
      # -*- coding: utf-8 -*-

      import requests
      import time
      import json

      # Укажите ваш API-ключ и ссылку на аудиофайл в Object Storage.
      key = '<API key>'
      filelink = 'https://storage.yandexcloud.net/speechkit/speech.ogg'

      POST = "https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize"

      body ={
          "config": {
              "specification": {
                  "languageCode": "ru-RU"
              }
          },
          "audio": {
              "uri": filelink
          }
      }

      # Если вы хотите использовать IAM-токен для аутентификации, замените Api-Key на Bearer.
      header = {'Authorization': 'Api-Key {}'.format(key)}

      # Отправить запрос на распознавание.
      req = requests.post(POST, headers=header, json=body)
      data = req.json()
      print(data)

      id = data['id']

      # Запрашивать на сервере статус операции, пока распознавание не будет завершено.
      while True:

          time.sleep(1)

          GET = "https://operation.api.cloud.yandex.net/operations/{id}"
          req = requests.get(GET.format(id=id), headers=header)
          req = req.json()

          if req['done']: break
          print("Not ready")

      # Показать полный ответ сервера в формате JSON.
      print("Response:")
      print(json.dumps(req, ensure_ascii=False, indent=2))

      # Показать только текст из результатов распознавания.
      print("Text chunks:")
      for chunk in req['response']['chunks']:
          print(chunk['alternatives'][0]['text'])
      ```
  1. Выполните созданный файл:

      ```bash
      $ python test.py
      ```
{% endlist %}

### Распознать речь в формате LPCM {#examples_lpcm}

Чтобы распознать речь в формате [LPCM](formats.md#lpcm) в настройках распознавания укажите частоту дискретизации файла и количество аудиоканалов. Язык распознавания укажите в поле `languageCode`.

1. Сформируйте тело запроса и сохраните его в файл, например `body.json`:

    ```json
    {
        "config": {
            "specification": {
                "languageCode": "ru-RU",
                "audioEncoding": "LINEAR16_PCM",
                "sampleRateHertz": 8000,
                "audioChannelCount": 1
            }
        },
        "audio": {
            "uri": "https://storage.yandexcloud.net/speechkit/speech.pcm"
        }
    }
    ```
1. Отправьте запрос на распознавание:
    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d @body.json \
        https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize

    {
        "done": false,
        "id": "e03sup6d5h1qr574ht99",
        "createdAt": "2019-04-21T22:49:29Z",
        "createdBy": "ajes08feato88ehbbhqq",
        "modifiedAt": "2019-04-21T22:49:29Z"
    }
    ```

    Сохраните идентификатор операции распознавания, полученный в ответе.
1. Подождите немного, пока закончится распознавание. 1 минута одноканального аудио распознается примерно за 10 секунд.
1. Отправьте запрос на [получение информации об операции](../../api-design-guide/concepts/operation.md#monitoring):

    ```bash
    $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        https://operation.api.cloud.yandex.net/operations/e03sup6d5h1qr574ht99

    {
    "done": true, "response": {
     "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
     "chunks": [
      {
       "alternatives": [
        {
         "text": "привет мир",
         "confidence": 1
        }
       ],
       "channelTag": "1"
      }
     ]
    },
    "id": "e03sup6d5h1qr574ht99",
    "createdAt": "2019-04-21T22:49:29Z",
    "createdBy": "ajes08feato88ehbbhqq",
    "modifiedAt": "2019-04-21T22:49:36Z"
   }
    ```
