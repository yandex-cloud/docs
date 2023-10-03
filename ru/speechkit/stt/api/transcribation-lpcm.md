# Асинхронное распознавание аудиофайлов в формате LPCM

Ниже рассмотрен пример [асинхронного распознавания речи](../transcribation.md) из аудиофайла с помощью [API v2](transcribation-api.md) {{ speechkit-name }}. В примере заданы параметры:

* [язык](../models.md#languages) — русский;
* [языковая модель](../models.md#tags) — `general:rc`;
* формат передаваемого аудиофайла — [LPCM](../../formats.md#LPCM) с частотой дискретизации 8000 Гц;
* [количество аудиоканалов](transcribation-api.md#sendfile-params) — 1 (значение по умолчанию);
* остальные параметры оставлены по умолчанию.

Вы можете сформировать и отправить запрос на распознавание речи с помощью утилиты [cURL](https://curl.haxx.se).

Аутентификация происходит от имени сервисного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Подробнее об [аутентификации в API {{speechkit-name}}](../../concepts/auth.md).

## Перед началом работы {#before-you-begin}

{% include [transcribation-before-you-begin](../../../_includes/speechkit/transcribation-before-you-begin.md) %}

Если у вас нет аудиофайла формата LPCM, вы можете скачать [пример файла](https://{{ s3-storage-host }}/speechkit/speech.pcm).

## Выполните распознавание с помощью API {#recognize-using-api}

{% list tabs %}

- cURL

  1. [Получите ссылку на аудиофайл](../../../storage/operations/objects/link-for-download.md) в {{ objstorage-name }}.
  1. Создайте файл, например `body.json`, и добавьте в него код:

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
              "uri": "<ссылка_на_аудиофайл>"
          }
      }
      ```

      Где:

      * `languageCode` — [язык](../models.md#languages), для которого будет выполнено распознавание.
      * `model` — [языковая модель](../models.md#tags).
      * `audioEncoding` — [формат](../../formats.md) передаваемого аудиофайла.
      * `sampleRateHertz` — частота дискретизации аудиофайла в Гц.
      * `audioChannelCount` — количество аудиоканалов.
      * `uri` — ссылка на аудиофайл в {{ objstorage-name }}. Пример ссылки: `https://{{ s3-storage-host }}/speechkit/speech.pcm`.

         Для бакета с ограниченным доступом в ссылке присутствуют дополнительные query-параметры (после знака `?`). Эти параметры не нужно передавать в {{ speechkit-name }} — они игнорируются.

  1. Выполните созданный файл:

      ```bash
      export IAM_TOKEN=<IAM-токен_сервисного_аккаунта> && \
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@body.json"\
          https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
      ```

      Где `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта.

      Пример результата:

      ```text
      {
          "done": false,
          "id": "e03sup6d5h1qr574ht99",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato88ehbbhqq",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Сохраните идентификатор (`id`) операции распознавания, полученный в ответе.

  1. Подождите немного, пока закончится распознавание. Одна минута одноканального аудио распознается примерно за 10 секунд.
  1. Отправьте запрос на [получение информации об операции](../../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host }}/operations/<ID_операции_распознавания>
      ```

      Пример результата:

      ```text
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

{% endlist %}

#### См. также {#see-also}

* [{#T}](transcribation-api.md)
* [{#T}](transcribation-ogg.md)
* [{#T}](batch-transcribation.md)
* [{#T}](../../concepts/auth.md)
