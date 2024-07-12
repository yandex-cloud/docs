# Загрузка переписки из чата

Вы можете загрузить текстовые сообщения из переписки клиента, оператора или бота в чате с помощью API {{ speechsense-name }}. Так сообщения будут доступны для анализа, например, в [отчетах {{ speechsense-name }}](../../concepts/reports/index.md).

Текстовые сообщения передаются в формате JSON. Также для загрузки данных используется отдельный JSON-файл с метаданными разговора.

[Аутентификация](../../api-ref/authentication.md) происходит от имени сервисного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md) или [API-ключа](../../../iam/concepts/authorization/api-key.md).

Если вы хотите загрузить аудиозапись разговора вместо переписки, обратитесь к [инструкции](upload-data.md).

## Перед началом работы {#before-you-begin}

Для работы с API {{ yandex-cloud }} потребуется Git, Python 3.6 или старше и пакет `grpcio-tools`. [Узнайте, как установить Python](https://www.python.org/downloads/).

Чтобы подготовиться к загрузке переписки из чата:

1. [Создайте подключение](../connection/create.md) типа **Чат**.
1. [Создайте проект](../project/create.md) с новым подключением.

   В созданные проект и подключение будут загружены текстовые сообщения.

1. В консоли управления [создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Добавьте сервисный аккаунт в пространство](../space/add-user-to-space.md) с ролью `{{ roles-speechsense-data-editor }}`. Это позволит сервисному аккаунту загружать данные в {{ speechsense-name }}.
1. Чтобы аутентифицироваться в API {{ yandex-cloud }}, [создайте API-ключ](../../../iam/operations/api-key/create.md) или [IAM-токен](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
1. Склонируйте [репозиторий API {{ yandex-cloud }}](https://github.com/yandex-cloud/cloudapi):

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

   ```python
   pip install grpcio-tools
   ```

## Загрузить данные {#upload-data}

1. Перейдите в папку с репозиторием API {{ yandex-cloud }}, создайте папку `upload_data`, сгенерируйте в ней код интерфейса клиента и перейдите в папку `upload_data`:

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

1. В папке `upload_data` создайте Python-скрипт `upload_text.py`, который загрузит переписку из чата в {{ speechsense-name }}:

      ```python
      import argparse
      import json
      from typing import Dict
      import grpc

      from yandex.cloud.speechsense.v1 import talk_service_pb2
      from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
      from yandex.cloud.speechsense.v1 import text_pb2
      from google.protobuf.timestamp_pb2 import Timestamp

      # Для аутентификации с IAM-токеном замените параметр api_key на iam_token
      def upload_talk(connection_id: str, metadata: Dict[str, str], api_key: str, text_data):
         credentials = grpc.ssl_channel_credentials()
         channel = grpc.secure_channel('api.talk-analytics.yandexcloud.net:443', credentials)

         talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

         messageList = []
         for message in text_data['messages']:
            timestamp = Timestamp()
            timestamp.FromJsonString(value=str(message['timestamp']))
            messageProto = text_pb2.Message(
               user_id=str(message['user_id']),
               text=text_pb2.TextPayload(text=str(message['text'])),
               timestamp=timestamp
            )
            messageList.append(messageProto)

         # Формирование запроса к API
         request = talk_service_pb2.UploadTextRequest(
            metadata=talk_service_pb2.TalkMetadata(
               connection_id=str(connection_id),
               fields=metadata),
            text_content=text_pb2.TextContent(
               messages=messageList)
         )

         # Тип аутентификации — API-ключ
         response = talk_service_stub.UploadText(request, metadata=(
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
         parser.add_argument('--text-path', required=True, help='JSON with text chat data', type=str)
         parser.add_argument('--meta-path', required=False, help='JSON with the dialog metadata', type=str, default=None)
         args = parser.parse_args()

         with open(args.meta_path, 'r') as fp:
            metadata = json.load(fp)

         with open(args.text_path, 'r') as fp:
            text_data = json.load(fp)
         upload_talk(args.connection_id, metadata, args.key, text_data)
      ```

1. В папке `upload_data` создайте файл `metadata.json` с метаданными разговора:

   ```json
   {
      "operator_name": "<имя_оператора>",
      "operator_id": "<идентификатор_оператора>",
      "client_name": "<имя_клиента>",
      "client_id": "<идентификатор_клиента>",
      "bot_name": "<имя_бота>",
      "bot_id": "<идентификатор_бота>",
      "date": "<дата_начала>",
      "direction_outgoing": "<исходящее_направление:_true_или_false>",
      "language": "<язык>",
      <дополнительные_параметры_подключения>
   }
   ```

   Поля в файле должны соответствовать параметрам подключения, в которое вы загружаете текстовые сообщения. В шаблоне выше указаны обязательные поля для подключений типа **Чат**. Если вы добавляли еще параметры в подключение, укажите их в файле `metadata.json`.

   Значение поля `date` задайте в формате `ГГГГ-ММ-ДДTЧЧ:ММ:СС.ССС`.

1. В папке `upload_data` создайте файл `chat.json` с текстовыми сообщениями в следующем формате:

   ```json
   {
      "messages": [
         {
            "user_id": <идентификатор_автора_сообщения>,
            "text" : "<текстовое_сообщение>",
            "timestamp" : "<время_отправки_сообщения>"
         },
         ...
      ]
   }
   ```

   Где:

   * `messages` — массив текстовых сообщений. Для каждого сообщения создайте отдельный объект в этом массиве.
   * `user_id` — идентификатор автора сообщения. Идентификатор должен совпадать с идентификатором клиента, оператора или бота в JSON-файле с метаданными.
   * `timestamp` — момент времени, когда сообщение было отправлено. Укажите значение в формате `ГГГГ-ММ-ДДTЧЧ:ММ:СС.СССZ`.

1. Задайте API-ключ сервисного аккаунта:

   ```bash
   export API_KEY=<API-ключ_сервисного_аккаунта>
   ```

   Если вы используете IAM-токен, передайте его вместо API-ключа:

   ```bash
   export IAM_TOKEN=<IAM-токен_сервисного_аккаунта>
   ```

1. Запустите скрипт `upload_text.py` с нужными параметрами:

   ```bash
   python3 upload_text.py \
      --text-path chat.json \
      --meta-path metadata.json \
      --connection-id <идентификатор_подключения> \
      --key ${API_KEY}
   ```

   Где:

   * `--text-path` — путь к файлу с перепиской.
   * `--meta-path` — путь к файлу с метаданными разговора.
   * `--connection-id` — идентификатор подключения, в которое вы загружаете данные.
   * `--key` — API-ключ для аутентификации. Если вы используете IAM-токен, укажите переменную окружения `IAM_TOKEN` вместо `API_KEY`.

1. С [главной страницы]({{ link-speechsense-main }}) {{ speechsense-name }} перейдите на страницу проекта, который вы создали для текстовых сообщений. Убедитесь, что во вкладке **Диалоги** появилась загруженная переписка.
