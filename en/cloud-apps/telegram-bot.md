# Demo Telegram Bot

A Telegram bot on a {{ yandex-cloud }} serverless stack that returns the same message sent by the user. Implemented on Node.js with the [Telegraf](https://telegraf.js.org/) library.

You can modify the Telegram bot's skills as you see fit.

## Required paid resources {#paid-resources}

The cost of resources for the application includes:

* Fee for the number of function calls, computing resources allocated to executing the function, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../api-gateway/pricing.md)).
* Fee for standard queue requests (see [{{ message-queue-full-name }} pricing](../message-queue/pricing.md)).
* Secret storage and request fees (see [{{ lockbox-full-name }} pricing](../lockbox/pricing.md)).

## Getting started {#before-begin}

Register your bot in Telegram and get a token:

1. Start the `BotFather` bot and send it the `/newbot` command.
1. Enter a name for your bot, such as `Serverless Echo Telegram Bot`. This is the name users will see when talking to the bot.
1. Specify a username for your bot, such as `ServerlessHelloTelegramBot`. You can use the username to search for the bot in Telegram. The user name must end with `...Bot` or `..._bot`.

Your Telegram bot's token will be displayed.

[Create](../lockbox/operations/secret-create.md) a {{ lockbox-full-name }} secret. In the **Key** field, enter `TG_TOKEN`, and in the **Value** field, enter the returned Telegram bot token.

## Deploy the application {#deploy-app}

1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Demo Telegram Bot** and click **Use**.
1. Specify the following:
   * Application name.
   * (optional) Application description.
   * Service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
   * ID of the previously created {{ lockbox-full-name }} secret.
1. Click **Install** and wait for the installation to complete.
1. On the **Overview** page, find the API gateway under **Application resources**, go to the gateway page, and copy the service domain link.
1. To bind the function to the Telegram bot, run a request. Replace the `<bot token>` with the Telegram bot token and the `<API gateway domain>` with a link to the API gateway's service domain.

   {% list tabs %}

   - Linux and macOS

      ```bash
      curl \
        --request POST \
        --url https://api.telegram.org/bot<bot token>/setWebhook?url=https://<API gateway domain>/echo
      ```

   - Windows (cmd)

      ```bash
      curl ^
        --request POST ^
        --url "https://api.telegram.org/bot<bot token>/setWebhook?url=https://<API gateway domain>/echo"
      ```

   - Windows (PowerShell)

      ```powershell
      curl.exe `
        --request POST `
        --url https://api.telegram.org/bot<bot token>/setWebhook?url=https://<API gateway domain>/echo
      ```

   {% endlist %}

   Result:

   ```
   {"ok":true,"result":true,"description":"Webhook was set"}
   ```

## Test the controller {#check-result}

Write to the bot on Telegram.
