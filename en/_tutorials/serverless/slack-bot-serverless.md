# How to create a Slack chat bot


In this tutorial, you will learn how to use serverless technology to create a Slack bot that will run commands in a chat and respond to user messages.



To create a bot:

1. [Set up your environment](#prepare).
1. [Create an application and connect it to {{ yandex-cloud }}](#app).
1. [Get a token and a secret for your app](#env).
1. [Create functions](#create-functions).
1. [Modify the API gateway](#edit-api-gw).
1. [Add commands to Slack](#commands).
1. [Test your Slack bot](#test).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of bot support includes:

* Fee for using the API gateway (see [{{ api-gw-full-name }} pricing](../../api-gateway/pricing.md)).
* Fee for using functions (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).

## Set up your environment {#prepare}

1. [Download](https://{{ s3-storage-host }}/doc-files/slackbot.zip) the file archive required to create a bot.
1. If you do not have a folder yet, [create one](../../resource-manager/operations/folder/create.md).
1. [Create](../../iam/operations/sa/create.md#create-sa) a service account named `sa-slack` and [assign](../../iam/operations/roles/grant.md#cloud-or-folder) it the `{{ roles-editor }}` role for your folder.

## Create an application and connect it to {{ yandex-cloud }} {#app}

### Register your Slack app {#create-app}

1. Log in to [Slack](https://slack.com/). To create a bot, make sure you have workspace admin permissions.
1. Create an [app](https://api.slack.com/apps):

   1. Click **Create an App**.
   1. Select **From scratch**.
   1. In the **App Name** field, enter the name for your app: `ServerlessBotApp`.
   1. Select the available workspace and click **Create App**.

1. Grant permissions to `ServerlessBotApp`:

   1. In the app menu, select **Features** → **OAuth & Permissions**.
   1. Under **Scopes** → **Bot Token Scopes**, click **Add an OAuth Scope** and add the following permissions: `chat:write`, `commands`, and `im:history`.

1. Install the application: in the app menu, select **Settings** → **Install App** and click **Install to Workspace** → **Allow**.

### Configure a link between Slack and {{ yandex-cloud }} {#connect-app}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-challenge`. Make sure it is [private](../../functions/operations/function/function-private.md).
1. [Create](../../functions/operations/function/version-manage.md) a function version:

   1. Specify the following settings:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: Service account you created [earlier](#prepare) (`sa-slack`).

   1. Create a file named `index.py` and paste into it the contents of the `0_for-slack-bot-challenge.py` file from the [archive](#prepare).

1. [Create](../../api-gateway/operations/api-gw-create.md) an API gateway:

   1. Enter `for-slack-bot` as the name.
   1. In the **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_spec }}** field, add the `POST` method configuration to the `paths` parameter:

      ```yaml
      paths:
        /:
          get:
            x-yc-apigateway-integration:
              type: dummy
              content:
                '*': Hello, World!
              http_code: 200
              http_headers:
                Content-Type: text/plain
          post:
            x-yc-apigateway-integration:
              type: cloud_functions
              function_id: <function_ID>
              service_account_id: <service_account_ID>
              operationId: slack-challenge
         ```

         Where:

         * `function_id`: `for-slack-bot-challenge` function ID.
         * `service_account_id`: `sa-slack` service account ID.

### Test the link between Slack and {{ yandex-cloud }} {#connect-test}

1. Copy the `for-slack-bot` API gateway service domain.
1. Select the [app](https://api.slack.com/apps) you created: `ServerlessBotApp`.
1. In the app menu, select **Features** → **Event Subscriptions**.
1. Check **Enable Events**.
1. In the **Request URL** field, paste the API gateway address and wait for `Verified` to appear.
1. Under **Subscribe to bot events**, click **Add Bot User Event** and select `message.im`.
1. Click **Save Changes**.

## Get a token and a secret for your app {#env}

Select the [app](https://api.slack.com/apps) you created: `ServerlessBotApp`.

1. In the app menu, select **Settings** → **Basic Information**.
1. Copy the **Signing Secret** value from the **App Credentials** section: this value will be used for the `SLACK_SIGNING_SECRET` environment variable.
1. In the app menu, select **Features** → **OAuth & Permissions**.
1. In the **OAuth Tokens for Your Workspace** section, copy the **Bot User OAuth Token** value: it will be used for the `SLACK_BOT_TOKEN` environment variable.

## Create functions {#create-functions}

Using functions, you can set up the bot’s responses to user actions within the chat. In this tutorial, you will create the following functions:

* For [messaging](#message-func) between the bot and the user.
* For [getting the bot's response](#command-func) to a simple command.

### Messaging function {#message-func}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-small-talk`. Make sure it is [private](../../functions/operations/function/function-private.md).

1. [Create](../../functions/operations/function/version-manage.md) a function version:

   1. Specify the following settings:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: Service account you created [earlier](#prepare) (`sa-slack`).

   1. Create a file named `requirements.txt` and specify these libraries in it:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Create a file named `index.py` and paste into it the contents of the `1_for-slack-bot-small-talk.py` file from the [archive](#prepare).

   1. Add these [environment variables](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.

### Command response function {#command-func}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-hello-from-serverless`. Make sure it is [private](../../functions/operations/function/function-private.md).

1. [Create](../../functions/operations/function/version-manage.md) a function version:

   1. Specify the following settings:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: Service account you created [earlier](#prepare) (`sa-slack`).

   1. Create a file named `requirements.txt` and specify these libraries in it:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Create a file named `index.py` and paste into it the contents of the `2_for-slack-bot-hello-from-serverless.py` file from the [archive](#prepare).
   1. Add these [environment variables](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.

## Modify the API gateway {#edit-api-gw}

To make sure the bot starts responding to user messages, link the created functions to your app. To do this, [update](../../api-gateway/operations/api-gw-update.md) the `for-slack-bot` API gateway specification and add the `POST` method configurations to the `paths` parameter:

```yaml
  /:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <function_1_ID>
        service_account_id: <service_account_ID>
        operationId: small-talk
  /hello-from-serverless:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <function_2_ID>
        service_account_id: <service_account_ID>
        operationId: hello-from-serverless
```

Where:

* `service_account_id`: `sa-slack` service account ID.
* `<function_1_ID>`: `for-slack-bot-small-talk` function ID.
* `<function_2_ID>`: `for-slack-bot-hello-from-serverless` function ID.

## Add a command to Slack {#commands}

Using [commands](https://api.slack.com/interactivity/slash-commands), you can set up the bot's actions in the chat. Commands start with `/` and users can always see their full list.

{% note info %}

The command will not work without the relevant method configured in the [API gateway](#edit-api-gw).

{% endnote %}

1. Select the [app](https://api.slack.com/apps) you created: `ServerlessBotApp`.
1. In the app menu, select **Features** → **Slash Commands** and click **Create New Command**.
1. Add a command for the `for-slack-bot-hello-from-serverless` function:

   * In the **Command** field, enter `/hello-from-serverless`.
   * In the **Request URL** field, paste the `url` from the `for-slack-bot` API gateway specification, adding the `/hello-from-serverless` command URL to it.
   * In the **Short descriptions** field, enter a brief description for the command.
   * Click **Save**.

1. Re-install the application: in the app menu, select **Settings** → **Install App** and click **Reinstall to Workspace** → **Allow**.
1. Enable users to send messages: in the app menu, select **Features** → **App Home** and enable **Allow users to send Slash commands and messages from the messages tab** under **Show Tabs**.

## Test your Slack bot {#test}

Open Slack and select a chat with `ServerlessBotApp` under **Apps**.

1. To test the `for-slack-bot-small-talk` function:
   * Send `:wave:` to the chat. The bot should respond with `Hi there, @<username>!`.
   * Send `knock knock` to the chat. The bot should respond with `Who's there?`.
1. To test the `for-slack-bot-hello-from-serverless` function, send the `/hello-from-serverless` command to the chat. The bot should respond with `Thanks!`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the functions](../../functions/operations/function/function-delete.md).