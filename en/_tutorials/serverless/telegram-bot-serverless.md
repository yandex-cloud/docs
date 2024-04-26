# How to create a Telegram bot


Serverless technologies enable you to create a Telegram bot that will respond to chat messages.


To create a bot:

1. [Prepare the environment](#before-begin).
1. [Set up resources](#create-resources).
1. [Register the Telegram bot](#create-bot).
1. [Post a bot image](#image-publish).
1. [Create an API gateway](#create-gateway).
1. [Create a function](#create-function).
1. [Configure a link between the function and the Telegram bot](#function-bind-bot).
1. [Check that the Telegram bot works](#test-bot).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of Telegram bot support includes:

* Fee for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for the amount of stored data, the number of data transactions, and outgoing traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).


## Create resources {#create-resources}

1. [Download](https://{{ s3-storage-host }}/doc-files/telegrambot.zip) the archive with the files required to create a bot.
1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `{{ roles-editor }}` and `{{ roles-functions-invoker }}` roles for your folder.

## Register the Telegram bot {#create-bot}

Register your bot in Telegram and get a token.

1. To register the new bot, launch the [BotFather](https://t.me/BotFather) bot and run the command below:

   ```
   /newbot
   ```

1. In the `name` field, enter a name for the bot being created, such as `Serverless Hello Telegram Bot`. This is the name users will see when communicating with the bot.
1. In the `username` field, enter the user name for the bot being created, such as `ServerlessHelloTelegramBot`. You can use the user name to search for the bot in Telegram. The user name must end with `...Bot` or `..._bot`.

   As a result, you will get a token. Save it. You will need it later.

1. Set an icon for the bot using `sayhello.png` from the saved archive. Send the BotFather bot the command below:

   ```
   /setuserpic
   ```

## Post a bot image {#image-publish}

For the bot to respond to user messages with an image, create a bucket in {{ objstorage-name }} and upload `sayhello.png` from the saved archive to the bucket.

### Create a bucket in {{ objstorage-name }} {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
   1. On the bucket creation page:

      1. Enter the name of the bucket. Save the bucket name. You will need it later.
      1. Specify the bucket settings:

         * **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}**: `1 {{ ui-key.yacloud_portal.common.units.label_gigabyte }}`
         * **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**: `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`
         * **{{ ui-key.yacloud.storage.bucket.settings.field_class }}**: `{{ ui-key.yacloud.storage.bucket.settings.class_value_standard }}`

      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}

### Upload the image to the bucket {#upload-image}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder that contains the previously created bucket.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Select the previously created bucket.
   1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
   1. In the window that opens, select `sayhello.png` from the saved archive. The management console will display the file selected for upload.
   1. Click **{{ ui-key.yacloud.storage.button_upload }}**.

{% endlist %}

### Get a link to the uploaded image {#get-image-link}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder that contains the previously created bucket.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
   1. Select the previously created bucket.
   1. Select `sayhello.png`.
   1. Click **{{ ui-key.yacloud.storage.file.button_generate }}**.
   1. Check that the image is available in your browser.

{% endlist %}

## Create an API gateway {#create-gateway}

Create and configure an [API Gateway](../../api-gateway/concepts/index.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
   1. Enter a name for the gateway: `for-serverless-hello-telegram-bot`.
   1. Clear the contents of the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field and replace them with the code below:

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
      * `service_account_id`: [ID of the service account](../../iam/operations/sa/get-id.md) created when [setting up resources](#create-resources).

   1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
   1. Select the created API gateway. Save the name of the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field from the **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_base }}** section. You will need it later.

{% endlist %}

## Create a function {#create-function}

To have the Telegram bot respond to the `/start` and `/help` commands and send an image in response to any other text, create a [function](../../functions/concepts/function.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create the function in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
   1. Enter a name for the function: `fshtb-function`.
   1. Click **{{ ui-key.yacloud.common.create }}**.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**, select the `Node.js` runtime environment and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
   1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**, replace the contents of the `index.js` file with the code below: Replace `<API_gateway_domain>` with the API gateway's service domain.

      ```javascript
      const { Telegraf } = require('telegraf');

      const bot = new Telegraf(process.env.BOT_TOKEN);
      bot.start((ctx) => ctx.reply(`Hello. \nMy name is Serverless Hello Telegram Bot \nI'm working on Cloud Function in Yandex Cloud.`))
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

   1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**, create a file named `package.json` with the following code:

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

   1. Specify the following parameters:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `nodejs16`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`

   1. Add the `BOT_TOKEN` variable to the environment. In the **{{ ui-key.yacloud.common.value }}** field, specify the Telegram bot token.
   1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
   1. Make sure that the function is [public](../../functions/operations/function/function-public.md). To do this, go to the **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page and, under **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-metadata }}**, switch the **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}** option to on.
   1. Save your function ID. You will need it later.

{% endlist %}

## Configure a link between the function and the Telegram bot {#function-bind-bot}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
   1. Select the `for-serverless-hello-telegram-bot` API gateway.
   1. Edit the API gateway specification by appending a `fshtb-function` section at the end:

      ```yml
        /fshtb-function:
          post:
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <function_ID>
            operationId: fshtb-function
      ```

      Where `function_id` is the `fshtb-function` function ID.

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

      * `<bot token>`: Telegram bot token.
      * `<API_gateway_domain>`: API gateway's service domain.

      Result:

      ```bash
      {"ok":true,"result":true,"description":"Webhook was set"}
      ```

{% endlist %}

## Check that the Telegram bot works {#test-bot}

Talk to the bot:

1. Open Telegram and search for the bot using the previously created `username` as its username.
1. Send a message saying `/start` to the chat.

   The bot must respond with:

   ```text
   Hello.
   My name is Serverless Hello Telegram Bot
   I'm working on Cloud Function in the Yandex Cloud.
   ```

1. Send the message `/help` in the chat.

   The bot must respond with:

   ```text
   Hello, <username>.
   I can say Hello and nothing more
   ```

1. Send any text message to the chat. The bot must respond with an image and `Hello, <username>`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the function](../../functions/operations/function/function-delete.md).
* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the bucket](../../storage/operations/buckets/delete.md).
