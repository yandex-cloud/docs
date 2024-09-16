---
title: "Асинхронное распознавание аудиофайлов в формате WAV в API v3 в {{ speechkit-full-name }}"
description: "Следуя данной инструкции, вы сможете использовать асинхронное распознавание аудиофайлов в формате WAV в API v3."
---

# Асинхронное распознавание аудиофайлов в формате WAV в API v3

Ниже рассмотрен пример асинхронного распознавания речи из аудиофайла в формате WAV с помощью [API v3](../../stt-v3/api-ref/grpc/index.md) {{ speechkit-name }}. В примере заданы параметры:

* формат аудиопотока — WAV;
* [модель распознавания речи](../models.md#tags) — `general`;
* остальные параметры оставлены по умолчанию.

Аутентификация происходит от имени сервисного аккаунта с помощью [API-ключа](../../../iam/concepts/authorization/api-key.md) или [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Подробнее об аутентификации в API {{ speechkit-name }} см. в [справочнике API](../../concepts/auth.md).

## Перед началом работы {#before-you-begin}

{% include [transcribation-before-you-begin](../../../_includes/speechkit/transcribation-before-you-begin.md) %}

Если у вас нет аудиофайла в формате WAV, вы можете использовать [пример файла](https://{{ s3-storage-host }}/doc-files/speech.wav).

## Выполните распознавание с помощью API v3 {#recognize-using-api-v3}

{% list tabs group=programming_language %}

- cURL {#curl}

  1. [Получите ссылку на аудиофайл](../../../storage/operations/objects/link-for-download.md) в {{ objstorage-name }}.
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
      * С помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md):

        ```bash
        export IAM_TOKEN=<IAM-токен_сервисного_аккаунта> && \
        curl -k \
             -H "Authorization: Bearer ${IAM_TOKEN}" \
             -d @request.json https://stt.{{ api-host }}:443/stt/v3/recognizeFileAsync
        ```

        Где `IAM_TOKEN` — IAM-токен сервисного аккаунта.

      * С помощью [API-ключей](../../../iam/concepts/authorization/api-key).

        {% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

        ```bash
        export API_KEY=<API-ключ_сервисного_аккаунта> && \
        curl -k \
             -H "Authorization: Api-Key ${API_KEY}" \
             -d @request.json https://stt.{{ api-host }}:443/stt/v3/recognizeFileAsync
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

  1. Подождите, пока закончится распознавание. Одна минута аудио распознается примерно за 10 секунд.
  1. [Запросите информацию](../../../api-design-guide/concepts/operation.md#monitoring) об операции:

      * С авторизацией через IAM-токен:

          ```bash
          curl -k \
               -X GET \
               -H "Authorization: Bearer ${IAM_TOKEN}" \
               https://operation.{{ api-host }}/operations/<идентификатор_операции_распознавания>
          ```

      * С авторизацией через API-ключ:

          ```bash
          curl -k \
               -X GET \
               -H "Authorization: Api-key ${API_KEY}" \
               https://operation.{{ api-host }}/operations/<идентификатор_операции_распознавания>
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

      * С авторизацией через IAM-токен:

          ```bash
          curl -k \
               -X GET \
               -H "Authorization: Bearer ${IAM_TOKEN}" \
               https://stt.{{ api-host }}:443/stt/v3/getRecognition?operation_id=<идентификатор_операции_распознавания>
          ```

      * С авторизацией через API-ключ:

          ```bash
          curl -k \
               -X GET \
               -H "Authorization: Api-key ${API_KEY}" \
               https://stt.{{ api-host }}:443/stt/v3/getRecognition?operation_id=<идентификатор_операции_распознавания>
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

- Python 3 {#python}

  1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

      ```bash
      git clone https://github.com/yandex-cloud/cloudapi
      ```

  1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

      ```bash
      pip install grpcio-tools
      ```

  1. Перейдите в папку со склонированным репозиторием {{ yandex-cloud }} API, создайте папку `output` и сгенерируйте в ней код интерфейса клиента:

      ```bash
      cd <путь_к_папке_cloudapi>
      mkdir output
      python3 -m grpc_tools.protoc -I . -I third_party/googleapis \
        --python_out=output \
        --grpc_python_out=output \
        google/api/http.proto \
        google/api/annotations.proto \
        yandex/cloud/api/operation.proto \
        google/rpc/status.proto \
        yandex/cloud/operation/operation.proto \
        yandex/cloud/validation.proto \
        yandex/cloud/ai/stt/v3/stt_service.proto \
        yandex/cloud/ai/stt/v3/stt.proto
      ```

      В папке `output` будут созданы файлы с интерфейсом клиента: `stt_pb2.py`, `stt_pb2_grpc.py`, `stt_service_pb2.py`, `stt_service_pb2_grpc.py` и файлы зависимостей.

  1. Создайте в корне папки `output` файл, например `test.py`, и добавьте в него код для выполнения запроса к API:

      ```python
      import grpc
      from yandex.cloud.ai.stt.v3 import stt_pb2, stt_service_pb2_grpc

      request = stt_pb2.RecognizeFileRequest(
        uri='https://storage.yandexcloud.net/<название_бакета>/<путь_к_WAV-файлу_в_бакете>',
        recognition_model=stt_pb2.RecognitionModelOptions(
          model='general',
          audio_format=stt_pb2.AudioFormatOptions(
            container_audio=stt_pb2.ContainerAudio(
              container_audio_type=stt_pb2.ContainerAudio.WAV
            )
          )
        )
      )

      cred = grpc.ssl_channel_credentials()
      chan = grpc.secure_channel('stt.{{ api-host }}:443', cred)
      stub = stt_service_pb2_grpc.AsyncRecognizerStub(chan)

      # Выберите один из способов аутентификации:

      # Аутентификация с IAM-токеном
      response = stub.RecognizeFile(request, metadata=[('authorization', 'Bearer <IAM-токен>')])

      # Аутентификация с API-ключом
      # response = stub.RecognizeFile(request, metadata=[('authorization', 'Api-Key <API-ключ>')])

      print(response)
      ```

  1. Выполните запрос:

      ```bash
      python3 test.py
      ```

      Результат:

      ```bash
      id: "f8dem628l2mq********"
      description: "STT v3 async recognition"
      created_at {
        seconds: 1721032219
      }
      created_by: "ajehumcuv38h********"
      modified_at {
        seconds: 1721032219
      }
      ```

      Сохраните идентификатор (`id`) операции распознавания, полученный в ответе.

  1. Создайте в корне папки `output` файл, например `results.py`, и добавьте в него код для получения результата операции:

      ```python
      import grpc
      from yandex.cloud.ai.stt.v3 import stt_pb2, stt_service_pb2_grpc, stt_service_pb2

      request = stt_service_pb2.GetRecognitionRequest(
          operation_id="<идентификатор_операции>"
      )

      cred = grpc.ssl_channel_credentials()
      chan = grpc.secure_channel('stt.{{ api-host }}:443', cred)
      stub = stt_service_pb2_grpc.AsyncRecognizerStub(chan)

      # Аутентификация с IAM-токеном
      response = stub.GetRecognition(request, metadata=[('authorization', 'Bearer <IAM-токен>')])

      # Аутентификация с API-ключом
      # response = stub.GetRecognition(request, metadata=[('authorization', 'Api-Key <API-ключ>')])

      print(list(response))
      ```

  1. Выполните запрос:

      ```bash
      python3 results.py
      ```

      {% cut "Пример результата" %}

      ```bash
      [session_uuid {
        uuid: "df49eaa2-25a55218-ae967fa1-********"
        user_request_id: "f8dkup42nmhk********"
      }
      audio_cursors {
        received_data_ms: 6600
        partial_time_ms: 6600
        final_time_ms: 6600
      }
      response_wall_time_ms: 204
      final {
        alternatives {
          words {
            text: "я"
            start_time_ms: 380
            end_time_ms: 420
          }
          words {
            text: "яндекс"
            start_time_ms: 539
            end_time_ms: 919
          }
          words {
            text: "спичкит"
            start_time_ms: 960
            end_time_ms: 1719
          }
          words {
            text: "я"
            start_time_ms: 2159
            end_time_ms: 2200
          }
          words {
            text: "могу"
            start_time_ms: 2260
            end_time_ms: 2440
          }
          words {
            text: "превратить"
            start_time_ms: 2520
            end_time_ms: 3000
          }
          words {
            text: "любой"
            start_time_ms: 3060
            end_time_ms: 3320
          }
          words {
            text: "текст"
            start_time_ms: 3419
            end_time_ms: 3740
          }
          words {
            text: "в"
            start_time_ms: 3780
            end_time_ms: 3800
          }
          words {
            text: "речь"
            start_time_ms: 3860
            end_time_ms: 4279
          }
          words {
            text: "теперь"
            start_time_ms: 4680
            end_time_ms: 5240
          }
          words {
            text: "и"
            start_time_ms: 5339
            end_time_ms: 5380
          }
          words {
            text: "вы"
            start_time_ms: 5460
            end_time_ms: 5766
          }
          words {
            text: "можете"
            start_time_ms: 5920
            end_time_ms: 6393
          }
          text: "я яндекс спичкит я могу превратить любой текст в речь теперь и вы можете"
          end_time_ms: 6600
        }
        channel_tag: "0"
      }
      channel_tag: "0"
      , session_uuid {
        uuid: "df49eaa2-25a55218-ae967fa1-********"
        user_request_id: "f8dkup42nmhk********"
      }
      audio_cursors {
        received_data_ms: 6600
        partial_time_ms: 6600
        final_time_ms: 6600
      }
      response_wall_time_ms: 204
      final_refinement {
        normalized_text {
          alternatives {
            words {
              text: "я"
              start_time_ms: 380
              end_time_ms: 420
            }
            words {
              text: "яндекс"
              start_time_ms: 539
              end_time_ms: 919
            }
            words {
              text: "спичкит"
              start_time_ms: 960
              end_time_ms: 1719
            }
            words {
              text: "я"
              start_time_ms: 2159
              end_time_ms: 2200
            }
            words {
              text: "могу"
              start_time_ms: 2260
              end_time_ms: 2440
            }
            words {
              text: "превратить"
              start_time_ms: 2520
              end_time_ms: 3000
            }
            words {
              text: "любой"
              start_time_ms: 3060
              end_time_ms: 3320
            }
            words {
              text: "текст"
              start_time_ms: 3419
              end_time_ms: 3740
            }
            words {
              text: "в"
              start_time_ms: 3780
              end_time_ms: 3800
            }
            words {
              text: "речь"
              start_time_ms: 3860
              end_time_ms: 4279
            }
            words {
              text: "теперь"
              start_time_ms: 4680
              end_time_ms: 5240
            }
            words {
              text: "и"
              start_time_ms: 5339
              end_time_ms: 5380
            }
            words {
              text: "вы"
              start_time_ms: 5460
              end_time_ms: 5766
            }
            words {
              text: "можете"
              start_time_ms: 5920
              end_time_ms: 6393
            }
            text: "Я яндекс спичкит я могу превратить любой текст в речь теперь и вы можете"
            end_time_ms: 6600
          }
          channel_tag: "0"
        }
      }
      channel_tag: "0"
      , session_uuid {
        uuid: "df49eaa2-25a55218-ae967fa1-********"
        user_request_id: "f8dkup42nmhk********"
      }
      audio_cursors {
        received_data_ms: 6600
        partial_time_ms: 6600
        final_time_ms: 6600
        eou_time_ms: 6600
      }
      response_wall_time_ms: 204
      eou_update {
        time_ms: 6600
      }
      channel_tag: "0"
      ]
      ```

      {% endcut %}

- Node {#node}

  1. [Получите ссылку на аудиофайл](../../../storage/operations/objects/link-for-download.md) в {{ objstorage-name }}.
  2. Отправьте `post` запрос для распознания аудио файла.

    ```js
    const { data } = await axios.post(
        "https://stt.api.cloud.yandex.net/stt/v3/recognizeFileAsync",
        {
          uri: "https://storage.yandexcloud.net/<название_бакета>/<путь_к_WAV-файлу_в_бакете>",
          recognition_model: {
            model: 'general',
            audio_format: {
              container_audio: {
                container_audio_type: 'OGG_OPUS',
              },
            },
            text_normalization: {
              text_normalization: 'TEXT_NORMALIZATION_ENABLED',
              literature_text: true,
            },
          },
        },
        {
          headers: {
            Authorization: `Api-key ${API_KEY}`,
          },
        },
      );

      return data;
    ```
    Где:
    * `uri` — ссылка на аудиофайл в Object Storage. Пример ссылки: `https://storage.yandexcloud.net/speechkit/speech.wav`
    * `model` — модель распознавания речи.
    * `container_audio_type` — тип аудиоконтейнера. [Разрешенные типы можно посмотреть здесь](https://yandex.cloud/ru/docs/speechkit/stt-v3/api-ref/grpc/stt_service#ContainerAudio). Если вы укажите не правильно тип - будет ошибка.
    * `API_KEY` - Апи ключ созданный в сервисном аккаунте. Он не ограничен по времени действия.
    * `text_normalization` - настройки приведения к нормальну виду. Там много настроек, посмотрите их по [ссылке](https://yandex.cloud/ru/docs/speechkit/stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions)
    
    Пример результата:

    ```json
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
    Сохраните идентификатор (id) операции распознавания, полученный в ответе.
    
    Если вы получили такую ошибку:
    ```js
    data: {
      error: 'unknown value "\\"OggOpus\\"" for enum speechkit.stt.v3.ContainerAudio.ContainerAudioType',
      code: 3,
      message: 'unknown value "\\"OggOpus\\"" for enum speechkit.stt.v3.ContainerAudio.ContainerAudioType',
      details: []
    }
    ```
    или такую:
    ```js
    error: {
        grpcCode: 3,
        httpCode: 400,
        message: 'Error in session internal_id=d37c0b7-13777363-52e7c7aa-fb23280a&request_id=f8d134ap164oulub0pk&client_request_id=f8d134ap164oulub0pk&folder_id=1gr7659c2un3cargb0f: No RIFF found',
        httpStatus: 'Bad Request',
        details: []
      }
    ```
    Это значит, что вы не верно указали `container_audio_type`, файл не сообветствует указанному типу.

3. Подождите, пока закончится распознавание. Одна минута аудио распознается примерно за 10 секунд.
4. [Запросите информацию](https://yandex.cloud/ru/docs/api-design-guide/concepts/operation#monitoring) об операции.
    ```js
    const { data } = await axios.get(
        "https://operation.api.cloud.yandex.net/operations/<идентификатор_операции_распознавания>",
        {
          headers: {
            Authorization: `Api-key ${API_KEY}`,
          },
        },
      );
      return data;
    ```
    Пример результата:
    ```json
    {
       "done": true,
       "id": "f8ddr61b30fk********",
       "description": "STT v3 async recognition",
       "createdAt": "2024-07-15T07:39:36Z",
       "createdBy": "ajehumcuv38h********",
       "modifiedAt": "2024-07-15T07:39:37Z"
    }
    ```
    Если  `"done": true` значит файл распознан и можно делать запрос на получение результата.
    
5. Запрос реультата.
    ```js
    const { data } = await axios.get(
        "https://stt.api.cloud.yandex.net:443/stt/v3/getRecognition?operation_id=<идентификатор_операции_распознавания>",
        {
          headers: {
            Authorization: `Api-key ${API_KEY}`,
          },
        },
      );
      return JSON.parse('[' + data.replaceAll('}\n{', '},\n{') + ']');
    ```
    Результат будет не JSON, а строкой. Чтобы привести её в нормальный вид прогоняем результат через код написанный выше. Или напишите свой.
    
    {% cut "Пример результата" %}
    ```json
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

{% endlist %}
