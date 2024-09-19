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

  {% include [transcribation-before-you-begin](../../../_includes/speechkit/async-recognition-v3.md) %}

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

{% endlist %}
