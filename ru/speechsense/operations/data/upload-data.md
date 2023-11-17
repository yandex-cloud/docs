# Загрузка аудиоданных

Эта инструкция поможет вам загрузить в {{ speechsense-name }} данные для распознавания и анализа речи с помощью API. В примере заданы параметры:

* формат аудио — WAV;
* метаданные диалога хранятся в файле `metadata_example.json`.

[Аутентификация](../../api-ref/authentication.md) происходит от имени сервисного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) или [API-ключа](../../../iam/concepts/authorization/api-key.md).

## Перед началом {#before-you-begin}

Для работы с API потребуется Git, Python 3.6 или старше и пакет `grpcio-tools`. [Как установить Python](https://www.python.org/downloads/).

1. [Создайте сервисный аккаунт](../../../iam/operations/sa/create.md) и добавьте его в пространство с [ролью](../../../iam/concepts/access-control/roles.md) `speech-sense.data.editor`. Это позволит сервисному аккаунту загружать данные в созданное подключение. Подробнее о ролях, действующих в сервисе, см. раздел [{#T}](../../security/index.md).

1. [Создайте API-ключ](../../../iam/operations/api-key/create.md) или [IAM-токен](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта, чтобы аутентифицироваться в API. 

1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

   ```python
   pip install grpcio-tools
   ```

## Загрузить данные {#upload-data}

1. Перейдите в папку с репозиторием {{ yandex-cloud }} API, создайте папку `upload_data`, сгенерируйте в ней код интерфейса клиента и перейдите в папку `upload_data`:

   {% list tabs %}

   - Bash
   
      ```bash
      cd <путь_к_папке_cloudapi> && \
      mkdir upload_data && \
      python3 -m grpc_tools.protoc -I . \
           --python_out=./upload_data/ \
           --grpc_python_out=./upload_data/ \
           yandex/cloud/speechsense/v1/talk_service.proto \
           yandex/cloud/speechsense/v1/audio.proto && \
      cd upload_data
      ```

   {% endlist %}

1. В папке `upload_data` создайте Python-скрипт `upload_grpc.py`, который загрузит данные в подключение {{ speechsense-name }}. Вы можете загружать данные в одном сообщении или передавать по частям в потоке gRPC. 

   {% list tabs %}

   - Одно сообщение

      ```python
      import argparse
      import json
      from typing import Dict
      import grpc
      
      from yandex.cloud.speechsense.v1 import talk_service_pb2
      from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
      from yandex.cloud.speechsense.v1 import audio_pb2
      
      # Для авторизации с IAM-токеном замените параметр api_key на iam_token
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
         # Тип авторизации — API key
         response = talk_service_stub.Upload(request, metadata=(
            ('authorization', f'Api-Key {api_key}'),
         # Для авторизации с IAM-токеном передавайте заголовок
         #  ('authorization', f'Bearer {iam_token}'),   
         ))
         
         # Вывести идентификатор диалога
         print(f'Dialog ID: {response.talk_id}')
      
      if name == '__main__':
         parser = argparse.ArgumentParser()
         parser.add_argument('--token', required=True, help='API key or IAM token', type=str)
         parser.add_argument('--connection-id', required=True, help='Connection ID', type=str)
         parser.add_argument('--audio-path', required=True, help='Audio file path', type=str)
         parser.add_argument('--meta-path', required=False, help='JSON with dialog metadata', type=str, default=None)
         args = parser.parse_args()
      
         # Значения по умолчанию, если метаданные не указаны
         if args.meta_path is None:
            metadata = {
               'operator_name': 'Operator',
               'operator_id': '1111',
               'client_name': 'Client',
               'client_id': '2222',
               'date_from': '2023-09-13T17:30:00.000',
               'date_to': '2023-09-13T17:31:00.000',
               'direction_outgoing': 'true',
            }
         else:
            with open(args.meta_path, 'r') as fp:
               metadata = json.load(fp)
      
         with open(args.audio_path, 'rb') as fp:
            audio_bytes = fp.read()
         upload_talk(args.connection_id, metadata, args.token, audio_bytes)
      ```

   - Потоковая загрузка 

      ```python
      import argparse
      import json
      from typing import Dict
      import grpc
   
      from yandex.cloud.speechsense.v1 import talk_service_pb2
      from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
      from yandex.cloud.speechsense.v1 import audio_pb2
   
      # Размер фрагмента 1 МБ
      CHUNK_SIZE_BYTES = 1024
   
      def upload_audio_requests_iterator(connection_id: int, metadata: Dict[str, str], audio_path: str):
         yield talk_service_pb2.StreamTalkRequest(
            metadata=talk_service_pb2.TalkMetadata(
               connection_id=str(connection_id),
               fields=metadata
            )
         )
         # Читаем данные из файла и передаем в поток
         with open(audio_path, mode='rb') as fp:
            data = fp.read(CHUNK_SIZE_BYTES)
            while data != b'':
               yield talk_service_pb2.StreamTalkRequest(
                  audio=talk_service_pb2.AudioStreamingRequest(
                     audio_metadata=audio_pb2.AudioMetadata(
                        container_audio=audio_pb2.ContainerAudio(
                           container_audio_type=audio_pb2.ContainerAudio.ContainerAudioType.CONTAINER_AUDIO_TYPE_WAV
                        )
                     ),
                     audio_data=audio_pb2.AudioChunk(data=data)
                  )
               )
               data = fp.read(CHUNK_SIZE_BYTES)
   
      # Для авторизации с IAM-токеном замените параметр api_key на iam_token
      def upload_talk(connection_id: int, metadata: Dict[str, str], api_key: str, audio_path: str):
         credentials = grpc.ssl_channel_credentials()
         channel = grpc.secure_channel('api.talk-analytics.yandexcloud.net:443', credentials)
         talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)
   
         # Тип авторизации — API key
         response = talk_service_stub.UploadAsStream(
            upload_audio_requests_iterator(connection_id, metadata, audio_path),
            metadata=(('authorization', f'Api-Key {api_key}'),
         # Для авторизации с IAM-токеном передавайте метаданные
         #  metadata=(('authorization', f'Bearer {iam_token}'),   
         ))
   
         # Вывести идентификатор диалога
         print(f'Dialog ID: {response.talk_id}')
   
      if name == '__main__':
         parser = argparse.ArgumentParser()
         parser.add_argument('--token', required=True, help='API key', type=str)
         parser.add_argument('--connection-id', required=True, help='API key or IAM token', type=str)
         parser.add_argument('--audio-path', required=True, help='Audio file path', type=str)
         parser.add_argument('--meta-path', required=False, help='Talk metadata json', type=str, default=None)
         args = parser.parse_args()
   
         # Значения по умолчанию, если метаданные не указаны
         if args.meta_path is None:
            metadata = {
               'operator_name': 'Operator',
               'operator_id': '1111',
               'client_name': 'Client',
               'client_id': '2222',
               'date_from': '2023-09-13T17:30:00.000',
               'date_to': '2023-09-13T17:31:00.000',
               'direction_outgoing': 'true',
            }
         else:
            with open(args.meta_path, 'r') as fp:
               metadata = json.load(fp)
   
         upload_talk(args.connection_id, metadata, args.token, args.audio_path)
      ```

   {% endlist %}

1. Запустите скрипт `upload_grpc.py`, передав нужные параметры:

   ```bash
   python3 upload_grpc.py \
      --audio-path <аудиофайл> \
      --meta-path <метаданные> \
      --connection-id <идентификатор_подключения> \
      --token-type api-key \
      --token ${IAM_TOKEN}
   ```

   Где:

   * `audio-path` — путь к файлу с аудио диалога.
   * `meta-path` — путь к файлу с метаданными диалога.
   * `connection-id` — идентификатор подключения, в которое вы загружаете данные.
   * `token-type` — способ аутентификации. Может принимать значения `iam-token` или `api-key` в зависимости от используемого типа авторизации.
   * `token` — значение токена для авторизации.
