1. [Get your cloud ready](#before-begin).
1. [Set up required resources](#create-resources).
1. [Register your Telegram bot](#create-bot).
1. [Publish an image for the bot](#image-publish).
1. [Create an API gateway](#create-gateway).
1. [Create a function](#create-function).
1. [Configure a link between the function and the Telegram bot](#function-bind-bot).
1. [Test your Telegram bot](#test-bot).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% include [paid-resources](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/paid-resources.md) %}


## Set up resources {#create-resources}

1. [Download](https://sourcecraft.dev/yandex-cloud-examples/yc-telegram-bot-serverless/browse/sayhello.png?rev=main) an image for the bot.
1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `{{ roles-editor }}` and `{{ roles-functions-invoker }}` roles for your folder.


## Create a Telegram bot {#create-bot}

{% include [create-bot](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/create-bot.md) %}


## Publish an image for the bot {#image-publish}

If you want your bot to respond to user messages with an image, create an {{ objstorage-name }} bucket and upload `sayhello.png` from the saved archive to it.


### Create an {{ objstorage-name }} bucket {#create-bucket}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../../../storage/concepts/bucket.md).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. On the bucket creation page:

      1. Enter a name for the bucket. Save the bucket name. You will need it later.
      1. Specify these bucket settings:

          * **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}**: `1 {{ ui-key.yacloud_portal.common.units.label_gigabyte }}`.
          * **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**: `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
          * **{{ ui-key.yacloud.storage.bucket.settings.field_class }}**: `{{ ui-key.yacloud.storage.value_standard }}`.

      1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}


### Upload the image to the bucket {#upload-image}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the created bucket.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select the bucket.
  1. Click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
  1. In the window that opens, select `sayhello.png` from the saved archive. The management console will display the file selected for upload.
  1. Click **{{ ui-key.yacloud.storage.button_upload }}**.

{% endlist %}


### Get a link to the uploaded image {#get-image-link}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the created bucket.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select the bucket.
  1. Select `sayhello.png`.
  1. Click **{{ ui-key.yacloud.storage.file.button_generate }}**.
  1. Make sure the image is accessible through the link in your browser.

{% endlist %}


## Create an API gateway {#create-gateway}

To enable your bot to work with a function, create and configure an [API gateway](../../../api-gateway/concepts/index.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an API gateway.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. Name the gateway: `for-serverless-hello-telegram-bot`.
  1. Clear the **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** field and paste this code:

      ```yaml
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
      * `service_account_id`: [ID of the service account](../../../iam/operations/sa/get-id.md) you created when [setting up the resources](#create-resources).

  1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Select the previously created API gateway. Save the **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** field value as you will need it to create the function.

{% endlist %}


## Create a function {#create-function}

If you want your Telegram bot to respond to the `/start` and `/help` commands and send an image in response to any other text, create a designated [function](../../../functions/concepts/function.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a function.
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Enter the function name: `fshtb-function`.
  1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}**, select `Node.js` as the runtime and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
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

      {% include [telegram-bot-package-json](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-package-json.md) %}

  1. Specify the following settings:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `nodejs22`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.

  1. Add the `BOT_TOKEN` environment variable. In the **{{ ui-key.yacloud.common.value }}** field, specify the Telegram bot token.
  1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. Make sure the function is [public](../../../functions/operations/function/function-public.md). To do this, navigate to the **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** page and enable the **{{ ui-key.yacloud.common.section-base }}** toggle under **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
  1. Save your function ID, as you will need it later.

{% endlist %}


## Configure a link between the function and the Telegram bot {#function-bind-bot}

1. Update the API gateway specification:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select a folder.
      1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
      1. Select the `for-serverless-hello-telegram-bot` API gateway.
      1. Update the API gateway specification by adding the `fshtb-function` section at the end of the code:

         {% include [telegram-bot-function-bind](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-function-bind.md) %}

      1. Click **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

    {% endlist %}

1. {% include [telegram-bot-setwebhook](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/telegram-bot-setwebhook.md) %}

    Where:

    * `<bot_token>`: Telegram bot token.
    * `<API_gateway_domain>`: API gateway service domain.

    Result:

    ```bash
    {"ok":true,"result":true,"description":"Webhook was set"}
    ```


## Test your Telegram bot {#test-bot}

{% include [test-bot](../../../_tutorials/_tutorials_includes/telegram-bot-serverless/test-bot.md) %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../../functions/operations/function/function-delete.md) the function.
1. [Delete](../../../api-gateway/operations/api-gw-delete.md) the API gateway.
1. [Delete](../../../storage/operations/buckets/delete.md) the bucket.
