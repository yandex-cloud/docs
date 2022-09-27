# Распознавание речи в формате LPCM 

Пример показывает, как с помощью [API v2](transcribation-api.md) распознать речь, записанную в аудиофайле формата LPCM, в режиме асинхронного распознавания.


В примере заданы следующие параметры:

* [язык](../index.md#langs) — русский;
* [языковая модель](../models.md) — `general:rc`;
* формат передаваемого аудиофайла — [LPCM](../../formats.md#LPCM) с частотой дискретизации 8000 Гц;
* [количество аудиоканалов](transcribation-api.md#sendfile-params) — 1 (значение по умолчанию);
* остальные параметры оставлены по умолчанию.

{% note info %}

Чтобы использовать значение параметра по умолчанию, не передавайте этот параметр в запросе.

{% endnote %}

Формирование и отправка запроса к серверу, выполняющему распознавание, происходит с помощью утилиты [cURL](https://curl.haxx.se).

Аутентификация происходит от имени сервисного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Подробнее об [аутентификации в API {{speechkit-name}}](../../concepts/auth.md).

{% list tabs %}

- cURL

  1. Создайте файл, например `body.json`, и добавьте в него следующий код:

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

      Где:

      * `languageCode` — [язык](../index.md#langs), для которого будет выполнено распознавание.
      * `model` — [языковая модель](../models.md).
      * `audioEncoding` — [формат](../../formats.md) передаваемого аудиофайла.
      * `sampleRateHertz` — частота дискретизации аудиофайла.
      * `audioChannelCount` — количество аудиоканалов.
      * `uri` — ссылка на аудиофайл в {{ objstorage-name }}.

  1. Выполните созданный файл:

      ```bash
      export IAM_TOKEN=<IAM-токен>
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@body.json'"\
          https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
      ```

      Где `IAM_TOKEN` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта.

      Результат:

      ```bash
      {
          "done": false,
          "id": "e03sup6d5h1qr574ht99",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato88ehbbhqq",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Сохраните идентификатор (`id`) операции распознавания, полученный в ответе.

  1. Подождите немного, пока закончится распознавание. Одна минута одноканального аудио распознается примерно за 10 секунд.
  1. Отправьте запрос на [получение информации об операции](../../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host }}/operations/e03sup6d5h1qr574ht99
      ```
      
      Результат:

      ```bash
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
* [{#T}](../../concepts/auth.md)