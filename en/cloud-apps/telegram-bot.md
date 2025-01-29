---
title: Demo Telegram Bot
description: Follow this guide to create a Telegram bot.
---

# Demo Telegram Bot

A Telegram bot on a {{ yandex-cloud }} serverless stack that returns the same message sent by the user. It is implemented with Node.js and the [Telegraf.js](https://telegraf.js.org/) library.

You can modify the Telegram bot's skills as you see fit.

## Required paid resources {#paid-resources}

The cost of resources for the application includes:

* Fee for the number of function calls, computing resources allocated to a function, and outgoing traffic (see [{{ sf-full-name }} pricing](../functions/pricing.md)).
* Fee for the number of requests to the API gateway and outgoing traffic (see [{{ api-gw-full-name }} pricing](../api-gateway/pricing.md)).
* Fee for standard queue requests (see [{{ message-queue-full-name }} pricing](../message-queue/pricing.md)).
* Secret storage and request fees (see [{{ lockbox-full-name }} pricing](../lockbox/pricing.md)).

## Getting started {#before-begin}

Register your bot in Telegram and get a token:

1. Start the `BotFather` bot and send the `/newbot` command to it.
1. Name your bot, e.g., `Serverless Echo Telegram Bot`. This is the name users will see when talking to the bot.
1. Specify a username for your bot, e.g., `ServerlessHelloTelegramBot`. You can use it to locate the bot in Telegram. The username must end with `...Bot` or `..._bot`.

Your Telegram bot's token will be displayed.

[Create](../lockbox/operations/secret-create.md) a {{ lockbox-full-name }} secret. In the **Key** field, enter `TG_TOKEN`, and in the **Value** field, enter the returned Telegram bot token.

## Deploy the application {#deploy-app}

1. In the [management console]({{ link-console-main }}), select the folder where you want to deploy the application.
1. Select **{{ cloud-apps-name }}**.
1. On the left-hand panel, select **Marketplace**.
1. Select **Demo Telegram Bot** and click **Use**.
1. Specify the following:
    * Application name.
    * Application description (not required).
    * Service account with the `admin` role for the folder, or select **Auto** to have the service account created when installing the application. This service account will be used to create the application resources.
    * ID of the previously created {{ lockbox-full-name }} secret.
1. Click **Install** and wait for the installation to complete.
1. On the **Overview** page, find the API gateway under **Application resources**, go to the gateway page, and copy the service domain link.
1. To bind the function to the Telegram bot, run a request. Replace `<bot_token>` with your Telegram bot token, and `<API_gateway_domain>` with a link to your API gateway's service domain.

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux-macos}

        ```bash
        curl \
          --request POST \
          --url "https://api.telegram.org/bot<bot_token>/setWebhook?url=<API_gateway_domain>/echo"
        ```

    - Windows (cmd) {#windows-cmd}

        ```bash
        curl ^
          --request POST ^
          --url "https://api.telegram.org/bot<bot_token>/setWebhook?url=<API_gateway_domain>/echo"
        ```

    - Windows (PowerShell) {#windows-powershell}

        ```powershell
        curl.exe `
          --request POST `
          --url "https://api.telegram.org/bot<bot_token>/setWebhook?url=<API_gateway_domain>/echo"
        ```

    {% endlist %}

    Result:

    ```json
    {"ok":true,"result":true,"description":"Webhook was set"}
    ```

## Test your website {#check-result}

Write to the bot on Telegram.
