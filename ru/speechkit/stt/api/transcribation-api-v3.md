---
title: Асинхронное распознавание аудиофайлов в формате WAV в API v3 в {{ speechkit-full-name }}
description: Следуя данной инструкции, вы сможете использовать асинхронное распознавание аудиофайлов в формате WAV в API v3.
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

  {% include [transcribation](../../../_includes/speechkit/async-recognition-v3.md) %}

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
        uri='https://{{ s3-storage-host }}/<название_бакета>/<путь_к_WAV-файлу_в_бакете>',
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
      chan = grpc.secure_channel('{{ api-host-sk-stt }}:443', cred)
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
      chan = grpc.secure_channel('{{ api-host-sk-stt }}:443', cred)
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

      {% include [transcribation-result](../../../_includes/speechkit/transcribe-result-example.md) %}


{% endlist %}
