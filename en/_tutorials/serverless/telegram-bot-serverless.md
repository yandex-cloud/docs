# How to create a Telegram bot


With serverless technology, you can create a Telegram bot that will respond to chat messages.



To create a bot:

1. [Set up your environment](#before-begin).
1. [Set up resources](#create-resources).
1. [Register your Telegram bot](#create-bot).
1. [Post a bot image](#image-publish).
1. [Create an API gateway](#create-gateway).
1. [Create a function](#create-function).
1. [Configure a link between the function and the Telegram bot](#function-bind-bot).
1. [Test your Telegram bot](#test-bot).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of Telegram bot support includes:

* Fee for function invocation count, computing resources allocated to run the function, and outbound traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for the amount of stored data, number of data operations, and outbound traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for the number of requests to the API gateway and outbound traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).

## Set up resources {#create-resources}

1. [Download](https://{{ s3-storage-host }}/doc-files/telegrambot.zip) the file archive required to create a bot.
1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `{{ roles-editor }}` and `{{ roles-functions-invoker }}` roles for your folder. 

## Create a Telegram bot {#create-bot}

Create a bot in Telegram and get a token.

1. To register the new bot, start [BotFather](https://t.me/BotFather) and run this command:

    ```
    /newbot
    ```

1. In the `name` field, enter a name for the bot, e.g., `Serverless Hello Telegram Bot`. This is the name users will see when chatting with the bot.
1. In the `username` field, specify a username for the bot, e.g., `ServerlessHelloTelegramBot`. This will allow users to find your bot on Telegram. The username must end with `...Bot` or `..._bot`.

    Once done, you will get a token. Save it, as you will need it later.

1. Set an icon for the bot using `sayhello.png` from the saved archive. Send this command to BotFather:

    ```
    /setuserpic
    ```

## Post a bot image {#image-publish}

If you want your bot to respond to user messages with an image, create an {{ objstorage-name }} bucket and upload `sayhello.png` from the saved archive to it.

### Create an {{ objstorage-name }} bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. On the bucket creation page:

      1. Enter a name for the bucket. Save the bucket name, as you will need it later.
      1. Specify these bucket settings:

          * **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}**: `1 {{ ui-key.yacloud_portal.common.units.label_gigabyte }}`
          * **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**: `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`
          * **{{ ui-key.yacloud.storage.bucket.settings.field_class }}**: `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`

      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Upload the image to the bucket {#upload-image}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the created bucket.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select the bucket.
  1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. In the window that opens, select `sayhello.png` from the saved archive. The management console will display the file selected for upload.
  1. Click **{{ ui-key.yacloud.storage.button_upload }}**.

{% endlist %}

### Get a link to the uploaded image {#get-image-link}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the created bucket.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select the bucket.
  1. Select `sayhello.png`.
  1. Click **{{ ui-key.yacloud.storage.file.button_generate }}**.
  1. Make sure the image is accessible through the link in your browser.

{% endlist %}

## Create an API gateway {#create-gateway}

Create and configure an [API Gateway](../../api-gateway/concepts/index.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. Name the gateway: `for-serverless-hello-telegram-bot`.
  1. Clear the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field and paste this code:

      ```yml
      openapi: 3.0.0
      info:
        title: for-serverless-hello-telegram-bot
        version: 1.0.0
      paths:
        /sayhello.png:
          get:
            x-yc-apigateway-integration:
              type: object_storage
              bucket: <bucket_name>
              object: sayhello.png
              presigned_redirect: false
              service_account_id: <service_account_ID>
            operationId: static
      ```
      
      Where:
      * `bucket`: Bucket name.
      * `service_account_id`: [ID of the service account](../../iam/operations/sa/get-id.md) you created when [setting up the resources](#create-resources).

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Select the created API gateway. Save the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field value, as you will need it later.

{% endlist %}

## Create a function {#create-function}

If you want your Telegram bot to respond to the `/start` and `/help` commands and send an image in response to any other text, create a designated [function](../../functions/concepts/function.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Enter the function name: `fshtb-function`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**, select `Node.js` as the runtime environment and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**, replace the contents of the `index.js` file with the code below. Replace `<API_gateway_domain>` with the API gateway service domain.

      ```javascript
      const { Telegraf } = require('telegraf');

      const bot = new Telegraf(process.env.BOT_TOKEN);
      bot.start((ctx) => ctx.reply(`Hello. \nMy name Serverless Hello Telegram Bot \nI'm working on Cloud Function in the Yandex Cloud.`))
      bot.help((ctx) => ctx.reply(`Hello, ${ctx.message.from.username}.\nI can say Hello and nothing more`))
      bot.on('text', (ctx) => {
          ctx.replyWithPhoto({url: '<API_gateway_domain>/sayhello.png'});
          ctx.reply(`Hello, ${ctx.message.from.username}`);

      });

      module.exports.handler = async function (event, context) {
          const message = JSON.parse(event.body);
          await bot.handleUpdate(message);
          return {
              statusCode: 200,
              body: '',
          };
      };
      ```

  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**, create a file named `package.json` and paste the following code into it:

      ```json
      {
        "name": "ycf-telegram-example",
        "version": "1.0.0",
        "description": "",
        "main": "index.js",
        "scripts": {
          "test": "echo \"Error: no test specified\" && exit 1"
        },
        "author": "",
        "license": "MIT",
        "dependencies": {
          "telegraf": "^4.12.0"
        }
      }
      ```

  1. Specify the following settings:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `nodejs16`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`

  1. Add the `BOT_TOKEN` environment variable. In the **{{ ui-key.yacloud.common.value }}** field, specify the Telegram bot token.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. Make sure the function is [public](../../functions/operations/function/function-public.md). To do this, navigate to the **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page and enable **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}** under **{{ ui-key.yacloud.common.section-base }}**.
  1. Save your function ID, as you will need it later.

{% endlist %}

## Configure a link between the function and the Telegram bot {#function-bind-bot}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select your folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Select the `for-serverless-hello-telegram-bot` API gateway.
  1. Update the API gateway specification by adding the `fshtb-function` section at the end of the code:

      ```yml
        /fshtb-function:
          post:
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <function_ID>
            operationId: fshtb-function
      ```
      
      Where `function_id` is the `fshtb-function` ID.

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.
  1. Run the following request in the terminal:

      * Linux, macOS:

          ```bash
          curl \
            --request POST \
            --url https://api.telegram.org/bot<bot_token>/setWebhook \
            --header 'content-type: application/json' \
            --data '{"url": "<API_gateway_domain>/fshtb-function"}'
          ```
    
      * Windows (cmd):

          ```bash
          curl ^
            --request POST ^
            --url https://api.telegram.org/bot<bot_token>/setWebhook ^
            --header "content-type: application/json" ^
            --data "{\"url\": \"<API_gateway_domain>/fshtb-function\"}"
          ```

      * Windows (PowerShell):
      
          ```powershell
          curl.exe `
            --request POST `
            --url https://api.telegram.org/bot<bot_token>/setWebhook `
            --header '"content-type: application/json"' `
            --data '"{ \"url\": \"<API_gateway_domain>/fshtb-function\" }"'
          ``` 

      Where:

      * `<bot_token>`: Telegram bot token.
      * `<API_gateway_domain>`: API gateway service domain.

      Result:

      ```bash
      {"ok":true,"result":true,"description":"Webhook was set"}
      ```

{% endlist %}

## Test your Telegram bot {#test-bot}

Chat with the bot:

1. Open Telegram and search for the bot using the previously created `username`.
1. Send `/start` to the chat.

    The bot should respond with:
    
    ```text
    Hello.
    My name Serverless Hello Telegram Bot
    I'm working on Cloud Function in the Yandex Cloud.
    ```

1. Send `/help` to the chat. 
    
    The bot should respond with:
    
    ```text
    Hello, <username>.
    I can say Hello and nothing more
    ```

1. Send a text message to the chat. The bot should respond with an image and this message: `Hello, <username>`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the function](../../functions/operations/function/function-delete.md).
* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the bucket](../../storage/operations/buckets/delete.md).
