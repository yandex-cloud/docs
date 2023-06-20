# Как распознать потоковое аудио в {{ speechkit-short-name }}

В этом разделе вы научитесь использовать {{ speechkit-short-name }} [API v3]((../../stt-v3/api-ref/grpc/)) для распознавания речи в режиме реального времени из готового файла в формате [LPCM](../formats.md#LPCM).

Работа с API выполняется с помощью утилиты `grpcurl`.

## Перед началом работы {#before-you-begin}

1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. Установите [утилиту grpcurl](https://github.com/fullstorydev/grpcurl#installation).
1. Установите [утилиту jq](https://stedolan.github.io/jq/) для потоковой обработки JSON-файлов:

   ```bash
   sudo apt update && sudo apt install jq
   ```

{% note info %}

Вы можете реализовать распознавание потокового аудио в {{ speechkit-short-name }} как с помощью указанных утилит, так и другими способами.

{% endnote %}

1. Скачайте [пример](https://{{ s3-storage-host }}/speechkit/speech.pcm) аудиофайла для распознавания.

## Распознавание речи {#speech-recognition}

Чтобы распознать речь из файла в [потоковом режиме](../stt/streaming.md):

1. Перейдите в директорию со склонированным репозиторием {{ yandex-cloud }} API и создайте в ней рабочие файлы:

   * Файл c инициирующей частью потоковых запросов к API:

     {% cut "stt_req.json" %}

     ```json
     {
        "sessionOptions": {
          "recognitionModel": {
              "audioFormat": {
                  "rawAudio": {
                      "audioEncoding": "LINEAR16_PCM",
                      "sampleRateHertz": 8000,
                      "audioChannelCount": 1
                  }
              },
              "textNormalization": {
                  "textNormalization": "TEXT_NORMALIZATION_ENABLED",
                  "profanityFilter": true,
                  "literatureText": false
              },
              "languageRestriction": {
                  "restrictionType": "WHITELIST",
                  "languageCode": [
                      "ru-RU"
                  ]
              },
              "audioProcessingType": "REAL_TIME"
          }
        }
     }
     ```

     {% endcut %}

     Части потокового аудио дописываются в файл с помощью скрипта ниже.

   * Скрипт для распознавания речи:

     {% cut "script.sh" %}

     ```bash
     split -d -b 4000 <путь к аудиофайлу> part
     for i in $(ls part*)
     do
       base64 $i -o $i.bb
       DATA=$(cat "$i".bb)
       jq -n --arg data $DATA '{"chunk":{"data":$data}}' >> stt_req.json
     done
     rm part*
     jq . -c stt_req_full.json | \
     grpcurl -H "authorization: Bearer ${IAM_TOKEN}" \
         -H "x-folder-id: ${FOLDER_ID}" \
         -d @ \
         -proto yandex/cloud/ai/stt/v3/stt_service.proto \
         stt.api.cloud.yandex.net:443 speechkit.stt.v3.Recognizer/RecognizeStreaming | \
     jq -r '
         if .finalRefinement != null then
           .finalRefinement.normalizedText.alternatives[0].text
         elif .partial != null then
           .partial.alternatives[0].text
         elif .final != null then
           .final.alternatives[0].text
         else
           .audioCursors.finalIndex end'
     ```

     {% endcut %}

1. Выполните команды:

   ```bash
   export FOLDER_ID=<идентификатор каталога>
   export IAM_TOKEN=<IAM-токен>
   chmod 755 script.sh
   ./script.sh
   ```

   Где:

   * `FOLDER_ID` — идентификатор каталога, полученный [перед началом работы](index.md#before-you-begin). Если вы используете IAM-токен сервисного аккаунта, не указывайте в запросе идентификатор каталога — сервис использует каталог, в котором был создан сервисный аккаунт.
   * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](index.md#before-you-begin).

  Будет выведен распознанный текст с промежуточными и окончательными результатами распознавания:

  ```text
  null
  привет
  привет
  привет мир
  Привет мир
  null
  null
  1
  ```

#### См. также {#what-is-next}

* [Подробнее про API v3](../../stt-v3/api-ref/grpc/)
* [Аутентификация в API](../concepts/auth.md)
* [{#T}](../stt/models.md)
* [{#T}](../stt/api/streaming-examples-v3.md)
