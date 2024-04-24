---
title: "Support chat in Telegram"
description: "In this tutorial, you will set up a support chat in Telegram."
---

# Support chat in Telegram

Users who have access to a support chat can get their questions about {{ yandex-cloud }} answered in a Telegram chat. Our engineers will provide real-time assistance in simple cases or start a support ticket if the issue requires more time to resolve.

To start a chat with our technical support in Telegram:

1. Open the {{ support-center-name }} [home page]({{ link-console-support }}).
1. In the bottom-left corner, select **{{ ui-key.yacloud.component.navigation-menu.label_help-center }}** and then **Telegram chat**.
1. Select an [organization](../organization/quickstart.md) to work with technical support.
1. Follow the instructions in the **Enter code from Telegram** window: confirm the token you received and use the link to open the Telegram chat.
1. You can use the following chat commands:
   * `/start`: Launches the Telegram bot.
   * `/help`: Displays general information about the chat and Telegram bot.
   * `/lang`: Changes the bot language.
   * `/org`: Shows the organization selected to work with technical support and allows to choose another one.
   * `/feedback`: Prompts you to share your feedback and suggestions on using the Telegram bot.
      To see the full list of commands, click **Menu**.
1. To get started, enter the `/start` command.
1. The bot will prompt you to link your Telegram account in {{ support-center-name }}. Support will receive information about your name, public link to your Telegram account, and photo. Click **Link**.
1. Type your message describing your issue or question. The maximum message size is 1,024 characters. You can also send a file (video, photo, or text) under 20 MB.

   {% note info %}

   If your token expires at any point, the Telegram bot will notify you and ask you to link a new one.

   {% endnote %}

1. If support cannot answer your question quickly, the bot will send you a link to the ticket in Support Center. Follow the link to get assistance from our specialists.

