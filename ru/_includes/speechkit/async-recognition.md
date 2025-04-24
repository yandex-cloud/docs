1. [Получите ссылку на аудиофайл](../../storage/operations/objects/link-for-download.md) в {{ objstorage-name }}.
1. Создайте файл `body.json` и добавьте в него код:

   ```json
   {
      "config": {
         "specification": {
            "languageCode": "ru-RU",
            "model": "general",
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

   * `languageCode` — [язык](../../speechkit/stt/models.md#languages), для которого будет выполнено распознавание.
   * `model` — [модель распознавания речи](../../speechkit/stt/models.md#tags).
   * `audioEncoding` — [формат](../../speechkit/formats.md) передаваемого аудиофайла.
   * `sampleRateHertz` — частота дискретизации аудиофайла в Гц.
   * `audioChannelCount` — количество аудиоканалов.
   * `uri` — ссылка на аудиофайл в {{ objstorage-name }}. Пример ссылки: `https://{{ s3-storage-host-ru }}/speechkit/speech.pcm`.

      Для бакета с ограниченным доступом в ссылке присутствуют дополнительные query-параметры (после знака `?`). Эти параметры не нужно передавать в {{ speechkit-name }} — они игнорируются.

1. Выполните созданный файл:

   ```bash
   export API_KEY=<API-ключ_сервисного_аккаунта> && \
   curl \
     --insecure \
     --header "Authorization: Api-Key ${API_KEY}" \
     --data "@body.json"\
     https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
   ```

   Пример результата:

   ```text
   {
      "done": false,
      "id": "e03sup6d5h1q********",
      "createdAt": "2019-04-21T22:49:29Z",
      "createdBy": "ajes08feato8********",
      "modifiedAt": "2019-04-21T22:49:29Z"
   }
   ```

   Сохраните идентификатор (`id`) операции распознавания, полученный в ответе.

1. Дождитесь, когда завершится распознавание. Одна минута одноканального аудио распознается примерно за 10 секунд.
1. Отправьте запрос на [получение информации об операции](../../api-design-guide/concepts/operation.md#monitoring):

   ```bash
   curl \
     --insecure \
     --header "Authorization: Api-key ${API_KEY}" \
     https://operation.{{ api-host }}/operations/<идентификатор_операции_распознавания>
   ```

   Пример результата:

   ```text
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
                           "startTime": "0.160s",
                           "endTime": "0.500s",
                           "word": "привет",
                           "confidence": 1
                        },
                        {
                           "startTime": "0.580s",
                           "endTime": "0.800s",
                           "word": "мир",
                           "confidence": 1
                        }
                     ],
                     "text": "Привет мир",
                     "confidence": 1
                  }
               ],
               "channelTag": "1"
            }
         ]
      },
      "id": "e03jjenu23uc********",
      "createdAt": "2024-08-22T11:39:22Z",
      "createdBy": "aje3bg430agh********",
      "modifiedAt": "2024-08-22T11:39:23Z"
   }
   ```

   {% include [absent-chunks-notice](./absent-chunks-notice.md) %}