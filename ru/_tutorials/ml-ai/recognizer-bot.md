# Разработка Telegram-бота для распознавания текста на изображениях, синтеза и распознавания аудио


В этом руководстве вы создадите [бота](../../glossary/chat-bot.md) для Telegram, который умеет:

* [синтезировать речь](../../speechkit/tts/index.md) из текста сообщения с помощью [API v1](../../speechkit/tts/request.md) сервиса {{ speechkit-full-name }};
* [распознавать речь](../../speechkit/stt/index.md) в голосовых сообщениях и преобразовывать ее в текст с помощью с помощью [API синхронного распознавания](../../speechkit/stt/api/request-api.md) сервиса {{ speechkit-full-name }};
* [распознавать текст](../../vision/concepts/ocr/index.md) на изображениях с помощью сервиса {{ vision-full-name }}.

Запросы от бота будет принимать API-шлюз {{ api-gw-full-name }} и перенаправлять их функции {{ sf-full-name }} для обработки.

Чтобы создать бота:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Подготовьте ресурсы](#prepare).
1. [Зарегистрируйте Telegram-бота](#bot-register).
1. [Создайте функцию](#create-function).
1. [Создайте API-шлюз](#create-api-gateway).
1. [Свяжите функцию и бота](#link-bot).
1. [Протестируйте бота](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки Telegram-бота входят:

* плата за использование {{ speechkit-name }} (см. [тарифы для {{ speechkit-name }}](../../speechkit/pricing.md));
* плата за использование {{ vision-name }} (см. [тарифы для {{ vision-name }}](../../vision/pricing.md));
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы для {{ sf-name }}](../../functions/pricing.md));
* плата за количество запросов к созданному API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-name }}](../../api-gateway/pricing.md)).


## Подготовьте ресурсы {#prepare}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `recognizer-bot-sa` и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роли `ai.editor`, `{{ roles-functions-editor }}` на ваш каталог.
1. Подготовьте ZIP-архив с кодом функции:

   1. Создайте файл `index.py` и добавьте в него указанный ниже код.

      {% cut "index.py" %}

      ```py
      import logging
      import requests
      import telebot
      import json
      import os
      import base64
      
      # Эндпоинты сервисов и данные для аутентификации

      API_TOKEN = os.environ['TELEGRAM_TOKEN']
      vision_url = 'https://ocr.{{ api-host }}/ocr/v1/recognizeText'
      speechkit_url = 'https://stt.{{ api-host }}/speech/v1/stt:recognize'
      speechkit_synthesis_url = 'https://tts.{{ api-host }}/speech/v1/tts:synthesize'
      folder_id = ""
      iam_token = ''

      logger = telebot.logger
      telebot.logger.setLevel(logging.INFO)
      bot = telebot.TeleBot(API_TOKEN, threaded=False)
      
      # Получение идентификатора каталога

      def get_folder_id(iam_token, version_id):

          headers = {'Authorization': f'Bearer {iam_token}'}
          function_id_req = requests.get(f'https://serverless-functions.{{ api-host }}/functions/v1/versions/{version_id}',
                                         headers=headers)
          function_id_data = function_id_req.json()
          function_id = function_id_data['functionId']
          folder_id_req = requests.get(f'https://serverless-functions.{{ api-host }}/functions/v1/functions/{function_id}',
                                       headers=headers)
          folder_id_data = folder_id_req.json()
          folder_id = folder_id_data['folderId']
          return folder_id

      def process_event(event):

          request_body_dict = json.loads(event['body'])
          update = telebot.types.Update.de_json(request_body_dict)

          bot.process_new_updates([update])

      def handler(event, context):
          global iam_token, folder_id
          iam_token = context.token["access_token"]
          version_id = context.function_version
          folder_id = get_folder_id(iam_token, version_id)
          process_event(event)
          return {
              'statusCode': 200
          }

      # Обработчики команд и сообщений

      @bot.message_handler(commands=['help', 'start'])
      def send_welcome(message):
          bot.reply_to(message,
                       "Бот умеет:\n*распознавать текст с картинок;\n* генерировать голосовые сообщения из текста;\n* переводить голосовые сообщения в текст.")

      @bot.message_handler(func=lambda message: True, content_types=['text'])
      def echo_message(message):
          global iam_token, folder_id
          with open('/tmp/audio.ogg', "wb") as f:
              for audio_content in synthesize(folder_id, iam_token, message.text):
                  f.write(audio_content)
          voice = open('/tmp/audio.ogg', 'rb')
          bot.send_voice(message.chat.id, voice)

      @bot.message_handler(func=lambda message: True, content_types=['voice'])
      def echo_audio(message):
          file_id = message.voice.file_id
          file_info = bot.get_file(file_id)
          downloaded_file = bot.download_file(file_info.file_path)
          response_text = audio_analyze(speechkit_url, iam_token, folder_id, downloaded_file)
          bot.reply_to(message, response_text)

      @bot.message_handler(func=lambda message: True, content_types=['photo'])
      def echo_photo(message):
          file_id = message.photo[-1].file_id
          file_info = bot.get_file(file_id)
          downloaded_file = bot.download_file(file_info.file_path)
          image_data = base64.b64encode(downloaded_file).decode('utf-8')
          response_text = image_analyze(vision_url, iam_token, folder_id, image_data)
          bot.reply_to(message, response_text)
      
      # Распознавание изображения

      def image_analyze(vision_url, iam_token, folder_id, image_data):
          response = requests.post(vision_url, headers={'Authorization': 'Bearer '+iam_token, 'x-folder-id': folder_id}, json={
              "mimeType": "image",
              "languageCodes": ["en", "ru"],
              "model": "page",
              "content": image_data
              })
          blocks = response.json()['result']['textAnnotation']['blocks']
          text = ''
          for block in blocks:
              for line in block['lines']:
                  for word in line['words']:
                      text += word['text'] + ' '
                  text += '\n'
          return text
      
      # Распознавание речи

      def audio_analyze(speechkit_url, iam_token, folder_id, audio_data):
          headers = {'Authorization': f'Bearer {iam_token}'}
          params = {
              "topic": "general",
              "folderId": f"{folder_id}",
              "lang": "ru-RU"}

          audio_request = requests.post(speechkit_url, params=params, headers=headers, data=audio_data)
          responseData = audio_request.json()
          response = 'error'
          if responseData.get("error_code") is None:
              response = (responseData.get("result"))
          return response
      
      # Синтез речи

      def synthesize(folder_id, iam_token, text):
         headers = {
             'Authorization': 'Bearer ' + iam_token,
         }

         data = {
             'text': text,
             'lang': 'ru-RU',
             'voice': 'filipp',
             'folderId': folder_id
         }

         with requests.post(speechkit_synthesis_url, headers=headers, data=data, stream=True) as resp:
             if resp.status_code != 200:
                 raise RuntimeError("Invalid response received: code: %d, message: %s" % (resp.status_code, resp.text))

             for chunk in resp.iter_content(chunk_size=None):
                 yield chunk
      ```

      {% endcut %}

   1. Создайте файл `requirements.txt` и укажите в нем библиотеку для работы с ботом.

      ```text
      telebot
      ```

   1. Добавьте оба файла в ZIP-архив `index.zip`.

## Зарегистрируйте Telegram-бота {#bot-register}

Зарегистрируйте бота в Telegram и получите токен.

1. Запустите бота [BotFather](https://t.me/BotFather) и отправьте ему команду:

   ```text
   /newbot
   ```

1. В поле `name` укажите имя создаваемого бота. Это имя увидят пользователи при общении с ботом.
1. В поле `username` укажите имя пользователя создаваемого бота. По имени пользователя можно будет найти бота в Telegram. Имя пользователя должно оканчиваться на `...Bot` или `..._bot`.

   В результате вы получите токен. Сохраните его — он потребуется в дальнейшем.

## Создайте функцию {#create-function}

Создайте функцию, которая будет обрабатывать действия пользователей в чате.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**
  1. Создайте функцию:

     1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
     1. Введите имя функции — `for-recognizer-bot`.
     1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

  1. Создайте версию функции:

     1. Выберите среду выполнения `Python`, отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. Укажите способ загрузки `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` и выберите архив `index.zip`, который [подготовили](#prepare) раньше.
     1. Укажите точку входа `index.handler`.
     1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}** укажите:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `30`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `recognizer-bot-sa`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

          * `TELEGRAM_TOKEN` — токен вашего бота в Telegram.

     1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Создайте функцию `for-recognizer-bot`:

     ```bash
     yc serverless function create --name=for-recognizer-bot
     ```

     Результат:

     ```text
     id: b09bhaokchn9********
     folder_id: aoek49ghmknn********
     created_at: "2023-03-21T10:03:37.475Z"
     name: for-recognizer-bot
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
     status: ACTIVE
     ```

  1. Создайте версию функции `for-recognizer-bot`:

     ```bash
     yc serverless function version create \
       --function-name for-recognizer-bot \
       --memory=128m \
       --execution-timeout=30s \
       --runtime=python312 \
       --entrypoint=index.handler \
       --service-account-id=<идентификатор_сервисного_аккаунта> \
       --environment TELEGRAM_TOKEN=<токен_бота> \
       --source-path=./index.zip
     ```

     Где:

     * `--function-name` — имя функции, версия которой создается.
     * `--memory` — объем RAM.
     * `--execution-timeout` — максимальное время выполнения функции до таймаута.
     * `--runtime` — среда выполнения.
     * `--entrypoint` — точка входа.
     * `--service-account-id` — идентификатор сервисного аккаунта `recognizer-bot-sa`.
     * `--environment` — переменные окружения.
     * `--source-path` — путь до ZIP-архива `index.zip`.

     Результат:

     ```text
     done (1s)
     id: d4e6qqlh53nu********
     function_id: d4emc80mnp5n********
     created_at: "2023-03-22T16:49:41.800Z"
     runtime: python312
     entrypoint: index.handler
     resources:
       memory: "134217728"
     execution_timeout: 30s
     service_account_id: aje20nhregkc********
     image_size: "4096"
     status: ACTIVE
     tags:
       - $latest
     log_group_id: ckgmc3l93cl0********
     environment:
       TELEGRAM_TOKEN: <токен_бота>
     log_options:
       folder_id: b1g86q4m5vej********
     ```

- {{ TF }} {#tf}

  1. Опишите в конфигурационном файле параметры функции:

     ```hcl
     resource "yandex_function" "for-recognizer-bot-function" {
       name               = "for-recognizer-bot"
       user_hash          = "first function"
       runtime            = "python312"
       entrypoint         = "index.handler"
       memory             = "128"
       execution_timeout  = "30"
       service_account_id = "aje20nhregkcvu******"
       environment = {
         TELEGRAM_TOKEN = <токен_бота>
       }
       content {
         zip_filename = "./index.zip"
       }
     }
     ```

     Где:

     * `name` — имя функции.
     * `user_hash` — произвольная строка, определяющая версию функции.
     * `runtime` — [среда выполнения](../../functions/concepts/runtime/index.md) функции.
     * `entrypoint` — точка входа.
     * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
     * `execution_timeout` — таймаут выполнения функции.
     * `service_account_id` — идентификатор сервисного аккаунта `recognizer-bot-sa`.
     * `environment` — переменные окружения.
     * `content` — путь до ZIP-архива `index.zip` с исходным кодом функции.

     Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание функции: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать функцию, воспользуйтесь методом [create](../../functions/functions/api-ref/Function/create.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md).

  Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../../functions/functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}

## Создайте API-шлюз {#create-api-gateway}

Сервер Telegram будет оповещать ваш бот о поступлении новых сообщений с помощью [веб-хука](https://core.telegram.org/bots/api#setwebhook). API-шлюз будет принимать запросы на стороне бота и перенаправлять их функции `for-recognizer-bot` для обработки.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать API-шлюз.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.common.name }}** введите `recognizer-bot-api-gw`.
  1. В блок **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** добавьте спецификацию:

     ```yaml
     openapi: 3.0.0
     info:
       title: Sample API
       version: 1.0.0
     paths:
       /for-recognizer-bot-function:
         post:
           x-yc-apigateway-integration:
             type: cloud_functions
             function_id: <идентификатор_функции>
             service_account_id: <идентификатор_сервисного_аккаунта>
           operationId: for-recognizer-bot-function
     ```

     Где:

     * `function_id` — идентификатор функции `for-recognizer-bot`;
     * `service_account_id` — идентификатор сервисного аккаунта `recognizer-bot-sa`.

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Выберите созданный API-шлюз. Сохраните значение поля **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** — оно потребуется в дальнейшем.

- CLI {#cli}

  1. Сохраните следующую спецификацию в файл `spec.yaml`:

     ```yaml
     openapi: 3.0.0
     info:
       title: Sample API
       version: 1.0.0
     paths:
       /for-recognizer-bot-function:
         post:
           x-yc-apigateway-integration:
             type: cloud_functions
             function_id: <идентификатор_функции>
             service_account_id: <идентификатор_сервисного_аккаунта>
           operationId: for-recognizer-bot-function
     ```

     Где:

     * `function_id` — идентификатор функции `for-recognizer-bot`.
     * `service_account_id` — идентификатор сервисного аккаунта `recognizer-bot-sa`.

  1. Выполните команду:

     ```bash
     yc serverless api-gateway create --name recognizer-bot-api-gw --spec=spec.yaml
     ```

     Где:

     * `--name` — имя API-шлюза.
     * `--spec` — файл со спецификацией.

     Результат:

     ```text
     done (5s)
     id: d5d1ud9bli1e********
     folder_id: b1gc1t4cb638********
     created_at: "2023-09-25T16:01:48.926Z"
     name: recognizer-bot-api-gw
     status: ACTIVE
     domain: d5d1ud9bli1e********.apigw.yandexcloud.net
     log_group_id: ckgefpleo5eg********
     connectivity: {}
     log_options:
       folder_id: b1gc1t4cb638********
     ```

- {{ TF }} {#tf}

  Чтобы создать API-шлюз:

  1. Опишите в конфигурационном файле параметры ресурса `yandex_api_gateway`:

     ```hcl
     resource "yandex_api_gateway" "recognizer-bot-api-gw" {
       name        = "recognizer-bot-api-gw"
       spec = <<-EOT
         openapi: 3.0.0
         info:
           title: Sample API
           version: 1.0.0

         paths:
           /for-recognizer-bot-function:
             post:
               x-yc-apigateway-integration:
                 type: cloud_functions
                 function_id: <идентификатор_функции>
                 service_account_id: <идентификатор_сервисного_аккаунта>
               operationId: for-recognizer-bot-function
       EOT
     }
     ```

     Где:

     * `name` — имя API-шлюза.
     * `spec` — спецификация API-шлюза.

     Более подробную информацию о параметрах ресурсов в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/api_gateway).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать API-шлюз, воспользуйтесь методом REST API [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) для ресурса [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md).

{% endlist %}

## Настройте связь между функцией и Telegram-ботом {#link-bot}

Установите веб-хук для вашего Telegram-бота:

```bash
curl --request POST \
  --url https://api.telegram.org/bot<токен_бота>/setWebhook \
  --header 'content-type: application/json' \ 
  --data '{"url": "<домен_API-шлюза>/for-recognizer-bot-function"}'
```

Где:

* `<токен_бота>` — токен Telegram-бота.
* `<домен_API-шлюза>` — служебный домен API-шлюза `recognizer-bot-api-gw`.

Результат:

```json
{"ok":true,"result":true,"description":"Webhook was set"}
```

## Протестируйте бота {#test}

Поговорите с ботом:

1. Откройте Telegram и найдите бота по [указанному](#bot-register) имени пользователя `username`.
1. Отправьте в чат сообщение `/start`.

   Бот должен ответить:

   ```text
   Бот умеет:

   * распознавать текст с картинок;
   * генерировать голосовые сообщения из текста;
   * переводить голосовые сообщения в текст.
   ```

1. Отправьте в чат текстовое сообщение. Бот ответит голосовым сообщением, синтезированным из вашего текста.
1. Отправьте в чат голосовое сообщение. Бот ответит сообщением с текстом, распознанным из вашей речи.
1. Отправьте в чат изображение с текстом. Бот ответит сообщением с распознанным текстом.

   {% note info %}

   Изображение должно соответствовать [требованиям](../../vision/concepts/ocr/index.md#image-requirements).

   {% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз {{ api-gw-name }};
* [удалите](../../functions/operations/function/function-delete.md) функцию {{ sf-name }}.
