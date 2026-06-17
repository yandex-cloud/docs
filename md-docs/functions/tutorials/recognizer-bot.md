# Разработка Telegram-бота для распознавания текста на изображениях, синтеза и распознавания аудио


В этом руководстве вы создадите [бота](../../glossary/chat-bot.md) для Telegram, который умеет:

* [синтезировать речь](https://aistudio.yandex.ru/docs/ru//speechkit/tts/index) из текста сообщения и [распознавать речь](https://aistudio.yandex.ru/docs/ru//speechkit/stt/index) в голосовых сообщениях с помощью [Python SDK](https://pypi.org/project/yandex-speechkit/) сервиса Yandex SpeechKit;
* [распознавать текст](https://aistudio.yandex.ru/docs/ru/vision/concepts/ocr/index) на изображениях с помощью сервиса Yandex Vision OCR.

Аутентификация в сервисах Yandex Cloud выполняется от имени сервисного аккаунта с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md). IAM-токен содержится в контексте [обработчика функции](../operations/function-sa.md), которая программирует диалог пользователя с ботом.

Запросы от бота будет принимать [API-шлюз](../../api-gateway/concepts/index.md) Yandex API Gateway и перенаправлять их [функции](../concepts/function.md) Yandex Cloud Functions для обработки.

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

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки Telegram-бота входят:

* плата за использование SpeechKit ([тарифы SpeechKit](https://aistudio.yandex.ru/docs/ru/speechkit/pricing));
* плата за использование Vision OCR ([тарифы для Vision OCR](https://aistudio.yandex.ru/docs/ru/vision/pricing));
* плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик ([тарифы для Cloud Functions](../pricing.md));
* плата за количество запросов к созданному API-шлюзу и исходящий трафик ([тарифы API Gateway](../../api-gateway/pricing.md)).

## Подготовьте ресурсы {#prepare}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `recognizer-bot-sa` и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему роли `ai.editor`, `functions.editor` на ваш каталог.
1. [Скачайте](https://github.com/BtbN/FFmpeg-Builds/releases/download/autobuild-2024-09-30-15-36/ffmpeg-N-117275-g04182b5549-linux64-gpl.tar.xz) архив с пакетом FFmpeg для корректной работы Python SDK SpeechKit в [среде выполнения функции](../concepts/runtime/index.md).
1. Извлеките из архива бинарные файлы `ffmpeg`, `ffprobe` и сделайте их исполняемыми, выполнив команды:

    ```bash
    chmod +x ffmpeg
    chmod +x ffprobe
    ```

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
      from speechkit import model_repository, configure_credentials, creds
      from speechkit.stt import AudioProcessingType


      folder_id = ""
      iam_token = ''
      
      # Эндпоинт сервиса распознавания изображений и данные для аутентификации

      API_TOKEN = os.environ['TELEGRAM_TOKEN']
      vision_url = 'https://ocr.api.cloud.yandex.net/ocr/v1/recognizeText'

      # Добавление папки с ffmpeg в системный PATH

      path = os.environ.get("PATH")
      os.environ["PATH"] = path + ':/function/code'

      logger = telebot.logger
      telebot.logger.setLevel(logging.INFO)
      bot = telebot.TeleBot(API_TOKEN, threaded=False)
      
      # Получение идентификатора каталога

      def get_folder_id(iam_token, version_id):
          headers = {'Authorization': f'Bearer {iam_token}'}
          function_id_req = requests.get(f'https://serverless-functions.api.cloud.yandex.net/functions/v1/versions/{version_id}',
                                         headers=headers)
          function_id_data = function_id_req.json()
          function_id = function_id_data['functionId']
          folder_id_req = requests.get(f'https://serverless-functions.api.cloud.yandex.net/functions/v1/functions/{function_id}',
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

          # Аутентификация в SpeechKit через IAM-токен
          configure_credentials(
              yandex_credentials=creds.YandexCredentials(
                  iam_token=iam_token
              )
          )

          process_event(event)
          return {
              'statusCode': 200
          }

      # Обработчики команд и сообщений

      @bot.message_handler(commands=['help', 'start'])
      def send_welcome(message):
          bot.reply_to(message,
                       "Бот умеет:\n* распознавать текст с картинок;\n* генерировать голосовые сообщения из текста;\n* переводить голосовые сообщения в текст.")

      @bot.message_handler(func=lambda message: True, content_types=['text'])
      def echo_message(message):
          export_path = '/tmp/audio.ogg'
          synthesize(message.text, export_path)
          with open(export_path, 'rb') as voice:
              bot.send_voice(message.chat.id, voice)

      @bot.message_handler(func=lambda message: True, content_types=['voice'])
      def echo_audio(message):
          file_id = message.voice.file_id
          file_info = bot.get_file(file_id)
          downloaded_file = bot.download_file(file_info.file_path)
          response_text = audio_analyze(downloaded_file)
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

      def audio_analyze(audio_data):
          model = model_repository.recognition_model()

          # Настройки распознавания
          model.model = 'general'
          model.language = 'ru-RU'
          model.audio_processing_type = AudioProcessingType.Full

          result = model.transcribe(audio_data)
          speech_text = [res.normalized_text for res in result]
          return ' '.join(speech_text)
      
      # Синтез речи

      def synthesize(text, export_path):
          model = model_repository.synthesis_model()

          # Настройки синтеза
          model.voice = 'kirill'

          result = model.synthesize(text, raw_format=False)
          result.export(export_path, 'ogg')
      ```

      {% endcut %}

   1. Создайте файл `requirements.txt` и укажите в нем библиотеку для работы с ботом и библиотеку Python SDK.

      ```text
      pyTelegramBotAPI==4.27
      yandex-speechkit==1.5.0
      ```

   1. Добавьте в ZIP-архив `index.zip` файлы `index.py`, `requirements.txt`, `ffmpeg` и `ffprobe`.

1. [Создайте бакет](../../storage/operations/buckets/create.md) Object Storage и [загрузите в него](../../storage/operations/objects/upload.md) созданный ZIP-архив.

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

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите создать функцию.
  1. [Перейдите]( ../../console/operations/select-service.md#select-service) в сервис **Cloud Functions**.
  1. Создайте функцию:

     1. Нажмите **Создать функцию**.
     1. Введите имя функции — `for-recognizer-bot`.
     1. Нажмите **Создать**.

  1. Создайте версию функции:

     1. Выберите среду выполнения `Python`, отключите опцию **Добавить файлы с примерами кода** и нажмите **Продолжить**.
     1. Укажите способ загрузки `Object Storage` и выберите [созданный ранее](#prepare) бакет. В поле **Объект** укажите имя файла `index.zip`.
     1. Укажите точку входа `index.handler`.
     1. В блоке **Параметры** укажите:

        * **Таймаут** — `30`.
        * **Память** — `256 МБ`.
        * **Сервисный аккаунт** — `recognizer-bot-sa`.
        * **Переменные окружения**:

          * `TELEGRAM_TOKEN` — токен вашего бота в Telegram.

     1. Нажмите **Сохранить изменения**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
     http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9********
     status: ACTIVE
     ```

  1. Создайте версию функции `for-recognizer-bot`:

     ```bash
     yc serverless function version create \
       --function-name for-recognizer-bot \
       --memory=256m \
       --execution-timeout=30s \
       --runtime=python312 \
       --entrypoint=index.handler \
       --service-account-id=<идентификатор_сервисного_аккаунта> \
       --environment TELEGRAM_TOKEN=<токен_бота> \
       --package-bucket-name=<имя_бакета> \
       --package-object-name=index.zip
     ```

     Где:

     * `--function-name` — имя функции, версия которой создается.
     * `--memory` — объем RAM.
     * `--execution-timeout` — максимальное время выполнения функции до таймаута.
     * `--runtime` — среда выполнения.
     * `--entrypoint` — точка входа.
     * `--service-account-id` — идентификатор сервисного аккаунта `recognizer-bot-sa`.
     * `--environment` — переменные окружения.
     * `--package-bucket-name` — имя бакета.
     * `--package-object-name` — ключ файла в бакете `index.zip`.

     Результат:

     ```text
     done (1s)
     id: d4e6qqlh53nu********
     function_id: d4emc80mnp5n********
     created_at: "2025-03-22T16:49:41.800Z"
     runtime: python312
     entrypoint: index.handler
     resources:
       memory: "268435456"
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

- Terraform {#tf}

  
  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.


  1. Опишите в конфигурационном файле параметры функции:

     ```hcl
     resource "yandex_function" "for-recognizer-bot-function" {
       name               = "for-recognizer-bot"
       user_hash          = "first function"
       runtime            = "python312"
       entrypoint         = "index.handler"
       memory             = "256"
       execution_timeout  = "30"
       service_account_id = "aje20nhregkcvu******"
       environment = {
         TELEGRAM_TOKEN = <токен_бота>
       }
       package {
         bucket_name = <имя_бакета>
         object_name = "index.zip"
       }
     }
     ```

     Где:

     * `name` — имя функции.
     * `user_hash` — произвольная строка, определяющая версию функции.
     * `runtime` — [среда выполнения](../concepts/runtime/index.md) функции.
     * `entrypoint` — точка входа.
     * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
     * `execution_timeout` — таймаут выполнения функции.
     * `service_account_id` — идентификатор сервисного аккаунта `recognizer-bot-sa`.
     * `environment` — переменные окружения.
     * `package` — имя бакета, в который загружен ZIP-архив `index.zip` с исходным кодом функции.

     Подробнее о параметрах ресурса `yandex_function` смотрите в [документации провайдера](../../terraform/resources/function.md).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Разверните облачные ресурсы.

     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```

     1. Подтвердите создание функции: введите в терминал слово `yes` и нажмите **Enter**.

- API {#api}

  Чтобы создать функцию, воспользуйтесь методом [create](../functions/api-ref/Function/create.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/Create](../functions/api-ref/grpc/Function/create.md).

  Чтобы создать версию функцию, воспользуйтесь методом [createVersion](../functions/api-ref/Function/createVersion.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}

## Создайте API-шлюз {#create-api-gateway}

Сервер Telegram будет оповещать ваш бот о поступлении новых сообщений с помощью [веб-хука](https://core.telegram.org/bots/api#setwebhook). API-шлюз будет принимать запросы на стороне бота и перенаправлять их функции `for-recognizer-bot` для обработки.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать API-шлюз.
  1. Перейдите в сервис **API Gateway**.
  1. Нажмите **Создать API-шлюз**.
  1. В поле **Имя** введите `recognizer-bot-api-gw`.
  1. В блок **Спецификация** добавьте спецификацию:

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

  1. Нажмите **Создать**.
  1. Выберите созданный API-шлюз. Сохраните значение поля **Служебный домен** — оно потребуется в дальнейшем.

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
     domain: d5dm1lba80md********.i9******.apigw.yandexcloud.net
     log_group_id: ckgefpleo5eg********
     connectivity: {}
     log_options:
       folder_id: b1gc1t4cb638********
     ```

- Terraform {#tf}

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

     Подробнее о параметрах ресурсов в Terraform смотрите в [документации провайдера](../../terraform/resources/api_gateway.md).

  1. Проверьте корректность конфигурационных файлов.

     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, Terraform на них укажет.

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
  --url 'https://api.telegram.org/bot<токен_бота>/setWebhook' \
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

   Изображение должно соответствовать [требованиям](https://aistudio.yandex.ru/docs/ru/vision/concepts/ocr/index#image-requirements).

   {% endnote %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы не [платить](#paid-resources) за ресурсы, которые вам больше не нужны, удалите их:

* [удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз API Gateway;
* [удалите](../operations/function/function-delete.md) функцию Cloud Functions.