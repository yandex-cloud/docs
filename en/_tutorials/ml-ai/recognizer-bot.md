# Developing a Telegram bot for text recognition in images, audio synthesis and recognition


In this tutorial, you will create a bot for Telegram that can:

* [Synthesize speech](../../speechkit/tts/index.md) from a message text using the {{ speechkit-full-name }} [API v1](../../speechkit/tts/request.md).
* [Recognize speech](../../speechkit/stt/index.md) in voice messages and convert it into text using the {{ speechkit-full-name }} [synchronous recognition API](../../speechkit/stt/api/request-api.md).
* [Recognize text](../../vision/concepts/ocr/index.md) in images using {{ vision-full-name }}.

The {{ api-gw-full-name }} API gateway will receive requests from the bot and forward them to the {{ sf-full-name }} function for processing.

To create a bot:

1. [Prepare your cloud](#before-you-begin).
1. [Set up resources](#prepare).
1. [Register the Telegram bot](#bot-register).
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
* Fee for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-name }} pricing](../../api-gateway/pricing.md)).


## Create resources {#prepare}

1. [Create a service account](../../iam/operations/sa/create.md) named `recognizer-bot-sa` and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `ai.editor` and `{{ roles-functions-editor }}` roles for your folder.
1. Prepare a ZIP archive with the function code:

   1. Create a file named `index.py` and paste the code below to it.

      {% cut "index.py" %}

      ```py
      import logging
      import requests
      import telebot
      import json
      import os
      import base64

      # Service endpoints and authentication data

      API_TOKEN = os.environ['TELEGRAM_TOKEN']
      vision_url = 'https://ocr.{{ api-host }}/ocr/v1/recognizeText'
      speechkit_url = 'https://stt.{{ api-host }}/speech/v1/stt:recognize'
      speechkit_synthesis_url = 'https://tts.{{ api-host }}/speech/v1/tts:synthesize'
      folder_id = ""
      iam_token = ''

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
          process_event(event)
          return {
              'statusCode': 200
          }

      # Command and message handlers

      @bot.message_handler(commands=['help', 'start'])
      def send_welcome(message):
          bot.reply_to(message,
                       "The bot can:\n*recognize text in images;\n* generate voice messages from text;\n* transcribe voice messages to text.")

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

      # Speech synthesis

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

   1. Create a file named `requirements.txt` and specify in it the library to work with the bot.

      ```text
      telebot
      ```

   1. Add both files to the `index.zip` archive.

## Register the Telegram bot {#bot-register}

Register the bot in Telegram and get a token.

1. Run the [BotFather](https://t.me/BotFather) and send it the following command:

   ```text
   /newbot
   ```

1. In the `name` field, specify the name of the bot you are creating. This is the name users will see when communicating with the bot.
1. In the `username` field, specify the user name of the bot you are creating. You can use the user name to search for the bot in Telegram. The user name must end with `...Bot` or `..._bot`.

   As a result, you will get a token. Save it. You will need it later.

## Create a function {#create-function}

Create a function to process user actions in the chat.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. Enter a name for the function: `for-recognizer-bot`.
      1. Click **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.

   1. Create a function version:

      1. Select the `Python` runtime environment, disable the **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** option, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. Specify the `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` upload method and select the `index.zip` archive [prepared](#prepare) earlier.
      1. Specify the entry point: `index.handler`.
      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `30`
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
         * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `recognizer-bot-sa`
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

            * `TELEGRAM_TOKEN`: Your Telegram bot token

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- {{ yandex-cloud }} CLI {#cli}

   1. Create a function named `for-recognizer-bot`:

      ```bash
      yc serverless function create --name=for-recognizer-bot
      ```

      Result:

      ```yaml
      id: b09bhaokchn9********
      folder_id: aoek49ghmknn********
      created_at: "2023-03-21T10:03:37.475Z"
      name: for-recognizer-bot
      log_group_id: eolm8aoq9vcp********
      http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
      status: ACTIVE
      ```

   1. Create the `for-recognizer-bot` function version:

      ```bash
      yc serverless function version create \
        --function-name for-recognizer-bot \
        --memory=128m \
        --execution-timeout=30s \
        --runtime=python312 \
        --entrypoint=index.handler \
        --service-account-id=<service_account_ID> \
        --environment TELEGRAM_TOKEN=<bot_token> \
        --source-path=./index.zip
      ```

      Where:

      * `--function-name`: Name of the function a version of which you are creating.
      * `--memory`: Amount of RAM.
      * `--execution-timeout`: Maximum function execution time before the timeout is reached.
      * `--runtime`: Runtime environment.
      * `--entrypoint`: Entry point.
      * `--service-account-id`: ID of the `recognizer-bot-sa` service account.
      * `--environment`: Environment variables.
      * `--source-path`: Path to the `index.zip` archive.

      Result:

      ```yaml
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
        TELEGRAM_TOKEN: <bot_token>
      log_options:
        folder_id: b1g86q4m5vej********
      ```

- {{ TF }} {#tf}

   1. In the configuration file, describe the function parameters:

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
        content {
          zip_filename = "./index.zip"
        }
      }
      ```

      Where:

      * `name`: Function name.
      * `user_hash`: Any string to identify the function version.
      * `runtime`: Function [runtime environment](../../functions/concepts/runtime/index.md).
      * `entrypoint`: Entry point.
      * `memory`: Amount of memory allocated for the function, in MB.
      * `execution_timeout`: Function execution timeout.
      * `service_account_id`: ID of the `recognizer-bot-sa` service account.
      * `environment`: Environment variables.
      * `content`: Path to the `index.zip` archive with the function source code.

      For more information about the `yandex_function` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the function: type `yes` in the terminal and press **Enter**.

- API {#api}

   To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/function_service.md#Create) gRPC API call.

   To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/function_service.md#CreateVersion) gRPC API call.

{% endlist %}

## Create an API gateway {#create-api-gateway}

The Telegram server will notify your bot of new messages using a [webhook](https://core.telegram.org/bots/api#setwebhook). The API gateway will accept requests on the bot side and redirect them to the `for-recognizer-bot` function for processing.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** field, enter `recognizer-bot-api-gw`.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** section, add the specification:

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

      * `function_id`: ID of the `for-recognizer-bot` function.
      * `service_account_id`: ID of the `recognizer-bot-sa` service account.

   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
   1. Select the created API gateway. Save the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field value from the **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_base }}** section. You will need it later.

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

      * `function_id`: ID of the `for-recognizer-bot` function.
      * `service_account_id`: ID of the `recognizer-bot-sa` service account.

   1. Run this command:

      ```bash
      yc serverless api-gateway create --name recognizer-bot-api-gw --spec=spec.yaml
      ```

      Where:

      * `--name`: API gateway name
      * `--spec`: Specification file

      Result:

      ```yaml
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

   To create an API gateway:

   1. Describe the parameters of the `yandex_api_gateway` resource in the configuration file:

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

      * `name`: API gateway name
      * `spec`: API gateway specification

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/api_gateway).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

- API {#api}

   To create an API gateway, use the [create](../../api-gateway/apigateway/api-ref/ApiGateway/create.md) REST API method for the [ApiGateway](../../api-gateway/apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Create](../../api-gateway/apigateway/api-ref/grpc/apigateway_service.md#Create) gRPC API call.

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

Talk to the bot:

1. Open Telegram and search for the bot by the [specified](#bot-register) `username`.
1. Send a message saying `/start` to the chat.

   The bot must respond with:

   ```text
   The bot can:

   * recognize text from images
   * generate voice messages from text
   * convert voice messages to text.
   ```

1. Send a text message to the chat. The bot will respond with a voice message synthesized from your text.
1. Send a voice message to the chat. The bot will respond with a message containing the text recognized from your speech.
1. Send an image with text to the chat. The bot will respond with a message containing the recognized text.

   {% note info %}

   The image must meet the [requirements](../../vision/concepts/ocr/index.md#image-requirements).

   {% endnote %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete](../../api-gateway/operations/api-gw-delete.md) the {{ api-gw-name }} API gateway.
* [Delete](../../functions/operations/function/function-delete.md) the {{ sf-name }} function.
