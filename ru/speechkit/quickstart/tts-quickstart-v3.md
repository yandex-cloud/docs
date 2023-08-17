# Как синтезировать речь в {{ speechkit-short-name }} API v3

В этом разделе вы научитесь синтезировать речь из из текста с помощью {{ speechkit-short-name }} [API v3](../tts-v3/api-ref/grpc/) (gRPC).

Работа с API выполняется с помощью утилиты `grpcurl`.

## Перед началом работы {#before-you-begin}

1. Установите [утилиту grpcurl](https://github.com/fullstorydev/grpcurl#installation).
1. Установите [утилиту jq](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

   ```bash
   sudo apt update && sudo apt install jq
   ```

{% note info %}

Вы можете реализовать синтез речи в {{ speechkit-short-name }} API v3 как с помощью указанных утилит, так и другими способами.

{% endnote %}

## Преобразуйте текст в аудио-файл {#text-to-wav-file}

Чтобы синтезировать речь из текста в [TTS-разметке](../tts/markup/tts-markup.md) в файл формата [WAV](https://ru.wikipedia.org/wiki/WAV):

1. Создайте файл c телом запроса API и текстом для синтеза речи:

   {% cut "tts_req.json" %}

   ```json
   {
    "text": "Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы — можете!",
    "outputAudioSpec": {
      "containerAudio": {
        "containerAudioType": "WAV"
      }
    },
    "hints": [
        {
            "voice": "jane"
        },
        {
            "role": "good"
        }
    ],
    "loudnessNormalizationType": "LUFS"
   }
   ```

   {% endcut %}

1. Выполните команды:

   ```bash
   export FOLDER_ID=<идентификатор каталога>
   export IAM_TOKEN=<IAM-токен>
   jq . -c tts_req.json | \
   grpcurl -H "authorization: Bearer ${IAM_TOKEN}" \
           -H "x-folder-id: ${FOLDER_ID}" \
           -d @ tts.api.cloud.yandex.net:443 speechkit.tts.v3.Synthesizer/UtteranceSynthesis | \
   jq -r '.audioChunk.data' | base64 -d > speech.wav 
   ```

   Где:

   * `FOLDER_ID` — идентификатор каталога, полученный [перед началом работы](index.md#before-you-begin). Если вы используете IAM-токен сервисного аккаунта, не указывайте в запросе идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.
   * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](index.md#before-you-begin).
   * `speech.wav` – файл, в который будет записан ответ.

В результате в директории будет создан файл `speech.wav` с синтезированной речью.

#### См. также {#what-is-next}

* [Подробнее про API v3](../../tts-v3/api-ref/grpc/)
* [Аутентификация в API](../concepts/auth.md)
* [{#T}](../tts/api/tts-examples-v3.md)
