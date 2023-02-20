# Creating a Slack chat bot

In this use case, you'll learn how to use serverless technologies to create a Slack bot that will run commands in a chat and respond to user messages.

{% if lang == "ru" %}
@[youtube](VmqFGYAPN_4)
{% endif %}

## Prepare the environment {#start}

1. [Download](https://{{ s3-storage-host }}/doc-files/slackbot.zip) the file archive needed to create the bot.
1. If you don't have a folder, [create](../../resource-manager/operations/folder/create.md) one.
1. [Create](../../iam/operations/sa/create.md#create-sa) a service account and [assign](../../iam/operations/roles/grant.md#access-to-sa) it the `editor` role for your folder.

## Create an app and connect it to {{ yandex-cloud }} {#app}

### Register the Slack app {#create-app}

1. Log in to [Slack](https://slack.com/). To create a bot, make sure you have workspace management permissions.
1. [Create](https://api.slack.com/apps) an app:
   1. Click **Create a custom app**.
   1. In the **Name** field, enter the app name: `ServerlessBotApp`.
   1. Select the available workspace and click **Create app**.
1. Grant permissions to the `ServerlessBotApp` app:
   1. In the app management menu, select **OAuth & Permissions**.
   1. Under **Bot Token Scopes**, add the following permissions: `chat:write`, `commands`, and `im:history`.
   1. After updating the permissions, reinstall the app: you'll see a notification at the top of the page. To reinstall the app, follow the link in the notification and click **Allow**.

### Set up a link between Slack and {{ yandex-cloud }} {#connect-app}

1. [Create](../../api-gateway/operations/api-gw-create.md) an API gateway named `for-slack-bot`.
1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-challenge`. Make sure that it's [private](../../functions/operations/function/function-private.md).
1. [Create](../../functions/operations/function/version-manage.md#version-create) a function version:
   1. Create a file named `index.py` and paste the contents of the `0_for-slack-bot-challenge.py` file from the [archive](#start) into it.
   1. Indicate the following:
      * Runtime environment: `python37`.
      * Entry point: `index.handler`.
      * Timeout: 5 seconds.
      * Service account.
1. [Edit](../../api-gateway/operations/api-gw-update.md) the `for-slack-bot` API gateway. Add to the `paths` parameter the `POST` method configuration:

   ```
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
           function_id: <function ID>
           service_account_id: <service account ID>
         operationId: slack-challenge
   ```

   Parameters:
   * `<Function ID>`: ID of the `for-slack-bot-challenge` function.
   * `<Service account ID>`: ID of the service account.

### Test the link between Slack and {{ yandex-cloud }} {#connect-test}

1. Copy the service domain of the `for-slack-bot` API gateway.
1. [Select](https://api.slack.com/apps) the `ServerlessBotApp` app.
1. In the app management menu, select **Event Subscriptions**.
1. Set **Enable Events** to **on**.
1. In the **Request URL** field, insert the API gateway's address and wait for the **Verified** entry to appear.

## Get a Token and Secret for the app {#env}

[Select](https://api.slack.com/apps) the `ServerlessBotApp` app:
* The **Bot User OAuth Token** value from the **OAuth & Permissions** section will be used for the `SLACK_BOT_TOKEN` environment variable.
* The **Signing Secret** value from the **Basic Information** section will be used for the `SLACK_SIGNING_SECRET` environment variable.

## Create a database {#create-db}

The bot will use responses to chat commands and messages taken from {{ ydb-full-name }}. To enable this, prepare a table:
1. [Create](../../ydb/quickstart.md#serverless) a database named `for-slack-bot` in Serverless mode.
1. In the `for-slack-bot` database, [create](../../ydb/operations/schema.md#create-table)a {{ ydb-short-name }} table named `coffee`:
   1. Go to the **Navigation** tab.
   1. In the upper-right corner, click **SQL query**. The **Query** page opens.
   1. In the **Query** field, enter:

      ```sql
      CREATE TABLE coffee
      (
        id Utf8,
        name Utf8,
        PRIMARY KEY (id)
      );
      ```

   1. Click **Run**.
1. [Add](../../ydb/operations/crud.md#web-sql) an entry to the table. For example, specify the coffee variety name and id = 1.

## Create functions {#create-functions}

Using functions, you can configure the bot's reactions to user actions in the chat. You'll create the following functions in this use case:
* For messaging between the bot and the user.
* For getting the bot's response to a simple command.
* For the bot to select a response to a command from {{ ydb-name }}.

### A function for messaging {#message-func}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-small-talk`. Make sure that it's [private](../../functions/operations/function/function-private.md).
1. [Create](../../functions/operations/function/version-manage.md#version-create) a function version:
   1. Create a file named `requirements.txt` and specify the following libraries in it:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Create a file named `index.py` and paste the contents of the `1_for-slack-bot-small-talk.py` file from the [archive](#start) into it.
   1. Indicate the following:
      * Runtime environment: `python37`.
      * Entry point: `index.handler`.
      * Timeout: 5 seconds.
      * Service account.
   1. Add [environment variables](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.

### A function for responding to commands {#command-func}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-hello-from-serverless`. Make sure that it's [private](../../functions/operations/function/function-private.md).
1. [Create](../../functions/operations/function/version-manage.md#version-create) a function version:
   1. Create a file named `requirements.txt` and specify the following libraries in it:

      ```text
      slack_sdk
      slack_bolt
      boto3
      ```

   1. Create a file named `index.py` and paste the contents of the `2_for-slack-bot-hello-from-serverless.py` file from the [archive](#start) into it.
   1. Indicate the following:
      * Runtime environment: `python37`.
      * Entry point: `index.handler`.
      * Timeout: 5 seconds.
      * Service account.
   1. Add [environment variables](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.

### A function for selecting responses to commands {#db-func}

1. [Create](../../functions/operations/function/function-create.md) a function named `for-slack-bot-what-kind-of-coffee`. Make sure that it's [private](../../functions/operations/function/function-private.md).
1. [Create](../../functions/operations/function/version-manage.md#version-create) a function version:
   1. Create a file named `requirements.txt` and specify in it the libraries and the version of**{{ ydb-name }}** :

      ```text
      slack_sdk
      slack_bolt
      boto3
      ydb==0.0.41
      ```

   1. Create a file named `index.py` and paste the contents of the `3_for-slack-bot-what-kind-of-coffee.py` file from the [archive](#start) into it.
   1. Indicate the following:
      * Runtime environment: `python37`.
      * Entry point: `index.handler`.
      * Timeout = 5 seconds.
      * Service account.
   1. Add [environment variables](#env):
      * `SLACK_BOT_TOKEN`.
      * `SLACK_SIGNING_SECRET`.
   1. Add the variables to work with {{ ydb-name }}:
      * `DATABASE`: The value of the **Database** field from the **Overview **section in the `for-slack-bot` database properties. For example: `/{{ region-id }}/a1bcd23mbaomkfvsleds/etn456khb7jn1ddedfht`.
      * `ENDPOINT`: The value of the **Endpoint **field from the **Overview** section in the `for-slack-bot` database properties. For example: `grpcs://ydb.serverless.yandexcloud.net:1234`.
      * `USE_METADATA_CREDENTIALS` = 1.

## Edit the API gateway {#create-api-gw}

To make sure the bot starts responding to user messages, link the created functions to the app. To do this, [edit](../../api-gateway/operations/api-gw-update.md) the `for-slack-bot` API gateway and add to the `paths` parameter the `POST` method configurations:

```
paths:
  /:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <ID_of_function_1>
        service_account_id: <Service account ID>
      operationId: slack-challenge
  /hello-from-serverless:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <ID_of_function_2>
         service_account_id: <Service account ID>
       operationId: hello-from-serverless
  /what-kind-of-coffee:
    post:
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: <ID_of_function_3>
        service_account_id: <Service account ID>
      operationId: /what-kind-of-coffee
```

Parameters:
* `<Service account ID>`: ID of the service account.
* `<ID_of_function_1>`: ID of the `for-slack-bot-small-talk` function.
* `<ID_of_function_2>`: ID of the `for-slack-bot-hello-from-serverless` function.
* `<ID_of_function_3>`: ID of the `for-slack-bot-what-kind-of-coffee` function.

## Add commands to Slack {#commands}

Using [commands](https://api.slack.com/interactivity/slash-commands), you can set up the bot's actions in the chat. Commands start with a `/` character and their list is always visible to the user.

{% note info %}

A command won't work if the corresponding method is not configured for it in the [API gateway](#create-api-gw).

{% endnote %}

1. [Select](https://api.slack.com/apps) the `ServerlessBotApp` app.
1. In the app management menu, select **Slash Commands** and click **Create New Command**.
1. Add a command for the `for-slack-bot-hello-from-serverless` function:
   * In the **Command** field, enter `/hello-from-serverless`.
   * In the **Request URL** field, paste the `url` from the `for-slack-bot` API gateway specification, adding the `/hello-from-serverless` command's URL to it.
   * In the **Short descriptions** field, enter any short description of the command.
   * Click **Save**.
1. Add a command for the `for-slack-bot-what-kind-of-coffee` function:
   * In the **Command** field, enter `/what-kind-of-coffee`.
   * In the **Request URL** field, paste the `url` from the `for-slack-bot` API gateway specification, adding the `/what-kind-of-coffee` command's URL to it.
   * In the **Short descriptions** field, enter any short description of the command.
   * Click **Save**.
1. After adding the new commands, reinstall the app: you'll see a notification at the top of the page. To reinstall the app, follow the link in the notification and click **Allow**.

## Test the Slack bot {#test}

Open the Slack client and choose a chat with the `ServerlessBotApp` bot under **Apps**.
1. To test the `for-slack-bot-small-talk` function:
   * Send a message saying `:wave:` in the chat. The bot should respond `Hi there, @<username>!`.
   * Send a message saying `knock knock` in the chat. The bot should respond `Who's there?`.
1. To test the `for-slack-bot-hello-from-serverless` function:
   * Send the `/hello-from-serverless` command in the chat. The bot should respond `Thanks!`.
1. To test the `for-slack-bot-what-kind-of-coffee` function:
   * Send the `/what-kind-of-coffee` command in the chat. The bot should respond `Today we use <entry from the coffee table>`.