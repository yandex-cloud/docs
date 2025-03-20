1. [Получите ссылку на аудиофайл](../../storage/operations/objects/link-for-download.md) в {{ objstorage-name }}.
1. Создайте файл, например `request.json`, и добавьте в него код:

    ```json
    {
      "uri": "https://storage.yandexcloud.net/<название_бакета>/<путь_к_WAV-файлу_в_бакете>",
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
          https://operation.{{ api-host-sk-stt }}/operations/<идентификатор_операции_распознавания>
        ```

    * С аутентификацией с помощью API-ключа:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Api-key ${API_KEY}" \
          https://operation.{{ api-host-sk-stt }}/operations/<идентификатор_операции_распознавания>
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

    ```text
    {
       "result": {
          "sessionUuid": {
             "uuid": "24935f24-2c1f62dc-8dd49006-********",
             "userRequestId": "f8d2h7m07t4i********"
          },
          "audioCursors": {
             "receivedDataMs": "7400",
             "resetTimeMs": "0",
             "partialTimeMs": "7400",
             "finalTimeMs": "7400",
             "finalIndex": "0",
             "eouTimeMs": "0"
          },
          "responseWallTimeMs": "189",
          "final": {
             "alternatives": [
                {
                   "words": [
                      {
                         "text": "я",
                         "startTimeMs": "459",
                         "endTimeMs": "520"
                      },
                      {
                         "text": "яндекс",
                         "startTimeMs": "640",
                         "endTimeMs": "1060"
                      },
                      {
                         "text": "спичкит",
                         "startTimeMs": "1120",
                         "endTimeMs": "1959"
                      },
                      {
                         "text": "я",
                         "startTimeMs": "2480",
                         "endTimeMs": "2520"
                      },
                      {
                         "text": "могу",
                         "startTimeMs": "2580",
                         "endTimeMs": "2800"
                      },
                      {
                         "text": "превратить",
                         "startTimeMs": "2860",
                         "endTimeMs": "3360"
                      },
                      {
                         "text": "любой",
                         "startTimeMs": "3439",
                         "endTimeMs": "3709"
                      },
                      {
                         "text": "текст",
                         "startTimeMs": "3800",
                         "endTimeMs": "4140"
                      },
                      {
                         "text": "в",
                         "startTimeMs": "4200",
                         "endTimeMs": "4220"
                      },
                      {
                         "text": "речь",
                         "startTimeMs": "4279",
                         "endTimeMs": "4740"
                      },
                      {
                         "text": "теперь",
                         "startTimeMs": "5140",
                         "endTimeMs": "5759"
                      },
                      {
                         "text": "и",
                         "startTimeMs": "5859",
                         "endTimeMs": "5900"
                      },
                      {
                         "text": "вы",
                         "startTimeMs": "5980",
                         "endTimeMs": "6399"
                      },
                      {
                         "text": "можете",
                         "startTimeMs": "6660",
                         "endTimeMs": "7180"
                      }
                   ],
                   "text": "я яндекс спичкит я могу превратить любой текст в речь теперь и вы можете",
                   "startTimeMs": "0",
                   "endTimeMs": "7400",
                   "confidence": 0,
                   "languages": []
                }
             ],
             "channelTag": "0"
          },
          "channelTag": "0"
       }
    }
    {
       "result": {
          "sessionUuid": {
             "uuid": "24935f24-2c1f62dc-8dd49006-********",
             "userRequestId": "f8d2h7m07t4i********"
          },
          "audioCursors": {
             "receivedDataMs": "7400",
             "resetTimeMs": "0",
             "partialTimeMs": "7400",
             "finalTimeMs": "7400",
             "finalIndex": "0",
             "eouTimeMs": "0"
          },
          "responseWallTimeMs": "189",
          "finalRefinement": {
             "finalIndex": "0",
             "normalizedText": {
                "alternatives": [
                   {
                      "words": [
                         {
                            "text": "я",
                            "startTimeMs": "459",
                            "endTimeMs": "520"
                         },
                         {
                            "text": "яндекс",
                            "startTimeMs": "640",
                            "endTimeMs": "1060"
                         },
                         {
                            "text": "спичкит",
                            "startTimeMs": "1120",
                            "endTimeMs": "1959"
                         },
                         {
                            "text": "я",
                            "startTimeMs": "2480",
                            "endTimeMs": "2520"
                         },
                         {
                            "text": "могу",
                            "startTimeMs": "2580",
                            "endTimeMs": "2800"
                         },
                         {
                            "text": "превратить",
                            "startTimeMs": "2860",
                            "endTimeMs": "3360"
                         },
                         {
                            "text": "любой",
                            "startTimeMs": "3439",
                            "endTimeMs": "3709"
                         },
                         {
                            "text": "текст",
                            "startTimeMs": "3800",
                            "endTimeMs": "4140"
                         },
                         {
                            "text": "в",
                            "startTimeMs": "4200",
                            "endTimeMs": "4220"
                         },
                         {
                            "text": "речь",
                            "startTimeMs": "4279",
                            "endTimeMs": "4740"
                         },
                         {
                            "text": "теперь",
                            "startTimeMs": "5140",
                            "endTimeMs": "5759"
                         },
                         {
                            "text": "и",
                            "startTimeMs": "5859",
                            "endTimeMs": "5900"
                         },
                         {
                            "text": "вы",
                            "startTimeMs": "5980",
                            "endTimeMs": "6399"
                         },
                         {
                            "text": "можете",
                            "startTimeMs": "6660",
                            "endTimeMs": "7180"
                         }
                      ],
                      "text": "Я яндекс спичкит я могу превратить любой текст в речь теперь и вы можете",
                      "startTimeMs": "0",
                      "endTimeMs": "7400",
                      "confidence": 0,
                      "languages": []
                   }
                ],
                "channelTag": "0"
             }
          },
          "channelTag": "0"
       }
    }
    {
       "result": {
          "sessionUuid": {
             "uuid": "24935f24-2c1f62dc-8dd49006-********",
             "userRequestId": "f8d2h7m07t4i********"
          },
          "audioCursors": {
             "receivedDataMs": "7400",
             "resetTimeMs": "0",
             "partialTimeMs": "7400",
             "finalTimeMs": "7400",
             "finalIndex": "0",
             "eouTimeMs": "7400"
          },
          "responseWallTimeMs": "190",
          "eouUpdate": {
             "timeMs": "7400"
          },
          "channelTag": "0"
       }
    }
    ```

    {% endcut %}
