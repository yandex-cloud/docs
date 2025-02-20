---
title: Загрузка аудиоданных через API
description: Следуя данной инструкции, вы сможете загрузить аудиоданные в {{ speechsense-name }} с помощью gPRC API.
---

# Загрузка аудиоданных через gPRC API

Эта инструкция поможет вам загрузить в {{ speechsense-name }} данные для распознавания и анализа речи через API. В примере заданы параметры:

* [формат аудио](../../concepts/formats.md) — WAV;
* метаданные диалога хранятся в файле `metadata_example.json`.

{% include [authentication](../../../_includes/speechsense/data/authentication.md) %}

Для ознакомления с функциональностью {{ speechsense-name }} вы можете использовать быструю загрузку аудиоданных через [консоль управления](upload-audio-console.md).

Если вы хотите загрузить переписку из чата вместо аудиозаписи разговора, обратитесь к [инструкции](upload-chat-text.md).

## Перед началом работы {#before-you-begin}

{% include [software](../../../_includes/speechsense/data/software.md) %}

Чтобы подготовиться к загрузке аудиоданных:

1. [Создайте подключение](../connection/create.md#create-audio-connection) типа **Двухканальное аудио**.
1. [Создайте проект](../project/create.md) с новым подключением.

   В созданные проект и подключение будут загружены аудиозаписи разговоров.

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. {% include [role-sa](../../../_includes/speechsense/data/role-sa.md) %}
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. {% include [clone-cloudapi](../../../_includes/speechsense/data/clone-cloudapi.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}

## Загрузить данные {#upload-data}

1. {% include [interface-code-generation](../../../_includes/speechsense/data/interface-code-generation.md) %}
1. В папке `upload_data` создайте Python-скрипт `upload_grpc.py`, который загрузит данные в подключение {{ speechsense-name }} одним сообщением:

      ```python
      import argparse
      import json
      from typing import Dict
      import grpc
      import datetime

      from yandex.cloud.speechsense.v1 import talk_service_pb2
      from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
      from yandex.cloud.speechsense.v1 import audio_pb2

      # Для аутентификации с IAM-токеном замените параметр api_key на iam_token
      def upload_talk(connection_id: int, metadata: Dict[str, str], api_key: str, audio_bytes: bytes):
         credentials = grpc.ssl_channel_credentials()
         channel = grpc.secure_channel('{{ speechsense-endpoint }}', credentials)
         talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

      # Формирование запроса к API
         request = talk_service_pb2.UploadTalkRequest(
            metadata=talk_service_pb2.TalkMetadata(
               connection_id=str(connection_id),
               fields=metadata
            ),
            # Формат аудио — WAV
            audio=audio_pb2.AudioRequest(
               audio_metadata=audio_pb2.AudioMetadata(
                  container_audio=audio_pb2.ContainerAudio(
                     container_audio_type=audio_pb2.ContainerAudio.ContainerAudioType.CONTAINER_AUDIO_TYPE_WAV
                  )
               ),
               audio_data=audio_pb2.AudioChunk(data=audio_bytes)
            )
         )
         # Тип аутентификации — API-ключ
         response = talk_service_stub.Upload(request, metadata=(
            ('authorization', f'Api-Key {api_key}'),
         # Для аутентификации с IAM-токеном передавайте заголовок
         #  ('authorization', f'Bearer {iam_token}'),
         ))

         # Вывести идентификатор диалога
         print(f'Dialog ID: {response.talk_id}')

      if __name__ == '__main__':
         parser = argparse.ArgumentParser()
         parser.add_argument('--key', required=True, help='API key or IAM token', type=str)
         parser.add_argument('--connection-id', required=True, help='Connection ID', type=str)
         parser.add_argument('--audio-path', required=True, help='Audio file path', type=str)
         parser.add_argument('--meta-path', required=False, help='JSON with the dialog metadata', type=str, default=None)
         args = parser.parse_args()

         # Значения по умолчанию, если метаданные не указаны
         if args.meta_path is None:
            now = datetime.datetime.now().isoformat()
            metadata = {
               'operator_name': 'Operator',
               'operator_id': '1111',
               'client_name': 'Client',
               'client_id': '2222',
               'date': str(now),
               'date_from': '2023-09-13T17:30:00.000',
               'date_to': '2023-09-13T17:31:00.000',
               'direction_outgoing': 'true',
            }
         else:
            with open(args.meta_path, 'r') as fp:
               metadata = json.load(fp)

         with open(args.audio_path, 'rb') as fp:
            audio_bytes = fp.read()
         upload_talk(args.connection_id, metadata, args.key, audio_bytes)
      ```

1. {% include [api-key](../../../_includes/speechsense/data/api-key.md) %}

1. Запустите скрипт `upload_grpc.py`, передав нужные параметры:

   ```bash
   python3 upload_grpc.py \
      --audio-path <аудиофайл> \
      --meta-path <метаданные> \
      --connection-id <идентификатор_подключения> \
      --key ${API_KEY}
   ```

   Где:

   * `--audio-path` — путь к файлу с аудио диалога.
   * `--meta-path` — путь к файлу с метаданными диалога.
   * `--connection-id` — идентификатор подключения, в которое вы загружаете данные.
   * `--key` — API-ключ для аутентификации. Если вы используете IAM-токен, укажите переменную окружения `IAM_TOKEN` вместо `API_KEY`.
