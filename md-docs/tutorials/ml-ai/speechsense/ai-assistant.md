[Документация Yandex Cloud](../../../index.md) > [Практические руководства](../../index.md) > [Машинное обучение и искусственный интеллект](../index.md) > Речевая аналитика > Работа с AI-ассистентом в SpeechSense

# Работа с AI-ассистентом в SpeechSense

# Работа с AI-ассистентом в SpeechSense

Вы можете получить из диалога информацию, извлеченную с помощью [AI-ассистента](https://aistudio.yandex.ru/docs/ru/speechsense/concepts/assistants). Его можно подключать к аудиодиалогам и к чатам. В этом руководстве рассмотрено подключение к чатам. В качестве примера приведена переписка клиента с турагентством.

Чтобы получить нужную информацию из чата с помощью AI-ассистента:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте инфраструктуру](#infrastructure-prepare).
1. [Создайте AI-ассистента](#create-assistant).
1. [Загрузите данные в проект](#load-data).
1. [Проверьте результат работы AI-ассистента в интерфейсе SpeechSense](#result-console).
1. [Получите информацию о диалоге с помощью API](#result-api).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

Для управления платежным аккаунтом у пользователя должна быть [назначена](../../../billing/security/index.md#set-role) роль `billing.accounts.editor`, `billing.accounts.admin` или `billing.accounts.owner` на нужный платежный аккаунт.

{% note info %}

Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.

{% endnote %}

### Необходимые платные ресурсы {#paid-resources}

* Сервис SpeechSense: количество символов в каждом текстовом диалоге и анализ диалогов с помощью AI-ассистента ([тарифы SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/pricing)).

## Подготовьте инфраструктуру {#infrastructure-prepare}

### Создайте сервисный аккаунт {#create-sa}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
    1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
    1. Нажмите кнопку **Создать сервисный аккаунт**.
    1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), например `speechsense`.
    1. Нажмите кнопку **Создать**.

{% endlist %}

### Создайте API-ключ для сервисного аккаунта {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
  1. На панели слева выберите ![FaceRobot](../../../_assets/console-icons/face-robot.svg) **Сервисные аккаунты**.
  1. Выберите сервисный аккаунт `speechsense`.
  1. На панели сверху нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать API-ключ**.
  1. В поле **Область действия** выберите `yc.speech-sense.use`.
  1. Нажмите кнопку **Создать**.
  1. Сохраните идентификатор и секретный ключ — они понадобятся позднее.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

{% endlist %}

### Создайте пространство и привяжите платежный аккаунт {#create-space}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

    1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
    1. Нажмите кнопку **Создать пространство**.
    1. Введите название [пространства](https://aistudio.yandex.ru/docs/ru/speechsense/concepts/resources-hierarchy#space).
    1. Нажмите кнопку **Создать**.
    1. [Привяжите платежный аккаунт](https://aistudio.yandex.ru/docs/ru/speechsense/operations/space/link-ba) к пространству для оплаты SpeechSense.

{% endlist %}

### Добавьте сервисный аккаунт в пространство {#add-sa-to-space}

## Подготовьте облако к работе {#before-you-begin}

1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь, если вы еще не зарегистрированы. Подробнее в документе [Начало работы с Yandex Cloud](../../../getting-started/index.md).
1. Примите пользовательское соглашение.
1. В сервисе [Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md), если платежный аккаунт находится в статусе `TRIAL_ACTIVE`, [активируйте платную версию](../../../billing/operations/activate-commercial.md) аккаунта.
1. [Назначьте](../../../iam/operations/roles/grant.md) вашему аккаунту в Yandex Cloud роль `speech-sense.spaces.creator`.

    {% note info %}
    
    Если вы не можете управлять ролями, обратитесь к администратору вашего облака или организации.
    
    {% endnote %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость инфраструктуры для интеграции с внешними системами входит плата за сервис SpeechSense: длительность каждого двухканального аудиофайла ([тарифы SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/pricing)).

### Создайте сервисный аккаунт {#create-sa}

Создайте сервисный аккаунт с [ролью](https://aistudio.yandex.ru/docs/ru/speechsense/security/#speechsense-data-editor) `speech-sense.data.editor` для доступа amoCRM к проекту SpeechSense.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите нужный каталог.
  1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management**.
  1. Нажмите **Создать сервисный аккаунт**.
  1. Введите имя [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md): `speechsense`.
  1. Нажмите ![image](../../../_assets/console-icons/plus.svg) **Добавить роль** и выберите `speech-sense.data.editor`.
  1. Нажмите **Создать**.

{% endlist %}


### Создайте API-ключ для сервисного аккаунта {#create-key}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором был создан сервисный аккаунт.
  1. [Перейдите](https://console.yandex.cloud/link/iam) в сервис **Identity and Access Management** и выберите сервисный аккаунт `speechsense`.
  1. На панели сверху нажмите ![image](../../../_assets/console-icons/plus.svg) **Создать новый ключ** и выберите **Создать API-ключ**.
  1. В открывшемся окне в поле **Область действия** выберите [область действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.speech-sense.use`.
  1. Нажмите **Создать**.
  1. Сохраните идентификатор и секретный ключ — они понадобятся позднее.

      {% note alert %}

      После закрытия диалога значение ключа будет недоступно.

      {% endnote %}

{% endlist %}


### Создайте пространство и привяжите платежный аккаунт {#create-space}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

  1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
  1. Нажмите кнопку **Создать пространство**.
  1. Введите название [пространства](https://aistudio.yandex.ru/docs/ru/speechsense/concepts/resources-hierarchy#space).
  1. Нажмите кнопку **Создать**.
  1. [Привяжите платежный аккаунт](https://aistudio.yandex.ru/docs/ru/speechsense/operations/space/link-ba) к пространству для оплаты SpeechSense.

      {% note info %}
      
      Для управления платежным аккаунтом у пользователя должна быть [назначена](../../../billing/security/index.md#set-role) роль `billing.accounts.editor`, `billing.accounts.admin` или `billing.accounts.owner` на нужный платежный аккаунт.
      
      {% endnote %}

{% endlist %}


### Добавьте сервисный аккаунт в пространство {#add-sa-to-space}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

  1. В [интерфейсе](https://speechsense.yandex.cloud/) SpeechSense перейдите в [новое пространство](#create-space).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/person-plus.svg) **Добавить участника** → ![image](../../../_assets/console-icons/persons.svg) **Добавить из организации**.
  1. Скопируйте идентификатор [созданного ранее сервисного аккаунта](#create-sa) `speechsense` и вставьте в строку поиска.
  1. Выберите сервисный аккаунт `speechsense` и укажите роль [Data editor](https://aistudio.yandex.ru/docs/ru/speechsense/security/#speechsense-data-editor). Эта роль позволит сервисному аккаунту загружать данные в SpeechSense.
  1. Нажмите кнопку **Добавить**.

{% endlist %}

### Создайте подключение для чата {#create-connection}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

    1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
    1. Перейдите в нужное пространство.
    1. Откройте вкладку **Подключения**.
    1. Нажмите кнопку **Создать подключение** → **Пустая форма**.
    1. Укажите название подключения, например `chats-default-metadata`.
    1. Выберите тип данных **Чат**.
    1. Нажмите кнопку **Создать подключение**.
    1. На открывшейся странице нажмите в левом верхнем углу кнопку **ID**, чтобы скопировать идентификатор созданного подключения. Сохраните этот идентификатор, он понадобится далее для [загрузки данных в проект](#load-data).

{% endlist %}

### Создайте проект {#create-project}

Создайте пустой проект с именем `chats-travel-agency` и подключением `chats-default-metadata`:

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

  1. В [интерфейсе](https://speechsense.yandex.cloud/) SpeechSense перейдите в нужное пространство и откройте вкладку **Проекты**.
  1. Если в пространстве уже есть проекты, нажмите **Создать проект**. Если проектов еще нет, шаблоны отображаются на вкладке **Проекты**.
  1. Выберите **Пустой проект**.
  1. В блоке **Параметры проекта** введите уникальное в пределах пространства имя проекта.
  1. В блоке **Подключение** выберите **Выбрать из списка** и укажите подключение, созданное [ранее](#create-connection).
  1. В блоке **Какие диалоги добавить в проект?** выберите **Все**.
  1. Нажмите **Создать** и дождитесь завершения создания проекта.

{% endlist %}

На странице созданного проекта нажмите в левом верхнем углу кнопку **ID**, чтобы скопировать его идентификатор. Сохраните этот идентификатор, он понадобится далее для [работы с API](#result-api).

## Создайте AI-ассистента {#create-assistant}

{% list tabs group=instructions %}

- Интерфейс SpeechSense {#speechsense}

    1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
    1. Перейдите в нужное пространство, затем выберите проект `chats-travel-agency`.
    1. Выберите вкладку **Ассистенты**.
    1. Нажмите кнопку **Создать ассистента**.
    1. Задайте параметры ассистента:

        1. Введите название `Тематика диалога`.
        1. В блоке **Инструкция** введите промпт:

            ```text
            Ты оцениваешь диалог оператора и клиента контактного центра. Будь крайне внимателен при ответе.
            Определи тематику, с которой обращается клиент, на основе следующего списка: Виза, Страна, Экскурсии.
            Если ничего из перечисленного не подходит, укажи значение «Иное».
            ```

        1. Выберите модель **Средняя**.

        1. В блоке **Результат** укажите:

            * Название поля — `Тематика`.
            * Тип поля — `Строка`.
            * Описание — `Наиболее подходящая тематика.`

    1. Включите блок **Использование**, чтобы активировать ассистента.

    1. Нажмите кнопку **Создать**.

{% endlist %}

## Загрузите данные в проект {#load-data}

Для работы с API Yandex Cloud потребуются Git, Python 3.11 или новее и пакет `grpcio-tools`. [Узнайте, как установить Python](https://www.python.org/downloads/).

1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
   
   ```bash
   cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
   ```
   
   Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
1. Создайте и активируйте виртуальное окружение, затем установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):
   
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   python3 -m pip install grpcio-tools
   ```
   
   Остальные команды Python выполняйте в этом окружении.
1. В папке с репозиторием API Yandex Cloud создайте папку `upload_data`, сгенерируйте в ней код интерфейса клиента и перейдите в эту папку:

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

1. В папке `upload_data` создайте Python-скрипт `upload_text.py`, который загрузит переписку из чата в SpeechSense:

    ```python
    import argparse
    import json
    from typing import Dict

    import grpc
    from google.protobuf.timestamp_pb2 import Timestamp

    from yandex.cloud.speechsense.v1 import talk_service_pb2
    from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc
    from yandex.cloud.speechsense.v1 import text_pb2


    def upload_talk(connection_id: str, metadata: Dict[str, str], token: str, text_data):
        credentials = grpc.ssl_channel_credentials()
        channel = grpc.secure_channel('api.speechsense.yandexcloud.net:443', credentials)
        talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

        messages = []
        for message in text_data['messages']:
            timestamp = Timestamp()
            timestamp.FromJsonString(message['timestamp'])
            messages.append(text_pb2.Message(
                user_id=str(message['user_id']),
                text=text_pb2.TextPayload(text=message['text']),
                timestamp=timestamp
            ))

        request = talk_service_pb2.UploadTextRequest(
            metadata=talk_service_pb2.TalkMetadata(
                connection_id=connection_id,
                fields=metadata
            ),
            text_content=text_pb2.TextContent(messages=messages)
        )
        response = talk_service_stub.UploadText(request, metadata=(('authorization', token),))
        print(f'Dialog ID: {response.talk_id}')


    if __name__ == '__main__':
        parser = argparse.ArgumentParser()
        parser.add_argument('--key', required=True, help='API key or IAM token')
        parser.add_argument('--key-type', choices=['api-key', 'iam-token'], default='api-key', help='Credentials type')
        parser.add_argument('--connection-id', required=True, help='Connection ID')
        parser.add_argument('--text-path', required=True, help='JSON with text chat data')
        parser.add_argument('--meta-path', required=True, help='JSON with the dialog metadata')
        args = parser.parse_args()

        with open(args.meta_path, encoding='utf-8') as fp:
            metadata = json.load(fp)
        with open(args.text_path, encoding='utf-8') as fp:
            text_data = json.load(fp)

        token = f'Bearer {args.key}' if args.key_type == 'iam-token' else f'Api-Key {args.key}'
        upload_talk(args.connection_id, metadata, token, text_data)
    ```

1. В папке `upload_data` создайте файл `metadata.json` с метаданными диалога:

    ```json
    {
      "operator_name": "Светлана",
      "operator_id": "24",
      "client_name": "Михаил",
      "client_id": "145",
      "date": "2026-10-22T12:34:19+03:00",
      "direction_outgoing": "false",
      "language": "ru-ru"
    }
    ```

    Замените дату и имена на данные своего диалога. Дата в метаданных и время сообщений в следующем файле должны соответствовать друг другу.

1. В папке `upload_data` создайте файл `chat.json` с текстовыми сообщениями:

    ```json
    {
      "messages": [
        {
          "user_id": "145",
          "text": "Здравствуйте, есть ли у вас экскурсионные туры?",
          "timestamp": "2026-10-22T12:34:19+03:00"
        },
        {
          "user_id": "24",
          "text": "Здравствуйте, Михаил. Да, есть экскурсионные туры в Европу и Азию. Какое направление вас интересует?",
          "timestamp": "2026-10-22T12:35:45+03:00"
        },
        {
          "user_id": "145",
          "text": "А в какие страны Азии можно поехать без визы?",
          "timestamp": "2026-10-22T12:37:14+03:00"
        },
        {
          "user_id": "24",
          "text": "Южная Корея.",
          "timestamp": "2026-10-22T12:38:55+03:00"
        },
        {
          "user_id": "145",
          "text": "Спасибо, я подумаю. До свидания.",
          "timestamp": "2026-10-22T12:41:21+03:00"
        },
        {
          "user_id": "24",
          "text": "До свидания.",
          "timestamp": "2026-10-22T12:41:50+03:00"
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

    Параметр `--key-type` по умолчанию равен `api-key`. Чтобы использовать IAM-токен, передайте `--key-type iam-token --key ${IAM_TOKEN}`.

    Результат:

    ```text
    Dialog ID: audh5bbnrstk********
    ```

    Сохраните идентификатор созданного диалога, он понадобится далее для [работы с API](#result-api).

    AI-ассистент обрабатывает диалог асинхронно. Если результат еще не появился, повторите проверку позднее. Готовность анализа отражается в поле `talk_state.processing_state` в ответе REST API и `talkState.processingState` в выводе grpcurl: значение `PROCESSING_STATE_PROCESSING` означает, что обработка продолжается, а `PROCESSING_STATE_SUCCESS` — что она завершена.

## Проверьте результат работы AI-ассистента в интерфейсе SpeechSense {#result-console}

Чтобы посмотреть, какую тематику определил AI-ассистент для диалога:

1. Откройте [главную страницу](https://speechsense.yandex.cloud/) SpeechSense.
1. Перейдите в нужное пространство, затем выберите проект `chats-travel-agency`.
1. На вкладке **Диалоги** включите опцию **Ассистенты**.

Под строкой диалога отобразится строка с указанием тематики `Экскурсии`. Эту тематику AI-ассистент определил как наиболее подходящую диалогу.

## Получите информацию о диалоге с помощью API {#result-api}

### Получите идентификаторы AI-ассистента и его поля {#get-field-id}

{% list tabs group=instructions %}

- REST API {#api}

    Воспользуйтесь методом [Assistants.List](https://aistudio.yandex.ru/docs/ru/speechsense/api-ref/Assistants/list) и выполните запрос, например с помощью [cURL](https://curl.se/):

    ```bash
    curl \
        --request POST \
        --header "Authorization: Api-Key $API_KEY" \
        --header "Content-Type: application/json" \
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

    Воспользуйтесь вызовом [AssistantsService.List](https://aistudio.yandex.ru/docs/ru//speechsense/api-ref/grpc/Assistants/list) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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

В запросе укажите идентификатор диалога, который сохранили [после загрузки](#load-data), и идентификатор проекта. Маска `assistants` ограничит ответ результатами работы AI-ассистентов и базовыми данными диалога.

{% list tabs group=instructions %}

- REST API {#api}

    Воспользуйтесь методом [Talk.Get](https://aistudio.yandex.ru/docs/ru/speechsense/api-ref/Talk/get) и выполните запрос, например с помощью [cURL](https://curl.se/):

    ```bash
    curl \
        --request POST \
        --header "Authorization: Api-Key $API_KEY" \
        --header "Content-Type: application/json" \
        --url 'https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/get' \
        --data '{
                  "projectId": "<идентификатор_проекта>",
                  "talkIds": [
                    "<идентификатор_диалога>"
                  ],
                  "resultsMask": {
                    "paths": ["assistants"]
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
          }
        }
      ]
    }
    ```

    Вы можете найти значение тематики для диалога при помощи поиска по [сохраненным ранее](#get-field-id) идентификаторам AI-ассистента и поля. Нужное значение находится в поле `talk.assistants.assistant_results.results.string_result`: `Экскурсии`.

- gRPC API {#grpc-api}

    Воспользуйтесь вызовом [TalkService.Get](https://aistudio.yandex.ru/docs/ru/speechsense/api-ref/grpc/Talk/get) и выполните запрос, например с помощью [gRPCurl](https://github.com/fullstorydev/grpcurl):

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
                "<идентификатор_диалога>"
              ],
              "results_mask": {
                "paths": ["assistants"]
              }
            }' \
        api.speechsense.yandexcloud.net:443 \
        yandex.cloud.speechsense.v1.TalkService.Get
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
          }
        }
      ]
    }
    ```

    Вы можете найти значение тематики для диалога при помощи поиска по [сохраненным ранее](#get-field-id) идентификаторам AI-ассистента и поля. Нужное значение находится в поле `talk.assistants.assistantResults.results.stringResult`: `Экскурсии`.

{% endlist %}

### Получите результаты для нескольких диалогов {#get-dialogs-batch}

Чтобы получить данные нескольких диалогов, передайте их идентификаторы одним массивом в запросе Get. Рекомендуемый размер пакета — до 100 диалогов. Если ответ получается слишком большим, уменьшите пакет или ограничьте результаты анализа маской `resultsMask` в REST API или `results_mask` в gRPC API.

Каждый вызов Get расходует [квоту на получение диалогов](https://aistudio.yandex.ru/docs/ru/speechsense/concepts/limits#speechsense-quotas). Например, данные 100 диалогов можно получить одним запросом с массивом из 100 ID. При запросе каждого диалога отдельно потребуется 100 запросов. Квоты действуют на проект и учитывают как запросы API, так и просмотр диалогов в интерфейсе SpeechSense.

В этом сценарии загружен один диалог. Если в проекте есть другие диалоги, получите результаты ассистента сразу для нескольких: в приведенных выше командах Get замените тело запроса на один из шаблонов ниже. Укажите идентификаторы проекта и нужных диалогов.

{% list tabs group=instructions %}

- REST API {#batch-api}

    ```json
    {
      "projectId": "<идентификатор_проекта>",
      "talkIds": [
        "<идентификатор_первого_диалога>",
        "<идентификатор_второго_диалога>"
      ],
      "resultsMask": {
        "paths": ["assistants"]
      }
    }
    ```

- gRPC API {#batch-grpc-api}

    ```json
    {
      "project_id": "<идентификатор_проекта>",
      "talk_ids": [
        "<идентификатор_первого_диалога>",
        "<идентификатор_второго_диалога>"
      ],
      "results_mask": {
        "paths": ["assistants"]
      }
    }
    ```

{% endlist %}

В ответе массив `talk` будет содержать данные найденных диалогов. Сопоставляйте результаты с диалогами по полю `talk.id`.

## Удалите ресурсы {#clear-out}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, [удалите проект SpeechSense](https://aistudio.yandex.ru/docs/ru/speechsense/operations/project/delete), если вы больше не будете его использовать. AI-ассистент будет удален при удалении проекта.