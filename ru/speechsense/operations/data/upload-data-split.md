---
title: Загрузка длинных аудиозаписей с разбиением через gRPC API
description: Следуя данной инструкции, вы сможете загрузить длинные аудиозаписи в {{ speechsense-name }} с разбивкой на отрезки через gRPC API.
---

# Загрузка длинных аудиозаписей с разбиением через gRPC API

Эта инструкция поможет вам загрузить в {{ speechsense-name }} данные для распознавания и анализа речи через API. В примере заданы параметры:

* [формат аудио](../../concepts/formats.md) — WAV;
* тип подключения — одноканальное аудио с разбиением на отрезки;
* метод gRPC API — [TalkService.UploadBadge](../../api-ref/grpc/Talk/uploadBadge.md);
* метаданные диалога хранятся в файле `metadata.json`.

{% include [authentication](../../../_includes/speechsense/data/authentication.md) %}

Для ознакомления с функциональностью {{ speechsense-name }} вы можете использовать быструю загрузку аудиоданных через [консоль управления](upload-audio-console.md).

Если вы хотите загрузить переписку из чата вместо аудиозаписи разговора, обратитесь к [инструкции](upload-chat-text.md).

## Перед началом работы {#before-you-begin}

{% include [software](../../../_includes/speechsense/data/software.md) %}

Чтобы подготовиться к загрузке аудиоданных:

1. [Создайте подключение](../connection/create.md#create-one-channel-audio-connection) типа **{{ ui-key.yc-ui-talkanalytics.connections.type.one-channel-key-value }}** с включенной опцией **{{ ui-key.yc-ui-talkanalytics.connections.additional.split.title }}**.

   Если вы хотите загрузить [связанные диалоги](../../concepts/dialogs.md#related-dialogs), добавьте в общие метаданные подключения строковый ключ `ticket_id`. По этому ключу диалоги будут связаны.

1. [Создайте проект](../project/create.md) с новым подключением.

   В созданный проект и подключение будут загружены аудиозаписи разговоров.

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. {% include [role-sa](../../../_includes/speechsense/data/role-sa.md) %}
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. {% include [clone-cloudapi](../../../_includes/speechsense/data/clone-cloudapi.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}

## Загрузить данные {#upload-data}

{% note warning %}

{% include [data-format](../../../_includes/speechsense/data/data-format.md) %}

{% include notitle [max-duration](../../../_includes/speechsense/data/max-duration.md) %}

{% include notitle [max-dialog-string](../../../_includes/speechsense/data/max-dialog-string.md) %}

Одноканальное аудио с разбиением на отрезки поддерживает загрузку только через [TalkService.UploadBadge](../../api-ref/grpc/Talk/uploadBadge.md).

Поддерживаемые форматы аудио: [WAV](../../concepts/formats.md#wav) и [MP3](../../concepts/formats.md#mp3).

{% endnote %}

1. {% include [interface-code-generation](../../../_includes/speechsense/data/interface-code-generation.md) %}
1. В папке `upload_data` создайте Python-скрипт `upload_grpc.py`, который загрузит данные в подключение {{ speechsense-name }}. Файл будет передаваться через чанки:

   ```python
   import argparse
   import datetime
   import json
   from typing import Dict

   import grpc

   from yandex.cloud.speechsense.v1 import talk_service_pb2
   from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
   from yandex.cloud.speechsense.v1 import audio_pb2


   # Настройте размер передаваемого чанка
   CHUNK_SIZE_BYTES = 1 * 1024 * 1024


   def upload_audio_requests_iterator(connection_id: str, metadata: Dict[str, str], audio_path: str):
       # Передайте общие метаданные диалога
       yield talk_service_pb2.StreamTalkRequest(
           metadata=talk_service_pb2.TalkMetadata(
               connection_id=connection_id,
               fields=metadata
           )
       )

       # Передайте метаданные аудиозаписи
       yield talk_service_pb2.StreamTalkRequest(
           audio=audio_pb2.AudioStreamingRequest(
               audio_metadata=audio_pb2.AudioMetadata(
                   container_audio=audio_pb2.ContainerAudio(
                       container_audio_type=audio_pb2.ContainerAudio.ContainerAudioType.CONTAINER_AUDIO_TYPE_WAV
                   )
               )
           )
       )

       with open(audio_path, mode='rb') as fp:
           data = fp.read(CHUNK_SIZE_BYTES)
           while len(data) > 0:
               # Передайте очередной чанк байт аудиофайла
               yield talk_service_pb2.StreamTalkRequest(
                   audio=audio_pb2.AudioStreamingRequest(
                       chunk=audio_pb2.AudioChunk(data=data)
                   )
               )
               data = fp.read(CHUNK_SIZE_BYTES)


   def upload_talk(connection_id: str, metadata: Dict[str, str], token: str, audio_path: str):
       # Установите соединение с сервером
       credentials = grpc.ssl_channel_credentials()
       channel = grpc.secure_channel('api.speechsense.yandexcloud.net:443', credentials)
       talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

       # Передайте итератор по запросам и получите ответ от сервера
       response = talk_service_stub.UploadBadge(
           upload_audio_requests_iterator(connection_id, metadata, audio_path),
           metadata=[('authorization', token)]
       )

       print(f'Badge id: {response.id}')


   if __name__ == '__main__':
       parser = argparse.ArgumentParser()

       parser.add_argument('--key', required=True, help='API key or IAM token', type=str)
       parser.add_argument('--key-type', required=False, help='Key type', choices=['iam-token', 'api-key'], default='iam-token', type=str)
       parser.add_argument('--connection-id', required=True, help='Connection Id', type=str)
       parser.add_argument('--audio-path', required=True, help='Audio file path', type=str)
       parser.add_argument('--meta-path', required=False, help='Talk metadata json', type=str, default=None)
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
               'direction_outgoing': 'true',
               'language': 'ru-ru'
           }
       else:
           with open(args.meta_path, 'r') as fp:
               metadata = json.load(fp)

       if args.key_type == 'iam-token':
           token = f'Bearer {args.key}'
       elif args.key_type == 'api-key':
           token = f'Api-Key {args.key}'

       upload_talk(args.connection_id, metadata, token, args.audio_path)
      ```

1. В папке `upload_data` создайте файл `metadata.json` с метаданными разговора:

   ```json
   {
       "operator_name": "<имя_оператора>",
       "operator_id": "<идентификатор_оператора>",
       "client_name": "<имя_клиента>",
       "client_id": "<идентификатор_клиента>",
       "date": "<дата_начала>",
       "language": "<язык>",
       <дополнительные_параметры_подключения>
   }
   ```

   Поля в файле должны соответствовать параметрам подключения, в которое вы загружаете аудиозаписи. В шаблоне выше указаны обязательные поля для подключений типа **{{ ui-key.yc-ui-talkanalytics.connections.type.one-channel-key-value }}**. Если вы добавляли другие параметры в подключение, укажите их в файле `metadata.json`. Например, если вы загружаете [связанные диалоги](../../concepts/dialogs.md#related-dialogs), добавьте в файл параметр:

   ```json
   {
      ...
      "ticket_id": "<номер_задачи>"
   }
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

   * `--audio-path` — путь к файлу с аудиозаписью диалога.
   * `--meta-path` — путь к файлу с метаданными диалога.
   * `--connection-id` — идентификатор подключения, в которое вы загружаете данные.
   * `--key` — API-ключ для аутентификации. Если вы используете IAM-токен, укажите переменную окружения `IAM_TOKEN` вместо `API_KEY`.

1. В случае успешного выполнения скрипта вы получите строку с `Badge id`. Обработка диалогов занимает продолжительное время, поэтому загруженные диалоги появятся в консоли {{ speechsense-name }} позднее.
