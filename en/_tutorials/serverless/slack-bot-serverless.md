# Creating a Slack chat bot


In this tutorial, you will learn how to use serverless technologies to create a Slack bot that will run commands in a chat and respond to user messages.

@[youtube](VmqFGYAPN_4)

To create a bot:

1. [Prepare the environment](#prepare).
1. [Create an application and connect it to {{ yandex-cloud }}](#app).
1. [Get a token and a secret for the app](#env).
1. [Create functions](#create-functions).
1. [Edit the API gateway](#edit-api-gw).
1. [Add commands to Slack](#commands).
1. [Test the Slack bot](#test).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of bot support includes:

* Fee for using the API gateway (see [{{ api-gw-full-name }}](../../api-gateway/pricing.md) pricing).
* Fee for using functions (see [{{ sf-full-name }}](../../functions/pricing.md) pricing).


## Prepare the environment {#prepare}

1. [Download](https://{{ s3-storage-host }}/doc-files/slackbot.zip) the archive with the files required to create a bot.
1. If you do not have a folder yet, [create](../../resource-manager/operations/folder/create.md) one.
1. [Create](../../iam/operations/sa/create.md#create-sa) a service account named `sa-slack` and [assign](../../iam/operations/roles/grant.md#access-to-sa) it the `{{ roles-editor }}` role for your folder.

## Create an app and connect it to {{ yandex-cloud }} {#app}

### Register the Slack app {#create-app}

1. Log in to [Slack](https://slack.com/). To create a bot, make sure you have workspace management permissions.
1. Create an [app](https://api.slack.com/apps):

   1. Click **Create an App**.
   1. Select **From scratch**.
   1. In the **App Name** field, enter the name for the app: `ServerlessBotApp`.
   1. Select the available workspace and click **Create App**.

1. Grant permissions to the `ServerlessBotApp app`:

   1. In the app control menu, select **Features** → **OAuth & Permissions**.
   1. Under **Scopes** → **Bot Token Scopes**, click **Add an OAuth Scope** and add the following permissions: `chat:write`, `commands`, and `im:history`.

1. Install the application: in the app control menu, select **Settings** → **Install App** and click **Install to Workspace** → **Allow**.

### Set up a link between Slack and {{ yandex-cloud }} {#connect-app}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-challenge`. Make sure it is [private](../../functions/operations/function/function-private.md).
1. [Create](../../functions/operations/function/version-manage.md) a function version:

   1. Specify the following parameters:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `sa-slack` service account you created [earlier](#prepare).

   1. Create a file named `index.py` and paste the contents of the `0_for-slack-bot-challenge.py` file from the [archive](#prepare) into it.

1. [Create](../../api-gateway/operations/api-gw-create.md) an API gateway:

   1. Specify the name: `for-slack-bot`.
   1. Under **{{ ui-key.yacloud.serverless-functions.gateways.overview.section_spec }}**, add the `POST` method configuration to the `paths` parameter:

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

      * `function_id`: ID of the `for-slack-bot-challenge` function.
      * `service_account_id`: ID of the `sa-slack` service account.

### Test the link between Slack and {{ yandex-cloud }} {#connect-test}

1. Copy the service domain of the `for-slack-bot` API gateway.
1. Select the `ServerlessBotApp` [app](https://api.slack.com/apps).
1. In the app control menu, select **Features** → **Event Subscriptions**.
1. Enable the **Enable Events** option.
1. In the **Request URL** field, insert the API gateway's address and wait for the `Verified` entry to appear.
1. In the **Subscribe to bot events** section, click **Add Bot User Event** and select the `message.im` event.
1. Click **Save Changes**.

## Get a token and a secret for the app {#env}

Select the `ServerlessBotApp` [app](https://api.slack.com/apps):

1. In the app control menu, select **Settings** → **Basic Information**.
1. Copy the **Signing Secret** value from the **App Credentials** section: it will be used for the `SLACK_SIGNING_SECRET` environment variable.
1. In the app control menu, select **Features** → **OAuth & Permissions**.
1. In the **OAuth Tokens for Your Workspace** section, copy the **Bot User OAuth Token** value: it will be used for the `SLACK_BOT_TOKEN` environment variable.

## Create functions {#create-functions}

Using functions, you can configure the bot's reactions to user actions in the chat. In this tutorial, you will create the following functions:

* For [messaging](#message-func) between the bot and the user.
* For [getting the bot's response](#command-func) to a simple command.

### Function for messaging {#message-func}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-small-talk`. Make sure it is [private](../../functions/operations/function/function-private.md).

1. [Create](../../functions/operations/function/version-manage.md) a function version:

   1. Specify the following parameters:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: [sa-slack](#prepare) service account you created `earlier`.

   1. Create a file named `requirements.txt` and specify the following libraries in it:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Create a file named `index.py` and paste the contents of the `1_for-slack-bot-small-talk.py` file from the [archive](#prepare) into it.

   1. Add [environment variables](#env):
      * `SLACK_BOT_TOKEN`
      * `SLACK_SIGNING_SECRET`

### Function for responding to commands {#command-func}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-hello-from-serverless`. Make sure it is [private](../../functions/operations/function/function-private.md).

1. [Create](../../functions/operations/function/version-manage.md) a function version:

   1. Specify the following parameters:

      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `python312`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
      * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
      * **{{ ui-key.yacloud.forms.label_service-account-select }}**: [sa-slack](#prepare) service account you created `earlier`.

   1. Create a file named `requirements.txt` and specify the following libraries in it:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Create a file named `index.py` and paste the contents of the `2_for-slack-bot-hello-from-serverless.py` file from the [archive](#prepare) into it.
   1. Add [environment variables](#env):
      * `SLACK_BOT_TOKEN`
      * `SLACK_SIGNING_SECRET`

## Edit the API gateway {#edit-api-gw}

To make sure the bot starts responding to user messages, link the created functions to the app. To do this, [edit](../../api-gateway/operations/api-gw-update.md) the specification of the `for-slack-bot` API gateway and add the `POST` method configurations to the `paths` parameter:

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

* `service_account_id`: ID of the `sa-slack` service account.
* `<ID_of_function_1>`: ID of the `for-slack-bot-small-talk` function.
* `<ID_of_function_2>`: ID of the `for-slack-bot-hello-from-serverless` function.

## Add a command to Slack {#commands}

Using [commands](https://api.slack.com/interactivity/slash-commands), you can set up the bot's actions in the chat. Commands start with a `/` character and their list is always visible to the user.

{% note info %}

A command will not work if the relevant method is not configured for it in the [API gateway](#edit-api-gw).

{% endnote %}

1. [Select](https://api.slack.com/apps) the `ServerlessBotApp` app.
1. In the app control menu, select **Features** → **Slash Commands** and click **Create New Command**.
1. Add a command for the `for-slack-bot-hello-from-serverless` function:

   * In the **Command** field, enter `/hello-from-serverless`.
   * In the **Request URL** field, paste the `url` from the `for-slack-bot` API gateway specification, adding the `/hello-from-serverless` command's URL to it.
   * In the **Short descriptions** field, enter any short description of the command.
   * Click **Save**.

1. Re-install the application: in the app control menu, select **Settings** → **Install App** and click **Reinstall to Workspace** → **Allow**.
1. Enable users to send messages: in the app control menu, select **Features** → **App Home** and enable **Allow users to send Slash commands and messages from the messages tab** in the **Show Tabs** section.

## Test the Slack bot {#test}

Open the Slack client and choose a chat with the `ServerlessBotApp` bot under **Apps**.

1. To test the `for-slack-bot-small-talk` function:
   * Send a message saying `:wave:` in the chat. The bot should respond with `Hi there, @<username>!`.
   * Send a message saying `knock knock` in the chat. The bot should respond with `Who's there?`.
1. To test the `for-slack-bot-hello-from-serverless` function, send the `/hello-from-serverless` command in the chat. The bot should respond with `Thanks!`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the API gateway](../../api-gateway/operations/api-gw-delete.md).
* [Delete the functions](../../functions/operations/function/function-delete.md).