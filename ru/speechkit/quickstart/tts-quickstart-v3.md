# Как синтезировать речь в {{ speechkit-short-name }} API v3

В этом разделе вы научитесь синтезировать речь из текста с помощью {{ speechkit-short-name }} [API v3](../tts-v3/api-ref/grpc/) ([gRPC](../../glossary/grpc)).

## Аутентификация для работы с API {#auth}

{% include [ai-before-beginning](../../_includes/speechkit/ai-before-beginning.md) %}

В примере ниже аутентификация выполняется от имени аккаунта на Яндексе.

## Перед началом работы {#before-you-begin}

1. Установите [утилиту grpcurl](https://github.com/fullstorydev/grpcurl#installation).
1. Установите [утилиту jq](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

   ```bash
   sudo apt update && sudo apt install jq
   ```

{% note info %}

Вы можете реализовать синтез речи в {{ speechkit-short-name }} API v3 как с помощью указанных утилит, так и другими способами.

{% endnote %}

## Преобразуйте текст в аудиофайл {#text-to-wav-file}

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
   export FOLDER_ID=<идентификатор_каталога>
   export IAM_TOKEN=<IAM-токен>
   jq . -c tts_req.json | \
   grpcurl -H "authorization: Bearer ${IAM_TOKEN}" \
           -H "x-folder-id: ${FOLDER_ID}" \
           -d @ tts.{{ api-host }}:443 speechkit.tts.v3.Synthesizer/UtteranceSynthesis | \
   jq -r '.audioChunk.data' | base64 -d > speech.wav
   ```

   Где:

   * `FOLDER_ID` — идентификатор каталога, полученный [ранее](#auth).

       Если вы используете IAM-токен сервисного аккаунта, не указывайте в запросе идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.
   * `IAM_TOKEN` — IAM-токен, полученный [ранее](#auth).
   * `speech.wav` – файл, в который будет записан ответ.

В результате в папке будет создан файл `speech.wav` с синтезированной речью.

#### См. также {#what-is-next}

* [Подробнее про API v3](../tts-v3/api-ref/grpc/)
* [Аутентификация в API](../concepts/auth.md)
* [{#T}](../tts/api/tts-examples-v3.md)
