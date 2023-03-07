# How to create a Telegram bot

Using serverless technologies, you can create a Telegram bot that will respond to chat messages.

{% if lang == "ru" %}
@[youtube](C2Ahit2EBo0)
{% endif %}

To create a bot:
1. [Prepare the environment](#before-begin).
1. [Set up resources](#create-resources).
1. [Register the Telegram bot](#create-bot).
1. [Post a bot image](#image-publish).
1. [Create an API gateway](#create-gateway).
1. [Create a function](#create-function).
1. [Configure a link between the function and the Telegram bot](#function-bind-bot).
1. [Check that the Telegram bot works](#test-bot).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

The cost of Telegram bot support includes:
* Payment for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Payment for the amount of stored data, the number of data transactions, and outgoing traffic (see [{{ objstorage-name }} pricing](../../storage/pricing.md)).
* Payment for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).

{% endif %}

## Create resources {#create-resources}

1. [Download](https://{{ s3-storage-host }}/doc-files/telegrambot.zip) the file archive needed to create the bot.
1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `editor` and the `serverless.functions.invoker` roles for your folder.

## Register the Telegram bot {#create-bot}

Register your bot in Telegram and get a token.

1. To register the new bot, launch the [BotFather](https://t.me/BotFather) bot and run the command below:

   ```
   /newbot
   ```

1. In the `name` field, enter a name for the bot being created, such as `Serverless Hello Telegram Bot`. This is the name users will see when communicating with the bot.
1. In the `username` field, enter the username for the bot being created, such as `ServerlessHelloTelegramBot`. You can use the username to search for the bot in Telegram. The user name must end with `...Bot` or `..._bot`.

   As a result, you will get a token. Save it. You will need it later.
1. Set an icon for the bot using `sayhello.png` from the saved archive. Send the BotFather bot the command below:

   ```
   /setuserpic
   ```

## Post a bot image {#image-publish}

For the bot to respond to user messages with an image, create a bucket in {{ objstorage-name }} and upload `sayhello.png` from the saved archive to the bucket.

### Create a bucket in {{ objstorage-name }} {#create-bucket}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../storage/concepts/bucket.md).
   1. Select **{{ objstorage-short-name }}**.
   1. Click **Create bucket**.
   1. On the bucket creation page:
      1. Enter a name for the bucket, such as `for-serverless-hello-telegram-bot`. Save the bucket name. You will need it later.
      1. Specify the bucket settings:
         * **Max Size**: `1 GB`.
         * **Object read access**: `Public`.
         * **Storage class**: `Standard`.
      1. Click **Create bucket**.

{% endlist %}

### Upload the image to the bucket {#upload-image}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder that contains the previously created bucket.
   1. Select **{{ objstorage-short-name }}**.
   1. Select a previously created bucket.
   1. Click **Upload**.
   1. In the resulting window, select `sayhello.png` from the saved archive and click **Open**. The management console will display the file selected for upload.
   1. Click **Upload**.

{% endlist %}

### Obtain a link to the uploaded image {#get-image-link}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder that contains the previously created bucket.
   1. Select **{{ objstorage-short-name }}**.
   1. Select a previously created bucket.
   1. Select `sayhello.png`.
   1. Click **Get link**.
   1. Check that the image is available in your browser.

{% endlist %}

## Create an API gateway {#create-gateway}

Create and configure an [API Gateway](../../api-gateway/concepts/index.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create an API gateway.
   1. Select **{{ api-gw-name }}**.
   1. Click Create **API gateway**.
   1. Enter a name for the gateway: `for-serverless-hello-telegram-bot`.
   1. Clear the contents of the **Specification** field and replace them with the code below:

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
              bucket: <bucket name>
              object: sayhello.png
              presigned_redirect: false
              service_account_id: <service account ID>
            operationId: static
      ```

      Where:
      * `bucket`: Bucket name.
      * `service_account_id`: [ID of the service account](../../iam/operations/sa/get-id.md) created when [setting up resources](#create-resources).

   1. Click **Create**.
   1. Select the created API gateway. Save the name of the **Service domain** field from the **General information** section. You will need it later.

{% endlist %}

## Create a function {#create-function}

To have the Telegram bot respond to the `/start` and `/help` commands and send an image in response to any other text, create a [function](../../functions/concepts/function.md).

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create the function.
   1. Select **{{ sf-name }}**.
   1. Click **Create function**.
   1. Enter a name for the function: `fshtb-function`.
   1. Click **Create**.
   1. Under **Editor**, select the `Node.js` runtime environment and click **Continue**.
   1. Under **Function code**, replace the contents of the `index.js` file with the code below: Replace `<API gateway domain>` with the API gateway's service domain.

      ```javascript
      const { Telegraf } = require('telegraf');
 
      const bot = new Telegraf(process.env.BOT_TOKEN);
      bot.start((ctx) => ctx.reply(`Hello. \nMy name is Serverless Hello Telegram Bot \nI'm working on Cloud Function in the Yandex Cloud.`))
      bot.help((ctx) => ctx.reply(`Hello, ${ctx.message.from.username}.\nI can say Hello and nothing more`))
      bot.on('text', (ctx) => {
          ctx.replyWithPhoto('<API gateway domain>/sayhello.png');
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

   1. Under **Function code**, create a file called `package.json` with the code below:

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
          "telegraf": "^3.38.0"
        }
      }
      ```

   1. Indicate the following:
      * Runtime environment: `nodejs12`.
      * Entry point: `index.handler`.
      * Timeout: `5 seconds`.
   1. Add the `BOT_TOKEN` variable to the environment. In the **Value** field, specify the Telegram bot token.
   1. Click **Create version**.
   1. Make sure that the function is [public](../../functions/operations/function/function-public.md). To do this, go to the **Overview** page and, under **General information**, switch the **Public function** option to on.
   1. Save your function ID. You will need it later.

{% endlist %}

## Configure a link between the function and the Telegram bot {#function-bind-bot}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ api-gw-name }}**.
   1. Select the `for-serverless-hello-telegram-bot` API gateway.
   1. Edit the API gateway specification by appending a `fshtb-function` section at the end:

      ```yml
        /fshtb-function:
          post:
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <function ID>
            operationId: fshtb-function
      ```

      Where `function_id` is the `fshtb-function` ID.

   1. Click **Save**.
   1. Run the request replacing `<bot token>` with that of the Telegram bot and the `<API gateway domain>` with the API gateway service domain:
      * Linux, macOS:

         ```bash
         curl \
           --request POST \
           --url https://api.telegram.org/bot<bot token>/setWebhook \
           --header 'content-type: application/json' \
           --data '{"url": "<API gateway domain>/fshtb-function"}'
         ```

      * Windows (cmd):

         ```bash
         curl ^
           --request POST ^
           --url https://api.telegram.org/bot<bot token>/setWebhook ^
           --header "content-type: application/json" ^
           --data "{\"url\": \"<API gateway domain>/fshtb-function\"}"
         ```

      * Windows (PowerShell):

         ```powershell
         curl.exe `
           --request POST `
           --url https://api.telegram.org/bot<bot token>/setWebhook `
           --header '"content-type: application/json"' `
           --data '"{ \"url\": \"<API gateway domain>/fshtb-function\" }"'
         ```

      Result:

      ```bash
      {"ok":true,"result":true,"description":"Webhook was set"}
      ```

{% endlist %}

## Check that the Telegram bot works {#test-bot}

Talk to the bot:

1. Open Telegram and search for the bot using the previously created `username` as its username.
1. Send the message `/start` in the chat.

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

1. Send any text message in the chat. The bot must respond with an image and `Hello, <username>`.

## How to delete created resources {#clear-out}

To stop paying for the resources created:
* [Delete the function](../../functions/operations/function/function-delete.md).
* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the bucket](../../storage/operations/buckets/delete.md).
