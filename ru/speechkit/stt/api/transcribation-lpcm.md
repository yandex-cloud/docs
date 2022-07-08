# Распознавание речи в формате LPCM 

Чтобы распознать речь в формате [LPCM](../../formats.md#lpcm), в настройках распознавания укажите частоту дискретизации файла и количество аудиоканалов. Язык распознавания укажите в поле `languageCode`, языковую модель задайте в поле `model`.

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

1. Сформируйте тело запроса и сохраните его в файл, например `body.json`:

   {% note info %}

   Чтобы использовать языковую модель по умолчанию, не передавайте поле `model` в запросе.

   {% endnote %}

    ```json
    {
        "config": {
            "specification": {
                "languageCode": "ru-RU",
                "model": "general:rc",
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

1. Отправьте запрос на распознавание, в параметре `IAM_TOKEN` укажите [IAM-токен](../../../iam/concepts/authorization/iam-token/):

    ```bash
    export IAM_TOKEN=<IAM-токен>
    curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize

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
1. Отправьте запрос на [получение информации об операции](../../../api-design-guide/concepts/operation.md#monitoring):

    ```bash
    curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        https://operation.{{ api-host }}/operations/e03sup6d5h1qr574ht99

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