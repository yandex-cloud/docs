1. [Получите ссылку на аудиофайл](../../storage/operations/objects/link-for-download.md) в {{ objstorage-name }}.
1. Создайте файл, например `request.json`, и добавьте в него код:

    ```json
    {
      "uri": "https://{{ s3-storage-host }}/<название_бакета>/<путь_к_WAV-файлу_в_бакете>",
      "recognition_model": {
        "model": "general",
        "audio_format": {
          "container_audio": {
            "container_audio_type": "WAV"
          }
        }
      }
    }
    ```

    Где:

    * `uri` — ссылка на аудиофайл в {{ objstorage-name }}. Пример ссылки: `https://{{ s3-storage-host }}/speechkit/speech.wav`.

        Для бакета с ограниченным доступом в ссылке присутствуют дополнительные query-параметры (после знака `?`). Эти параметры не нужно передавать в {{ speechkit-name }} — они игнорируются.

    * `model` — модель распознавания речи.
    * `container_audio_type` — тип аудиоконтейнера.

1. Выполните запрос, используя один из способов аутентификации через сервисный аккаунт:    
    * С помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md):

      ```bash
      export IAM_TOKEN=<IAM-токен_сервисного_аккаунта> && \
      curl \
        --insecure \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data @request.json https://{{ api-host-sk-stt }}:443/stt/v3/recognizeFileAsync
      ```

      Где `IAM_TOKEN` — IAM-токен сервисного аккаунта.

    * С помощью [API-ключа](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      ```bash
      export API_KEY=<API-ключ_сервисного_аккаунта> && \
      curl \
        --insecure \
        --header "Authorization: Api-Key ${API_KEY}" \
        --data @request.json https://{{ api-host-sk-stt }}:443/stt/v3/recognizeFileAsync
      ```

    Пример результата:

    ```text
    {
       "id":"f8ddr61b30fk********",
       "description":"STT v3 async recognition",
       "createdAt":"2024-07-15T07:39:36Z",
       "createdBy":"ajehumcuv38h********",
       "modifiedAt":"2024-07-15T07:39:36Z",
       "done":false,
       "metadata":null
    }
    ```

    Сохраните идентификатор (`id`) операции распознавания, полученный в ответе.

1. Дождитесь, когда завершится распознавание. Одна минута аудио распознается примерно за 10 секунд.


1. [Запросите информацию](../../api-design-guide/concepts/operation.md#monitoring) об операции:

    * С аутентификацией с помощью IAM-токена:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host-sk }}/operations/<идентификатор_операции_распознавания>
        ```

    * С аутентификацией с помощью API-ключа:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Api-key ${API_KEY}" \
          https://operation.{{ api-host-sk }}/operations/<идентификатор_операции_распознавания>
        ```

    Пример результата:

    ```text
    {
       "done": true,
       "id": "f8ddr61b30fk********",
       "description": "STT v3 async recognition",
       "createdAt": "2024-07-15T07:39:36Z",
       "createdBy": "ajehumcuv38h********",
       "modifiedAt": "2024-07-15T07:39:37Z"
    }
    ```


1. Запросите результат операции:

    * С аутентификацией с помощью IAM-токена:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          https://{{ api-host-sk-stt }}:443/stt/v3/getRecognition?operation_id=<идентификатор_операции_распознавания>
        ```

    * С аутентификацией с помощью API-ключа:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Api-key ${API_KEY}" \
          https://{{ api-host-sk-stt }}:443/stt/v3/getRecognition?operation_id=<идентификатор_операции_распознавания>
        ```

    {% cut "Пример результата" %}

    {% include [output-example](../../_untranslatable/speechkit/stt-output-example.md) %}

    {% endcut %}
