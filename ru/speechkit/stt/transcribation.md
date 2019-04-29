# Распознавание длинных аудиофайлов

_Распознавание длинных аудиофайлов находится на [стадии Preview](../../overview/concepts/launch-stages)._

## Требования к аудиофайлу

Сервис [!KEYREF speechkit-name] позволяет распознавать многоканальные аудиофайлы до [!KEYREF stt-long-fileSize].

Также ознакомьтесь с [поддерживаемыми форматами](formats.md).

## Перед началом

1. Запрос на распознавание необходимо отправлять от имени [сервисного аккаунта](../../iam/concepts/users/service-accounts.md)! Если у вас еще нет сервисного аккаунта, [создайте его](../../iam/operations/sa/create.md).
1. Убедитесь, что у сервисного аккаунта есть доступ к каталогу, в котором он создан. Если вы хотите использовать другой каталог для авторизации, необходимо будет указать идентификатор каталога в запросе.
1. [Получите IAM-токен](../../iam/operations/iam-token/create-for-sa.md) для вашего сервисного аккаунта.
1. Загрузите аудиофайл в сервис [!KEYREF objstorage-full-name] и получите ссылку на загруженный файл:
   1. Если у вас еще нет бакета в [!KEYREF objstorage-name], [создайте](../../storage/operations/buckets/create.md) его.
   1. [Загрузите аудиофайл](../../storage/operations/objects/upload.md) в ваш бакет. В терминах [!KEYREF objstorage-name] загружаемые файлы называются _объектами_.
   1. [Получите ссылку](../../storage/operations/objects/link-for-download.md) на загруженный файл. Используйте эту ссылку в запросе на распознавание аудио.

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
        },
        "folderId": "string"
    },
    "audio": {
        "uri": "string"
    }
}
```

Параметр | Описание
----- | -----
config | **object**<br>Поле с настройками распознавания и идентификатором каталога.
config.<br>specification | **object**<br>Настройки распознавания.
config.<br>specification.<br>languageCode | **string**<br>Язык, для которого будет выполнено распознавание.<br/>Допустимые значения:<ul><li>`ru-RU` (по умолчанию) — русский язык,</li><li>`en-US` — английский язык.</li><li>`tr-TR` — турецкий язык.</li></ul>
config.<br>specification.<br>profanityFilter | **boolean**<br>Фильтр ненормативной лексики.<br/>Допустимые значения:<ul><li>`true` — исключать ненормативную лексику из результатов распознавания.</li><li>`false` (по умолчанию) — не исключать ненормативную лексику.</li></ul>
config.<br>specification.<br>audioEncoding | **string**<br>[Формат](formats.md) передаваемого аудио.<br/>Допустимые значения:<ul><li>`LINEAR16_PCM` — [LPCM без WAV-заголовка](formats.md#lpcm).</li><li>`OGG_OPUS` (по умолчанию) — формат [OggOpus](formats.md#oggopus).</li></ul>
config.<br>specification.<br>sampleRateHertz | **integer** (int64)<br>Частота дискретизации передаваемого аудио.<br/>Этот параметр обязателен, если значение `format` равно `LINEAR16_PCM`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
config.<br>specification.<br>audioChannelCount | **integer** (int64)<br>Количество каналов для файлов в [формате LPCM](formats.md#lpcm). По умолчанию используется значение `1`.<br>Не используйте это поле для файлов в формате [OggOpus](formats.md#oggopus).
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

[Проверяйте результаты распознавания](../../api-design-guide/concepts/operation.md#monitoring), используя полученный идентификатор. Количество запросов на проверку результатов [ограничено](../concepts/limits.md#stt-long), поэтому учитывайте скорость распознавания: 1 минута одноканального аудио распознается примерно за 10 секунд.

> [!IMPORTANT]
>
> Результаты распознавания хранятся на сервере [!KEYREF stt-long-resultsStorageTime]. После этого вы не сможете запросить результаты распознавания используя полученный идентификатор.

### HTTP-запрос

```
GET https://operation.api.cloud.yandex.net/operations/{operationtId}
```

### Path-параметры

Параметр | Описание
----- | -----
operationtId | Идентификатор операции, полученный при отправке запроса на распознавание.

### Ответ

Когда распознавание будет закончено, значение поля `done` будет `true`, а в поле `response` будет список результатов распознавания `chunks[]`.

Каждый результат в `chunks[]` содержит поля:

* `alternatives[]` - список вариантов распознанного текста. Каждый вариант содержит поля:
    * `text` - распознанный текст.
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

* [[!TITLE]](#examples_ogg)
* [[!TITLE]](#examples_lpcm)

### Распознать русскую речь в формате OggOpus {#examples_ogg}

Чтобы распознать речь в формате [OggOpus](formats.md#oggopus), достаточно указать в конфигурации язык распознавания в поле `languageCode`. Если язык не указан, будет использован русский.

Ссылку на загруженный аудиофайл укажите в поле `uri`.

1. Сформируйте тело запроса и сохраните его в файл, например `body.json`:

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

    Сохраните идентификатор операции на распознавание, полученный в ответе.
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


### Распознать речь в формате LPCM {#examples_lpcm}

Чтобы распознать речь в формате [LPCM](formats.md#lpcm) в настройках распознавания укажите частоту дискретизации файла и количество аудиоканалов. Язык распознавания укажите в поле `languageCode`. Если язык не указан, будет использован русский.

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

    Сохраните идентификатор операции на распознавание, полученный в ответе.
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
