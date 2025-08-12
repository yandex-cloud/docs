# Developing a Telegram bot for text recognition in images, audio synthesis and recognition


In this tutorial, you will create a Telegram bot that can:

* [Synthesize speech](../../speechkit/tts/index.md) from a message text and [recognize speech](../../speechkit/stt/index.md) in voice messages using the {{ speechkit-full-name }} [Python SDK](../../speechkit/sdk/python/index.md).
* [Recognize text](../../vision/concepts/ocr/index.md) in images using {{ vision-full-name }}.

Authentication in {{ yandex-cloud }} services is performed under a service account using an [IAM token](../../iam/concepts/authorization/iam-token.md). The IAM token is contained in the handler context of the [function](../../functions/operations/function-sa.md) which manages user conversation with the bot.

The {{ api-gw-full-name }} will receive requests from your bot and forward them to {{ sf-full-name }} for processing.

To create a bot:

1. [Get your cloud ready](#before-you-begin).
1. [Set up resources](#prepare).
1. [Register your Telegram bot](#bot-register).
1. [Create a function](#create-function).
1. [Create an API gateway](#create-api-gateway).
1. [Link the function and the bot](#link-bot).
1. [Test the bot](#test).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of Telegram bot support includes:

* Fee for using {{ speechkit-name }} (see [{{ speechkit-name }} pricing](../../speechkit/pricing.md)).
* Fee for using {{ vision-name }} (see [{{ vision-name }} pricing](../../vision/pricing.md)).
* Fee for function invocation count, computing resources allocated to run the function, and outbound traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for the number of requests to the API gateway and outbound traffic (see [{{ api-gw-name }} pricing](../../api-gateway/pricing.md)).

## Set up resources {#prepare}

1. [Create a service account](../../iam/operations/sa/create.md) named `recognizer-bot-sa` and assign it the `ai.editor` and `{{ roles-functions-editor }}` [roles](../../iam/operations/sa/assign-role-for-sa.md) for your folder.
1. [Download](https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-linuxarm64-gpl.tar.xz) the archive with the FFmpeg package for the {{ speechkit-name }} Python SDK to work correctly in the [function execution environment](../../functions/concepts/runtime/index.md).
1. Create a ZIP archive with the function code:

   1. Create a file named `index.py` and paste the code below to it.

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

      
      # Service endpoints and authentication credentials

      API_TOKEN = os.environ['TELEGRAM_TOKEN']
      vision_url = 'https://ocr.{{ api-host }}/ocr/v1/recognizeText'
      folder_id = ""
      iam_token = ''
      path = os.environ.get("PATH")
      os.environ["PATH"] = path + ':/function/code'


      logger = telebot.logger
      telebot.logger.setLevel(logging.INFO)
      bot = telebot.TeleBot(API_TOKEN, threaded=False)
      
      # Getting the folder ID

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

          # Authenticating in SpeechKit with an IAM token
          configure_credentials(
              yandex_credentials=creds.YandexCredentials(
                  iam_token=iam_token
              )
          )

          process_event(event)
          return {
              'statusCode': 200
          }

      # Command and message handlers

      @bot.message_handler(commands=['help', 'start'])
      def send_welcome(message):
          bot.reply_to(message,
                       "The bot can do the following:\n*Recognize text from images.\n* Generate voice messages from text.\n* Convert voice messages to text.")

      @bot.message_handler(func=lambda message: True, content_types=['text'])
      def echo_message(message):
          export_path = '/tmp/audio.ogg'
          synthesize(message.text, export_path)
          voice = open(export_path, 'rb')
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
      
      # Image recognition

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
      
      # Speech recognition

      def audio_analyze(audio_data):
          model = model_repository.recognition_model()

          # Recognition settings
          model.model = 'general'
          model.language = 'ru-RU'
          model.audio_processing_type = AudioProcessingType.Full

          try:
              result = model.transcribe(audio_data)
              speech_text = [res.normalized_text for res in result]
              return ' '.join(speech_text)
          except:
              return 'Cannot recognize message'
      
      # Speech synthesis

      def synthesize(folder_id, iam_token, text):
          model = model_repository.synthesis_model()

          # Synthesis settings
          model.voice = 'kirill'

          result = model.synthesize(text, raw_format=False)
          result.export(export_path, 'ogg')
      ```

      {% endcut %}

   1. Create a file named `requirements.txt`. In this file, specify a library to use for the bot and the Python SDK library.

      ```text
      telebot
      yandex-speechkit
      ```

   1. Add the `index.py` and `requirements.txt` files and the `ffmpeg` and `ffprobe` binary files from the FFMpeg utility into the `index.zip` ZIP archive.
   1. Create an [{{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) and [upload the created ZIP archive into it](../../storage/operations/objects/upload.md).

## Register your Telegram bot {#bot-register}

Register your bot in Telegram and get a token.

1. Start [BotFather](https://t.me/BotFather) and send it the following command:

   ```text
   /newbot
   ```

1. In the `name` field, enter a name for the new bot. This is the name users will see when chatting with the bot.
1. In the `username` field, enter a username for the new bot. You can use it to find the bot in Telegram. The username must end with `...Bot` or `..._bot`.

   Once done, you will get a token. Save it, as you will need it later.

## Create a function {#create-function}

Create a function to process user actions in the chat.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:

     1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
     1. Enter the function name: `for-recognizer-bot`.
     1. Click **{{ ui-key.yacloud.common.create }}**.

  1. Create a function version:

     1. Select `Python` as the runtime environment, disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. Specify the upload method `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-storage }}` and select the bucket you [created earlier](#prepare). In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_object}}** field, specify the file name: `index.zip`.
     1. Specify the entry point: `index.handler`.
     1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `30`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `recognizer-bot-sa`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

          * `TELEGRAM_TOKEN`: Your Telegram bot token.

     1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  1. Create a function named `for-recognizer-bot`:

     ```bash
     yc serverless function create --name=for-recognizer-bot
     ```

     Result:

     ```text
     id: b09bhaokchn9********
     folder_id: aoek49ghmknn********
     created_at: "2023-03-21T10:03:37.475Z"
     name: for-recognizer-bot
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
     status: ACTIVE
     ```

  1. Create a version of the `for-recognizer-bot` function:

     ```bash
     yc serverless function version create \
       --function-name for-recognizer-bot \
       --memory=128m \
       --execution-timeout=30s \
       --runtime=python312 \
       --entrypoint=index.handler \
       --service-account-id=<service_account_ID> \
       --environment TELEGRAM_TOKEN=<bot_token> \
       --package-bucket-name=<bucket_name> \
       --package-object-name=index.zip
     ```

     Where:

     * `--function-name`: Name of the function whose version you are creating.
     * `--memory`: Amount of RAM.
     * `--execution-timeout`: Maximum function running time before timeout.
     * `--runtime`: Runtime environment.
     * `--entrypoint`: Entry point.
     * `--service-account-id`: `recognizer-bot-sa` service account ID.
     * `--environment`: Environment variables.
     * `--package-bucket-name`: Bucket name.
     * `--package-object-name`: File key in the `index.zip` bucket.

     Result:

     ```text
     done (1s)
     id: d4e6qqlh53nu********
     function_id: d4emc80mnp5n********
     created_at: "2025-03-22T16:49:41.800Z"
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
       TELEGRAM_TOKEN: <bot_token>
     log_options:
       folder_id: b1g86q4m5vej********
     ```

- {{ TF }} {#tf}

  1. In the configuration file, describe the function settings:

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
         TELEGRAM_TOKEN = <bot_token>
       }
       package {
         bucket_name = <bucket_name>
         object_name = "index.zip"
       }
     }
     ```

     Where:

     * `name`: Function name.
     * `user_hash`: Custom string to define the function version.
     * `runtime`: Function [runtime environment](../../functions/concepts/runtime/index.md).
     * `entrypoint`: Entry point.
     * `memory`: Amount of memory allocated for the function, in MB.
     * `execution_timeout`: Function execution timeout.
     * `service_account_id`: `recognizer-bot-sa` service account ID.
     * `environment`: Environment variables.
     * `package`: Name of the bucket containing the uploaded `index.zip` archive with the function source code.

     For more information about `yandex_function` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/function).

  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the function by typing `yes` in the terminal and pressing **Enter**.

- API {#api}

  To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call.

  To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}

## Create an API gateway {#create-api-gateway}

The Telegram server will notify your bot of new messages using a [webhook](https://core.telegram.org/bots/api#setwebhook). The API gateway will receive requests on the bot side and forward them to the `for-recognizer-bot` function for processing.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, enter `recognizer-bot-api-gw`.
  1. Under **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}**, add the following specification:

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
             function_id: <function_ID>
             service_account_id: <service_account_ID>
           operationId: for-recognizer-bot-function
     ```

     Where:

     * `function_id`: `for-recognizer-bot` function ID.
     * `service_account_id`: `recognizer-bot-sa` service account ID.

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Select the created API gateway. Save the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field value. You will need it later.

- CLI {#cli}

  1. Save the following specification to `spec.yaml`:

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
             function_id: <function_ID>
             service_account_id: <service_account_ID>
           operationId: for-recognizer-bot-function
     ```

     Where:

     * `function_id`: `for-recognizer-bot` function ID.
     * `service_account_id`: `recognizer-bot-sa` service account ID.

  1. Run this command:

     ```bash
     yc serverless api-gateway create --name recognizer-bot-api-gw --spec=spec.yaml
     ```

     Where:

     * `--name`: API gateway name.
     * `--spec`: Specification file.

     Result:

     ```text
     done (5s)
     id: d5d1ud9bli1e********
     folder_id: b1gc1t4cb638********
     created_at: "2023-09-25T16:01:48.926Z"
     name: recognizer-bot-api-gw
     status: ACTIVE
     domain: {{ api-host-apigw }}
     log_group_id: ckgefpleo5eg********
     connectivity: {}
     log_options:
       folder_id: b1gc1t4cb638********
     ```

- {{ TF }} {#tf}

  To create an API gateway:

  1. Describe the `yandex_api_gateway` properties in the configuration file:

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
                 function_id: <function_ID>
                 service_account_id: <service_account_ID>
               operationId: for-recognizer-bot-function
       EOT
     }
     ```

     Where:

     * `name`: API gateway name.
     * `spec`: API gateway specification.

     For more information about resource properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/api_gateway).

  1. Make sure the configuration files are correct.

     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

  To create an API gateway, use the [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/ApiGateway/create.md) gRPC API call.

{% endlist %}

## Configure a link between the function and the Telegram bot {#link-bot}

Install a webhook for your Telegram bot:

```bash
curl --request POST \
  --url https://api.telegram.org/bot<bot_token>/setWebhook \
  --header 'content-type: application/json' \ 
  --data '{"url": "<API_gateway_domain>/for-recognizer-bot-function"}'
```

Where:

* `<bot_token>`: Telegram bot token.
* `<API_gateway_domain>`: `recognizer-bot-api-gw` API gateway's service domain.

Result:

```json
{"ok":true,"result":true,"description":"Webhook was set"}
```

## Test the bot {#test}

Chat with the bot:

1. Open Telegram and search for the bot by the [specified](#bot-register) `username`.
1. Send `/start` to the chat.

   The bot should respond with:

   ```text
   The bot can do the following:

   * Recognize text from images.
   * Generate voice messages from text.
   * Convert voice messages to text.
   ```

1. Send a text message to the chat. The bot will respond with a voice message synthesized from your text.
1. Send a voice message to the chat. The bot will respond with a message containing the text recognized from your speech.
1. Send an image with text to the chat. The bot will respond with a message containing the recognized text.

   {% note info %}

   The image must meet [these requirements](../../vision/concepts/ocr/index.md#image-requirements).

   {% endnote %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete](../../api-gateway/operations/api-gw-delete.md) the {{ api-gw-name }}.
* [Delete](../../functions/operations/function/function-delete.md) the function in {{ sf-name }}.
