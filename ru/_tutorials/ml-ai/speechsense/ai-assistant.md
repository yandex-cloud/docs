# Работа с AI-ассистентом в {{ speechsense-name }}

Вы можете получить из диалога информацию, извлеченную с помощью [AI-ассистента](../../../speechsense/concepts/assistants.md). Его можно подключать к аудиодиалогам и к чатам. В этом руководстве рассмотрено подключение к чатам. В качестве примера приведена переписка клиента с турагентством.

Чтобы получить нужную информацию из чата с помощью AI-ассистента:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте инфрастуктуру](#infrastructure-prepare).
1. [Создайте AI-ассистента](#create-assistant).
1. [Загрузите данные в проект](#load-data).
1. [Проверьте результат работы AI-ассистента в интерфейсе {{ speechsense-name }}](#result-console).
1. [Получите информацию о диалоге с помощью API](#result-api).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Для управления платежным аккаунтом у пользователя должна быть [назначена](../../../billing/security/index.md#set-role) роль `billing.accounts.editor`, `billing.accounts.admin` или `billing.accounts.owner` на нужный платежный аккаунт.

{% include [note-managing-roles](../../../_includes/mdb/note-managing-roles.md) %}

### Необходимые платные ресурсы {#paid-resources}

* Сервис {{ speechsense-name }}: количество символов в каждом текстовом диалоге (см. [тарифы {{ speechsense-name }}](../../../speechsense/pricing.md)).
* AI-ассистент: генерация текста (см. [тарифы {{ foundation-models-full-name }}](../../../ai-studio/pricing.md)). Тарификация за использование ассистента начинается с момента его включения.

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
    1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
    1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), например `speechsense`.
    1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Создайте API-ключ для сервисного аккаунта {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. Выберите сервисный аккаунт `speechsense`.
  1. На панели сверху нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** и выберите **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. В поле **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** выберите `yc.speech-sense.use`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Сохраните идентификатор и секретный ключ — они понадобятся позднее.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

{% endlist %}

### Создайте пространство и привяжите платежный аккаунт {#create-space}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

    1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
    1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.spaces.create-space }}**.
    1. Введите название [пространства](../../../speechsense/concepts/resources-hierarchy.md#space).
    1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.create }}**.
    1. [Привяжите платежный аккаунт](../../../speechsense/operations/space/link-ba.md) к пространству для оплаты {{ speechsense-name }}.

{% endlist %}

### Добавьте сервисный аккаунт в пространство {#add-sa-to-space}

{% include notitle [prepare-cloud](../../_tutorials_includes/speechsense-integration/prepare-cloud.md#add-sa-to-space) %}

### Создайте подключение для чата {#create-connection}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

    1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
    1. Перейдите в нужное пространство.
    1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.connections.connections }}**.
    1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}** → **{{ ui-key.yc-ui-talkanalytics.connections.template.default.name }}**.
    1. Укажите название подключения, например `chats-default-metadata`.
    1. Выберите тип данных **{{ ui-key.yc-ui-talkanalytics.connections.type.chat-key-value }}**.
    1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.connections.create-connection-key-value }}**.
    1. На открывшейся странице нажмите в левом верхнем углу кнопку **ID**, чтобы скопировать идентификатор созданного подключения. Сохраните этот идентификатор, он понадобится далее для [загрузки данных в проект](#load-data).

{% endlist %}

### Создайте проект {#create-project}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

    1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
    1. Перейдите в нужное пространство.
    1. Нажмите кнопку ![create](../../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.
    1. Введите имя проекта, например `chats-travel-agency`.
    1. В блоке **{{ ui-key.yc-ui-talkanalytics.connections.connection }}** нажмите **{{ ui-key.yc-ui-talkanalytics.projects.add-connection }}** и выберите подключение `chats-default-metadata`.
    1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.projects.create-project }}**.
    1. На открывшейся странице нажмите в левом верхнем углу кнопку **ID**, чтобы скопировать идентификатор созданного проекта. Сохраните этот идентификатор, он понадобится далее для [работы с API](#result-api).

{% endlist %}

## Создайте AI-ассистента {#create-assistant}

{% list tabs group=instructions %}

- Интерфейс {{ speechsense-name }} {#speechsense}

    1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
    1. Перейдите в нужное пространство, затем выберите проект `chats-travel-agency`.
    1. Выберите вкладку **{{ ui-key.yc-ui-talkanalytics.assistants.assistants }}**.
    1. Нажмите кнопку **Создать ассистента**.
    1. Задайте параметры ассистента:

        1. Введите название `Тематика диалога`.
        1. В блоке **{{ ui-key.yc-ui-talkanalytics.assistants.prompt }}** введите промпт:

            ```text
            Ты оцениваешь диалог оператора и клиента контактного центра. Будь крайне внимателен при ответе.
            Определи тематику, с которой обращается клиент, на основе следующего списка: Виза, Страна, Экскурсии.
            Если ничего из перечисленного не подходит, укажи значение «Иное».
            ```

        1. Выберите модель `YandexGPT 5.1 Pro`.

        1. В блоке **Результат** укажите:

            * Название поля — `Тематика`.
            * Тип поля — `Строка`.
            * Описание — `Наиболее подходящая тематика.`

    1. Включите блок **{{ ui-key.yc-ui-talkanalytics.assistants.applying }}**, чтобы активировать ассистента.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Загрузите данные в проект {#load-data}

{% include [software](../../../_includes/speechsense/data/software.md) %}

1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}
1. Перейдите в папку с репозиторием API {{ yandex-cloud }}, создайте папку `upload_data`, сгенерируйте в ней код интерфейса клиента и перейдите в папку `upload_data`:

    ```bash
    cd ~/cloudapi/ && \
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

    def upload_talk(connection_id: str, metadata: Dict[str, str], api_key: str, text_data):
       credentials = grpc.ssl_channel_credentials()
       channel = grpc.secure_channel('api.speechsense.yandexcloud.net:443', credentials)

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
       ))

       # Вывести идентификатор диалога
       print(f'Dialog ID: {response.talk_id}')

    if __name__ == '__main__':
       parser = argparse.ArgumentParser()
       parser.add_argument('--key', required=True, help='API key', type=str)
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
       "operator_name": "Светлана",
       "operator_id": "24",
       "client_name": "Михаил",
       "client_id": "145",
       "date": "2025-12-01T12:34:19+03:00",
       "direction_outgoing": "false",
       "language": "ru-ru"
    }
    ```

1. В папке `upload_data` создайте файл `chat.json` с текстовыми сообщениями:

    ```json
    {
       "messages": [
          {
             "user_id": 145,
             "text" : "Здравствуйте, есть ли у вас экскурсионные туры?",
             "timestamp" : "2025-12-01T12:34:19+03:00"
          },
          {
             "user_id": 24,
             "text" : "Здравствуйте, Михаил. Да, есть экскурсионные туры в Европу и Азию. Какое направление вас интересует?",
             "timestamp" : "2025-12-01T12:35:45+03:00"
          },
          {
             "user_id": 145,
             "text" : "А в какие страны Азии можно поехать без визы?",
             "timestamp" : "2025-12-01T12:37:14+03:00"
          },
          {
             "user_id": 24,
             "text" : "Южная Корея.",
             "timestamp" : "2025-12-01T12:38:55+03:00"
          },
          {
             "user_id": 145,
             "text" : "Спасибо, я подумаю. До свидания.",
             "timestamp" : "2025-12-01T12:41:21+03:00"
          },
          {
             "user_id": 24,
             "text" : "До свидания.",
             "timestamp" : "2025-12-01T12:41:50+03:00"
          }
       ]
    }
    ```

1. Задайте API-ключ сервисного аккаунта:

    ```bash
    export API_KEY=<секретная_часть_API-ключа>
    ```

1. Запустите скрипт `upload_text.py`:

    ```bash
    python3 upload_text.py \
       --text-path chat.json \
       --meta-path metadata.json \
       --connection-id <идентификатор_подключения> \
       --key ${API_KEY}
    ```

    Результат:

    ```
    Dialog ID: audh5bbnrstk********
    ```

    Сохраните идентификатор созданного диалога, он понадобится далее для [работы с API](#result-api).

## Проверьте результат работы AI-ассистента в интерфейсе {{ speechsense-name }} {#result-console}

Чтобы посмотреть, какую тематику определил AI-ассистент для диалога:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект `chats-travel-agency`.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.dialogs }}** включите опцию **{{ ui-key.yc-ui-talkanalytics.assistants.assistants }}**.

Под строкой диалога отобразится строка с указанием тематики `Экскурсии`. Эту тематику AI-ассистент определил как наиболее подходящую диалогу.

## Получите информацию о диалоге с помощью API {#result-api}

### Получите идентификаторы AI-ассистента и его поля {#get-field-id}

{% list tabs group=instructions %}

- REST API {#api}

    Воспользуйтесь методом [Assistants.List](../../../speechsense/api-ref/Assistants/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Api-Key $API_KEY" \
        --url 'https://rest-api.speechsense.yandexcloud.net/speechsense/v1/assistants/list' \
        --data '{
                  "projectId": "<идентификатор_проекта>"
                }'
    ```

    Результат:

    ```json
    {
      "assistants": [
        {
          "id": "eagdf4es87u0********",
          "project_id": "eags34o1skdi********",
          "model_id": "YGPT_LITE",
          "name": "Тематика диалога",
          "description": "",
          "prompt": "Ты оцениваешь диалог оператора и клиента контактного центра. Будь крайне внимателен при ответе. \nОпредели тематику, с которой обращается клиент, на основе следующего списка: Виза, Страна, Экскурсии. \nЕсли ничего из перечисленного не подходит, укажи значение «Иное».",
          "fields": [
            {
              "id": "eagldsqk9fp4********",
              "name": "Тематика",
              "description": "Наиболее подходящая тематика.",
              "type": "ASSISTANT_FIELD_TYPE_STRING"
            }
          ],
          "enabled": true,
          "labels": {},
          "created_at": "2025-11-13T23:38:00.686738Z",
          "created_by": "ajegrmkclceh********",
          "modified_at": "2025-11-14T01:32:48.358727Z",
          "modified_by": "ajegrmkclceh********"
        }
      ]
    }
    ```

- gRPC API {#grpc-api}

    Воспользуйтесь вызовом [AssistantsService.List](../../../speechsense/api-ref/grpc/Assistants/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

    ```bash
    grpcurl \
      -format json \
      -import-path ~/cloudapi/ \
      -import-path ~/cloudapi/third_party/googleapis/ \
      -proto ~/cloudapi/yandex/cloud/speechsense/v1/assistants_service.proto \
      -rpc-header "Authorization: Api-Key $API_KEY" \
      -d '{
            "project_id": "<идентификатор_проекта>"
          }' \
      api.speechsense.yandexcloud.net:443 \
      yandex.cloud.speechsense.v1.AssistantsService.List
    ```

    Результат:

    ```json
    {
      "assistants": [
        {
          "id": "eagdf4es87u0********",
          "projectId": "eags34o1skdi********",
          "modelId": "YGPT_LITE",
          "name": "Тематика диалога",
          "prompt": "Ты оцениваешь диалог оператора и клиента контактного центра. Будь крайне внимателен при ответе. \nОпредели тематику, с которой обращается клиент, на основе следующего списка: Виза, Страна, Экскурсии. \nЕсли ничего из перечисленного не подходит, укажи значение «Иное».",
          "fields": [
            {
              "id": "eagldsqk9fp4********",
              "name": "Тематика",
              "description": "Наиболее подходящая тематика.",
              "type": "ASSISTANT_FIELD_TYPE_STRING"
            }
          ],
          "enabled": true,
          "createdAt": "2025-11-13T23:38:00.686738Z",
          "createdBy": "ajegrmkclceh********",
          "modifiedAt": "2025-11-14T01:32:48.358727Z",
          "modifiedBy": "ajegrmkclceh********"
        }
      ]
    }
    ```

{% endlist %}

Сохраните значения полей:

* `assistants.id` — идентификатор AI-ассистента `Тематика диалога`.
* `assistants.fields.id` — идентификатор поля `Тематика`.

### Получите информацию о диалоге {#get-dialog-info}

{% list tabs group=instructions %}

- REST API {#api}

    Воспользуйтесь методом [Talk.Get](../../../speechsense/api-ref/Talk/get.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

    ```bash
    curl \
        --request POST \
        --header "Authorization: Api-Key $API_KEY" \
        --url 'https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/get' \
        --data '{
                  "projectId": "<идентификатор_проекта>",
                  "talkIds": [
                    "string"
                  ],
                  "resultsMask": 
                    {
                      "paths": [
                        "assistants"
                      ]
                    }
                }'
    ```

    Результат:

    ```json
    {
      "talk": [
        {
          "id": "audh5bbnrstk********",
          "organization_id": "********",
          "space_id": "f3fuclf1kufs********",
          "connection_id": "eagojm8e3bfv********",
          "project_ids": [
            "eags34o1skdi********"
          ],
          ...
          "assistants": {
            "assistant_results": [
              {
                "assistant_id": "eagdf4es87u0********",
                "results": [
                  {
                    "field_id": "eagldsqk9fp4********",
                    "string_result": "Экскурсии"
                  }
                ]
              }
            ]
          },
          ...
        }
      ]
    }
    ```

    Вы можете найти значение тематики для диалога при помощи поиска по [сохраненным ранее](#get-field-id) идентификаторам AI-ассистента и поля. Нужное значение находится в поле `talk.assistants.assistant_results.results.string_result`: `Экскурсии`.

- gRPC API {#grpc-api}

    Воспользуйтесь вызовом [TalkService.Get](../../../speechsense/api-ref/grpc/Talk/get.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

    ```bash
    grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/speechsense/v1/talk_service.proto \
        -rpc-header "Authorization: Api-Key $API_KEY" \
        -d '{
              "project_id": "<идентификатор_проекта>",
              "talk_ids": [
                <идентификатор_диалога>
              ],
              "results_mask": 
                {
                  "paths": [
                    "assistants"
                  ]
                }
            }' \
        api.speechsense.yandexcloud.net:443 \
        yandex.cloud.api.speechsense.v1.TalkService.Get
    ```

    Результат:

    ```json
    {
      "talk": [
        {
          "id": "audh5bbnrstk********",
          "organizationId": "********",
          "spaceId": "f3fuclf1kufs********",
          "connectionId": "eagojm8e3bfv********",
          "projectIds": [
            "eags34o1skdi********"
          ],
          ...
          "assistants": {
            "assistantResults": [
              {
                "assistantId": "eagdf4es87u0********",
                "results": [
                  {
                    "fieldId": "eagldsqk9fp4********",
                    "stringResult": "Экскурсии"
                  }
                ]
              }
            ]
          },
          ...
        }
      ]
    }
    ```

    Вы можете найти значение тематики для диалога при помощи поиска по [сохраненным ранее](#get-field-id) идентификаторам AI-ассистента и поля. Нужное значение находится в поле `talk.assistants.assistantResults.results.stringResult`: `Экскурсии`.

{% endlist %}

## Удалите ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, [удалите проект {{ speechsense-name }}](../../../speechsense/operations/project/delete.md), если вы больше не будете его использовать. AI-ассистент будет удален при удалении проекта.
