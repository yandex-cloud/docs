# Загрузка аудиоданных через gRPC API

Эта инструкция поможет вам загрузить в SpeechSense данные для распознавания и анализа речи через API. В примере заданы параметры:

* [формат аудио](../../concepts/formats.md) — WAV;
* метаданные диалога хранятся в файле `metadata.json`.

[Аутентификация](../../api-ref/authentication.md) происходит от имени сервисного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) или [API-ключа](../../../iam/concepts/authorization/api-key.md) с заданной [областью действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.speech-sense.use`.

Для ознакомления с функциональностью SpeechSense вы можете использовать быструю загрузку аудиоданных через [консоль управления](upload-audio-console.md).

Если вы хотите загрузить переписку из чата вместо аудиозаписи разговора, обратитесь к [инструкции](upload-chat-text.md).

## Перед началом работы {#before-you-begin}

Для работы с API Yandex Cloud потребуется Git, Python 3.6 или старше и пакет `grpcio-tools`. [Узнайте, как установить Python](https://www.python.org/downloads/).

Чтобы подготовиться к загрузке аудиоданных:

1. [Создайте подключение](../connection/create.md) типа **Двухканальное аудио** или **Одноканальное аудио** (без дополнительных настроек разбиения диалога).

   Если вы хотите загрузить [связанные диалоги](../../concepts/dialogs.md#related-dialogs), добавьте в общие метаданные подключения строковый ключ `ticket_id`. По этому ключу диалоги будут связаны.

1. [Создайте проект](../project/create.md) с новым подключением.

   В созданный проект и подключение будут загружены аудиозаписи разговоров.

1. В консоли управления [создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Добавьте сервисный аккаунт в пространство](../space/add-user-to-space.md) с ролью `Data editor`. Это позволит сервисному аккаунту загружать данные в SpeechSense.
1. Чтобы аутентифицироваться в API Yandex Cloud, создайте для сервисного аккаунта [API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) с заданной [областью действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.speech-sense.use` или [IAM-токен](../../../iam/operations/iam-token/create-for-sa.md).
1. Склонируйте [репозиторий API Yandex Cloud](https://github.com/yandex-cloud/cloudapi):
   
   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```
1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):
   
   ```python
   pip install grpcio-tools
   ```

## Загрузить данные {#upload-data}

{% note info %}

Даты указываются в формате ISO 8601 UTC с нулевым смещением времени. Если необходимо указать московское время, добавьте `+03:00` вместо `Z` в конец строки: `2025-04-24T14:34:19+03:00`.

Максимальная длительность аудио — 4 часа.

Максимальный размер строки в метаданных диалога — 1 024 байта.

{% endnote %}

1. Перейдите в папку с репозиторием API Yandex Cloud, создайте папку `upload_data`, сгенерируйте в ней код интерфейса клиента и перейдите в папку `upload_data`:
   
   {% list tabs group=programming_language %}
   
   - Bash {#bash}
   
      ```bash
      cd <путь_к_папке_cloudapi> && \
      mkdir upload_data && \
      python3 -m grpc_tools.protoc -I . -I third_party/googleapis \
           --python_out=./upload_data/ \
           --grpc_python_out=./upload_data/ \
           google/api/http.proto \
           google/api/annotations.proto \
           yandex/cloud/api/operation.proto \
           google/rpc/status.proto \
           yandex/cloud/operation/operation.proto \
           yandex/cloud/validation.proto \
           yandex/cloud/speechsense/v1/*.proto \
           yandex/cloud/speechsense/v1/*/*.proto
      cd upload_data
      ```
   
   {% endlist %}
1. В папке `upload_data` создайте Python-скрипт `upload_grpc.py`, который загрузит данные в подключение SpeechSense одним сообщением:

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
         channel = grpc.secure_channel('api.speechsense.yandexcloud.net:443', credentials)
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
               'date_from': '2023-09-13T17:30:00.000Z',
               'date_to': '2023-09-13T17:31:00.000Z',
               'direction_outgoing': 'true',
            }
         else:
            with open(args.meta_path, 'r') as fp:
               metadata = json.load(fp)

         with open(args.audio_path, 'rb') as fp:
            audio_bytes = fp.read()
         upload_talk(args.connection_id, metadata, args.key, audio_bytes)
      ```

1. В папке `upload_data` создайте файл `metadata.json` с метаданными разговора:

   ```json
   {
      "operator_name": "<имя_оператора>",
      "operator_id": "<идентификатор_оператора>",
      "client_name": "<имя_клиента>",
      "client_id": "<идентификатор_клиента>",
      "date": "<дата_начала>",
      "direction_outgoing": "<сделать_направление_исходящим>",
      "language": "<язык>",
      <дополнительные_параметры_подключения>
   }
   ```

   Поля в файле должны соответствовать параметрам подключения, в которое вы загружаете аудиозаписи. В шаблоне выше указаны обязательные поля для подключений типа **Двухканальное аудио**. Поле `direction_outgoing` определяет направление диалога: `true` — исходящее, `false` — входящее.

   Если вы добавляли другие параметры в подключение, укажите их в файле `metadata.json`. Например, если вы загружаете [связанные диалоги](../../concepts/dialogs.md#related-dialogs), добавьте в файл параметр:

   ```json
   {
      ...
      "ticket_id": "<номер_задачи>"
   }
   ```

1. Задайте API-ключ сервисного аккаунта:
   
   ```bash
   export API_KEY=<API-ключ_сервисного_аккаунта>
   ```
   
   Если вы используете IAM-токен, передайте его вместо API-ключа:
   
   ```bash
   export IAM_TOKEN=<IAM-токен_сервисного_аккаунта>
   ```

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